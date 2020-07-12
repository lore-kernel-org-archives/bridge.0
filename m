Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594562965; x=1626098965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uci+63N0XBlAvV0QBr++Adpov2aPMsyTOj+m1Y0wXT8=;
 b=KefjtlJKT9lbEweOYeEf6ktOcc49+IysD7EJeeQTJ0X1LhGKRhR2G7Z6
 2XEJg0YXwOfmDhUIN/uxMdXtI+G4whbe/yC8DDWAUDrHGpzWGh04141Je
 /TjreG75DRG/Ss8E3LI1EhOqCympVrsdxPFdDwc9XIfngnB5uz5Ty6FDP
 Q3KUqAW++xi4GVnXNA9x/Ayy06jxLhaUDA7P1ivDmp18LxSAf3IO1rFok
 ZRftM4t5czxrmdNtpeUG7MCwKfs4huqfDttz8UqmTncaPzvCWXzCfG5NE
 fxfZANSpHtnnt5GQSTy2Qmm0/A30kT3Q70f4OGS/hJLdv5CawxgbfNsKy Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sun, 12 Jul 2020 16:05:45 +0200
Message-ID: <20200712140556.1758725-2-horatiu.vultur@microchip.com>
In-Reply-To: <20200712140556.1758725-1-horatiu.vultur@microchip.com>
References: <20200712140556.1758725-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 01/12] switchdev: mrp: Extend switchdev
	API for MRP Interconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Extend switchdev API to add support for MRP interconnect. The HW is
notified in the following cases:

SWITCHDEV_OBJ_ID_IN_ROLE_MRP: This is used when the interconnect role
  of the node changes. The supported roles are MIM and MIC.

SWITCHDEV_OBJ_ID_IN_STATE_MRP: This is used when the interconnect ring
  changes it states to open or closed.

SWITCHDEV_OBJ_ID_IN_TEST_MRP: This is used to start/stop sending
  MRP_InTest frames on all MRP ports. This is called only on nodes that
  have the interconnect role MIM.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index b8c059b4e06d9..ff22469143013 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -76,6 +76,10 @@ enum switchdev_obj_id {
 	SWITCHDEV_OBJ_ID_RING_TEST_MRP,
 	SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
 	SWITCHDEV_OBJ_ID_RING_STATE_MRP,
+	SWITCHDEV_OBJ_ID_IN_TEST_MRP,
+	SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
+	SWITCHDEV_OBJ_ID_IN_STATE_MRP,
+
 #endif
 };
 
@@ -155,6 +159,40 @@ struct switchdev_obj_ring_state_mrp {
 #define SWITCHDEV_OBJ_RING_STATE_MRP(OBJ) \
 	container_of((OBJ), struct switchdev_obj_ring_state_mrp, obj)
 
+/* SWITCHDEV_OBJ_ID_IN_TEST_MRP */
+struct switchdev_obj_in_test_mrp {
+	struct switchdev_obj obj;
+	/* The value is in us and a value of 0 represents to stop */
+	u32 interval;
+	u32 in_id;
+	u32 period;
+	u8 max_miss;
+};
+
+#define SWITCHDEV_OBJ_IN_TEST_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_in_test_mrp, obj)
+
+/* SWICHDEV_OBJ_ID_IN_ROLE_MRP */
+struct switchdev_obj_in_role_mrp {
+	struct switchdev_obj obj;
+	struct net_device *i_port;
+	u32 ring_id;
+	u16 in_id;
+	u8 in_role;
+};
+
+#define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_in_role_mrp, obj)
+
+struct switchdev_obj_in_state_mrp {
+	struct switchdev_obj obj;
+	u32 in_id;
+	u8 in_state;
+};
+
+#define SWITCHDEV_OBJ_IN_STATE_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_in_state_mrp, obj)
+
 #endif
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
-- 
2.27.0

