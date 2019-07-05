Return-Path: <wenxu@ucloud.cn>
From: wenxu@ucloud.cn
Date: Fri,  5 Jul 2019 21:16:33 +0800
Message-Id: <1562332598-17415-2-git-send-email-wenxu@ucloud.cn>
In-Reply-To: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
Subject: [Bridge] [PATCH 2/7 nf-next v2] netfilter: nft_meta_bridge: Remove
	the br_private.h header
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, pablo@netfilter.org
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Mkae the nft_bridge_meta can't direct access the bridge
internal API.

Signed-off-by: wenxu <wenxu@ucloud.cn>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/netfilter/nft_meta_bridge.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index dde8651..2ea8acb 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -8,7 +8,14 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nft_meta.h>
 
-#include "../br_private.h"
+static const struct net_device *
+nft_meta_get_bridge(const struct net_device *dev)
+{
+	if (dev && netif_is_bridge_port(dev))
+		return netdev_master_upper_dev_get_rcu((struct net_device *)dev);
+
+	return NULL;
+}
 
 static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 				     struct nft_regs *regs,
@@ -17,22 +24,24 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 	const struct nft_meta *priv = nft_expr_priv(expr);
 	const struct net_device *in = nft_in(pkt), *out = nft_out(pkt);
 	u32 *dest = &regs->data[priv->dreg];
-	const struct net_bridge_port *p;
+	const struct net_device *br_dev;
 
 	switch (priv->key) {
 	case NFT_META_BRI_IIFNAME:
-		if (in == NULL || (p = br_port_get_rcu(in)) == NULL)
+		br_dev = nft_meta_get_bridge(in);
+		if (!br_dev)
 			goto err;
 		break;
 	case NFT_META_BRI_OIFNAME:
-		if (out == NULL || (p = br_port_get_rcu(out)) == NULL)
+		br_dev = nft_meta_get_bridge(out);
+		if (!br_dev)
 			goto err;
 		break;
 	default:
 		goto out;
 	}
 
-	strncpy((char *)dest, p->br->dev->name, IFNAMSIZ);
+	strncpy((char *)dest, br_dev->name, IFNAMSIZ);
 	return;
 out:
 	return nft_meta_get_eval(expr, regs, pkt);
-- 
1.8.3.1

