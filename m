Date: Wed, 7 Mar 2007 16:03:55 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070307160355.0e27f425@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: adding new device to bridge should enable
	if up
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

One change introduced by the workqueue removal patch is that adding an
interface that is up to a bridge which is also up does not ever call
br_stp_enable_port(), leaving the port in DISABLED state until we do
ifconfig down and up or link events occur.

The following patch to the br_add_if function fixes it.
This is a regression introduced in 2.6.21.

Submitted-by: Aji_Srinivas@emc.com
Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

diff -Naur a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	2007-02-28 15:34:38.000000000 +0530
+++ b/net/bridge/br_if.c	2007-03-08 01:49:20.000000000 +0530
@@ -428,6 +428,10 @@
 	spin_lock_bh(&br->lock);
 	br_stp_recalculate_bridge_id(br);
 	br_features_recompute(br);
+
+	if ((dev->flags & IFF_UP) && netif_carrier_ok(dev) &&
+	    (br->dev->flags & IFF_UP)) 
+		br_stp_enable_port(p);
 	spin_unlock_bh(&br->lock);
 
 	dev_set_mtu(br->dev, br_min_mtu(br));

