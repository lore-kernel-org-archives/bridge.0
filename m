Date: Mon, 23 Aug 2010 12:35:32 +0900
From: Simon Horman <horms@verge.net.au>
Message-ID: <20100823033532.GA28463@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [rfc] bridge: is PACKET_LOOPBACK unlikely()?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Jesse Gross <jesse@nicira.com>, Jiri Pirko <jpirko@redhat.com>

While looking at using netdev_rx_handler_register for openvswitch Jesse
Gross suggested that an unlikely() might be worthwhile in that code.
I'm interested to see if its appropriate for the bridge code.

Cc: Jesse Gross <jesse@nicira.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: net-next-2.6/net/bridge/br_input.c
===================================================================
--- net-next-2.6.orig/net/bridge/br_input.c	2010-08-23 12:17:58.000000000 +0900
+++ net-next-2.6/net/bridge/br_input.c	2010-08-23 12:19:46.000000000 +0900
@@ -141,7 +141,7 @@ struct sk_buff *br_handle_frame(struct s
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
 	int (*rhook)(struct sk_buff *skb);
 
-	if (skb->pkt_type == PACKET_LOOPBACK)
+	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
 		return skb;
 
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
