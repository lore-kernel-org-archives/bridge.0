Return-Path: <wenxu@ucloud.cn>
From: wenxu@ucloud.cn
Date: Thu,  4 Jul 2019 15:22:34 +0800
Message-Id: <1562224955-3979-6-git-send-email-wenxu@ucloud.cn>
In-Reply-To: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
Subject: [Bridge] [PATCH 6/7 nf-next] netfilter: nft_meta_bridge: Add
	NFT_META_BRI_IIFVPROTO support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, nikolay@cumulusnetworks.com
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch provide a meta to get the bridge vlan proto

nft add rule bridge firewall zones counter meta br_vlan_proto 0x8100

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/bridge/netfilter/nft_meta_bridge.c   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 8a1bd0b..a0d1dbd 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -796,6 +796,7 @@ enum nft_exthdr_attributes {
  * @NFT_META_IIFKIND: packet input interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_BRI_IIFPVID: packet input bridge port pvid
+ * @NFT_META_BRI_IIFVPROTO: packet input bridge vlan proto
  */
 enum nft_meta_keys {
 	NFT_META_LEN,
@@ -827,6 +828,7 @@ enum nft_meta_keys {
 	NFT_META_IIFKIND,
 	NFT_META_OIFKIND,
 	NFT_META_BRI_IIFPVID,
+	NFT_META_BRI_IIFVPROTO,
 };
 
 /**
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 9487d42..2cd145a 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -49,6 +49,17 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		nft_reg_store16(dest, p_pvid);
 		return;
 	}
+	case NFT_META_BRI_IIFVPROTO: {
+		u16 p_proto;
+
+		br_dev = nft_meta_get_bridge(in);
+		if (!br_dev || !br_vlan_enabled(br_dev))
+			goto err;
+
+		br_vlan_get_proto(in, &p_proto);
+		nft_reg_store16(dest, p_proto);
+		return;
+	}
 	default:
 		goto out;
 	}
@@ -75,6 +86,7 @@ static int nft_meta_bridge_get_init(const struct nft_ctx *ctx,
 		len = IFNAMSIZ;
 		break;
 	case NFT_META_BRI_IIFPVID:
+	case NFT_META_BRI_IIFVPROTO:
 		len = sizeof(u16);
 		break;
 	default:
-- 
1.8.3.1

