Return-Path: <gregkh@linuxfoundation.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588869591;
 bh=wq2CHy58Cr6P3g53lcN3y4RE88fxN0x54WdnN8sOIko=;
 h=Subject:To:Cc:From:Date:From;
 b=k99ZnXN1Xe9/36qor8EMQZQYeE1HFIs0avbfPwlKKED5WjDC4Qc+GskEPSvkNAVyT
 4F841Q2Q0eycKHg/x1MH/bPE6+kTK/5ldQDkUIXWTbBvmIogA2du6VxgMbkgCfulgq
 p7K8+LWZvcGaEjPtVouRvO5YOeYtYyCJQVrlXcXc=
From: <gregkh@linuxfoundation.org>
Date: Thu, 07 May 2020 18:39:13 +0200
Message-ID: <1588869553183206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Patch "net: bridge: don't increment tx_dropped in
	br_do_proxy_arp" has been added to the 4.4-stable tree
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, davem@davemloft.net, gregkh@linuxfoundation.org, kyeyoonp@codeaurora.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, stephen@networkplumber.org
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    net: bridge: don't increment tx_dropped in br_do_proxy_arp

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     net-bridge-don-t-increment-tx_dropped-in-br_do_proxy_arp.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 85a3d4a9356b595d5440c3f1bf07ee7cecca1567 Mon Sep 17 00:00:00 2001
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Aug 2016 17:44:29 +0200
Subject: net: bridge: don't increment tx_dropped in br_do_proxy_arp

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


Patches currently in stable-queue which might be from nikolay@cumulusnetworks.com are

queue-4.4/bonding-prevent-out-of-bound-accesses.patch
queue-4.4/net-bridge-don-t-increment-tx_dropped-in-br_do_proxy_arp.patch
