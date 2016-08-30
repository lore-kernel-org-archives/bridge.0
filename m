Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=MvOg/lMQor0im4oMKkrRieGJGjA3ftDcUZBSrYdZcN8=;
	b=IRzRWnjSzDCP6pYR/BTRP5IfRu+7EPDrUNaEKnXlpM4idR4BA06qWG4Ji4fJKFA73p
	9EpajGf+40YZtxrfTj3yAhNguj/w7lB2aWNyQBY0Wkh/NBJ6FfceWItvuPtTbnbfdkzH
	PogQnjZIqV/gCmy4Ns1oKLuehqUJT53guFJb0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 17:44:29 +0200
Message-Id: <1472571869-3005-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: don't increment tx_dropped in
	br_do_proxy_arp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Kyeyoon Park <kyeyoonp@codeaurora.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@cumulusnetworks.com>

pskb_may_pull may fail due to various reasons (e.g. alloc failure), but the
skb isn't changed/dropped and processing continues so we shouldn't
increment tx_dropped.

CC: Kyeyoon Park <kyeyoonp@codeaurora.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: bridge@lists.linux-foundation.org
Fixes: 958501163ddd ("bridge: Add support for IEEE 802.11 Proxy ARP")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_input.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 8e486203d133..abe11f085479 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -80,13 +80,10 @@ static void br_do_proxy_arp(struct sk_buff *skb, struct net_bridge *br,
 
 	BR_INPUT_SKB_CB(skb)->proxyarp_replied = false;
 
-	if (dev->flags & IFF_NOARP)
+	if ((dev->flags & IFF_NOARP) ||
+	    !pskb_may_pull(skb, arp_hdr_len(dev)))
 		return;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev->stats.tx_dropped++;
-		return;
-	}
 	parp = arp_hdr(skb);
 
 	if (parp->ar_pro != htons(ETH_P_IP) ||
-- 
2.1.4

