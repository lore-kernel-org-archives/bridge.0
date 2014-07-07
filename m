Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon,  7 Jul 2014 05:41:17 +0200
Message-Id: <1404704477-19448-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1404704477-19448-1-git-send-email-linus.luessing@web.de>
References: <1404704477-19448-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/2] bridge: export knowledge about the
	presence of IGMP/MLD queriers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, "David S. Miller" <davem@davemloft.net>

With this patch other modules are able to ask the bridge whether an
IGMP or MLD querier exists on the according, bridged link layer.

Multicast snooping can only be performed if a valid, selected querier
exists on a link.

Just like the bridge only enables its multicast snooping if a querier
exists, e.g. batman-adv too can only activate its multicast
snooping in bridged scenarios if a querier is present.

For instance this export avoids having to reimplement IGMP/MLD
querier message snooping and parsing in e.g. batman-adv, when
multicast optimizations for bridged scenarios are added in the
future.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 include/linux/if_bridge.h |    6 ++++++
 net/bridge/br_multicast.c |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index e0c575c..808dcb8 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -40,6 +40,7 @@ extern br_should_route_hook_t __rcu *br_should_route_hook;
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
 int br_multicast_list_adjacent(struct net_device *dev,
 			       struct list_head *br_ip_list);
+bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto);
 bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto);
 #else
 static inline int br_multicast_list_adjacent(struct net_device *dev,
@@ -47,6 +48,11 @@ static inline int br_multicast_list_adjacent(struct net_device *dev,
 {
 	return 0;
 }
+static inline bool br_multicast_has_querier_anywhere(struct net_device *dev,
+						     int proto)
+{
+	return false;
+}
 static inline bool br_multicast_has_querier_adjacent(struct net_device *dev,
 						     int proto)
 {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index abfa0b65..b4845f4 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2216,6 +2216,43 @@ unlock:
 EXPORT_SYMBOL_GPL(br_multicast_list_adjacent);
 
 /**
+ * br_multicast_has_querier_anywhere - Checks for a querier on a bridge
+ * @dev: The bridge port providing the bridge on which to check for a querier
+ * @proto: The protocol family to check for: IGMP -> ETH_P_IP, MLD -> ETH_P_IPV6
+ *
+ * Checks whether the given interface has a bridge on top and if so returns
+ * true if a valid querier exists anywhere on the bridged link layer.
+ * Otherwise returns false.
+ */
+bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
+{
+	struct net_bridge *br;
+	struct net_bridge_port *port;
+	struct ethhdr eth;
+	bool ret = false;
+
+	rcu_read_lock();
+	if (!br_port_exists(dev))
+		goto unlock;
+
+	port = br_port_get_rcu(dev);
+	if (!port || !port->br)
+		goto unlock;
+
+	br = port->br;
+
+	memset(&eth, 0, sizeof(eth));
+	eth.h_proto = htons(proto);
+
+	ret = br_multicast_querier_exists(br, &eth);
+
+unlock:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(br_multicast_has_querier_anywhere);
+
+/**
  * br_multicast_has_querier_adjacent - Checks for a querier behind a bridge port
  * @dev: The bridge port adjacent to which to check for a querier
  * @proto: The protocol family to check for: IGMP -> ETH_P_IP, MLD -> ETH_P_IPV6
-- 
1.7.10.4

