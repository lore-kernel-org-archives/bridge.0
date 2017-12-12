Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=F+SXoiPF4JUHyZ5RIworhRoEIcG0PSKRZklFPLRvPmk=;
	b=SMsg6jhYWEpRcxJtogaD/DwAMiL/KwTY63Zs2pPNPjKEOMEa0WjZhtONKLqJoZ2vQJ
	ZtJmQa3HFTl90wiPiUoADH5LuSO3f+0qcuRcgH/OEm2lB5klAooYgElVdF0YXSR5ZgHX
	LEnxch9oT91BTuCENKk7ywZimKhKoH9CwVAas=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 12 Dec 2017 16:02:50 +0200
Message-Id: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] net: bridge: use rhashtable for fdbs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, srn@prgmr.com, davem@davemloft.net

Before this patch the bridge used a fixed 256 element hash table which
was fine for small use cases (in my tests it starts to degrade
above 1000 entries), but it wasn't enough for medium or large
scale deployments. Modern setups have thousands of participants in a
single bridge, even only enabling vlans and adding a few thousand vlan
entries will cause a few thousand fdbs to be automatically inserted per
participating port. So we need to scale the fdb table considerably to
cope with modern workloads, and this patch converts it to use a
rhashtable for its operations thus improving the bridge scalability.
Tests show the following results (10 runs each), at up to 1000 entries
rhashtable is ~3% slower, at 2000 rhashtable is 30% faster, at 3000 it
is 2 times faster and at 30000 it is 50 times faster.
Obviously this happens because of the properties of the two constructs
and is expected, rhashtable keeps pretty much a constant time even with
10000000 entries (tested), while the fixed hash table struggles
considerably even above 10000.
As a side effect this also reduces the net_bridge struct size from 3248
bytes to 1344 bytes. Also note that the key struct is 8 bytes.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
After this I'll post patches for the per-port fdb limit option. Later we
can get rid of hash_lock altogether though that requires much more
careful changes.

 include/trace/events/bridge.h |   4 +-
 net/bridge/br_device.c        |  10 ++
 net/bridge/br_fdb.c           | 392 ++++++++++++++++++++----------------------
 net/bridge/br_private.h       |  16 +-
 net/bridge/br_switchdev.c     |   8 +-
 5 files changed, 211 insertions(+), 219 deletions(-)

diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
index 1bee3e7fdf32..8ea966448b58 100644
--- a/include/trace/events/bridge.h
+++ b/include/trace/events/bridge.h
@@ -82,8 +82,8 @@ TRACE_EVENT(fdb_delete,
 	TP_fast_assign(
 		__assign_str(br_dev, br->dev->name);
 		__assign_str(dev, f->dst ? f->dst->dev->name : "null");
-		memcpy(__entry->addr, f->addr.addr, ETH_ALEN);
-		__entry->vid = f->vlan_id;
+		memcpy(__entry->addr, f->key.addr.addr, ETH_ALEN);
+		__entry->vid = f->key.vlan_id;
 	),
 
 	TP_printk("br_dev %s dev %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u",
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index af5b8c87f590..1285ca30ab0a 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -125,9 +125,16 @@ static int br_dev_init(struct net_device *dev)
 	if (!br->stats)
 		return -ENOMEM;
 
+	err = br_fdb_hash_init(br);
+	if (err) {
+		free_percpu(br->stats);
+		return err;
+	}
+
 	err = br_vlan_init(br);
 	if (err) {
 		free_percpu(br->stats);
+		br_fdb_hash_fini(br);
 		return err;
 	}
 
@@ -135,6 +142,7 @@ static int br_dev_init(struct net_device *dev)
 	if (err) {
 		free_percpu(br->stats);
 		br_vlan_flush(br);
+		br_fdb_hash_fini(br);
 	}
 	br_set_lockdep_class(dev);
 
@@ -148,6 +156,7 @@ static void br_dev_uninit(struct net_device *dev)
 	br_multicast_dev_del(br);
 	br_multicast_uninit_stats(br);
 	br_vlan_flush(br);
+	br_fdb_hash_fini(br);
 	free_percpu(br->stats);
 }
 
@@ -416,6 +425,7 @@ void br_dev_setup(struct net_device *dev)
 	br->dev = dev;
 	spin_lock_init(&br->lock);
 	INIT_LIST_HEAD(&br->port_list);
+	INIT_HLIST_HEAD(&br->fdb_list);
 	spin_lock_init(&br->hash_lock);
 
 	br->bridge_id.prio[0] = 0x80;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4ea5c8bbe286..dc87fbc9a23b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -28,14 +28,20 @@
 #include <trace/events/bridge.h>
 #include "br_private.h"
 
+static const struct rhashtable_params br_fdb_rht_params = {
+	.head_offset = offsetof(struct net_bridge_fdb_entry, rhnode),
+	.key_offset = offsetof(struct net_bridge_fdb_entry, key),
+	.key_len = sizeof(struct net_bridge_fdb_key),
+	.automatic_shrinking = true,
+	.locks_mul = 1,
+};
+
 static struct kmem_cache *br_fdb_cache __read_mostly;
 static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		      const unsigned char *addr, u16 vid);
 static void fdb_notify(struct net_bridge *br,
 		       const struct net_bridge_fdb_entry *, int);
 
