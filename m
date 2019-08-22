Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 22 Aug 2019 21:07:28 +0200
Message-ID: <1566500850-6247-2-git-send-email-horatiu.vultur@microchip.com>
In-Reply-To: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 1/3] net: Add HW_BRIDGE offload feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com, allan.nielsen@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch adds a netdev feature to configure the HW as a switch.
The purpose of this flag is to show that the hardware can do switching
of the frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/netdev_features.h |  3 +++
 net/bridge/br_if.c              | 29 ++++++++++++++++++++++++++++-
 net/core/ethtool.c              |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 4b19c54..34274de 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -78,6 +78,8 @@ enum {
 	NETIF_F_HW_TLS_TX_BIT,		/* Hardware TLS TX offload */
 	NETIF_F_HW_TLS_RX_BIT,		/* Hardware TLS RX offload */
 
+	NETIF_F_HW_BRIDGE_BIT,		/* Bridge offload support */
+
 	NETIF_F_GRO_HW_BIT,		/* Hardware Generic receive offload */
 	NETIF_F_HW_TLS_RECORD_BIT,	/* Offload TLS record */
 
@@ -150,6 +152,7 @@ enum {
 #define NETIF_F_GSO_UDP_L4	__NETIF_F(GSO_UDP_L4)
 #define NETIF_F_HW_TLS_TX	__NETIF_F(HW_TLS_TX)
 #define NETIF_F_HW_TLS_RX	__NETIF_F(HW_TLS_RX)
+#define NETIF_F_HW_BRIDGE	__NETIF_F(HW_BRIDGE)
 
 /* Finds the next feature with the highest number of the range of start till 0.
  */
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 4fe30b1..975a34c 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -127,6 +127,31 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
 	p->flags &= ~BR_PROMISC;
 }
 
+/* Determin if the SW bridge can be offloaded to HW. Return true if all
+ * the interfaces of the bridge have the feature NETIF_F_HW_SWITCHDEV set
+ * and have the same netdev_ops.
+ */
+static int br_hw_offload(struct net_bridge *br)
+{
+	const struct net_device_ops *ops = NULL;
+	struct net_bridge_port *p;
+
+	list_for_each_entry(p, &br->port_list, list) {
+		if (!(p->dev->hw_features & NETIF_F_HW_BRIDGE))
+			return 0;
+
+		if (!ops) {
+			ops = p->dev->netdev_ops;
+			continue;
+		}
+
+		if (ops != p->dev->netdev_ops)
+			return 0;
+	}
+
+	return 1;
+}
+
 /* When a port is added or removed or when certain port flags
  * change, this function is called to automatically manage
  * promiscuity setting of all the bridge ports.  We are always called
@@ -134,6 +159,7 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
  */
 void br_manage_promisc(struct net_bridge *br)
 {
+	bool hw_offload = br_hw_offload(br);
 	struct net_bridge_port *p;
 	bool set_all = false;
 
@@ -161,7 +187,8 @@ void br_manage_promisc(struct net_bridge *br)
 			    (br->auto_cnt == 1 && br_auto_port(p)))
 				br_port_clear_promisc(p);
 			else
-				br_port_set_promisc(p);
+				if (!hw_offload)
+					br_port_set_promisc(p);
 		}
 	}
 }
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 6288e69..4e224fe 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -111,6 +111,7 @@ static const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN]
 	[NETIF_F_HW_TLS_RECORD_BIT] =	"tls-hw-record",
 	[NETIF_F_HW_TLS_TX_BIT] =	 "tls-hw-tx-offload",
 	[NETIF_F_HW_TLS_RX_BIT] =	 "tls-hw-rx-offload",
+	[NETIF_F_HW_BRIDGE_BIT] =	 "hw-bridge-offload",
 };
 
 static const char
-- 
2.7.4

