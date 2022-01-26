Return-Path: <huangguobin4@huawei.com>
From: Huang Guobin <huangguobin4@huawei.com>
Date: Wed, 26 Jan 2022 11:36:39 +0800
Message-ID: <20220126033639.909340-2-huangguobin4@huawei.com>
In-Reply-To: <20220126033639.909340-1-huangguobin4@huawei.com>
References: <20220126033639.909340-1-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 4.19 1/1] net: bridge: clear bridge's private skb
	space on xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stable@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit fd65e5a95d08389444e8591a20538b3edece0e15 ]

We need to clear all of the bridge private skb variables as they can be
stale due to the packet being recirculated through the stack and then
transmitted through the bridge device. Similar memset is already done on
bridge's input. We've seen cases where proxyarp_replied was 1 on routed
multicast packets transmitted through the bridge to ports with neigh
suppress which were getting dropped. Same thing can in theory happen with
the port isolation bit as well.

Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 net/bridge/br_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a350c05b7ff5..7c6b1024dd4b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -42,6 +42,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ethhdr *eth;
 	u16 vid = 0;
 
+	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
+
 	rcu_read_lock();
 	nf_ops = rcu_dereference(nf_br_ops);
 	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
-- 
2.25.1