-static u32 fdb_salt __read_mostly;
-
 int __init br_fdb_init(void)
 {
 	br_fdb_cache = kmem_cache_create("bridge_fdb_cache",
@@ -45,7 +51,6 @@ int __init br_fdb_init(void)
 	if (!br_fdb_cache)
 		return -ENOMEM;
 
-	get_random_bytes(&fdb_salt, sizeof(fdb_salt));
 	return 0;
 }
 
@@ -54,6 +59,15 @@ void br_fdb_fini(void)
 	kmem_cache_destroy(br_fdb_cache);
 }
 
+int br_fdb_hash_init(struct net_bridge *br)
+{
+	return rhashtable_init(&br->fdb_hash_tbl, &br_fdb_rht_params);
+}
+
+void br_fdb_hash_fini(struct net_bridge *br)
+{
+	rhashtable_destroy(&br->fdb_hash_tbl);
+}
 
 /* if topology_changing then use forward_delay (default 15 sec)
  * otherwise keep longer (default 5 minutes)
@@ -70,13 +84,6 @@ static inline int has_expired(const struct net_bridge *br,
 		time_before_eq(fdb->updated + hold_time(br), jiffies);
 }
 
-static inline int br_mac_hash(const unsigned char *mac, __u16 vid)
-{
-	/* use 1 byte of OUI and 3 bytes of NIC */
-	u32 key = get_unaligned((u32 *)(mac + 2));
-	return jhash_2words(key, vid, fdb_salt) & (BR_HASH_SIZE - 1);
-}
-
 static void fdb_rcu_free(struct rcu_head *head)
 {
 	struct net_bridge_fdb_entry *ent
@@ -84,19 +91,18 @@ static void fdb_rcu_free(struct rcu_head *head)
 	kmem_cache_free(br_fdb_cache, ent);
 }
 
