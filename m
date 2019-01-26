Return-Path: <SRS0=QhAl=QC=linuxfoundation.org=gregkh@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548497229;
	bh=LgJ/bYWCjUpqyU6vFlRfzyUjgg0X9jzznLflOFkoyy4=;
	h=Subject:To:Cc:From:Date:From;
	b=CwRkelBpp0JlXNSedWMG3H5hPhT8k5Wl92n0JANV6piaCqNqGF20WJ9ekgE0Zcl4+
	iAx/EEccotmq4zGjGb1Qxi1JIB7lac78v0BXs99i9hEg8nM8S5uszWMwlDy9DnY4vN
	e+SGNgwh8U66BKG6BdL8kDN4UunLETaHppU1ZsAA=
From: <gregkh@linuxfoundation.org>
Date: Sat, 26 Jan 2019 11:07:06 +0100
Message-ID: <154849722649213@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Patch "net: bridge: Fix ethernet header pointer before
	check skb forwardable" has been added to the 4.9-stable tree
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, davem@davemloft.net, gregkh@linuxfoundation.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, stephen@networkplumber.org, wangyunjian@huawei.com
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    net: bridge: Fix ethernet header pointer before check skb forwardable

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     net-bridge-fix-ethernet-header-pointer-before-check-skb-forwardable.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Sat Jan 26 10:53:10 CET 2019
From: Yunjian Wang <wangyunjian@huawei.com>
Date: Thu, 17 Jan 2019 09:46:41 +0800
Subject: net: bridge: Fix ethernet header pointer before check skb forwardable

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit 28c1382fa28f2e2d9d0d6f25ae879b5af2ecbd03 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_forward.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -35,10 +35,10 @@ static inline int should_deliver(const s
 
 int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	skb_push(skb, ETH_HLEN);
 	if (!is_skb_forwardable(skb->dev, skb))
 		goto drop;
 
-	skb_push(skb, ETH_HLEN);
 	br_drop_fake_rtable(skb);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -96,12 +96,11 @@ static void __br_forward(const struct ne
 		net = dev_net(indev);
 	} else {
 		if (unlikely(netpoll_tx_running(to->br->dev))) {
-			if (!is_skb_forwardable(skb->dev, skb)) {
+			skb_push(skb, ETH_HLEN);
+			if (!is_skb_forwardable(skb->dev, skb))
 				kfree_skb(skb);
-			} else {
-				skb_push(skb, ETH_HLEN);
+			else
 				br_netpoll_send_skb(to, skb);
-			}
 			return;
 		}
 		br_hook = NF_BR_LOCAL_OUT;


Patches currently in stable-queue which might be from wangyunjian@huawei.com are

queue-4.9/net-bridge-fix-ethernet-header-pointer-before-check-skb-forwardable.patch
