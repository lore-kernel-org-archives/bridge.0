Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MYnDkfJ7uAer8ttESPhc9/WGOCVzTSnoof4Md1l1Xac=;
	b=PC1PE4gx4X3uJdln4PkjO7fFk/IIlFFXib50MrrNG2nrQIgs5a322w9Ln3sv/R0jfq
	+gSn3e2fDrpoGB5ZuS+4ThzolkrJjGGqd+wnqNVvxFxF8I40bIxYKLracML30N2rlga6
	ItBr1qgE+JnGDFWEWxU3egOiSsHEsJVz2L8/M=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  4 Feb 2017 18:05:06 +0100
Message-Id: <1486227909-18319-2-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/4] bridge: modify bridge and port to
	have often accessed fields in one cache line
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

Move around net_bridge so the vlan fields are in the beginning since
they're checked on every packet even if vlan filtering is disabled.
For the port move flags & vlan group to the beginning, so they're in the
same cache line with the port's state (both flags and state are checked
on each packet).

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_private.h | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 40177df45ba6..ec8560349b6f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -212,12 +212,16 @@ struct net_bridge_mdb_htable
 	u32				ver;
 };
 
-struct net_bridge_port
-{
+struct net_bridge_port {
 	struct net_bridge		*br;
 	struct net_device		*dev;
 	struct list_head		list;
 
+	unsigned long			flags;
+#ifdef CONFIG_BRIDGE_VLAN_FILTERING
+	struct net_bridge_vlan_group	__rcu *vlgrp;
+#endif
+
 	/* STP */
 	u8				priority;
 	u8				state;
@@ -238,8 +242,6 @@ struct net_bridge_port
 	struct kobject			kobj;
 	struct rcu_head			rcu;
 
-	unsigned long 			flags;
-
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	struct bridge_mcast_own_query	ip4_own_query;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -259,9 +261,6 @@ struct net_bridge_port
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	struct netpoll			*np;
 #endif
-#ifdef CONFIG_BRIDGE_VLAN_FILTERING
-	struct net_bridge_vlan_group	__rcu *vlgrp;
-#endif
 #ifdef CONFIG_NET_SWITCHDEV
 	int				offload_fwd_mark;
 #endif
@@ -283,14 +282,21 @@ static inline struct net_bridge_port *br_port_get_rtnl(const struct net_device *
 		rtnl_dereference(dev->rx_handler_data) : NULL;
 }
 
-struct net_bridge
-{
+struct net_bridge {
 	spinlock_t			lock;
+	spinlock_t			hash_lock;
 	struct list_head		port_list;
 	struct net_device		*dev;
-
 	struct pcpu_sw_netstats		__percpu *stats;
-	spinlock_t			hash_lock;
+	/* These fields are accessed on each packet */
+#ifdef CONFIG_BRIDGE_VLAN_FILTERING
+	u8				vlan_enabled;
+	u8				vlan_stats_enabled;
+	__be16				vlan_proto;
+	u16				default_pvid;
+	struct net_bridge_vlan_group	__rcu *vlgrp;
+#endif
+
 	struct hlist_head		hash[BR_HASH_SIZE];
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	union {
@@ -308,6 +314,9 @@ struct net_bridge
 	bridge_id			designated_root;
 	bridge_id			bridge_id;
 	u32				root_path_cost;
+	unsigned char			topology_change;
+	unsigned char			topology_change_detected;
+	u16				root_port;
 	unsigned long			max_age;
 	unsigned long			hello_time;
 	unsigned long			forward_delay;
@@ -319,7 +328,6 @@ struct net_bridge
 
 	u8				group_addr[ETH_ALEN];
 	bool				group_addr_set;
-	u16				root_port;
 
 	enum {
 		BR_NO_STP, 		/* no spanning tree */
@@ -327,9 +335,6 @@ struct net_bridge
 		BR_USER_STP,		/* new RSTP in userspace */
 	} stp_enabled;
 
-	unsigned char			topology_change;
-	unsigned char			topology_change_detected;
-
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	unsigned char			multicast_router;
 
@@ -381,14 +386,6 @@ struct net_bridge
 #ifdef CONFIG_NET_SWITCHDEV
 	int offload_fwd_mark;
 #endif
-
-#ifdef CONFIG_BRIDGE_VLAN_FILTERING
-	struct net_bridge_vlan_group	__rcu *vlgrp;
-	u8				vlan_enabled;
-	u8				vlan_stats_enabled;
-	__be16				vlan_proto;
-	u16				default_pvid;
-#endif
 };
 
 struct br_input_skb_cb {
-- 
2.1.4

