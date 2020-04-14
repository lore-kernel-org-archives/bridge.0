Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1586863646; x=1618399646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=Wk5W6JOrVyShu0Bu566DjA/nJMtV0L8hDnh56QYpSOM=;
 b=tyCIgc+GlkAGy2SvX8CQDvqdenComncHwn4KJvlErPaG4vLFv3O7mk4f
 LBfxsNhgH6cY6Hy2OjZ1W4NLNiWtU4zmOOC0COngm5i+whvgV3j6V3xyY
 xMFjZpEsbV1EfSqHSjQs/R/G5DrTFKfsxe1TGgNFbZIBzGkQnwLFUm3PC
 1NDC0JPBUHyjjIGSfYZ3EHvcbT2ibjqEr/mmJjG9RkX/BMCiDn9gqHLxK
 uIT0ib05uXly5u3VFQ0JnKSA4iXTfoUxP47Y26sFnQaP1C5v1YGpN+reC
 eoQ2n8V2L5+uVFyw+Fc5S8L+7VZW4Pw7qxghbPqItleyiyvymomQI6xvH g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 14 Apr 2020 13:26:14 +0200
Message-ID: <20200414112618.3644-6-horatiu.vultur@microchip.com>
In-Reply-To: <20200414112618.3644-1-horatiu.vultur@microchip.com>
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v5 5/9] switchdev: mrp: Extend switchdev API
	to offload MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Extend switchdev API to add support for MRP. The HW is notified in
following cases:

SWITCHDEV_OBJ_ID_MRP: This is used when a MRP instance is added/removed
  from the MRP ring.

SWITCHDEV_OBJ_ID_RING_ROLE_MRP: This is used when the role of the node
  changes. The current supported roles are MRM and MRC.

SWITCHDEV_OBJ_ID_RING_TEST_MRP: This is used when to start/stop sending
  MRP_Test frames on the mrp ring ports. This is called only on nodes that have
  the role MRM. In case this fails then the SW will generate the frames.

SWITCHDEV_OBJ_ID_RING_STATE_STATE: This is used when the ring changes it states
  to open or closed. This is required to notify HW because the MRP_Test frame
  contains the field MRP_InState which contains this information.

SWITCHDEV_ATTR_ID_MRP_PORT_STATE: This is used when the port's state is
  changed. It can be in blocking/forwarding mode.

SWITCHDEV_ATTR_ID_MRP_PORT_ROLE: This is used when port's role changes. The
  roles of the port can be primary/secondary. This is required to notify HW
  because the MRP_Test frame contains the field MRP_PortRole that contains this
  information.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index aee86a189432..ae7aeb0d1f9c 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -40,6 +40,10 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	SWITCHDEV_ATTR_ID_MRP_PORT_STATE,
+	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
+#endif
 };
 
 struct switchdev_attr {
@@ -55,6 +59,11 @@ struct switchdev_attr {
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
 		bool mc_disabled;			/* MC_DISABLED */
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+		u8 mrp_port_state;			/* MRP_PORT_STATE */
+		u8 mrp_port_role;			/* MRP_PORT_ROLE */
+		u8 mrp_ring_state;			/* MRP_RING_STATE */
+#endif
 	} u;
 };
 
@@ -63,6 +72,12 @@ enum switchdev_obj_id {
 	SWITCHDEV_OBJ_ID_PORT_VLAN,
 	SWITCHDEV_OBJ_ID_PORT_MDB,
 	SWITCHDEV_OBJ_ID_HOST_MDB,
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	SWITCHDEV_OBJ_ID_MRP,
+	SWITCHDEV_OBJ_ID_RING_TEST_MRP,
+	SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
+	SWITCHDEV_OBJ_ID_RING_STATE_MRP,
+#endif
 };
 
 struct switchdev_obj {
@@ -94,6 +109,53 @@ struct switchdev_obj_port_mdb {
 #define SWITCHDEV_OBJ_PORT_MDB(OBJ) \
 	container_of((OBJ), struct switchdev_obj_port_mdb, obj)
 
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+/* SWITCHDEV_OBJ_ID_MRP */
+struct switchdev_obj_mrp {
+	struct switchdev_obj obj;
+	struct net_device *p_port;
+	struct net_device *s_port;
+	u32 ring_id;
+};
+
+#define SWITCHDEV_OBJ_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_mrp, obj)
+
+/* SWITCHDEV_OBJ_ID_RING_TEST_MRP */
+struct switchdev_obj_ring_test_mrp {
+	struct switchdev_obj obj;
+	/* The value is in us and a value of 0 represents to stop */
+	u32 interval;
+	u8 max_miss;
+	u32 ring_id;
+	u32 period;
+};
+
+#define SWITCHDEV_OBJ_RING_TEST_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_ring_test_mrp, obj)
+
+/* SWICHDEV_OBJ_ID_RING_ROLE_MRP */
+struct switchdev_obj_ring_role_mrp {
+	struct switchdev_obj obj;
+	u8 ring_role;
+	u32 ring_id;
+};
+
+#define SWITCHDEV_OBJ_RING_ROLE_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_ring_role_mrp, obj)
+
+struct switchdev_obj_ring_state_mrp {
+	struct switchdev_obj obj;
+	u8 ring_state;
+	u32 ring_id;
+};
+
+#define SWITCHDEV_OBJ_RING_STATE_MRP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_ring_state_mrp, obj)
+
+#endif
+
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
 enum switchdev_notifier_type {
-- 
2.17.1

