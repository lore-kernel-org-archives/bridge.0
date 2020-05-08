Return-Path: <gregkh@linuxfoundation.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588942059;
 bh=lAWvsf08nZvSQrfzMExadqGz3aL2prjAHcmVRlzYXZg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JGNdz8lZwZ3kZY97w3pSEMAvvhh7dn4Stde5hNe0kNCdKG7FNjmuBGtWkcJt4v8+K
 rMLwlOiuDGZH0tvB6/W9/cZz4C2Q0ShogXGUC2AR+We+GQwWrcF9SAf94gAxwSJRAy
 96BL/d5htW9ok+xfgeuasAKfTQ/DeFpJslUCpcR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri,  8 May 2020 14:34:32 +0200
Message-Id: <20200508123144.177646487@linuxfoundation.org>
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 4.4 281/312] net: bridge: dont increment tx_dropped
	in br_do_proxy_arp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, stable@vger.kernel.org, Kyeyoon Park <kyeyoonp@codeaurora.org>, "David S. Miller" <davem@davemloft.net>

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 85a3d4a9356b595d5440c3f1bf07ee7cecca1567 upstream.

pskb_may_pull may fail due to various reasons (e.g. alloc failure), but the
skb isn't changed/dropped and processing continues so we shouldn't
increment tx_dropped.

CC: Kyeyoon Park <kyeyoonp@codeaurora.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: bridge@lists.linux-foundation.org
Fixes: 958501163ddd ("bridge: Add support for IEEE 802.11 Proxy ARP")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/br_input.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -78,13 +78,10 @@ static void br_do_proxy_arp(struct sk_bu
 
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


