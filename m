Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590855077; x=1622391077;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tPH1x0kmwkLhsh44hhxU/ZfYVRSXnJ4NnEaEZr8D7fA=;
 b=IaX0C7Kq7xJrAmk9L8lhyQyoMk2Mawo7IYXuNZz8squcctIh1y/ChFol
 /u9S9W6tTasvcxLveOm65k26jmZikoDJqOnOmEWtQTSBJh0D6snld+LV3
 9DIJWX9ia0FnSRF0qKQvm47311Z7PkwB/uPlhZGKRhl4NS9+xg3Aq9jVK
 hXC+lbD/i5gzdSXiTnJQT0k6KCrEC95Qm25RLNOUyElHSy+HiuSW1iqXq
 ryyBSow1SFfR4L8bf02NaJW+jjajWqnE79zpwf+4uDz/QbksK5c4OiYUE
 WHTP/RzDJjaVfn+UHvBzFbt1qgYpJRgzS6yIxswLDnd4IRfNWu3lqj+C5 w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 30 May 2020 18:09:46 +0000
Message-ID: <20200530180948.1194569-2-horatiu.vultur@microchip.com>
In-Reply-To: <20200530180948.1194569-1-horatiu.vultur@microchip.com>
References: <20200530180948.1194569-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 1/3] bridge: mrp: Update MRP frame type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Replace u16/u32 with be16/be32 in the MRP frame types.
This fixes sparse warnings like:
warning: cast to restricted __be16

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/mrp_bridge.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
index 2600cdf5a2848..bcad42128d625 100644
--- a/include/uapi/linux/mrp_bridge.h
+++ b/include/uapi/linux/mrp_bridge.h
@@ -55,30 +55,30 @@ struct br_mrp_end_hdr {
 };
 
 struct br_mrp_common_hdr {
-	__u16 seq_id;
+	__be16 seq_id;
 	__u8 domain[MRP_DOMAIN_UUID_LENGTH];
 };
 
 struct br_mrp_ring_test_hdr {
-	__u16 prio;
+	__be16 prio;
 	__u8 sa[ETH_ALEN];
-	__u16 port_role;
-	__u16 state;
-	__u16 transitions;
-	__u32 timestamp;
+	__be16 port_role;
+	__be16 state;
+	__be16 transitions;
+	__be32 timestamp;
 };
 
 struct br_mrp_ring_topo_hdr {
-	__u16 prio;
+	__be16 prio;
 	__u8 sa[ETH_ALEN];
-	__u16 interval;
+	__be16 interval;
 };
 
 struct br_mrp_ring_link_hdr {
 	__u8 sa[ETH_ALEN];
-	__u16 port_role;
-	__u16 interval;
-	__u16 blocked;
+	__be16 port_role;
+	__be16 interval;
+	__be16 blocked;
 };
 
 #endif
-- 
2.26.2

