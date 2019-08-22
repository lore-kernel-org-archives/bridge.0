Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 22 Aug 2019 21:07:29 +0200
Message-ID: <1566500850-6247-3-git-send-email-horatiu.vultur@microchip.com>
In-Reply-To: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 2/3] net: mscc: Use NETIF_F_HW_BRIDGE
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

Enable HW_BRIDGE feature for ocelot. In this way the HW will do all the
switching of the frames so it is not needed for the ports to be in promisc
mode.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 4d1bce4..c9cf2bee 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -2017,8 +2017,10 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 	dev->ethtool_ops = &ocelot_ethtool_ops;
 
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS |
-		NETIF_F_HW_TC;
-	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
+		NETIF_F_HW_TC | NETIF_F_HW_BRIDGE;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC |
+		NETIF_F_HW_BRIDGE;
+	dev->priv_flags |= IFF_UNICAST_FLT;
 
 	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
 	dev->dev_addr[ETH_ALEN - 1] += port;
-- 
2.7.4

