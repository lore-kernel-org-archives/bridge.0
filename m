Return-Path: <SRS0=8pH2=QL=linuxfoundation.org=gregkh@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276809;
	bh=20ymTtmY//YfJe8bCukmbRfQOq0OKsy/5HXrG4YdXyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goDfRTyecaIz6jGvWCOrQGOYJrWu2VjG6VE0neZ2YEU83/fuHq2wiEvjo5Kq4TkAf
	0Ed2y5PILup8CaJnco3PjiDTjxMNTkEYnwzi4aSXvIF51kLwKcMLnpjNElvgmVpxzl
	cyg9aRC+q9I6WlrKwK5v52Vfe4EbObpNwdZPBxjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon,  4 Feb 2019 11:35:58 +0100
Message-Id: <20190204103611.451902141@linuxfoundation.org>
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 4.4 05/65] net: bridge: Fix ethernet header pointer
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 net/bridge/br_forward.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -39,10 +39,10 @@ static inline int should_deliver(const s
 
 int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	skb_push(skb, ETH_HLEN);
 	if (!is_skb_forwardable(skb->dev, skb))
 		goto drop;
 
-	skb_push(skb, ETH_HLEN);
 	br_drop_fake_rtable(skb);
 	skb_sender_cpu_clear(skb);
 
@@ -88,12 +88,11 @@ static void __br_deliver(const struct ne
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
 


