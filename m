Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zy0C67079dKM2qzqcNpb2hl3akbZywYG5Z46PJrnyD4=;
	b=WrrtlxZZH88oDOn4U+1Vn8NfrmxMM/ZzOEU+2adKSYvpCLfMXwEGguJ/l1TYIxtYQi
	ZKzLEy2lg6LwzeRiAm/jqMFXdluZlvuJGjyIH2JnTRHesjdWIr24LLIp8LicxUXbCRo7
	5RLyxHLBxk1jWk8tTrkreEF8SBE3DSOJCG0Zc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 14 Jul 2016 06:10:00 +0300
Message-Id: <1468465802-4571-3-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/4] net: bridge: rearrange flood vs
	unicast receive paths
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

This patch removes one conditional from the unicast path by using the fact
that skb is NULL only when the packet is multicast or is local.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_input.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 0b6d32619468..c20c5be6fc22 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -134,10 +134,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
 	struct net_bridge_fdb_entry *dst = NULL;
+	bool mcast_hit = false, unicast = true;
 	struct net_bridge_mdb_entry *mdst;
 	struct net_bridge *br;
 	struct sk_buff *skb2;
-	bool unicast = true;
 	u16 vid = 0;
 
 	if (!p || p->state == BR_STATE_DISABLED)
@@ -177,30 +177,29 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(br, eth_hdr(skb))) {
 			if ((mdst && mdst->mglist) ||
-			    br_multicast_is_router(br))
+			    br_multicast_is_router(br)) {
 				skb2 = skb;
-			br_multicast_forward(mdst, skb, skb2);
-			skb = NULL;
-			if (!skb2)
-				goto out;
+				br->dev->stats.multicast++;
+			}
+			mcast_hit = true;
 		} else {
 			skb2 = skb;
+			br->dev->stats.multicast++;
 		}
 		unicast = false;
-		br->dev->stats.multicast++;
 	} else if ((dst = __br_fdb_get(br, dest, vid)) && dst->is_local) {
-		skb2 = skb;
 		/* Do not forward the packet since it's local. */
-		skb = NULL;
+		return br_pass_frame_up(skb);
 	}
 
-	if (skb) {
-		if (dst) {
-			dst->used = jiffies;
-			br_forward(dst->dst, skb, skb2);
-		} else {
+	if (dst) {
+		dst->used = jiffies;
+		br_forward(dst->dst, skb, skb2);
+	} else {
+		if (!mcast_hit)
 			br_flood_forward(br, skb, skb2, unicast);
-		}
+		else
+			br_multicast_forward(mdst, skb, skb2);
 	}
 
 	if (skb2)
-- 
2.4.3

