Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LeWliuXGUYC9xUwbiOlJJMdzh12t1FT0WYAvp2F6ti0=;
	b=LfodLLmnQMDRZb4Q4LUrYynBtbWuahbUAtd4er98Z70x9OYYXTCRJsc11PU+yZTZ4R
	YIww3ToGURDn49ZkBLkMXmWKsML1SCQPllcJ00XYq4n6aMGV2DG0jgvdns5Cdp0pjWTp
	Bt+JXoEJ6u39MPfFfj3MSTj7ev13BLQPJyCgA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  5 Dec 2018 15:14:24 +0200
Message-Id: <20181205131427.4989-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
References: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 1/4] net: bridge: convert multicast to
	generic rhashtable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

The bridge multicast code currently uses a custom resizable hashtable
which predates the generic rhashtable interface. It has many
shortcomings compared and duplicates functionality that is presently
available via the generic rhashtable, so this patch removes the custom
rhashtable implementation in favor of the kernel's generic rhashtable.
The hash maximum is kept and the rhashtable's size is used to do a loose
check if it's reached in which case we revert to the old behaviour and
disable further bridge multicast processing. Also now we can support any
hash maximum, doesn't need to be a power of 2.

v3: add non-rcu br_mdb_get variant and use it where multicast_lock is
    held to avoid RCU splat, drop hash_max function and just set it
    directly

v2: handle when IGMP snooping is undefined, add br_mdb_init/uninit
    placeholders

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_device.c    |  10 +
 net/bridge/br_mdb.c       | 120 +++++------
 net/bridge/br_multicast.c | 414 +++++++-------------------------------
 net/bridge/br_netlink.c   |   9 +-
 net/bridge/br_private.h   |  38 ++--
 net/bridge/br_sysfs_br.c  |   8 +-
 6 files changed, 163 insertions(+), 436 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c6abf927f0c9..9f41a5d4da3f 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -131,9 +131,17 @@ static int br_dev_init(struct net_device *dev)
 		return err;
 	}
 
+	err = br_mdb_hash_init(br);
+	if (err) {
+		free_percpu(br->stats);
+		br_fdb_hash_fini(br);
+		return err;
+	}
+
 	err = br_vlan_init(br);
 	if (err) {
 		free_percpu(br->stats);
+		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
 		return err;
 	}
@@ -142,6 +150,7 @@ static int br_dev_init(struct net_device *dev)
 	if (err) {
 		free_percpu(br->stats);
 		br_vlan_flush(br);
+		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
 	}
 	br_set_lockdep_class(dev);
@@ -156,6 +165,7 @@ static void br_dev_uninit(struct net_device *dev)
 	br_multicast_dev_del(br);
 	br_multicast_uninit_stats(br);
 	br_vlan_flush(br);
