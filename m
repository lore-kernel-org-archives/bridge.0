Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1624738688; x=1656274688;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Vj06UnUe+oVLWflWqrlGCKDMOgEci9fLJMM5g30tqRE=;
 b=sb2nlx9+zTH4mOjIPgo1acbnIkCj80jqq6MxcNpXg1GsTtQ7qdhIshN3
 6w9hWIPDDZk0p7+tCTQGUITZbU2iJ5b0Gpc73l+1GWAGkVxc8dkqA//hP
 BZtt58bFfyQ2lKBWiasZ907FbZWlYYas1IsA1LatvPlElB2ifrjtqRwpF
 mAb3SBZQCzfB8znpyOPEZj5C5bbkX+UZN2rxh9oNec1NgY/gdv9Yf5nrc
 nL8gyM6litaHLjri3+t0Vool06K3j4gp7Io8B4kvyAL38lBIeWKoBr6Lp
 rPIj4SJIyhKsJyzKro6wghbJY3E/xIK+ZnXV73KoCzHXq35cyNveRIYXN w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 26 Jun 2021 22:18:04 +0200
Message-ID: <20210626201804.1737815-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] net: bridge: mrp: Update the Test frames
	for MRA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

According to the standard IEC 62439-2, in case the node behaves as MRA
and needs to send Test frames on ring ports, then these Test frames need
to have an Option TLV and a Sub-Option TLV which has the type AUTO_MGR.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c         | 27 +++++++++++++++++++++++++++
 net/bridge/br_private_mrp.h | 11 +++++++++++
 2 files changed, 38 insertions(+)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index f7012b7d7ce4..fd2de35ffb3c 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -204,6 +204,33 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 	hdr->timestamp = cpu_to_be32(jiffies_to_msecs(jiffies));
 
 	br_mrp_skb_common(skb, mrp);
+
+	/* In case the node behaves as MRA then the Test frame needs to have
+	 * an Option TLV which includes eventually a sub-option TLV that has
+	 * the type AUTO_MGR
+	 */
+	if (mrp->ring_role == BR_MRP_RING_ROLE_MRA) {
+		struct br_mrp_sub_option1_hdr *sub_opt = NULL;
+		struct br_mrp_tlv_hdr *sub_tlv = NULL;
+		struct br_mrp_oui_hdr *oui = NULL;
+		u8 length;
+
+		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
+			MRP_OPT_PADDING;
+		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
+
+		oui = skb_put(skb, sizeof(*oui));
+		memset(oui, 0x0, sizeof(*oui));
+		sub_opt = skb_put(skb, sizeof(*sub_opt));
+		memset(sub_opt, 0x0, sizeof(*sub_opt));
+
+		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
+		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
+
+		/* 32 bit alligment shall be ensured therefore add 2 bytes */
+		skb_put(skb, MRP_OPT_PADDING);
+	}
+
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
 
 	return skb;
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 9559aa2750fb..bda8e1896712 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -6,6 +6,8 @@
 #include "br_private.h"
 #include <uapi/linux/mrp_bridge.h>
 
+#define MRP_OPT_PADDING		0x2
+
 struct br_mrp {
 	/* list of mrp instances */
 	struct hlist_node		list;
@@ -134,4 +136,13 @@ struct br_mrp_in_test_hdr {
 	__be32 timestamp;
 } __attribute__((__packed__));
 
+struct br_mrp_oui_hdr {
+	__u8 oui[MRP_OUI_LENGTH];
+};
+
+struct br_mrp_sub_option1_hdr {
+	__u8 type;
+	__u8 data[MRP_MANUFACTURE_DATA_LENGTH];
+};
+
 #endif /* _BR_PRIVATE_MRP_H */
-- 
2.31.1

