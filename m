Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1601548392; x=1633084392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v9RWNVkU7uOPL8JOS/0jPuHZ+/LWn2COnY2+d5vrWbk=;
 b=zNu/LRIz3r7/XGxFKicbeVxSgig7fH74fbgijiJ5ACoFG6VhK3sRBP6f
 MoryPrM3vfTnqMGy7SstTtMZ2xflHgwJmXGjhNQpBLwesBro9aAsJTRHp
 b+Lt8XWPvQddeqMuD4wNyneX+DABAW+nmfhxei9q7QkI2W5qrAWcl7xqM
 Cjq6Dq98PcMFy3Uv3JNsjoi19JCCD7wsIxFqB5/5dn5jrNqNCzqOMhsby
 3kQiZe021CXYMz1FaUwrwBSis+1CBGWjveRIHA0Ca/A4lK3SvZRxMkHAJ
 aN7McGkkUTJoQLOJQQMA+sflnvAPMIa9yUHdAWGDIY8GINx95kebOEIP6 g==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Thu, 1 Oct 2020 10:30:18 +0000
Message-ID: <20201001103019.1342470-11-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
References: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [net-next v2 10/11] bridge: switchdev: cfm: switchdev
	interface implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@mellanox.com, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This is the definition of the CFM switchdev interface.

The interface consist of these objects:
    SWITCHDEV_OBJ_ID_MEP_CFM,
    SWITCHDEV_OBJ_ID_MEP_CONFIG_CFM,
    SWITCHDEV_OBJ_ID_CC_CONFIG_CFM,
    SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM,
    SWITCHDEV_OBJ_ID_CC_CCM_TX_CFM,
    SWITCHDEV_OBJ_ID_MEP_STATUS_CFM,
    SWITCHDEV_OBJ_ID_PEER_MEP_STATUS_CFM

MEP instance add/del
    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_MEP_CFM)
    switchdev_port_obj_del(SWITCHDEV_OBJ_ID_MEP_CFM)

MEP cofigure
    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_MEP_CONFIG_CFM)

MEP CC cofigure
    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_CC_CONFIG_CFM)

Peer MEP add/del
    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM)
    switchdev_port_obj_del(SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM)

Start/stop CCM transmission
    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_CC_CCM_TX_CFM)

Get MEP status
	switchdev_port_obj_get(SWITCHDEV_OBJ_ID_MEP_STATUS_CFM)

Get Peer MEP status
	switchdev_port_obj_get(SWITCHDEV_OBJ_ID_PEER_MEP_STATUS_CFM)

Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
---
 include/linux/if_bridge.h |  13 +++++
 include/net/switchdev.h   | 115 ++++++++++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c |  54 ++++++++++++++++++
 3 files changed, 182 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 556caed00258..5476880319ae 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -155,4 +155,17 @@ br_port_flag_is_set(const struct net_device *dev, unsigned long flag)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BRIDGE_CFM)
+#define BR_CFM_EVENT_CCM_DEFECT  (1<<0)
+
+struct br_cfm_notif_info {
+	u32 instance;
+	u32 peer_mep;
+	u32 events;
+};
+
+/* Function to be called from CFM switchdev driver to notify change in status */
+void br_cfm_notification(struct net_device *dev, const struct br_cfm_notif_info *const notif_info);
+#endif
+
 #endif
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 53e8b4994296..cd5194cd54d0 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -11,6 +11,9 @@
 #include <linux/notifier.h>
 #include <linux/list.h>
 #include <net/ip_fib.h>
+#include <uapi/linux/cfm_bridge.h>
+#include "../net/bridge/br_private.h"
+#include "../net/bridge/br_private_cfm.h"
 
 #define SWITCHDEV_F_NO_RECURSE		BIT(0)
 #define SWITCHDEV_F_SKIP_EOPNOTSUPP	BIT(1)