+	br_mdb_hash_fini(br);
 	br_fdb_hash_fini(br);
 	free_percpu(br->stats);
 }
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a7ea2d431714..ea8abdb56df3 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -78,82 +78,72 @@ static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip)
 static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 			    struct net_device *dev)
 {
+	int idx = 0, s_idx = cb->args[1], err = 0;
 	struct net_bridge *br = netdev_priv(dev);
-	struct net_bridge_mdb_htable *mdb;
+	struct net_bridge_mdb_entry *mp;
 	struct nlattr *nest, *nest2;
-	int i, err = 0;
-	int idx = 0, s_idx = cb->args[1];
 
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
 
-	mdb = rcu_dereference(br->mdb);
-	if (!mdb)
-		return 0;
-
 	nest = nla_nest_start(skb, MDBA_MDB);
 	if (nest == NULL)
 		return -EMSGSIZE;
 
-	for (i = 0; i < mdb->max; i++) {
-		struct net_bridge_mdb_entry *mp;
+	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group *p;
 		struct net_bridge_port_group __rcu **pp;
 		struct net_bridge_port *port;
 
-		hlist_for_each_entry_rcu(mp, &mdb->mhash[i], hlist[mdb->ver]) {
-			if (idx < s_idx)
-				goto skip;
+		if (idx < s_idx)
+			goto skip;
 
-			nest2 = nla_nest_start(skb, MDBA_MDB_ENTRY);
-			if (nest2 == NULL) {
-				err = -EMSGSIZE;
-				goto out;
-			}
+		nest2 = nla_nest_start(skb, MDBA_MDB_ENTRY);
+		if (!nest2) {
+			err = -EMSGSIZE;
+			break;
+		}
 
-			for (pp = &mp->ports;
-			     (p = rcu_dereference(*pp)) != NULL;
-			      pp = &p->next) {
-				struct nlattr *nest_ent;
-				struct br_mdb_entry e;
-
-				port = p->port;
-				if (!port)
-					continue;
-
-				memset(&e, 0, sizeof(e));
-				e.ifindex = port->dev->ifindex;
-				e.vid = p->addr.vid;
-				__mdb_entry_fill_flags(&e, p->flags);
-				if (p->addr.proto == htons(ETH_P_IP))
-					e.addr.u.ip4 = p->addr.u.ip4;
+		for (pp = &mp->ports; (p = rcu_dereference(*pp)) != NULL;
+		      pp = &p->next) {
+			struct nlattr *nest_ent;
+			struct br_mdb_entry e;
+
+			port = p->port;
+			if (!port)
+				continue;
+
+			memset(&e, 0, sizeof(e));
+			e.ifindex = port->dev->ifindex;
+			e.vid = p->addr.vid;
+			__mdb_entry_fill_flags(&e, p->flags);
+			if (p->addr.proto == htons(ETH_P_IP))
+				e.addr.u.ip4 = p->addr.u.ip4;
 #if IS_ENABLED(CONFIG_IPV6)
-				if (p->addr.proto == htons(ETH_P_IPV6))
-					e.addr.u.ip6 = p->addr.u.ip6;
+			if (p->addr.proto == htons(ETH_P_IPV6))
+				e.addr.u.ip6 = p->addr.u.ip6;
 #endif
-				e.addr.proto = p->addr.proto;
-				nest_ent = nla_nest_start(skb,
-							  MDBA_MDB_ENTRY_INFO);
-				if (!nest_ent) {
-					nla_nest_cancel(skb, nest2);
-					err = -EMSGSIZE;
-					goto out;
-				}
-				if (nla_put_nohdr(skb, sizeof(e), &e) ||
-				    nla_put_u32(skb,
-						MDBA_MDB_EATTR_TIMER,
-						br_timer_value(&p->timer))) {
-					nla_nest_cancel(skb, nest_ent);
-					nla_nest_cancel(skb, nest2);
-					err = -EMSGSIZE;
-					goto out;
-				}
-				nla_nest_end(skb, nest_ent);
+			e.addr.proto = p->addr.proto;
+			nest_ent = nla_nest_start(skb, MDBA_MDB_ENTRY_INFO);
+			if (!nest_ent) {
+				nla_nest_cancel(skb, nest2);
+				err = -EMSGSIZE;
+				goto out;
 			}
-			nla_nest_end(skb, nest2);
-		skip:
-			idx++;
+			if (nla_put_nohdr(skb, sizeof(e), &e) ||
+			    nla_put_u32(skb,
+					MDBA_MDB_EATTR_TIMER,
+					br_timer_value(&p->timer))) {
+				nla_nest_cancel(skb, nest_ent);
+				nla_nest_cancel(skb, nest2);
+				err = -EMSGSIZE;
+				goto out;
+			}
+			nla_nest_end(skb, nest_ent);
 		}
+		nla_nest_end(skb, nest2);
+skip:
+		idx++;
 	}
 
 out:
@@ -203,8 +193,7 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 
-	/* In theory this could be wrapped to 0... */
-	cb->seq = net->dev_base_seq + br_mdb_rehash_seq;
+	cb->seq = net->dev_base_seq;
 
 	for_each_netdev_rcu(net, dev) {
 		if (dev->priv_flags & IFF_EBRIDGE) {
@@ -297,7 +286,6 @@ static void br_mdb_complete(struct net_device *dev, int err, void *priv)
 	struct br_mdb_complete_info *data = priv;
 	struct net_bridge_port_group __rcu **pp;
 	struct net_bridge_port_group *p;
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
@@ -306,8 +294,7 @@ static void br_mdb_complete(struct net_device *dev, int err, void *priv)
 		goto err;
 
 	spin_lock_bh(&br->multicast_lock);
-	mdb = mlock_dereference(br->mdb, br);
-	mp = br_mdb_ip_get(mdb, &data->ip);
+	mp = br_mdb_ip_get(br, &data->ip);
 	if (!mp)
 		goto out;
 	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
@@ -588,14 +575,12 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
-	struct net_bridge_mdb_htable *mdb;
 	unsigned long now = jiffies;
 	int err;
 
-	mdb = mlock_dereference(br->mdb, br);
-	mp = br_mdb_ip_get(mdb, group);
+	mp = br_mdb_ip_get(br, group);
 	if (!mp) {
-		mp = br_multicast_new_group(br, port, group);
+		mp = br_multicast_new_group(br, group);
 		err = PTR_ERR_OR_ZERO(mp);
 		if (err)
 			return err;
@@ -696,7 +681,6 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 {
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
@@ -709,9 +693,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 	__mdb_entry_to_br_ip(entry, &ip);
 
 	spin_lock_bh(&br->multicast_lock);
-	mdb = mlock_dereference(br->mdb, br);
-
-	mp = br_mdb_ip_get(mdb, &ip);
+	mp = br_mdb_ip_get(br, &ip);
 	if (!mp)
 		goto unlock;
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6bac0d6b7b94..83a5931a7784 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -37,6 +37,14 @@
 
 #include "br_private.h"
 
+static const struct rhashtable_params br_mdb_rht_params = {
+	.head_offset = offsetof(struct net_bridge_mdb_entry, rhnode),
+	.key_offset = offsetof(struct net_bridge_mdb_entry, addr),
+	.key_len = sizeof(struct br_ip),
+	.automatic_shrinking = true,
+	.locks_mul = 1,
+};
+
 static void br_multicast_start_querier(struct net_bridge *br,
 				       struct bridge_mcast_own_query *query);
 static void br_multicast_add_router(struct net_bridge *br,
@@ -54,7 +62,6 @@ static void br_ip6_multicast_leave_group(struct net_bridge *br,
 					 const struct in6_addr *group,
 					 __u16 vid, const unsigned char *src);
 #endif
-unsigned int br_mdb_rehash_seq;
 
 static inline int br_ip_equal(const struct br_ip *a, const struct br_ip *b)
 {
@@ -73,89 +80,58 @@ static inline int br_ip_equal(const struct br_ip *a, const struct br_ip *b)
 	return 0;
 }
 
-static inline int __br_ip4_hash(struct net_bridge_mdb_htable *mdb, __be32 ip,
-				__u16 vid)
-{
-	return jhash_2words((__force u32)ip, vid, mdb->secret) & (mdb->max - 1);
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static inline int __br_ip6_hash(struct net_bridge_mdb_htable *mdb,
-				const struct in6_addr *ip,
-				__u16 vid)
+static struct net_bridge_mdb_entry *br_mdb_ip_get_rcu(struct net_bridge *br,
+						      struct br_ip *dst)
 {
-	return jhash_2words(ipv6_addr_hash(ip), vid,
-			    mdb->secret) & (mdb->max - 1);
+	return rhashtable_lookup(&br->mdb_hash_tbl, dst, br_mdb_rht_params);
 }
-#endif
 
-static inline int br_ip_hash(struct net_bridge_mdb_htable *mdb,
-			     struct br_ip *ip)
-{
-	switch (ip->proto) {
-	case htons(ETH_P_IP):
-		return __br_ip4_hash(mdb, ip->u.ip4, ip->vid);
-#if IS_ENABLED(CONFIG_IPV6)
-	case htons(ETH_P_IPV6):
-		return __br_ip6_hash(mdb, &ip->u.ip6, ip->vid);
-#endif
-	}
-	return 0;
-}
-
-static struct net_bridge_mdb_entry *__br_mdb_ip_get(
-	struct net_bridge_mdb_htable *mdb, struct br_ip *dst, int hash)
+struct net_bridge_mdb_entry *br_mdb_ip_get(struct net_bridge *br,
+					   struct br_ip *dst)
 {
-	struct net_bridge_mdb_entry *mp;
-
-	hlist_for_each_entry_rcu(mp, &mdb->mhash[hash], hlist[mdb->ver]) {
-		if (br_ip_equal(&mp->addr, dst))
-			return mp;
-	}
+	struct net_bridge_mdb_entry *ent;
 
-	return NULL;
-}
+	lockdep_assert_held_once(&br->multicast_lock);
 
-struct net_bridge_mdb_entry *br_mdb_ip_get(struct net_bridge_mdb_htable *mdb,
-					   struct br_ip *dst)
-{
-	if (!mdb)
-		return NULL;
+	rcu_read_lock();
+	ent = rhashtable_lookup(&br->mdb_hash_tbl, dst, br_mdb_rht_params);
+	rcu_read_unlock();
 
-	return __br_mdb_ip_get(mdb, dst, br_ip_hash(mdb, dst));
+	return ent;
 }
 
-static struct net_bridge_mdb_entry *br_mdb_ip4_get(
-	struct net_bridge_mdb_htable *mdb, __be32 dst, __u16 vid)
+static struct net_bridge_mdb_entry *br_mdb_ip4_get(struct net_bridge *br,
+						   __be32 dst, __u16 vid)
 {
 	struct br_ip br_dst;
 
+	memset(&br_dst, 0, sizeof(br_dst));
 	br_dst.u.ip4 = dst;
 	br_dst.proto = htons(ETH_P_IP);
 	br_dst.vid = vid;
 
-	return br_mdb_ip_get(mdb, &br_dst);
+	return br_mdb_ip_get(br, &br_dst);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static struct net_bridge_mdb_entry *br_mdb_ip6_get(
-	struct net_bridge_mdb_htable *mdb, const struct in6_addr *dst,
-	__u16 vid)
+static struct net_bridge_mdb_entry *br_mdb_ip6_get(struct net_bridge *br,
+						   const struct in6_addr *dst,
+						   __u16 vid)
 {
 	struct br_ip br_dst;
 
+	memset(&br_dst, 0, sizeof(br_dst));
 	br_dst.u.ip6 = *dst;
 	br_dst.proto = htons(ETH_P_IPV6);
 	br_dst.vid = vid;
 
-	return br_mdb_ip_get(mdb, &br_dst);
+	return br_mdb_ip_get(br, &br_dst);
 }
 #endif
 
 struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 					struct sk_buff *skb, u16 vid)
 {
-	struct net_bridge_mdb_htable *mdb = rcu_dereference(br->mdb);
 	struct br_ip ip;
 
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
@@ -164,6 +140,7 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 	if (BR_INPUT_SKB_CB(skb)->igmp)
 		return NULL;
 
+	memset(&ip, 0, sizeof(ip));
 	ip.proto = skb->protocol;
 	ip.vid = vid;
 
@@ -180,47 +157,7 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 		return NULL;
 	}
 
-	return br_mdb_ip_get(mdb, &ip);
-}
-
-static void br_mdb_free(struct rcu_head *head)
-{
-	struct net_bridge_mdb_htable *mdb =
-		container_of(head, struct net_bridge_mdb_htable, rcu);
-	struct net_bridge_mdb_htable *old = mdb->old;
-
-	mdb->old = NULL;
-	kfree(old->mhash);
-	kfree(old);
-}
-
-static int br_mdb_copy(struct net_bridge_mdb_htable *new,
-		       struct net_bridge_mdb_htable *old,
-		       int elasticity)
-{
-	struct net_bridge_mdb_entry *mp;
-	int maxlen;
-	int len;
-	int i;
-
-	for (i = 0; i < old->max; i++)
-		hlist_for_each_entry(mp, &old->mhash[i], hlist[old->ver])
-			hlist_add_head(&mp->hlist[new->ver],
-				       &new->mhash[br_ip_hash(new, &mp->addr)]);
-
-	if (!elasticity)
-		return 0;
-
-	maxlen = 0;
-	for (i = 0; i < new->max; i++) {
-		len = 0;
-		hlist_for_each_entry(mp, &new->mhash[i], hlist[new->ver])
-			len++;
-		if (len > maxlen)
-			maxlen = len;
-	}
-
-	return maxlen > elasticity ? -EINVAL : 0;
+	return br_mdb_ip_get_rcu(br, &ip);
 }
 
 void br_multicast_free_pg(struct rcu_head *head)
@@ -243,7 +180,6 @@ static void br_multicast_group_expired(struct timer_list *t)
 {
 	struct net_bridge_mdb_entry *mp = from_timer(mp, t, timer);
 	struct net_bridge *br = mp->br;
-	struct net_bridge_mdb_htable *mdb;
 
 	spin_lock(&br->multicast_lock);
 	if (!netif_running(br->dev) || timer_pending(&mp->timer))
@@ -255,10 +191,9 @@ static void br_multicast_group_expired(struct timer_list *t)
 	if (mp->ports)
 		goto out;
 
-	mdb = mlock_dereference(br->mdb, br);
-
-	hlist_del_rcu(&mp->hlist[mdb->ver]);
-	mdb->size--;
+	rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
+			       br_mdb_rht_params);
+	hlist_del_rcu(&mp->mdb_node);
 
 	call_rcu_bh(&mp->rcu, br_multicast_free_group);
 
@@ -269,14 +204,11 @@ static void br_multicast_group_expired(struct timer_list *t)
 static void br_multicast_del_pg(struct net_bridge *br,
 				struct net_bridge_port_group *pg)
 {
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
 
-	mdb = mlock_dereference(br->mdb, br);
-
-	mp = br_mdb_ip_get(mdb, &pg->addr);
+	mp = br_mdb_ip_get(br, &pg->addr);
 	if (WARN_ON(!mp))
 		return;
 
@@ -319,53 +251,6 @@ static void br_multicast_port_group_expired(struct timer_list *t)
 	spin_unlock(&br->multicast_lock);
 }
 
-static int br_mdb_rehash(struct net_bridge_mdb_htable __rcu **mdbp, int max,
-			 int elasticity)
-{
-	struct net_bridge_mdb_htable *old = rcu_dereference_protected(*mdbp, 1);
-	struct net_bridge_mdb_htable *mdb;
-	int err;
-
-	mdb = kmalloc(sizeof(*mdb), GFP_ATOMIC);
-	if (!mdb)
-		return -ENOMEM;
-
-	mdb->max = max;
-	mdb->old = old;
-
-	mdb->mhash = kcalloc(max, sizeof(*mdb->mhash), GFP_ATOMIC);
-	if (!mdb->mhash) {
-		kfree(mdb);
-		return -ENOMEM;
-	}
-
-	mdb->size = old ? old->size : 0;
-	mdb->ver = old ? old->ver ^ 1 : 0;
-
-	if (!old || elasticity)
-		get_random_bytes(&mdb->secret, sizeof(mdb->secret));
-	else
-		mdb->secret = old->secret;
-
-	if (!old)
-		goto out;
-
-	err = br_mdb_copy(mdb, old, elasticity);
-	if (err) {
-		kfree(mdb->mhash);
-		kfree(mdb);
-		return err;
-	}
-
-	br_mdb_rehash_seq++;
-	call_rcu_bh(&mdb->rcu, br_mdb_free);
-
-out:
-	rcu_assign_pointer(*mdbp, mdb);
-
-	return 0;
-}
-
 static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge *br,
 						    __be32 group,
 						    u8 *igmp_type)
@@ -589,111 +474,19 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge *br,
 	return NULL;
 }
 
-static struct net_bridge_mdb_entry *br_multicast_get_group(
-	struct net_bridge *br, struct net_bridge_port *port,
-	struct br_ip *group, int hash)
-{
-	struct net_bridge_mdb_htable *mdb;
-	struct net_bridge_mdb_entry *mp;
-	unsigned int count = 0;
-	unsigned int max;
-	int elasticity;
-	int err;
-
-	mdb = rcu_dereference_protected(br->mdb, 1);
-	hlist_for_each_entry(mp, &mdb->mhash[hash], hlist[mdb->ver]) {
-		count++;
-		if (unlikely(br_ip_equal(group, &mp->addr)))
-			return mp;
-	}
-
-	elasticity = 0;
-	max = mdb->max;
-
-	if (unlikely(count > br->hash_elasticity && count)) {
-		if (net_ratelimit())
-			br_info(br, "Multicast hash table "
-				"chain limit reached: %s\n",
-				port ? port->dev->name : br->dev->name);
-
-		elasticity = br->hash_elasticity;
-	}
-
-	if (mdb->size >= max) {
-		max *= 2;
-		if (unlikely(max > br->hash_max)) {
-			br_warn(br, "Multicast hash table maximum of %d "
-				"reached, disabling snooping: %s\n",
-				br->hash_max,
-				port ? port->dev->name : br->dev->name);
-			err = -E2BIG;
-disable:
-			br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
-			goto err;
-		}
-	}
-
-	if (max > mdb->max || elasticity) {
-		if (mdb->old) {
-			if (net_ratelimit())
-				br_info(br, "Multicast hash table "
-					"on fire: %s\n",
-					port ? port->dev->name : br->dev->name);
-			err = -EEXIST;
-			goto err;
-		}
-
-		err = br_mdb_rehash(&br->mdb, max, elasticity);
-		if (err) {
-			br_warn(br, "Cannot rehash multicast "
-				"hash table, disabling snooping: %s, %d, %d\n",
-				port ? port->dev->name : br->dev->name,
-				mdb->size, err);
-			goto disable;
-		}
-
-		err = -EAGAIN;
-		goto err;
-	}
-
-	return NULL;
-
-err:
-	mp = ERR_PTR(err);
-	return mp;
-}
-
 struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
-						    struct net_bridge_port *p,
 						    struct br_ip *group)
 {
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
-	int hash;
 	int err;
 
-	mdb = rcu_dereference_protected(br->mdb, 1);
-	if (!mdb) {
-		err = br_mdb_rehash(&br->mdb, BR_HASH_SIZE, 0);
-		if (err)
-			return ERR_PTR(err);
-		goto rehash;
-	}
-
-	hash = br_ip_hash(mdb, group);
-	mp = br_multicast_get_group(br, p, group, hash);
-	switch (PTR_ERR(mp)) {
-	case 0:
-		break;
+	mp = br_mdb_ip_get(br, group);
+	if (mp)
+		return mp;
 
-	case -EAGAIN:
-rehash:
-		mdb = rcu_dereference_protected(br->mdb, 1);
-		hash = br_ip_hash(mdb, group);
-		break;
-
-	default:
-		goto out;
+	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
+		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
+		return ERR_PTR(-E2BIG);
 	}
 
 	mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
@@ -703,11 +496,15 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 	mp->br = br;
 	mp->addr = *group;
 	timer_setup(&mp->timer, br_multicast_group_expired, 0);
+	err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
+					    br_mdb_rht_params);
+	if (err) {
+		kfree(mp);
+		mp = ERR_PTR(err);
+	} else {
+		hlist_add_head_rcu(&mp->mdb_node, &br->mdb_list);
+	}
 
-	hlist_add_head_rcu(&mp->hlist[mdb->ver], &mdb->mhash[hash]);
-	mdb->size++;
-
-out:
 	return mp;
 }
 
@@ -768,7 +565,7 @@ static int br_multicast_add_group(struct net_bridge *br,
 	    (port && port->state == BR_STATE_DISABLED))
 		goto out;
 
-	mp = br_multicast_new_group(br, port, group);
+	mp = br_multicast_new_group(br, group);
 	err = PTR_ERR(mp);
 	if (IS_ERR(mp))
 		goto err;
@@ -837,6 +634,7 @@ static int br_ip6_multicast_add_group(struct net_bridge *br,
 	if (ipv6_addr_is_ll_all_nodes(group))
 		return 0;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip6 = *group;
 	br_group.proto = htons(ETH_P_IPV6);
 	br_group.vid = vid;
@@ -1483,7 +1281,7 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 		goto out;
 	}
 
-	mp = br_mdb_ip4_get(mlock_dereference(br->mdb, br), group, vid);
+	mp = br_mdb_ip4_get(br, group, vid);
 	if (!mp)
 		goto out;
 
@@ -1567,7 +1365,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 		goto out;
 	}
 
-	mp = br_mdb_ip6_get(mlock_dereference(br->mdb, br), group, vid);
+	mp = br_mdb_ip6_get(br, group, vid);
 	if (!mp)
 		goto out;
 
@@ -1601,7 +1399,6 @@ br_multicast_leave_group(struct net_bridge *br,
 			 struct bridge_mcast_own_query *own_query,
 			 const unsigned char *src)
 {
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	unsigned long now;
@@ -1612,8 +1409,7 @@ br_multicast_leave_group(struct net_bridge *br,
 	    (port && port->state == BR_STATE_DISABLED))
 		goto out;
 
-	mdb = mlock_dereference(br->mdb, br);
-	mp = br_mdb_ip_get(mdb, group);
+	mp = br_mdb_ip_get(br, group);
 	if (!mp)
 		goto out;
 
@@ -1999,6 +1795,7 @@ void br_multicast_init(struct net_bridge *br)
 	timer_setup(&br->ip6_own_query.timer,
 		    br_ip6_multicast_query_expired, 0);
 #endif
+	INIT_HLIST_HEAD(&br->mdb_list);
 }
 
 static void __br_multicast_open(struct net_bridge *br,
@@ -2033,40 +1830,20 @@ void br_multicast_stop(struct net_bridge *br)
 
 void br_multicast_dev_del(struct net_bridge *br)
 {
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_mdb_entry *mp;
-	struct hlist_node *n;
-	u32 ver;
-	int i;
+	struct hlist_node *tmp;
 
 	spin_lock_bh(&br->multicast_lock);
-	mdb = mlock_dereference(br->mdb, br);
-	if (!mdb)
-		goto out;
-
-	br->mdb = NULL;
-
-	ver = mdb->ver;
-	for (i = 0; i < mdb->max; i++) {
-		hlist_for_each_entry_safe(mp, n, &mdb->mhash[i],
-					  hlist[ver]) {
-			del_timer(&mp->timer);
-			call_rcu_bh(&mp->rcu, br_multicast_free_group);
-		}
-	}
-
-	if (mdb->old) {
-		spin_unlock_bh(&br->multicast_lock);
-		rcu_barrier_bh();
-		spin_lock_bh(&br->multicast_lock);
-		WARN_ON(mdb->old);
+	hlist_for_each_entry_safe(mp, tmp, &br->mdb_list, mdb_node) {
+		del_timer(&mp->timer);
+		rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
+				       br_mdb_rht_params);
+		hlist_del_rcu(&mp->mdb_node);
+		call_rcu_bh(&mp->rcu, br_multicast_free_group);
 	}
-
-	mdb->old = mdb;
-	call_rcu_bh(&mdb->rcu, br_mdb_free);
-
-out:
 	spin_unlock_bh(&br->multicast_lock);
+
+	rcu_barrier_bh();
 }
 
 int br_multicast_set_router(struct net_bridge *br, unsigned long val)
@@ -2176,7 +1953,6 @@ static void br_multicast_start_querier(struct net_bridge *br,
 
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 {
-	struct net_bridge_mdb_htable *mdb;
 	struct net_bridge_port *port;
 	int err = 0;
 
@@ -2192,21 +1968,6 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 	if (!netif_running(br->dev))
 		goto unlock;
 
-	mdb = mlock_dereference(br->mdb, br);
-	if (mdb) {
-		if (mdb->old) {
-			err = -EEXIST;
-rollback:
-			br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
-			goto unlock;
-		}
-
-		err = br_mdb_rehash(&br->mdb, mdb->max,
-				    br->hash_elasticity);
-		if (err)
-			goto rollback;
-	}
-
 	br_multicast_open(br);
 	list_for_each_entry(port, &br->port_list, list)
 		__br_multicast_enable_port(port);
@@ -2271,45 +2032,6 @@ int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
 	return 0;
 }
 
-int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val)
-{
-	int err = -EINVAL;
-	u32 old;
-	struct net_bridge_mdb_htable *mdb;
-
-	spin_lock_bh(&br->multicast_lock);
-	if (!is_power_of_2(val))
-		goto unlock;
-
-	mdb = mlock_dereference(br->mdb, br);
-	if (mdb && val < mdb->size)
-		goto unlock;
-
-	err = 0;
-
-	old = br->hash_max;
-	br->hash_max = val;
-
-	if (mdb) {
-		if (mdb->old) {
-			err = -EEXIST;
-rollback:
-			br->hash_max = old;
-			goto unlock;
-		}
-
-		err = br_mdb_rehash(&br->mdb, br->hash_max,
-				    br->hash_elasticity);
-		if (err)
-			goto rollback;
-	}
-
-unlock:
-	spin_unlock_bh(&br->multicast_lock);
-
-	return err;
-}
-
 int br_multicast_set_igmp_version(struct net_bridge *br, unsigned long val)
 {
 	/* Currently we support only version 2 and 3 */
@@ -2646,3 +2368,13 @@ void br_multicast_get_stats(const struct net_bridge *br,
 	}
 	memcpy(dest, &tdst, sizeof(*dest));
 }
+
+int br_mdb_hash_init(struct net_bridge *br)
+{
+	return rhashtable_init(&br->mdb_hash_tbl, &br_mdb_rht_params);
+}
+
+void br_mdb_hash_fini(struct net_bridge *br)
+{
+	rhashtable_destroy(&br->mdb_hash_tbl);
+}
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 13cd50326af2..063da636cb82 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1195,13 +1195,8 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		br->hash_elasticity = val;
 	}
 
-	if (data[IFLA_BR_MCAST_HASH_MAX]) {
-		u32 hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]);
-
-		err = br_multicast_set_hash_max(br, hash_max);
-		if (err)
-			return err;
-	}
+	if (data[IFLA_BR_MCAST_HASH_MAX])
+		br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]);
 
 	if (data[IFLA_BR_MCAST_LAST_MEMBER_CNT]) {
 		u32 val = nla_get_u32(data[IFLA_BR_MCAST_LAST_MEMBER_CNT]);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d29f837cd7a2..a0ce0822921c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -213,23 +213,14 @@ struct net_bridge_port_group {
 };
 
 struct net_bridge_mdb_entry {
-	struct hlist_node		hlist[2];
+	struct rhash_head		rhnode;
 	struct net_bridge		*br;
 	struct net_bridge_port_group __rcu *ports;
 	struct rcu_head			rcu;
 	struct timer_list		timer;
 	struct br_ip			addr;
 	bool				host_joined;
-};
-
-struct net_bridge_mdb_htable {
-	struct hlist_head		*mhash;
-	struct rcu_head			rcu;
-	struct net_bridge_mdb_htable	*old;
-	u32				size;
-	u32				max;
-	u32				secret;
-	u32				ver;
+	struct hlist_node		mdb_node;
 };
 
 struct net_bridge_port {
@@ -400,7 +391,9 @@ struct net_bridge {
 	unsigned long			multicast_query_response_interval;
 	unsigned long			multicast_startup_query_interval;
 
-	struct net_bridge_mdb_htable __rcu *mdb;
+	struct rhashtable		mdb_hash_tbl;
+
+	struct hlist_head		mdb_list;
 	struct hlist_head		router_list;
 
 	struct timer_list		multicast_router_timer;
@@ -659,7 +652,6 @@ int br_ioctl_deviceless_stub(struct net *net, unsigned int cmd,
 
 /* br_multicast.c */
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
-extern unsigned int br_mdb_rehash_seq;
 int br_multicast_rcv(struct net_bridge *br, struct net_bridge_port *port,
 		     struct sk_buff *skb, u16 vid);
 struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
@@ -684,17 +676,16 @@ int br_multicast_set_igmp_version(struct net_bridge *br, unsigned long val);
 int br_multicast_set_mld_version(struct net_bridge *br, unsigned long val);
 #endif
 struct net_bridge_mdb_entry *
-br_mdb_ip_get(struct net_bridge_mdb_htable *mdb, struct br_ip *dst);
+br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
 struct net_bridge_mdb_entry *
-br_multicast_new_group(struct net_bridge *br, struct net_bridge_port *port,
-		       struct br_ip *group);
+br_multicast_new_group(struct net_bridge *br, struct br_ip *group);
 void br_multicast_free_pg(struct rcu_head *head);
 struct net_bridge_port_group *
 br_multicast_new_port_group(struct net_bridge_port *port, struct br_ip *group,
 			    struct net_bridge_port_group __rcu *next,
 			    unsigned char flags, const unsigned char *src);
-void br_mdb_init(void);
-void br_mdb_uninit(void);
+int br_mdb_hash_init(struct net_bridge *br);
+void br_mdb_hash_fini(struct net_bridge *br);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_port *port,
 		   struct br_ip *group, int type, u8 flags);
 void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
@@ -706,6 +697,8 @@ void br_multicast_uninit_stats(struct net_bridge *br);
 void br_multicast_get_stats(const struct net_bridge *br,
 			    const struct net_bridge_port *p,
 			    struct br_mcast_stats *dest);
+void br_mdb_init(void);
+void br_mdb_uninit(void);
 
 #define mlock_dereference(X, br) \
 	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
@@ -831,6 +824,15 @@ static inline void br_mdb_uninit(void)
 {
 }
 
+static inline int br_mdb_hash_init(struct net_bridge *br)
+{
+	return 0;
+}
+
+static inline void br_mdb_hash_fini(struct net_bridge *br)
+{
+}
+
 static inline void br_multicast_count(struct net_bridge *br,
 				      const struct net_bridge_port *p,
 				      const struct sk_buff *skb,
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 6a378a7e16ea..f164cda30fe2 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -449,10 +449,16 @@ static ssize_t hash_max_show(struct device *d, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", br->hash_max);
 }
 
+static int set_hash_max(struct net_bridge *br, unsigned long val)
+{
+	br->hash_max = val;
+	return 0;
+}
+
 static ssize_t hash_max_store(struct device *d, struct device_attribute *attr,
 			      const char *buf, size_t len)
 {
-	return store_bridge_parm(d, buf, len, br_multicast_set_hash_max);
+	return store_bridge_parm(d, buf, len, set_hash_max);
 }
 static DEVICE_ATTR_RW(hash_max);
 
-- 
2.17.2