-static struct net_bridge_fdb_entry *fdb_find_rcu(struct hlist_head *head,
+static struct net_bridge_fdb_entry *fdb_find_rcu(struct rhashtable *tbl,
 						 const unsigned char *addr,
 						 __u16 vid)
 {
-	struct net_bridge_fdb_entry *f;
+	struct net_bridge_fdb_key key;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	hlist_for_each_entry_rcu(f, head, hlist)
-		if (ether_addr_equal(f->addr.addr, addr) && f->vlan_id == vid)
-			break;
+	key.vlan_id = vid;
+	memcpy(key.addr.addr, addr, sizeof(key.addr.addr));
 
-	return f;
+	return rhashtable_lookup(tbl, &key, br_fdb_rht_params);
 }
 
 /* requires bridge hash_lock */
@@ -104,13 +110,12 @@ static struct net_bridge_fdb_entry *br_fdb_find(struct net_bridge *br,
 						const unsigned char *addr,
 						__u16 vid)
 {
-	struct hlist_head *head = &br->hash[br_mac_hash(addr, vid)];
 	struct net_bridge_fdb_entry *fdb;
 
 	lockdep_assert_held_once(&br->hash_lock);
 
 	rcu_read_lock();
-	fdb = fdb_find_rcu(head, addr, vid);
+	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	rcu_read_unlock();
 
 	return fdb;
@@ -120,9 +125,7 @@ struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 					     const unsigned char *addr,
 					     __u16 vid)
 {
-	struct hlist_head *head = &br->hash[br_mac_hash(addr, vid)];
-
-	return fdb_find_rcu(head, addr, vid);
+	return fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 }
 
 /* When a static FDB entry is added, the mac address from the entry is
@@ -175,9 +178,11 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f)
 	trace_fdb_delete(br, f);
 
 	if (f->is_static)
-		fdb_del_hw_addr(br, f->addr.addr);
+		fdb_del_hw_addr(br, f->key.addr.addr);
 
-	hlist_del_init_rcu(&f->hlist);
+	hlist_del_init_rcu(&f->fdb_node);
+	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
+			       br_fdb_rht_params);
 	fdb_notify(br, f, RTM_DELNEIGH);
 	call_rcu(&f->rcu, fdb_rcu_free);
 }
@@ -187,11 +192,11 @@ static void fdb_delete_local(struct net_bridge *br,
 			     const struct net_bridge_port *p,
 			     struct net_bridge_fdb_entry *f)
 {
-	const unsigned char *addr = f->addr.addr;
+	const unsigned char *addr = f->key.addr.addr;
 	struct net_bridge_vlan_group *vg;
 	const struct net_bridge_vlan *v;
 	struct net_bridge_port *op;
-	u16 vid = f->vlan_id;
+	u16 vid = f->key.vlan_id;
 
 	/* Maybe another port has same hw addr? */
 	list_for_each_entry(op, &br->port_list, list) {
@@ -233,31 +238,23 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 {
 	struct net_bridge_vlan_group *vg;
+	struct net_bridge_fdb_entry *f;
 	struct net_bridge *br = p->br;
 	struct net_bridge_vlan *v;
-	int i;
 
 	spin_lock_bh(&br->hash_lock);
-
 	vg = nbp_vlan_group(p);
-	/* Search all chains since old address/hash is unknown */
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		struct hlist_node *h;
-		hlist_for_each(h, &br->hash[i]) {
-			struct net_bridge_fdb_entry *f;
-
-			f = hlist_entry(h, struct net_bridge_fdb_entry, hlist);
-			if (f->dst == p && f->is_local && !f->added_by_user) {
-				/* delete old one */
-				fdb_delete_local(br, p, f);
-
-				/* if this port has no vlan information
-				 * configured, we can safely be done at
-				 * this point.
-				 */
-				if (!vg || !vg->num_vlans)
-					goto insert;
-			}
+	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {
+		if (f->dst == p && f->is_local && !f->added_by_user) {
+			/* delete old one */
+			fdb_delete_local(br, p, f);
+
+			/* if this port has no vlan information
+			 * configured, we can safely be done at
+			 * this point.
+			 */
+			if (!vg || !vg->num_vlans)
+				goto insert;
 		}
 	}
 
@@ -316,35 +313,32 @@ void br_fdb_cleanup(struct work_struct *work)
 {
 	struct net_bridge *br = container_of(work, struct net_bridge,
 					     gc_work.work);
+	struct net_bridge_fdb_entry *f = NULL;
 	unsigned long delay = hold_time(br);
 	unsigned long work_delay = delay;
 	unsigned long now = jiffies;
-	int i;
 
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		struct net_bridge_fdb_entry *f;
-		struct hlist_node *n;
+	/* this part is tricky, in order to avoid blocking learning and
+	 * consequently forwarding, we rely on rcu to delete objects with
+	 * delayed freeing allowing us to continue traversing
+	 */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		unsigned long this_timer;
 
-		if (!br->hash[i].first)
+		if (f->is_static || f->added_by_external_learn)
 			continue;
-
-		spin_lock_bh(&br->hash_lock);
-		hlist_for_each_entry_safe(f, n, &br->hash[i], hlist) {
-			unsigned long this_timer;
-
-			if (f->is_static)
-				continue;
-			if (f->added_by_external_learn)
-				continue;
-			this_timer = f->updated + delay;
-			if (time_after(this_timer, now))
-				work_delay = min(work_delay, this_timer - now);
-			else
+		this_timer = f->updated + delay;
+		if (time_after(this_timer, now)) {
+			work_delay = min(work_delay, this_timer - now);
+		} else {
+			spin_lock_bh(&br->hash_lock);
+			if (!hlist_unhashed(&f->fdb_node))
 				fdb_delete(br, f);
+			spin_unlock_bh(&br->hash_lock);
 		}
-		spin_unlock_bh(&br->hash_lock);
-		cond_resched();
 	}
+	rcu_read_unlock();
 
 	/* Cleanup minimum 10 milliseconds apart */
 	work_delay = max_t(unsigned long, work_delay, msecs_to_jiffies(10));
@@ -354,16 +348,13 @@ void br_fdb_cleanup(struct work_struct *work)
 /* Completely flush all dynamic entries in forwarding database.*/
 void br_fdb_flush(struct net_bridge *br)
 {
-	int i;
+	struct net_bridge_fdb_entry *f;
+	struct hlist_node *tmp;
 
 	spin_lock_bh(&br->hash_lock);
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		struct net_bridge_fdb_entry *f;
-		struct hlist_node *n;
-		hlist_for_each_entry_safe(f, n, &br->hash[i], hlist) {
-			if (!f->is_static)
-				fdb_delete(br, f);
-		}
+	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
+		if (!f->is_static)
+			fdb_delete(br, f);
 	}
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -377,27 +368,22 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 			   u16 vid,
 			   int do_all)
 {
-	int i;
+	struct net_bridge_fdb_entry *f;
+	struct hlist_node *tmp;
 
 	spin_lock_bh(&br->hash_lock);
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		struct hlist_node *h, *g;
+	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
+		if (f->dst != p)
+			continue;
 
-		hlist_for_each_safe(h, g, &br->hash[i]) {
-			struct net_bridge_fdb_entry *f
-				= hlist_entry(h, struct net_bridge_fdb_entry, hlist);
-			if (f->dst != p)
+		if (!do_all)
+			if (f->is_static || (vid && f->key.vlan_id != vid))
 				continue;
 
-			if (!do_all)
-				if (f->is_static || (vid && f->vlan_id != vid))
-					continue;
-
-			if (f->is_local)
-				fdb_delete_local(br, p, f);
-			else
-				fdb_delete(br, f);
-		}
+		if (f->is_local)
+			fdb_delete_local(br, p, f);
+		else
+			fdb_delete(br, f);
 	}
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -433,52 +419,48 @@ int br_fdb_test_addr(struct net_device *dev, unsigned char *addr)
 int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		   unsigned long maxnum, unsigned long skip)
 {
-	struct __fdb_entry *fe = buf;
-	int i, num = 0;
 	struct net_bridge_fdb_entry *f;
+	struct __fdb_entry *fe = buf;
+	int num = 0;
 
 	memset(buf, 0, maxnum*sizeof(struct __fdb_entry));
 
 	rcu_read_lock();
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(f, &br->hash[i], hlist) {
-			if (num >= maxnum)
-				goto out;
+	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		if (num >= maxnum)
+			break;
 
-			if (has_expired(br, f))
-				continue;
+		if (has_expired(br, f))
+			continue;
 
-			/* ignore pseudo entry for local MAC address */
-			if (!f->dst)
-				continue;
+		/* ignore pseudo entry for local MAC address */
+		if (!f->dst)
+			continue;
 
-			if (skip) {
-				--skip;
-				continue;
-			}
+		if (skip) {
+			--skip;
+			continue;
+		}
 
-			/* convert from internal format to API */
-			memcpy(fe->mac_addr, f->addr.addr, ETH_ALEN);
+		/* convert from internal format to API */
+		memcpy(fe->mac_addr, f->key.addr.addr, ETH_ALEN);
 
-			/* due to ABI compat need to split into hi/lo */
-			fe->port_no = f->dst->port_no;
-			fe->port_hi = f->dst->port_no >> 8;
+		/* due to ABI compat need to split into hi/lo */
+		fe->port_no = f->dst->port_no;
+		fe->port_hi = f->dst->port_no >> 8;
 
-			fe->is_local = f->is_local;
-			if (!f->is_static)
-				fe->ageing_timer_value = jiffies_delta_to_clock_t(jiffies - f->updated);
-			++fe;
-			++num;
-		}
+		fe->is_local = f->is_local;
+		if (!f->is_static)
+			fe->ageing_timer_value = jiffies_delta_to_clock_t(jiffies - f->updated);
+		++fe;
+		++num;
 	}
-
- out:
 	rcu_read_unlock();
 
 	return num;
 }
 
-static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
+static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 					       struct net_bridge_port *source,
 					       const unsigned char *addr,
 					       __u16 vid,
@@ -489,16 +471,23 @@ static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
 
 	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
 	if (fdb) {
-		memcpy(fdb->addr.addr, addr, ETH_ALEN);
+		memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
 		fdb->dst = source;
-		fdb->vlan_id = vid;
+		fdb->key.vlan_id = vid;
 		fdb->is_local = is_local;
 		fdb->is_static = is_static;
 		fdb->added_by_user = 0;
 		fdb->added_by_external_learn = 0;
 		fdb->offloaded = 0;
 		fdb->updated = fdb->used = jiffies;
-		hlist_add_head_rcu(&fdb->hlist, head);
+		if (rhashtable_lookup_insert_fast(&br->fdb_hash_tbl,
+						  &fdb->rhnode,
+						  br_fdb_rht_params)) {
+			kmem_cache_free(br_fdb_cache, fdb);
+			fdb = NULL;
+		} else {
+			hlist_add_head_rcu(&fdb->fdb_node, &br->fdb_list);
+		}
 	}
 	return fdb;
 }
@@ -506,7 +495,6 @@ static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
 static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		  const unsigned char *addr, u16 vid)
 {
-	struct hlist_head *head = &br->hash[br_mac_hash(addr, vid)];
 	struct net_bridge_fdb_entry *fdb;
 
 	if (!is_valid_ether_addr(addr))
@@ -524,7 +512,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		fdb_delete(br, fdb);
 	}
 
