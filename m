Message-Id: <20070425234950.610323798@linux-foundation.org>
References: <20070425234737.727790594@linux-foundation.org>
Date: Wed, 25 Apr 2007 16:47:38 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Content-Disposition: inline; filename=bridge-stp-multicast.patch
Subject: [Bridge] [PATCH 1/4] bridge: don't change packet type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

The change to forward STP bpdu's (for usermode STP) through normal path,
changed the packet type in the process. Since link local stuff is multicast, it
should stay pkt_type = PACKET_MULTICAST.  The code was probably copy/pasted
incorrectly from the bridge pseudo-device receive path.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- bridge-2.6.22.orig/net/bridge/br_input.c
+++ bridge-2.6.22/net/bridge/br_input.c
@@ -131,12 +131,9 @@ struct sk_buff *br_handle_frame(struct n
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
 		goto drop;
 
-	if (unlikely(is_link_local(dest))) {
-		skb->pkt_type = PACKET_HOST;
-
+	if (unlikely(is_link_local(dest)))
 		return (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
 				NULL, br_handle_local_finish) == 0) ? skb : NULL;
-	}
 
 	switch (p->state) {
 	case BR_STATE_FORWARDING:

-- 

