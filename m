Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 25 Apr 2021 18:00:50 +0200
Message-Id: <20210425160050.8732-3-linus.luessing@c0d3.blue>
In-Reply-To: <20210425160050.8732-1-linus.luessing@c0d3.blue>
References: <20210425160050.8732-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: mcast: export multicast
	router presence adjacent to a port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

To properly support routable multicast addresses in batman-adv in a
group-aware way, a batman-adv node needs to know if it serves multicast
routers.

This adds a function to the bridge to export this so that batman-adv
can then make full use of the Multicast Router Discovery capability of
the bridge.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/linux/if_bridge.h |  8 ++++++
 net/bridge/br_multicast.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 2cc35038a8ca..12e9a32dbca0 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -67,6 +67,7 @@ int br_multicast_list_adjacent(struct net_device *dev,
 			       struct list_head *br_ip_list);
 bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto);
 bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto);
+bool br_multicast_has_router_adjacent(struct net_device *dev, int proto);
 bool br_multicast_enabled(const struct net_device *dev);
 bool br_multicast_router(const struct net_device *dev);
 int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
@@ -87,6 +88,13 @@ static inline bool br_multicast_has_querier_adjacent(struct net_device *dev,
 {
 	return false;
 }
+
+static inline bool br_multicast_has_router_adjacent(struct net_device *dev,
+						    int proto)
+{
+	return true;
+}
+
 static inline bool br_multicast_enabled(const struct net_device *dev)
 {
 	return false;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0ebdbf09f44c..4afaf011f171 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4013,6 +4013,64 @@ bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
 }
 EXPORT_SYMBOL_GPL(br_multicast_has_querier_adjacent);
 
+/**
+ * br_multicast_has_router_adjacent - Checks for a router behind a bridge port
+ * @dev: The bridge port adjacent to which to check for a multicast router
+ * @proto: The protocol family to check for: IGMP -> ETH_P_IP, MLD -> ETH_P_IPV6
+ *
+ * Checks whether the given interface has a bridge on top and if so returns
+ * true if a multicast router is behind one of the other ports of this
+ * bridge. Otherwise returns false.
+ */
+bool br_multicast_has_router_adjacent(struct net_device *dev, int proto)
+{
+	struct net_bridge_port *port, *p;
+	bool ret = false;
+
+	rcu_read_lock();
+	if (!netif_is_bridge_port(dev))
+		goto unlock;
+
+	port = br_port_get_rcu(dev);
+	if (!port || !port->br)
+		goto unlock;
+
+	switch (proto) {
+	case ETH_P_IP:
+		hlist_for_each_entry_rcu(p, &port->br->ip4_mc_router_list,
+					 ip4_rlist) {
+			if (p == port)
+				continue;
+
+			ret = true;
+			goto unlock;
+		}
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
+		hlist_for_each_entry_rcu(p, &port->br->ip6_mc_router_list,
+					 ip6_rlist) {
+			if (p == port)
+				continue;
+
+			ret = true;
+			goto unlock;
+		}
+		break;
+#endif
+	default:
+		/* when compiled without IPv6 support, be conservative and
+		 * always assume presence of an IPv6 multicast router
+		 */
+		ret = true;
+	}
+
+unlock:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(br_multicast_has_router_adjacent);
+
 static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
 			       const struct sk_buff *skb, u8 type, u8 dir)
 {
-- 
2.31.0

