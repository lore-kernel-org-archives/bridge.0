Return-Path: <wangyunjian@huawei.com>
From: wangyunjian <wangyunjian@huawei.com>
Date: Tue, 15 Jan 2019 11:12:39 +0800
Message-ID: <1547521959-3736-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2] net: bridge: Fix ethernet header pointer
	before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@cumulusnetworks.com>, Yunjian Wang <wangyunjian@huawei.com>, xudingke@huawei.com

From: Yunjian Wang <wangyunjian@huawei.com>

The skb header should be set to ethernet header before using
is_skb_forwardable. Because the ethernet header length has been
considered in is_skb_forwardable(including dev->hard_header_len
length).

To reproduce the issue:
1, add 2 ports on linux bridge br using following commands:
$ brctl addbr br
$ brctl addif br eth0
$ brctl addif br eth1
2, the mtu of eth0 and eth1 is 1500
3, send a 1504 packet from eth0 to eth1

So the expect result is packet larger than 1500 cannot pass through
eth0 and eth1. But currently, the packet passes through success, it
means eth1's mtu limit donen't take effect.

Fixes: f6367b4660dd ("bridge: use is_skb_forwardable in forward path")
Cc: bridge@lists.linux-foundation.org
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
v2:
 -fix commit log and cc the bridge maintainers with fixes tags
---
 net/bridge/br_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 5372e20..74b688b 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -36,10 +36,10 @@ static inline int should_deliver(const struct net_bridge_port *p,
 
 int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	skb_push(skb, ETH_HLEN);
 	if (!is_skb_forwardable(skb->dev, skb))
 		goto drop;
 
-	skb_push(skb, ETH_HLEN);
 	br_drop_fake_rtable(skb);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -97,10 +97,10 @@ static void __br_forward(const struct net_bridge_port *to,
 		net = dev_net(indev);
 	} else {
 		if (unlikely(netpoll_tx_running(to->br->dev))) {
+			skb_push(skb, ETH_HLEN);
 			if (!is_skb_forwardable(skb->dev, skb)) {
 				kfree_skb(skb);
 			} else {
-				skb_push(skb, ETH_HLEN);
 				br_netpoll_send_skb(to, skb);
 			}
 			return;
-- 
1.8.3.1


