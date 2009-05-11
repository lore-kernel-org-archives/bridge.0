Sender: Cyrill Gorcunov <gorcunov@gmail.com>
Message-Id: <20090511125350.555985895@openvz.org>
Date: Mon, 11 May 2009 15:46:40 +0400
From: Cyrill Gorcunov <gorcunov@openvz.org>
References: <20090511114639.440944109@openvz.org>
Content-Disposition: inline; filename=net-br-use-is_multicast
Subject: [Bridge] [RFC 1/5] net: bridge - use is_multicast_ether_addr helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

Instead of handwritten constrcution it's better 
to use is_multicast_ether_addr.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
---
 net/bridge/br_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.git/net/bridge/br_device.c
=====================================================================
--- linux-2.6.git.orig/net/bridge/br_device.c
+++ linux-2.6.git/net/bridge/br_device.c
@@ -32,7 +32,7 @@ int br_dev_xmit(struct sk_buff *skb, str
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
 
-	if (dest[0] & 1)
+	if (is_multicast_ether_addr(dest))
 		br_flood_deliver(br, skb);
 	else if ((dst = __br_fdb_get(br, dest)) != NULL)
 		br_deliver(dst->dst, skb);

