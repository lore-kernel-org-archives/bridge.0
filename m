Return-Path: <mbizon@freebox.fr>
From: Maxime Bizon <mbizon@freebox.fr>
Message-Id: <1403534015-28496-1-git-send-email-mbizon@freebox.fr>
Subject: [Bridge] [PATCH] bridge: mark packets sent to any local mac address
	as PACKET_HOST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 23 Jun 2014 14:43:37 -0000
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, Maxime Bizon <mbizon@freebox.fr>

The bridge code only set PACKET_HOST on packets sent to the bridge mac
address, packets sent to other local mac addresses are sent to upper
layers, but ignored because they are marked as PACKET_OTHERHOST.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 net/bridge/br_input.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 366c436..b9cc8554 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -120,6 +120,7 @@ int br_handle_frame_finish(struct sk_buff *skb)
 			dst->is_local) {
 		skb2 = skb;
 		/* Do not forward the packet since it's local. */
+		skb2->pkt_type = PACKET_HOST;
 		skb = NULL;
 	}
 
-- 
1.7.9.5

