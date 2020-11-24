Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1606206410; x=1637742410;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rzJrrzklVRf9eadjbGgdPrbEEAvaq8klfJmDth8IB6k=;
 b=gkMQtnbeOu3uOt/nIWdGcDe4JaQTV+vZLKgC75xdFQDKnx0F700d4155
 QDgrLYQ9GVt8WcMOSeG3dURBwz8YH16LydUoA7x+Snz+KN6I3W3BJMDW9
 PLrAYPyEuG0jUiaOsOMvLz21Y/0z6de0Wy+/Zmw/6Fqv1VzZJ5lfsmeXT
 9sLAK82uE7QbsZKhM+mXCQTtNuDuDfWYkLRTYMKQ5ttAp6RTefFMg6PDT
 p7FBX18vy9ZUhPeVsJLmj62+hcZTs0A8GTH2fLkmLsQC22CK+RMvUMMBu
 ENZInHN4Inll/MXOXYdEYYYBIm+d3lfdLzXM/+Pb2HugcSxccjDeXCsnU A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 24 Nov 2020 09:25:25 +0100
Message-ID: <20201124082525.273820-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2] bridge: mrp: Implement LC mode for MRP
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

This patch adds InLinkStatus frame type and extends existing rules on
how to forward this frame.

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
v1 -> v2:
  - remove struct 'br_mrp_in_link_status_hdr' as is unused
---
 include/uapi/linux/mrp_bridge.h |  1 +
 net/bridge/br_mrp.c             | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
index 6aeb13ef0b1e..9744773de5ff 100644
--- a/include/uapi/linux/mrp_bridge.h
+++ b/include/uapi/linux/mrp_bridge.h
@@ -61,6 +61,7 @@ enum br_mrp_tlv_header_type {
 	BR_MRP_TLV_HEADER_IN_TOPO = 0x7,
 	BR_MRP_TLV_HEADER_IN_LINK_DOWN = 0x8,
 	BR_MRP_TLV_HEADER_IN_LINK_UP = 0x9,
+	BR_MRP_TLV_HEADER_IN_LINK_STATUS = 0xa,
 	BR_MRP_TLV_HEADER_OPTION = 0x7f,
 };
 
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

