From: Changli Gao <xiaosuo@gmail.com>
Date: Sat, 25 Dec 2010 21:41:30 +0800
Message-Id: <1293284490-17114-1-git-send-email-xiaosuo@gmail.com>
Subject: [Bridge] [PATCH] net: bridge: check the length of skb after
	nf_bridge_maybe_copy_header()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Changli Gao <xiaosuo@gmail.com>

Since nf_bridge_maybe_copy_header() may change the length of skb,
we should check the length of skb after it to handle the ppoe skbs.

Signed-off-by: Changli Gao <xiaosuo@gmail.com>
---
 net/bridge/br_forward.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 2bd11ec..ee64287 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -41,17 +41,13 @@ static inline unsigned packet_length(const struct sk_buff *skb)
 
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
-	/* drop mtu oversized packets except gso */
-	if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
+	/* ip_fragment doesn't copy the MAC header */
+	if (nf_bridge_maybe_copy_header(skb) ||
+	    (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))) {
 		kfree_skb(skb);
-	else {
-		/* ip_fragment doesn't copy the MAC header */
-		if (nf_bridge_maybe_copy_header(skb))
-			kfree_skb(skb);
-		else {
-			skb_push(skb, ETH_HLEN);
-			dev_queue_xmit(skb);
-		}
+	} else {
+		skb_push(skb, ETH_HLEN);
+		dev_queue_xmit(skb);
 	}
 
 	return 0;
