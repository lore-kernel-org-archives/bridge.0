Return-Path: <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.710221079@decadent.org.uk>
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
Subject: [Bridge] [PATCH 3.16 052/202] net: bridge: Fix ethernet header
 pointer before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yunjian Wang <wangyunjian@huawei.com>, Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yunjian Wang <wangyunjian@huawei.com>

commit 28c1382fa28f2e2d9d0d6f25ae879b5af2ecbd03 upstream.

The skb header should be set to ethernet header before using
is_skb_forwardable. Because the ethernet header length has been
considered in is_skb_forwardable(including dev->hard_header_len
length).

To reproduce the issue:
1, add 2 ports on linux bridge br using following commands:
$ brctl addbr br
$ brctl addif br eth0
$ brctl addif br eth1
2, the MTU of eth0 and eth1 is 1500
3, send a packet(Data 1480, UDP 8, IP 20, Ethernet 14, VLAN 4)
from eth0 to eth1

So the expect result is packet larger than 1500 cannot pass through
eth0 and eth1. But currently, the packet passes through success, it
means eth1's MTU limit doesn't take effect.

Fixes: f6367b4660dd ("bridge: use is_skb_forwardable in forward path")
Cc: bridge@lists.linux-foundation.org
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - br_dev_queue_push_xmit() has to call nf_bridge_maybe_copy_header()
   before pushing the Ethernet header
 - adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -38,16 +38,21 @@ static inline int should_deliver(const s
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
 	/* ip_fragment doesn't copy the MAC header */
-	if (nf_bridge_maybe_copy_header(skb) ||
-	    !is_skb_forwardable(skb->dev, skb)) {
-		kfree_skb(skb);
-	} else {
-		skb_push(skb, ETH_HLEN);
-		br_drop_fake_rtable(skb);
-		dev_queue_xmit(skb);
-	}
+	if (nf_bridge_maybe_copy_header(skb))
+		goto drop;
+
+	skb_push(skb, ETH_HLEN);
+	if (!is_skb_forwardable(skb->dev, skb))
+		goto drop;
+
+	br_drop_fake_rtable(skb);
+	dev_queue_xmit(skb);
 
 	return 0;
+
+drop:
+	kfree_skb(skb);
+	return 0;
 }
 
 int br_forward_finish(struct sk_buff *skb)
@@ -66,12 +71,11 @@ static void __br_deliver(const struct ne
 	skb->dev = to->dev;
 
 	if (unlikely(netpoll_tx_running(to->br->dev))) {
+		skb_push(skb, ETH_HLEN);
 		if (!is_skb_forwardable(skb->dev, skb))
 			kfree_skb(skb);
-		else {
-			skb_push(skb, ETH_HLEN);
+		else
 			br_netpoll_send_skb(to, skb);
-		}
 		return;
 	}
 

