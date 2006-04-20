Date: Thu, 20 Apr 2006 14:44:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060420144419.71f0c03d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: allow full size vlan tagged packets to be
	bridged
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@osdl.org

The Ethernet bridge code silently drops packets when forwarding a packet
that is too large for the destination interface (as per 802.1d). But it
should allow for VLAN tagged frames.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- bridge.orig/net/bridge/br_forward.c	2006-04-10 16:17:51.000000000 -0700
+++ bridge/net/bridge/br_forward.c	2006-04-19 13:50:42.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/if_vlan.h>
 #include <linux/netfilter_bridge.h>
 #include "br_private.h"
 
@@ -29,10 +30,15 @@
 	return 1;
 }
 
+static inline unsigned packet_length(const struct sk_buff *skb)
+{
+	return skb->len - (skb->protocol == htons(ETH_P_8021Q) ? VLAN_HLEN : 0);
+}
+
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
 	/* drop mtu oversized packets except tso */
-	if (skb->len > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
+	if (packet_length(skb) > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
 		kfree_skb(skb);
 	else {
 #ifdef CONFIG_BRIDGE_NETFILTER
