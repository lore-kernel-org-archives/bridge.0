Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mzyAv1ylBdJBBskA/FLRvBG2U6MttLS1nRYeB0zExYs=;
 b=uwAwCQVv9WJPm0/J6HK330KMa0/diE5RxCzSZzel8GewXvIg3DnFz10DIPrl17ng/p
 Xw9KazTQyQV6yPZXwHtGQdRREegu/vgZsdF+6cHvf5Com4FEP2rXdpYSJy9EPpm0sJfw
 1Gtk/7+E5uScVKvQjEFGvZdcGQUKOkMqBhu+dp0kk9zCT0Iv4b59RnN5oSmW/PGbzIpT
 YW+yRHMaFu9INm4jDlyuqK3fFUHHXwTVEcpiWbJxvWlHjrbHDROBrsLKpQZu3fJk3hcn
 qrVaRbZn0vdvyUH0x9cpVn0SWqHen4ckG4wbTGsGFTNKkannoyzHpPcl+qae68SQYHLl
 YLrw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 22 Sep 2020 10:30:21 +0300
Message-Id: <20200922073027.1196992-11-razor@blackwall.org>
In-Reply-To: <20200922073027.1196992-1-razor@blackwall.org>
References: <20200922073027.1196992-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 10/16] net: bridge: mcast: add
	rt_protocol field to the port group struct
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We need to be able to differentiate between pg entries created by
user-space and the kernel when we start generating S,G entries for
IGMPv3/MLDv2's fast path. User-space entries are created by default as
RTPROT_STATIC and the kernel entries are RTPROT_KERNEL. Later we can
allow user-space to provide the entry rt_protocol so we can
differentiate between who added the entries specifically (e.g. clag,
admin, frr etc).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_mdb.c            | 42 +++++++++++++++++++++-------------
 net/bridge/br_multicast.c      |  7 ++++--
 net/bridge/br_private.h        |  3 ++-
 4 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 3e6377c865eb..1054f151078d 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -458,6 +458,7 @@ enum {
 	MDBA_MDB_EATTR_SRC_LIST,
 	MDBA_MDB_EATTR_GROUP_MODE,
 	MDBA_MDB_EATTR_SOURCE,
+	MDBA_MDB_EATTR_RTPROT,
 	__MDBA_MDB_EATTR_MAX
 };
 #define MDBA_MDB_EATTR_MAX (__MDBA_MDB_EATTR_MAX - 1)
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7f9ca5c20120..b386a5e07698 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -184,6 +184,7 @@ static int __mdb_fill_info(struct sk_buff *skb,
 			MDBA_MDB_EATTR_TIMER,
 			br_timer_value(mtimer)))
 		goto nest_err;
