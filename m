Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1606130073; x=1637666073;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=knfos+BqzH4dlo+fODl7yedIW3k3ViBBu3PBL+ng7bw=;
 b=icvnS7hDhYJpHyv068QBwcQlFzNvZlQy8TLtVKiyfeV2de0i3lhIk0Bx
 j3kL9UM8Q5rQjVtR0eQJR/xwqHxMzOtl92kLcRPyj/qoK7+n8riEHjY5f
 90jDVmF+Mm7eLEz8LVlYBxXCp3lE8G5fMgmoGJ7Q+cHtD/OhfNBIxmGiQ
 GQ2LXgTVvZw/E+vAIW4peFtfD96ZdW2fPJDfRSfMxqjFAqG/yofvw8QaP
 lQdh36iaSKSo+R2xc/NBAPYvxjbYq7ZlHeG3oRf1uII1tux65uQc382yW
 3Xr7FHDQF7Yt+mhEhY1XVD3CBdzUI6TsE3m9/ntm+rZTZNrZbHXo1ZN+7 w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 23 Nov 2020 12:14:01 +0100
Message-ID: <20201123111401.136952-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] bridge: mrp: Implement LC mode for MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Extend MRP to support LC mode(link check) for the interconnect port.
This applies only to the interconnect ring.

Opposite to RC mode(ring check) the LC mode is using CFM frames to
detect when the link goes up or down and based on that the userspace
will need to react.
One advantage of the LC mode over RC mode is that there will be fewer
frames in the normal rings. Because RC mode generates InTest on all
ports while LC mode sends CFM frame only on the interconnect port.

All 4 nodes part of the interconnect ring needs to have the same mode.
And it is not possible to have running LC and RC mode at the same time
on a node.

Whenever the MIM starts it needs to detect the status of the other 3
nodes in the interconnect ring so it would send a frame called
InLinkStatus, on which the clients needs to reply with their link
status.

This patch adds the frame header for the frame InLinkStatus and
extends existing rules on how to forward this frame.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/mrp_bridge.h |  7 +++++++
 net/bridge/br_mrp.c             | 18 +++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
index 6aeb13ef0b1e..450f6941a5a1 100644
--- a/include/uapi/linux/mrp_bridge.h
+++ b/include/uapi/linux/mrp_bridge.h
@@ -61,6 +61,7 @@ enum br_mrp_tlv_header_type {
 	BR_MRP_TLV_HEADER_IN_TOPO = 0x7,
 	BR_MRP_TLV_HEADER_IN_LINK_DOWN = 0x8,
 	BR_MRP_TLV_HEADER_IN_LINK_UP = 0x9,
+	BR_MRP_TLV_HEADER_IN_LINK_STATUS = 0xa,
 	BR_MRP_TLV_HEADER_OPTION = 0x7f,
 };
 
@@ -156,4 +157,10 @@ struct br_mrp_in_link_hdr {
 	__be16 interval;
 };
 
+struct br_mrp_in_link_status_hdr {
+	__u8 sa[ETH_ALEN];
+	__be16 port_role;
+	__be16 id;
+};
+
 #endif
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index bb12fbf9aaf2..cec2c4e4561d 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -858,7 +858,8 @@ static bool br_mrp_in_frame(struct sk_buff *skb)
 	if (hdr->type == BR_MRP_TLV_HEADER_IN_TEST ||
 	    hdr->type == BR_MRP_TLV_HEADER_IN_TOPO ||
 	    hdr->type == BR_MRP_TLV_HEADER_IN_LINK_DOWN ||
-	    hdr->type == BR_MRP_TLV_HEADER_IN_LINK_UP)
+	    hdr->type == BR_MRP_TLV_HEADER_IN_LINK_UP ||
+	    hdr->type == BR_MRP_TLV_HEADER_IN_LINK_STATUS)
 		return true;
 
 	return false;
@@ -1126,9 +1127,9 @@ static int br_mrp_rcv(struct net_bridge_port *p,
 						goto no_forward;
 				}
 			} else {
-				/* MIM should forward IntLinkChange and
+				/* MIM should forward IntLinkChange/Status and
 				 * IntTopoChange between ring ports but MIM
-				 * should not forward IntLinkChange and
+				 * should not forward IntLinkChange/Status and
 				 * IntTopoChange if the frame was received at
 				 * the interconnect port
 				 */
@@ -1155,6 +1156,17 @@ static int br_mrp_rcv(struct net_bridge_port *p,
 			     in_type == BR_MRP_TLV_HEADER_IN_LINK_DOWN))
 				goto forward;
 
+			/* MIC should forward IntLinkStatus frames only to
+			 * interconnect port if it was received on a ring port.
+			 * If it is received on interconnect port then, it
+			 * should be forward on both ring ports
+			 */
+			if (br_mrp_is_ring_port(p_port, s_port, p) &&
+			    in_type == BR_MRP_TLV_HEADER_IN_LINK_STATUS) {
+				p_dst = NULL;
+				s_dst = NULL;
+			}
+
 			/* Should forward the InTopo frames only between the
 			 * ring ports
 			 */
-- 
2.27.0

