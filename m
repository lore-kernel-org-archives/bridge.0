Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WayoRnxZyewNqS/mFzEIX1pEz8tkw70crwUI/Ut43xI=;
 b=cLkPqR8fBMH2h69UUp28ea8gpxzq8/xunFN1Un8ezIaQPbgXTjjNRkJRx6g8Yq/upd
 1OgQb43tDH4ZhJg/SjIgl6T6piQzVJWIyspQpoIbcp6Ru2Gqpiw2Z/RueO/bDR/3KMtW
 4j9mBtvikdB4HiV5h+FawwFUf7zbqt72TqTMPOWY9nYoWPFqeaR0GfPrRSvMsZGs9vKB
 fgzVN8Co1Xpb8bdH2GVSmDaKUkcEnaT2X91MS+px15/q5iJJHhGt75jlnDLiugVuHM53
 5mCVgESDP2kNqO4iixSmryBp94+xbuRbXAgQOh9zuj+qonHC63WdBLStQLxSohPxjVBT
 JW1A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 26 Jan 2021 11:35:32 +0200
Message-Id: <20210126093533.441338-2-razor@blackwall.org>
In-Reply-To: <20210126093533.441338-1-razor@blackwall.org>
References: <20210126093533.441338-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 1/2] net: bridge: multicast: add
	per-port EHT hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add a default limit of 512 for number of tracked EHT hosts per-port.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
v2: no change

 net/bridge/br_multicast.c         |  1 +
 net/bridge/br_multicast_eht.c     |  7 +++++++
 net/bridge/br_private.h           |  2 ++
 net/bridge/br_private_mcast_eht.h | 26 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3aa2833f60c7..6f672eb7ff33 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1608,6 +1608,7 @@ static void br_mc_disabled_update(struct net_device *dev, bool value)
 int br_multicast_add_port(struct net_bridge_port *port)
 {
 	port->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
+	port->multicast_eht_hosts_limit = BR_MCAST_DEFAULT_EHT_HOSTS_LIMIT;
 
 	timer_setup(&port->multicast_router_timer,
 		    br_multicast_router_expired, 0);
diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index ff9b3ba37cab..445768c8495f 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -127,6 +127,8 @@ static void __eht_destroy_host(struct net_bridge_group_eht_host *eht_host)
 {
 	WARN_ON(!hlist_empty(&eht_host->set_entries));
 
+	br_multicast_eht_hosts_dec(eht_host->pg);
+
 	rb_erase(&eht_host->rb_node, &eht_host->pg->eht_host_tree);
 	RB_CLEAR_NODE(&eht_host->rb_node);
 	kfree(eht_host);
@@ -257,6 +259,9 @@ __eht_lookup_create_host(struct net_bridge_port_group *pg,
 			return this;
 	}
 
+	if (br_multicast_eht_hosts_over_limit(pg))
+		return NULL;
+
 	eht_host = kzalloc(sizeof(*eht_host), GFP_ATOMIC);
 	if (!eht_host)
 		return NULL;
@@ -269,6 +274,8 @@ __eht_lookup_create_host(struct net_bridge_port_group *pg,
 	rb_link_node(&eht_host->rb_node, parent, link);
 	rb_insert_color(&eht_host->rb_node, &pg->eht_host_tree);
 
+	br_multicast_eht_hosts_inc(pg);
+
 	return eht_host;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0e26ba623006..d242ba668e47 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -310,6 +310,8 @@ struct net_bridge_port {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct bridge_mcast_own_query	ip6_own_query;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
+	u32				multicast_eht_hosts_limit;
+	u32				multicast_eht_hosts_cnt;
 	unsigned char			multicast_router;
 	struct bridge_mcast_stats	__percpu *mcast_stats;
 	struct timer_list		multicast_router_timer;
diff --git a/net/bridge/br_private_mcast_eht.h b/net/bridge/br_private_mcast_eht.h
index 9daffa3ad8d5..b2c8d988721f 100644
--- a/net/bridge/br_private_mcast_eht.h
+++ b/net/bridge/br_private_mcast_eht.h
@@ -4,6 +4,8 @@
 #ifndef _BR_PRIVATE_MCAST_EHT_H_
 #define _BR_PRIVATE_MCAST_EHT_H_
 
+#define BR_MCAST_DEFAULT_EHT_HOSTS_LIMIT 512
+
 union net_bridge_eht_addr {
 	__be32				ip4;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -47,6 +49,7 @@ struct net_bridge_group_eht_set {
 	struct net_bridge_mcast_gc	mcast_gc;
 };
 
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 void br_multicast_eht_clean_sets(struct net_bridge_port_group *pg);
 bool br_multicast_eht_handle(struct net_bridge_port_group *pg,
 			     void *h_addr,
@@ -62,4 +65,27 @@ br_multicast_eht_should_del_pg(const struct net_bridge_port_group *pg)
 		  RB_EMPTY_ROOT(&pg->eht_host_tree));
 }
 
+static inline bool
+br_multicast_eht_hosts_over_limit(const struct net_bridge_port_group *pg)
+{
+	const struct net_bridge_port *p = pg->key.port;
+
+	return !!(p->multicast_eht_hosts_cnt >= p->multicast_eht_hosts_limit);
+}
+
+static inline void br_multicast_eht_hosts_inc(struct net_bridge_port_group *pg)
+{
+	struct net_bridge_port *p = pg->key.port;
+
+	p->multicast_eht_hosts_cnt++;
+}
+
+static inline void br_multicast_eht_hosts_dec(struct net_bridge_port_group *pg)
+{
+	struct net_bridge_port *p = pg->key.port;
+
+	p->multicast_eht_hosts_cnt--;
+}
+#endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
+
 #endif /* _BR_PRIVATE_MCAST_EHT_H_ */
-- 
2.29.2

