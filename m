Return-Path: <SRS0=Yq8B=QF=linuxfoundation.org=gregkh@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762644;
	bh=AFyzQwdmwwoIk+2NzayeE0HLrbyAZ6pqw3LqqChiMRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+L7sV9hJjIqziDyKlqjJvfzxHOQv9+bDq7k8JTgHW007gL35LXJQg+J5Ttdqt9Ng
	mgtSYchw97ErSvhoJ/j67s8SenZaOHdnVNimd5unnc7A3gLEvbtRfCfykGeds6i/Ds
	A1vZ6VRXbOc0vn6kK8lrRrNIVVDQMyxSQM0PPr5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 29 Jan 2019 12:35:56 +0100
Message-Id: <20190129113140.009177508@linuxfoundation.org>
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 4.9 01/44] net: bridge: Fix ethernet header pointer
	before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Yunjian Wang <wangyunjian@huawei.com>, Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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