+
 	switch (mp->addr.proto) {
 	case htons(ETH_P_IP):
 		dump_srcs_mode = !!(mp->br->multicast_igmp_version == 3);
@@ -206,10 +207,15 @@ static int __mdb_fill_info(struct sk_buff *skb,
 		break;
 #endif
 	}
-	if (p && dump_srcs_mode &&
-	    (__mdb_fill_srcs(skb, p) ||
-	     nla_put_u8(skb, MDBA_MDB_EATTR_GROUP_MODE, p->filter_mode)))
-		goto nest_err;
+	if (p) {
+		if (nla_put_u8(skb, MDBA_MDB_EATTR_RTPROT, p->rt_protocol))
+			goto nest_err;
+		if (dump_srcs_mode &&
+		    (__mdb_fill_srcs(skb, p) ||
+		     nla_put_u8(skb, MDBA_MDB_EATTR_GROUP_MODE,
+				p->filter_mode)))
+			goto nest_err;
+	}
 	nla_nest_end(skb, nest_ent);
 
 	return 0;
@@ -414,6 +420,9 @@ static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
 	if (!pg)
 		goto out;
 
+	/* MDBA_MDB_EATTR_RTPROT */
+	nlmsg_size += nla_total_size(sizeof(u8));
+
 	switch (pg->addr.proto) {
 	case htons(ETH_P_IP):
 		/* MDBA_MDB_EATTR_SOURCE */
@@ -809,16 +818,20 @@ static int br_mdb_parse(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
-			    struct br_ip *group, struct br_mdb_entry *entry,
+			    struct br_mdb_entry *entry,
+			    struct nlattr **mdb_attrs,
 			    struct netlink_ext_ack *extack)
 {
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
 	unsigned long now = jiffies;
+	struct br_ip group;
 	u8 filter_mode;
 	int err;
 
+	__mdb_entry_to_br_ip(entry, &group, mdb_attrs);
+
 	/* host join errors which can happen before creating the group */
 	if (!port) {
 		/* don't allow any flags for host-joined groups */
@@ -826,15 +839,15 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
 			return -EINVAL;
 		}
-		if (!br_multicast_is_star_g(group)) {
+		if (!br_multicast_is_star_g(&group)) {
 			NL_SET_ERR_MSG_MOD(extack, "Groups with sources cannot be manually host joined");
 			return -EINVAL;
 		}
 	}
 
-	mp = br_mdb_ip_get(br, group);
+	mp = br_mdb_ip_get(br, &group);
 	if (!mp) {
-		mp = br_multicast_new_group(br, group);
+		mp = br_multicast_new_group(br, &group);
 		err = PTR_ERR_OR_ZERO(mp);
 		if (err)
 			return err;
@@ -864,11 +877,11 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 			break;
 	}
 
-	filter_mode = br_multicast_is_star_g(group) ? MCAST_EXCLUDE :
-						      MCAST_INCLUDE;
+	filter_mode = br_multicast_is_star_g(&group) ? MCAST_EXCLUDE :
+						       MCAST_INCLUDE;
 
-	p = br_multicast_new_port_group(port, group, *pp, entry->state, NULL,
-					filter_mode);
+	p = br_multicast_new_port_group(port, &group, *pp, entry->state, NULL,
+					filter_mode, RTPROT_STATIC);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new port group");
 		return -ENOMEM;
@@ -887,13 +900,10 @@ static int __br_mdb_add(struct net *net, struct net_bridge *br,
 			struct nlattr **mdb_attrs,
 			struct netlink_ext_ack *extack)
 {
-	struct br_ip ip;
 	int ret;
 
-	__mdb_entry_to_br_ip(entry, &ip, mdb_attrs);
-
 	spin_lock_bh(&br->multicast_lock);
-	ret = br_mdb_add_group(br, p, &ip, entry, extack);
+	ret = br_mdb_add_group(br, p, entry, mdb_attrs, extack);
 	spin_unlock_bh(&br->multicast_lock);
 
 	return ret;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4fd690bc848f..b6e7b0ece422 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -795,7 +795,8 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 			struct net_bridge_port_group __rcu *next,
 			unsigned char flags,
 			const unsigned char *src,
-			u8 filter_mode)
+			u8 filter_mode,
+			u8 rt_protocol)
 {
 	struct net_bridge_port_group *p;
 
@@ -807,6 +808,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	p->port = port;
 	p->flags = flags;
 	p->filter_mode = filter_mode;
+	p->rt_protocol = rt_protocol;
 	p->mcast_gc.destroy = br_multicast_destroy_port_group;
 	INIT_HLIST_HEAD(&p->src_list);
 	rcu_assign_pointer(p->next, next);
@@ -892,7 +894,8 @@ static int br_multicast_add_group(struct net_bridge *br,
 			break;
 	}
 
-	p = br_multicast_new_port_group(port, group, *pp, 0, src, filter_mode);
+	p = br_multicast_new_port_group(port, group, *pp, 0, src, filter_mode,
+					RTPROT_KERNEL);
 	if (unlikely(!p))
 		goto err;
 	rcu_assign_pointer(*pp, p);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0f54a7a7c186..dae7e3526fc7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -246,6 +246,7 @@ struct net_bridge_port_group {
 	unsigned char			flags;
 	unsigned char			filter_mode;
 	unsigned char			grp_query_rexmit_cnt;
+	unsigned char			rt_protocol;
 
 	struct hlist_head		src_list;
 	unsigned int			src_ents;
@@ -804,7 +805,7 @@ struct net_bridge_port_group *
 br_multicast_new_port_group(struct net_bridge_port *port, struct br_ip *group,
 			    struct net_bridge_port_group __rcu *next,
 			    unsigned char flags, const unsigned char *src,
-			    u8 filter_mode);
+			    u8 filter_mode, u8 rt_protocol);
 int br_mdb_hash_init(struct net_bridge *br);
 void br_mdb_hash_fini(struct net_bridge *br);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
-- 
2.25.4

