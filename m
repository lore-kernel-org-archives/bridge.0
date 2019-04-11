Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=e2Cyu5wZD1o5O7FXPAqIqm0AabQ+tygwXhac+ZfAR/w=;
	b=ggtbRiZ7+Tfdi/t5Z5Nj5eb4KwbnbsbfrwCAeZYgMWI/ARM49nLAcigtkIyyRsP1nL
	T/SKjAYmDTQLHuj3cOPXta+kjiNqbEuQ7ibY9IhGhWRE0unNjjyAigFzDiV78Gc875S9
	e2YfQxqX3txcGYor6qlF2HBfFkyhSrf0A0NRU=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 11 Apr 2019 13:56:39 +0300
Message-Id: <20190411105639.7358-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: fix per-port af_packet sockets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de

When the commit below was introduced it changed two visible things:
 - the skb was no longer passed through the protocol handlers with the
   original device
 - the skb was passed up the stack with skb->dev = bridge

The first change broke af_packet sockets on bridge ports. For example we
use them for hostapd which listens for ETH_P_PAE packets on the ports.
We discussed two possible fixes:
 - create a clone and pass it through NF_HOOK(), act on the original skb
   based on the result
 - somehow signal to the caller from the okfn() that it was called,
   meaning the skb is ok to be passed, which this patch is trying to
   implement via returning 1 from the bridge link-local okfn()

Note that we rely on the fact that NF_QUEUE/STOLEN would return 0 and
drop/error would return < 0 thus the okfn() is called only when the
return was 1, so we signal to the caller that it was called by preserving
the return value from nf_hook().

Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
I plan to make a selftest for this one too. Once we agree on the fix.

 net/bridge/br_input.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5ea7e56119c1..ba303ee99b9b 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -197,13 +197,10 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 /* note: already called with rcu_read_lock */
 static int br_handle_local_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
-
 	__br_handle_local_finish(skb);
 
-	BR_INPUT_SKB_CB(skb)->brdev = p->br->dev;
-	br_pass_frame_up(skb);
-	return 0;
+	/* return 1 to signal the okfn() was called so it's ok to use the skb */
+	return 1;
 }
 
 /*
@@ -280,10 +277,18 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 				goto forward;
 		}
 
-		/* Deliver packet to local host only */
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, dev_net(skb->dev),
-			NULL, skb, skb->dev, NULL, br_handle_local_finish);
-		return RX_HANDLER_CONSUMED;
+		/* The else clause should be hit when nf_hook():
+		 *   - returns < 0 (drop/error)
+		 *   - returns = 0 (stolen/nf_queue)
+		 * Thus return 1 from the okfn() to signal the skb is ok to pass
+		 */
+		if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
+			    dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+			    br_handle_local_finish) == 1) {
+			return RX_HANDLER_PASS;
+		} else {
+			return RX_HANDLER_CONSUMED;
+		}
 	}
 
 forward:
-- 
2.20.1