-	fdb = fdb_create(head, source, addr, vid, 1, 1);
+	fdb = fdb_create(br, source, addr, vid, 1, 1);
 	if (!fdb)
 		return -ENOMEM;
 
@@ -548,7 +536,6 @@ int br_fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		   const unsigned char *addr, u16 vid, bool added_by_user)
 {
-	struct hlist_head *head = &br->hash[br_mac_hash(addr, vid)];
 	struct net_bridge_fdb_entry *fdb;
 	bool fdb_modified = false;
 
@@ -561,7 +548,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 	      source->state == BR_STATE_FORWARDING))
 		return;
 
-	fdb = fdb_find_rcu(head, addr, vid);
+	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
 		if (unlikely(fdb->is_local)) {
@@ -590,14 +577,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-		if (likely(!fdb_find_rcu(head, addr, vid))) {
-			fdb = fdb_create(head, source, addr, vid, 0, 0);
-			if (fdb) {
-				if (unlikely(added_by_user))
-					fdb->added_by_user = 1;
-				trace_br_fdb_update(br, source, addr, vid, added_by_user);
-				fdb_notify(br, fdb, RTM_NEWNEIGH);
-			}
+		fdb = fdb_create(br, source, addr, vid, 0, 0);
+		if (fdb) {
+			if (unlikely(added_by_user))
+				fdb->added_by_user = 1;
+			trace_br_fdb_update(br, source, addr, vid,
+					    added_by_user);
+			fdb_notify(br, fdb, RTM_NEWNEIGH);
 		}
 		/* else  we lose race and someone else inserts
 		 * it first, don't bother updating
@@ -646,7 +632,7 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 	if (fdb->added_by_external_learn)
 		ndm->ndm_flags |= NTF_EXT_LEARNED;
 
-	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->addr))
+	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
 		goto nla_put_failure;
@@ -657,7 +643,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
 		goto nla_put_failure;
 
-	if (fdb->vlan_id && nla_put(skb, NDA_VLAN, sizeof(u16), &fdb->vlan_id))
+	if (fdb->key.vlan_id && nla_put(skb, NDA_VLAN, sizeof(u16),
+					&fdb->key.vlan_id))
 		goto nla_put_failure;
 
 	nlmsg_end(skb, nlh);
@@ -711,54 +698,48 @@ int br_fdb_dump(struct sk_buff *skb,
 		int *idx)
 {
 	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge_fdb_entry *f;
 	int err = 0;
-	int i;
 
 	if (!(dev->priv_flags & IFF_EBRIDGE))
-		goto out;
+		return err;
 
 	if (!filter_dev) {
 		err = ndo_dflt_fdb_dump(skb, cb, dev, NULL, idx);
 		if (err < 0)
-			goto out;
+			return err;
 	}
 
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		struct net_bridge_fdb_entry *f;
-
-		hlist_for_each_entry_rcu(f, &br->hash[i], hlist) {
-
-			if (*idx < cb->args[2])
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		if (*idx < cb->args[2])
+			goto skip;
+		if (filter_dev && (!f->dst || f->dst->dev != filter_dev)) {
+			if (filter_dev != dev)
 				goto skip;
-
-			if (filter_dev &&
-			    (!f->dst || f->dst->dev != filter_dev)) {
-				if (filter_dev != dev)
-					goto skip;
-				/* !f->dst is a special case for bridge
-				 * It means the MAC belongs to the bridge
-				 * Therefore need a little more filtering
-				 * we only want to dump the !f->dst case
-				 */
-				if (f->dst)
-					goto skip;
-			}
-			if (!filter_dev && f->dst)
+			/* !f->dst is a special case for bridge
+			 * It means the MAC belongs to the bridge
+			 * Therefore need a little more filtering
+			 * we only want to dump the !f->dst case
+			 */
+			if (f->dst)
 				goto skip;
-
-			err = fdb_fill_info(skb, br, f,
-					    NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq,
-					    RTM_NEWNEIGH,
-					    NLM_F_MULTI);
-			if (err < 0)
-				goto out;
-skip:
-			*idx += 1;
 		}