@@ -81,6 +84,15 @@ enum switchdev_obj_id {
 	SWITCHDEV_OBJ_ID_IN_STATE_MRP,
 
 #endif
+#if IS_ENABLED(CONFIG_BRIDGE_CFM)
+	SWITCHDEV_OBJ_ID_MEP_CFM,
+	SWITCHDEV_OBJ_ID_MEP_CONFIG_CFM,
+	SWITCHDEV_OBJ_ID_CC_CONFIG_CFM,
+	SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM,
+	SWITCHDEV_OBJ_ID_CC_CCM_TX_CFM,
+	SWITCHDEV_OBJ_ID_MEP_STATUS_CFM,
+	SWITCHDEV_OBJ_ID_PEER_MEP_STATUS_CFM
+#endif
 };
 
 struct switchdev_obj {
@@ -112,6 +124,97 @@ struct switchdev_obj_port_mdb {
 #define SWITCHDEV_OBJ_PORT_MDB(OBJ) \
 	container_of((OBJ), struct switchdev_obj_port_mdb, obj)
 
+#if IS_ENABLED(CONFIG_BRIDGE_CFM)
+/* SWITCHDEV_OBJ_ID_MEP_CFM */
+struct switchdev_obj_cfm_mep {
+	struct switchdev_obj obj;
+	u32 instance;
+	enum br_cfm_domain domain; /* Domain for this MEP */
+	enum br_cfm_mep_direction direction; /* Up or Down MEP direction */
+	struct net_device *port; /* Residence port */
+};
+
+#define SWITCHDEV_OBJ_CFM_MEP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_mep, obj)
+
+/* SWITCHDEV_OBJ_ID_MEP_CONFIG_CFM */
+struct switchdev_obj_cfm_mep_config_set {
+	struct switchdev_obj obj;
+	u32 instance;
+	u32 mdlevel;
+	u32 mepid;
+	struct mac_addr unicast_mac;
+};
+
+#define SWITCHDEV_OBJ_CFM_MEP_CONFIG_SET(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_mep_config_set, obj)
+
+#define SWITCHDEV_CFM_MAID_LENGTH	48
+
+/* SWITCHDEV_OBJ_ID_CC_CONFIG_CFM */
+struct switchdev_obj_cfm_cc_config_set {
+	struct switchdev_obj obj;
+	u32 instance;
+	struct br_cfm_maid maid;
+	enum br_cfm_ccm_interval interval;
+	bool enable;
+};
+
+#define SWITCHDEV_OBJ_CFM_CC_CONFIG_SET(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_cc_config_set, obj)
+
+/* SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM */
+struct switchdev_obj_cfm_cc_peer_mep {
+	struct switchdev_obj obj;
+	u32 instance;
+	u32 peer_mep_id;
+};
+
+#define SWITCHDEV_OBJ_CFM_CC_PEER_MEP(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_cc_peer_mep, obj)
+
+/* SWITCHDEV_OBJ_ID_CC_CCM_TX_CFM */
+struct switchdev_obj_cfm_cc_ccm_tx {
+	struct switchdev_obj obj;
+	u32 instance;
+	u32 period;
+	struct sk_buff *skb;
+	enum br_cfm_ccm_interval interval;
+};
+
+#define SWITCHDEV_OBJ_CFM_CC_CCM_TX(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_cc_ccm_tx, obj)
+
+/* SWITCHDEV_OBJ_ID_MEP_STATUS_CFM */
+struct switchdev_obj_cfm_mep_status_get {
+	struct switchdev_obj obj;
+	u32 instance;
+	bool clear;
+	bool opcode_unexp_seen;
+	bool version_unexp_seen;
+	bool rx_level_low_seen;
+};
+
+#define SWITCHDEV_OBJ_CFM_MEP_STATUS_get(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_mep_status_get, obj)
+
+/* SWITCHDEV_OBJ_ID_PEER_MEP_STATUS_CFM */
+struct switchdev_obj_cfm_cc_peer_status_get {
+	struct switchdev_obj obj;
+	u32 instance;
+	bool clear;
+	u8 port_tlv_value;
+	u8 if_tlv_value;
+	bool ccm_defect;
+	bool rdi;
+	bool seen;
+	bool tlv_seen;
+	bool seq_unexp_seen;
+};
+#define SWITCHDEV_OBJ_CFM_CC_PEER_STATUS_get(OBJ) \
+	container_of((OBJ), struct switchdev_obj_cfm_cc_peer_status_get, obj)
+
+#endif
 
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 /* SWITCHDEV_OBJ_ID_MRP */
@@ -208,6 +311,7 @@ enum switchdev_notifier_type {
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
 	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
+	SWITCHDEV_PORT_OBJ_GET, /* Blocking */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -265,6 +369,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 			   struct netlink_ext_ack *extack);
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
+int switchdev_port_obj_get(struct net_device *dev,
+			   const struct switchdev_obj *obj,
+			   struct netlink_ext_ack *extack);
 
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
@@ -326,6 +433,14 @@ static inline int switchdev_port_obj_del(struct net_device *dev,
 	return -EOPNOTSUPP;
 }
 
+int switchdev_port_obj_get(struct net_device *dev,
+			   const struct switchdev_obj *obj,
+			   struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+
 static inline int register_switchdev_notifier(struct notifier_block *nb)
 {
 	return 0;
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 865f3e037425..fefb05b885e0 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -372,6 +372,60 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+static int switchdev_port_obj_get_now(struct net_device *dev,
+				      const struct switchdev_obj *obj,
+				      struct netlink_ext_ack *extack)
+{
+	struct switchdev_trans trans;
+	int err;
+
+	/* Phase I: prepare for obj add. Driver/device should fail
+	 * here if there are going to be issues in the commit phase,
+	 * such as lack of resources or support.  The driver/device
+	 * should reserve resources needed for the commit phase here,
+	 * but should not commit the obj.
+	 */
+
+	trans.ph_prepare = true;
+	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_GET,
+					dev, obj, &trans, extack);
+	if (err)
+		return err;
+
+	/* Phase II: commit obj add.  This cannot fail as a fault
+	 * of driver/device.  If it does, it's a bug in the driver/device
+	 * because the driver said everythings was OK in phase I.
+	 */
+
+	trans.ph_prepare = false;
+	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_GET,
+					dev, obj, &trans, extack);
+	WARN(err, "%s: Commit of object (id=%d) failed.\n", dev->name, obj->id);
+
+	return err;
+}
+
+/**
+ *	switchdev_port_obj_get - Get information from a port object
+ *	It is expected that the driver fill in information in the
+ *	obj structure.
+ *
+ *	@dev: port device
+ *	@obj: object to get information from
+ *	@extack: netlink extended ack
+ *
+ *	Use a 2-phase prepare-commit transaction model to ensure
+ *	system is not left in a partially updated state due to
+ *	failure from driver/device.
+ */
+int switchdev_port_obj_get(struct net_device *dev,
+			   const struct switchdev_obj *obj,
+			   struct netlink_ext_ack *extack)
+{
+	return switchdev_port_obj_get_now(dev, obj, extack);
+}
+EXPORT_SYMBOL_GPL(switchdev_port_obj_get);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.28.0

