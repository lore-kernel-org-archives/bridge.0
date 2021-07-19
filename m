Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FB7z8k/P/2xrVSLTebtzWJZe24gB6OgBCQ9IKuHeTdQ=;
 b=1eOKeSvNmWJpOonKmqwgF0o6//+djWs/KaiQLgUXOGmLvJ41NYoEowIGXmtRifAulq
 hj7aoWP4DFVU2ZMRp7Zgz3d9N6m57AyJRvzHIC/Fo46417Lzcuy28L7dN+W1lXtROx5c
 RqF5XhTbgWPakrlm/D/uC/3s2ncEHv+4KeiIXp+6ppWfPjGvsI/RL5YizZv4f0qgol74
 VhDGstaycL2WXEqv6t3NXoVhg3imIto1DgcBVHNjJa93n+mFlkBkMOH4krd1Viaek2gG
 0IJV5iTKKVH/bFbh7dOEUa33oXk+hRWpNwFd02CzGIA72kb2limj9uyyfhVl7EVqb/3M
 1phg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 19 Jul 2021 20:06:32 +0300
Message-Id: <20210719170637.435541-11-razor@blackwall.org>
In-Reply-To: <20210719170637.435541-1-razor@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 10/15] net: bridge: multicast: add vlan
	querier and query support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add basic vlan context querier support, if the contexts passed to
multicast_alloc_query are vlan then the query will be tagged. Also
handle querier start/stop of vlan contexts.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 68 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4620946ec7d7..9d4a18a711e4 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -773,7 +773,28 @@ static void br_multicast_gc(struct hlist_head *head)
 	}
 }
 
+static void __br_multicast_query_handle_vlan(struct net_bridge_mcast *brmctx,
+					     struct net_bridge_mcast_port *pmctx,
+					     struct sk_buff *skb)
+{
+	struct net_bridge_vlan *vlan = NULL;
+
+	if (pmctx && br_multicast_port_ctx_is_vlan(pmctx))
+		vlan = pmctx->vlan;
+	else if (br_multicast_ctx_is_vlan(brmctx))
+		vlan = brmctx->vlan;
+
+	if (vlan && !(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
+		u16 vlan_proto;
+
+		if (br_vlan_get_proto(brmctx->br->dev, &vlan_proto) != 0)
+			return;
+		__vlan_hwaccel_put_tag(skb, htons(vlan_proto), vlan->vid);
+	}
+}
+
 static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brmctx,
+						    struct net_bridge_mcast_port *pmctx,
 						    struct net_bridge_port_group *pg,
 						    __be32 ip_dst, __be32 group,
 						    bool with_srcs, bool over_lmqt,
@@ -822,6 +843,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	if (!skb)
 		goto out;
 
+	__br_multicast_query_handle_vlan(brmctx, pmctx, skb);
 	skb->protocol = htons(ETH_P_IP);
 
 	skb_reset_mac_header(skb);
@@ -919,6 +941,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 
 #if IS_ENABLED(CONFIG_IPV6)
 static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brmctx,
+						    struct net_bridge_mcast_port *pmctx,
 						    struct net_bridge_port_group *pg,
 						    const struct in6_addr *ip6_dst,
 						    const struct in6_addr *group,
@@ -970,6 +993,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 	if (!skb)
 		goto out;
 
+	__br_multicast_query_handle_vlan(brmctx, pmctx, skb);
 	skb->protocol = htons(ETH_P_IPV6);
 
 	/* Ethernet header */
@@ -1082,6 +1106,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 #endif
 
 static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
+						struct net_bridge_mcast_port *pmctx,
 						struct net_bridge_port_group *pg,
 						struct br_ip *ip_dst,
 						struct br_ip *group,
@@ -1094,7 +1119,7 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 	switch (group->proto) {
 	case htons(ETH_P_IP):
 		ip4_dst = ip_dst ? ip_dst->dst.ip4 : htonl(INADDR_ALLHOSTS_GROUP);
-		return br_ip4_multicast_alloc_query(brmctx, pg,
+		return br_ip4_multicast_alloc_query(brmctx, pmctx, pg,
 						    ip4_dst, group->dst.ip4,
 						    with_srcs, over_lmqt,
 						    sflag, igmp_type,
@@ -1109,7 +1134,7 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 			ipv6_addr_set(&ip6_dst, htonl(0xff020000), 0, 0,
 				      htonl(1));
 
-		return br_ip6_multicast_alloc_query(brmctx, pg,
+		return br_ip6_multicast_alloc_query(brmctx, pmctx, pg,
 						    &ip6_dst, &group->dst.ip6,
 						    with_srcs, over_lmqt,
 						    sflag, igmp_type,
@@ -1603,9 +1628,12 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	struct sk_buff *skb;
 	u8 igmp_type;
 
+	if (!br_multicast_ctx_should_use(brmctx, pmctx))
+		return;
+
 again_under_lmqt:
-	skb = br_multicast_alloc_query(brmctx, pg, ip_dst, group, with_srcs,
-				       over_lmqt, sflag, &igmp_type,
+	skb = br_multicast_alloc_query(brmctx, pmctx, pg, ip_dst, group,
+				       with_srcs, over_lmqt, sflag, &igmp_type,
 				       need_rexmit);
 	if (!skb)
 		return;
@@ -1679,6 +1707,7 @@ br_multicast_port_query_expired(struct net_bridge_mcast_port *pmctx,
 	spin_lock(&br->multicast_lock);
 	if (br_multicast_port_ctx_state_stopped(pmctx))
 		goto out;
+
 	brmctx = br_multicast_port_ctx_get_global(pmctx);
 	if (query->startup_sent < brmctx->multicast_startup_query_count)
 		query->startup_sent++;
@@ -4129,15 +4158,38 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(port, &brmctx->br->port_list, list) {
-		if (port->state == BR_STATE_DISABLED ||
-		    port->state == BR_STATE_BLOCKING)
+		struct bridge_mcast_own_query *ip4_own_query;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct bridge_mcast_own_query *ip6_own_query;
+#endif
+
+		if (br_multicast_port_ctx_state_stopped(&port->multicast_ctx))
 			continue;
 
+		if (br_multicast_ctx_is_vlan(brmctx)) {
+			struct net_bridge_vlan *vlan;
+
+			vlan = br_vlan_find(nbp_vlan_group(port), brmctx->vlan->vid);
+			if (!vlan ||
+			    br_multicast_port_ctx_state_stopped(&vlan->port_mcast_ctx))
+				continue;
+
+			ip4_own_query = &vlan->port_mcast_ctx.ip4_own_query;
+#if IS_ENABLED(CONFIG_IPV6)
+			ip6_own_query = &vlan->port_mcast_ctx.ip6_own_query;
+#endif
+		} else {
+			ip4_own_query = &port->multicast_ctx.ip4_own_query;
+#if IS_ENABLED(CONFIG_IPV6)
+			ip6_own_query = &port->multicast_ctx.ip6_own_query;
+#endif
+		}
+
 		if (query == &brmctx->ip4_own_query)
-			br_multicast_enable(&port->multicast_ctx.ip4_own_query);
+			br_multicast_enable(ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 		else
-			br_multicast_enable(&port->multicast_ctx.ip6_own_query);
+			br_multicast_enable(ip6_own_query);
 #endif
 	}
 	rcu_read_unlock();
-- 
2.31.1