+		if (!filter_dev && f->dst)
+			goto skip;
+
+		err = fdb_fill_info(skb, br, f,
+				    NETLINK_CB(cb->skb).portid,
+				    cb->nlh->nlmsg_seq,
+				    RTM_NEWNEIGH,
+				    NLM_F_MULTI);
+		if (err < 0)
+			break;
+skip:
+		*idx += 1;
 	}
+	rcu_read_unlock();
 
-out:
 	return err;
 }
 
@@ -766,7 +747,6 @@ int br_fdb_dump(struct sk_buff *skb,
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 			 const __u8 *addr, __u16 state, __u16 flags, __u16 vid)
 {
-	struct hlist_head *head = &br->hash[br_mac_hash(addr, vid)];
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
 
@@ -787,7 +767,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(head, source, addr, vid, 0, 0);
+		fdb = fdb_create(br, source, addr, vid, 0, 0);
 		if (!fdb)
 			return -ENOMEM;
 
@@ -1012,65 +992,60 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
 {
-	struct net_bridge_fdb_entry *fdb, *tmp;
-	int i;
+	struct net_bridge_fdb_entry *f, *tmp;
 	int err;
 
 	ASSERT_RTNL();
 
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		hlist_for_each_entry(fdb, &br->hash[i], hlist) {
-			/* We only care for static entries */
-			if (!fdb->is_static)
-				continue;
-
-			err = dev_uc_add(p->dev, fdb->addr.addr);
-			if (err)
-				goto rollback;
-		}
+	/* the key here is that static entries change only under rtnl */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		/* We only care for static entries */
+		if (!f->is_static)
+			continue;
+		err = dev_uc_add(p->dev, f->key.addr.addr);
+		if (err)
+			goto rollback;
 	}
-	return 0;
+done:
+	rcu_read_unlock();
 
-rollback:
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		hlist_for_each_entry(tmp, &br->hash[i], hlist) {
-			/* If we reached the fdb that failed, we can stop */
-			if (tmp == fdb)
-				break;
-
-			/* We only care for static entries */
-			if (!tmp->is_static)
-				continue;
+	return err;
 
-			dev_uc_del(p->dev, tmp->addr.addr);
-		}
+rollback:
+	hlist_for_each_entry_rcu(tmp, &br->fdb_list, fdb_node) {
+		/* We only care for static entries */
+		if (!tmp->is_static)
+			continue;
+		if (tmp == f)
+			break;
+		dev_uc_del(p->dev, tmp->key.addr.addr);
 	}
-	return err;
+
+	goto done;
 }
 
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 {
-	struct net_bridge_fdb_entry *fdb;
-	int i;
+	struct net_bridge_fdb_entry *f;
 
 	ASSERT_RTNL();
 
-	for (i = 0; i < BR_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(fdb, &br->hash[i], hlist) {
-			/* We only care for static entries */
-			if (!fdb->is_static)
-				continue;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		/* We only care for static entries */
+		if (!f->is_static)
+			continue;
 
-			dev_uc_del(p->dev, fdb->addr.addr);
-		}
+		dev_uc_del(p->dev, f->key.addr.addr);
 	}
+	rcu_read_unlock();
 }
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid)
 {
 	struct net_bridge_fdb_entry *fdb;
-	struct hlist_head *head;
 	bool modified = false;
 	int err = 0;
 
@@ -1078,10 +1053,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 	spin_lock_bh(&br->hash_lock);
 
-	head = &br->hash[br_mac_hash(addr, vid)];
 	fdb = br_fdb_find(br, addr, vid);
 	if (!fdb) {
-		fdb = fdb_create(head, p, addr, vid, 0, 0);
+		fdb = fdb_create(br, p, addr, vid, 0, 0);
 		if (!fdb) {
 			err = -ENOMEM;
 			goto err_unlock;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1312b8d20ec3..80559fd11b7e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -168,12 +168,17 @@ struct net_bridge_vlan_group {
 	u16				pvid;
 };
 
+struct net_bridge_fdb_key {
+	mac_addr addr;
+	u16 vlan_id;
+};
+
 struct net_bridge_fdb_entry {
-	struct hlist_node		hlist;
+	struct rhash_head		rhnode;
 	struct net_bridge_port		*dst;
 
-	mac_addr			addr;
-	__u16				vlan_id;
+	struct net_bridge_fdb_key	key;
+	struct hlist_node		fdb_node;
 	unsigned char			is_local:1,
 					is_static:1,
 					added_by_user:1,
@@ -315,7 +320,7 @@ struct net_bridge {
 	struct net_bridge_vlan_group	__rcu *vlgrp;
 #endif
 
-	struct hlist_head		hash[BR_HASH_SIZE];
+	struct rhashtable		fdb_hash_tbl;
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	union {
 		struct rtable		fake_rtable;
@@ -405,6 +410,7 @@ struct net_bridge {
 	int offload_fwd_mark;
 #endif
 	bool				neigh_suppress_enabled;
+	struct hlist_head		fdb_list;
 };
 
 struct br_input_skb_cb {
@@ -515,6 +521,8 @@ static inline void br_netpoll_disable(struct net_bridge_port *p)
 /* br_fdb.c */
 int br_fdb_init(void);
 void br_fdb_fini(void);
+int br_fdb_hash_init(struct net_bridge *br);
+void br_fdb_hash_fini(struct net_bridge *br);
 void br_fdb_flush(struct net_bridge *br);
 void br_fdb_find_delete_local(struct net_bridge *br,
 			      const struct net_bridge_port *p,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 9700e0f3307b..ee775f4ff76c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -121,13 +121,13 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 
 	switch (type) {
 	case RTM_DELNEIGH:
-		br_switchdev_fdb_call_notifiers(false, fdb->addr.addr,
-						fdb->vlan_id,
+		br_switchdev_fdb_call_notifiers(false, fdb->key.addr.addr,
+						fdb->key.vlan_id,
 						fdb->dst->dev);
 		break;
 	case RTM_NEWNEIGH:
-		br_switchdev_fdb_call_notifiers(true, fdb->addr.addr,
-						fdb->vlan_id,
+		br_switchdev_fdb_call_notifiers(true, fdb->key.addr.addr,
+						fdb->key.vlan_id,
 						fdb->dst->dev);
 		break;
 	}
-- 
2.1.4

