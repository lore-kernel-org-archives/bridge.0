Date: Mon, 21 Jun 2004 14:50:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040621145040.4e4a0b3d@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.4] (1/2) bridge - backport of API checking
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: bridge@osdl.org

This adds the checks in 2.6 for invalid ether 
and deleting wrong bridge port to 2.4.27 (from Erich Schubert)

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	2004-06-21 07:47:10 -07:00
+++ b/net/bridge/br_if.c	2004-06-21 07:47:10 -07:00
@@ -19,6 +19,7 @@
 #include <linux/inetdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/brlock.h>
+#include <linux/etherdevice.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
@@ -44,7 +45,7 @@
 	struct net_bridge_port *p;
 	struct net_bridge_port **pptr;
 
-	if ((p = dev->br_port) == NULL)
+	if ((p = dev->br_port) == NULL || p->br != br)
 		return -EINVAL;
 
 	br_stp_disable_port(p);
@@ -231,6 +232,9 @@
 
 	if (dev->hard_start_xmit == br_dev_xmit)
 		return -ELOOP;
+
+	if (!is_valid_ether_addr(dev->dev_addr))
+		return -EADDRNOTAVAIL;
 
 	dev_hold(dev);
 	write_lock_bh(&br->lock);
