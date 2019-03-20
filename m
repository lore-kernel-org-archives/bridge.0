Return-Path: <maowenan@huawei.com>
From: Mao Wenan <maowenan@huawei.com>
Date: Wed, 20 Mar 2019 10:06:57 +0800
Message-ID: <20190320020657.31423-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] net: bridge: use eth_broadcast_addr() to
	assign broadcast address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com

This patch is to use eth_broadcast_addr() to assign broadcast address
insetad of memset().

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a0e369179f6d..b257342c0860 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -517,7 +517,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	if (src)
 		memcpy(p->eth_addr, src, ETH_ALEN);
 	else
-		memset(p->eth_addr, 0xff, ETH_ALEN);
+		eth_broadcast_addr(p->eth_addr);
 
 	return p;
 }
-- 
2.20.1

