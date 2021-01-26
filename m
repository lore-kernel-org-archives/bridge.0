Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGsRWy51vjzAAtKfm5HLV3fNy1Jk4kk0SKHg2lCkGU0=;
 b=kEQWCDjvtuvjd6M8uTc5wfk2OWNPfWOQWCw4t4QXxwV+1HKuEyOOygdrIiUJj7ZaG8
 DtpHDKIfc6Ed0Ja/hgmsAnbYN3+xUgJLkak7o3RaiE01cWEt2mFG9Cihnl8uAVCA11sg
 chj+cFOr/6HWmh/CN9XEKytrz78Qxf0cZoUHsui4KebU/WRjVga4arv0t24VGE/Zg+Ld
 8CyzxMp1O3Jsg/c5vgMPjgygNLDAjocF1AiNsyxzsIHVI0PtWVhB4vyUe8W1iGhC0iiG
 XxzwfSqSWB+NiILCUrcEI+wzprgfG8x2Ezxj9M5Wa4tMd93bTJLzDVOsdacsUpik3Wrh
 gV4Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 26 Jan 2021 11:21:31 +0200
Message-Id: <20210126092132.407355-2-razor@blackwall.org>
In-Reply-To: <20210126092132.407355-1-razor@blackwall.org>
References: <20210126092132.407355-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/2] net: bridge: multicast: add per-port
	EHT hosts limit
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
 net/bridge/br_multicast.c         |  1 +
 net/bridge/br_multicast_eht.c     |  7 +++++++
 net/bridge/br_private.h           |  2 ++
 net/bridge/br_private_mcast_eht.h | 26 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index df5db6a58e95..8c0029f415ea 100644
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

