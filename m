Return-Path: <mbizon@freebox.fr>
Message-ID: <1398189018.19788.2.camel@sakura.staff.proxad.net>
From: Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: [Bridge] [PATCH][RFC] bridge: mark packets sent to any local mac
 address as PACKET_HOST
Reply-To: mbizon@freebox.fr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 22 Apr 2014 17:59:06 -0000
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org


The bridge code only set PACKET_HOST on packets sent to the bridge mac
address, packets sent to other local mac addresses are sent to upper
layer, but ignored because they are marked as PACKET_OTHERHOST.
---
 net/bridge/br_input.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 7985dea..b942561 100644
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


-- 
Maxime


