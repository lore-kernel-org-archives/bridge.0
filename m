Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
Date: Sat, 31 Mar 2018 00:05:17 -0700
Message-Id: <a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Subject: [Bridge] [PATCH 02/12] treewide/net: Rename eth_stp_addr to
	ether_stp_addr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Florian Fainelli <f.fainelli@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

eth_stp_addr is not in the same form as the other global ether_<foo>_addr
addresses like ether_broadcast_addr.

Convert it treewide.

Miscellanea:

o Add comment to the ether_stp_addr define to show it's for spanning-tree

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/dsa/lan9303-core.c | 4 ++--
 include/linux/etherdevice.h    | 3 ++-
 net/bridge/br_device.c         | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index fefa454f3e56..a6f015ef251a 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -789,7 +789,7 @@ static int lan9303_separate_ports(struct lan9303 *chip)
 {
 	int ret;
 
-	lan9303_alr_del_port(chip, eth_stp_addr, 0);
+	lan9303_alr_del_port(chip, ether_stp_addr, 0);
 	ret = lan9303_write_switch_reg(chip, LAN9303_SWE_PORT_MIRROR,
 				LAN9303_SWE_PORT_MIRROR_SNIFFER_PORT0 |
 				LAN9303_SWE_PORT_MIRROR_MIRRORED_PORT1 |
@@ -814,7 +814,7 @@ static void lan9303_bridge_ports(struct lan9303 *chip)
 
 	lan9303_write_switch_reg(chip, LAN9303_SWE_PORT_STATE,
 				 chip->swe_port_state);
-	lan9303_alr_add_port(chip, eth_stp_addr, 0, true);
+	lan9303_alr_add_port(chip, ether_stp_addr, 0, true);
 }
 
 static void lan9303_handle_reset(struct lan9303 *chip)
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 85d2486b2959..142da8043b24 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -70,7 +70,8 @@ extern const u8 ether_zero_addr[ETH_ALEN];	/* all zeros */
 /* Reserved Ethernet Addresses per IEEE 802.1Q */
 extern const u8 ether_reserved_addr_base[ETH_ALEN];
 
-#define eth_stp_addr ether_reserved_addr_base
+/* Ethernet bridge - spanning tree protocol */
+#define ether_stp_addr ether_reserved_addr_base
 
 /**
  * is_link_local_ether_addr - Determine if given Ethernet address is link-local
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 278fc999d355..3abcf69d1976 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -1,4 +1,4 @@
-/*
+gg/*
  *	Device handling code
  *	Linux ethernet bridge
  *
@@ -431,7 +431,7 @@ void br_dev_setup(struct net_device *dev)
 	br->bridge_id.prio[0] = 0x80;
 	br->bridge_id.prio[1] = 0x00;
 
-	ether_addr_copy(br->group_addr, eth_stp_addr);
+	ether_addr_copy(br->group_addr, ether_stp_addr);
 
 	br->stp_enabled = BR_NO_STP;
 	br->group_fwd_mask = BR_GROUPFWD_DEFAULT;
-- 
2.15.0

