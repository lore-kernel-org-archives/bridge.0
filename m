Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 26 Aug 2019 10:11:13 +0200
Message-ID: <1566807075-775-2-git-send-email-horatiu.vultur@microchip.com>
In-Reply-To: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
References: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH v2 1/3] net: Add NETIF_HW_BR_CAP feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com, allan.nielsen@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch adds a netdev feature to allow the SW bridge not to set all the
slave interfaces in promisc mode if the HW is capable of learning and
flooading the frames.

The current implementation adds all the bridge ports in promisc mode. Even
if the HW has bridge capabilities(can learn and flood frames). Then all the
frames will be copy to the CPU even if there are cases where there is no
need for this.

For example in the following scenario:
+----------------------------------+
|               SW BR              |
+----------------------------------+
|      |                  |
|      |        +------------------+
|      |        |       HW BR      |
|      |        +------------------+
|      |          |            |
+      +          +            +
p1     p2         p3           p4

Case A: There is a SW bridge with the ports p1 and p2
Case B: There is a SW bridge with the ports p3 and p4.
Case C: THere is a SW bridge with the ports p2, p3 and p4.

For case A, the HW can't do learning and flooding of the frames. Therefore
all the frames need to be copied to the CPU to allow the SW bridge to
decide what do do with the frame(forward, flood, copy to the upper layers,
etc..).

For case B, there is HW support to learn and flood the frames. In this case
there is no point to send all the frames to the CPU(except for frames that
need to go to CPU and flooded frames if flooding is enabled). Because the
HW will already forward the frame to the correct network port, then the
SW bridge will not have anything to do. It would just use CPU cycles and
then drop the frame. The reason for dropping the frame is that the network
driver will set the flag fwd_offload_mark and then SW bridge will skip all
the ports that have the same parent_id as the port that received the frame.
Which is this case.

For case C, there is HW support to learn and flood frames for ports p3 and
p4 while p2 doesn't have HW support. In this case the port p2 needs to be
in promisc mode to allow SW bridge to do the learning and flooding of the
frames while ports p3 and p4 they don't need to be in promisc mode.
The ports p3 and p4 need to make sure that the CPU is in flood mask and
need to know which addresses can be access through SW bridge so it could
send those frames to CPU port. So it would allow the SW bridge to send to
the correct network port.

A workaround for all these cases is not to set the network port in
promisc mode if it is a bridge port, which is the case for mlxsw. Or not
to implement it at all, which is the case for ocelot. But the disadvantage
of this approach is that the network bridge ports can not be set in promisc
mode if there is a need to monitor all the traffic on that port using the
command 'ip link set dev swp promisc on'. This patch adds also support for
this case.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/netdev_features.h |  6 ++++++
 net/bridge/br_if.c              | 11 ++++++++++-
 net/core/ethtool.c              |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 4b19c54..b5a3463 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -78,6 +78,11 @@ enum {
 	NETIF_F_HW_TLS_TX_BIT,		/* Hardware TLS TX offload */
 	NETIF_F_HW_TLS_RX_BIT,		/* Hardware TLS RX offload */
 
+	NETIF_F_HW_BR_CAP_BIT,		/* Hardware is capable to behave as a
+					 * bridge to learn and switch frames
+					 */
+
+
 	NETIF_F_GRO_HW_BIT,		/* Hardware Generic receive offload */
 	NETIF_F_HW_TLS_RECORD_BIT,	/* Offload TLS record */
 
@@ -150,6 +155,7 @@ enum {
 #define NETIF_F_GSO_UDP_L4	__NETIF_F(GSO_UDP_L4)
 #define NETIF_F_HW_TLS_TX	__NETIF_F(HW_TLS_TX)
 #define NETIF_F_HW_TLS_RX	__NETIF_F(HW_TLS_RX)
+#define NETIF_F_HW_BR_CAP	__NETIF_F(HW_BR_CAP)
 
 /* Finds the next feature with the highest number of the range of start till 0.
  */
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 4fe30b1..93bfc55 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -161,7 +161,16 @@ void br_manage_promisc(struct net_bridge *br)
 			    (br->auto_cnt == 1 && br_auto_port(p)))
 				br_port_clear_promisc(p);
 			else
-				br_port_set_promisc(p);
+				/* If the HW has bridge capabilities to learn
+				 * and flood the frames then there is no need
+				 * to copy all the frames to the SW to do the
+				 * same. Because the HW already switched the
+				 * frame and then there is nothing to do for
+				 * the SW bridge. The SW will just use CPU
+				 * and it would drop the frame.
+				 */
+				if (!(p->dev->features & NETIF_F_HW_BR_CAP))
+					br_port_set_promisc(p);
 		}
 	}
 }
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 6288e69..10430fe 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -111,6 +111,7 @@ static const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN]
 	[NETIF_F_HW_TLS_RECORD_BIT] =	"tls-hw-record",
 	[NETIF_F_HW_TLS_TX_BIT] =	 "tls-hw-tx-offload",
 	[NETIF_F_HW_TLS_RX_BIT] =	 "tls-hw-rx-offload",
+	[NETIF_F_HW_BR_CAP_BIT] =	 "bridge-capabilities-offload",
 };
 
 static const char
-- 
2.7.4

