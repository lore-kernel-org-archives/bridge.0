Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613511795; x=1645047795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0t3hodfyHS0ONmeoOm8gwtxudEniDf4gCtEtzfr6mUk=;
 b=YCoKYJDLtQZHJMxWEPB2eVrHCu6iUC0bX/xqLCkMH3u2Q6RreoOuNnMT
 eHMnkGCKygrzt61BpqvDGnpIOIA2ZLUhSvdnImESNZxZrorLLojdQ0fgJ
 sxyA/PD7yW024YqR5FcjQ+saGsV8wnFPK70mAulHasUOb4++fhLkIBTKq
 E278u/FQtdYgW2KQc+cU4W+WYOR9NpcTHXLlQZTzPJ3fNBmTjgDQ6bpnr
 nGWAQnFXQTKZGBeSrWFS3fqeKAGNwqlBvj4a+08t1qAzgUQzx2tuW/M7E
 WsqD0L+uJytnHmBNXTuBkHyazrlG6x02IMq8yMy+Q89wlenbIjtHghr1f Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 16 Feb 2021 22:41:58 +0100
Message-ID: <20210216214205.32385-2-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-1-horatiu.vultur@microchip.com>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 1/8] switchdev: mrp: Remove
	CONFIG_BRIDGE_MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: ivecera@redhat.com, andrew@lunn.ch, alexandre.belloni@bootlin.com, f.fainelli@gmail.com, jiri@resnulli.us, rasmus.villemoes@prevas.dk, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, vivien.didelot@gmail.com

Remove #IS_ENABLED(CONFIG_BRIDGE_MRP) from switchdev.h. This will
simplify the code implements MRP callbacks and will be similar with the
vlan filtering.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 9a5426b61ca5..465362d9d063 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -27,9 +27,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
-#if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
-#endif
 };
 
 struct switchdev_brport_flags {
@@ -51,9 +49,7 @@ struct switchdev_attr {
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
 		bool mc_disabled;			/* MC_DISABLED */
-#if IS_ENABLED(CONFIG_BRIDGE_MRP)
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
-#endif
 	} u;
 };
 
@@ -62,7 +58,6 @@ enum switchdev_obj_id {
 	SWITCHDEV_OBJ_ID_PORT_VLAN,
 	SWITCHDEV_OBJ_ID_PORT_MDB,
 	SWITCHDEV_OBJ_ID_HOST_MDB,
-#if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	SWITCHDEV_OBJ_ID_MRP,
 	SWITCHDEV_OBJ_ID_RING_TEST_MRP,
 	SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
@@ -70,8 +65,6 @@ enum switchdev_obj_id {
 	SWITCHDEV_OBJ_ID_IN_TEST_MRP,
 	SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
 	SWITCHDEV_OBJ_ID_IN_STATE_MRP,
-
-#endif
 };
 
 struct switchdev_obj {
@@ -103,7 +96,6 @@ struct switchdev_obj_port_mdb {
 	container_of((OBJ), struct switchdev_obj_port_mdb, obj)
 
 
-#if IS_ENABLED(CONFIG_BRIDGE_MRP)
 /* SWITCHDEV_OBJ_ID_MRP */
 struct switchdev_obj_mrp {
 	struct switchdev_obj obj;
@@ -183,8 +175,6 @@ struct switchdev_obj_in_state_mrp {
 #define SWITCHDEV_OBJ_IN_STATE_MRP(OBJ) \
 	container_of((OBJ), struct switchdev_obj_in_state_mrp, obj)
 
-#endif
-
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
 enum switchdev_notifier_type {
-- 
2.27.0

