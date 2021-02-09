Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612902266; x=1644438266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CKsk90s1Zwe7NmvCndD9QVFLL8JUzWHwEz1IrisAv3o=;
 b=ggvwzueKtRERynsEFwyhG7VvlezNaJgaFk7eNKppTw3F+ND4a/xTp5A1
 AG97ZFxx4hDG7ENwfOkifXWiZ0fyLItP5xx6WEFFz7oaOWtSzWwGc+GWX
 mj3Dwd76IbmwwgxdISH/aioiAR6baXefyhTUTI9F9CGJN6xL9oasME9Ql
 h6BHdfGwmyxzlnU0zfWxETp6JAYaTFM2EIvWqkO7FotSYaO1Qmg9ROIIo
 y1ZskmCYjylqXmJMxKxsjI67h5WhpZVNgeN7Qnw1FjVjmmYGrWteFzORJ
 xvPkJTQ+xn1d5vWF1P+Wx4csGk2/emoKkuLLhGWNRPJ9SMviQ+ovhCphL Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 9 Feb 2021 21:21:10 +0100
Message-ID: <20210209202112.2545325-4-horatiu.vultur@microchip.com>
In-Reply-To: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
References: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 3/5] bridge: mrp: Extend
	br_mrp_switchdev to detect better the errors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, andrew@lunn.ch, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch extends the br_mrp_switchdev functions to be able to have a
better understanding what cause the issue and if the SW needs to be used
as a backup.

There are the following cases:
- when the code is compiled without CONFIG_NET_SWITCHDEV. In this case
  return success so the SW can continue with the protocol. Depending
  on the function, it returns 0 or BR_MRP_SW.
- when code is compiled with CONFIG_NET_SWITCHDEV and the driver doesn't
  implement any MRP callbacks. In this case the HW can't run MRP so it
  just returns -EOPNOTSUPP. So the SW will stop further to configure the
  node.
- when code is compiled with CONFIG_NET_SWITCHDEV and the driver fully
  supports any MRP functionality. In this case the SW doesn't need to do
  anything. The functions will return 0 or BR_MRP_HW.
- when code is compiled with CONFIG_NET_SWITCHDEV and the HW can't run
  completely the protocol but it can help the SW to run it. For
  example, the HW can't support completely MRM role(can't detect when it
  stops receiving MRP Test frames) but it can redirect these frames to
  CPU. In this case it is possible to have a SW fallback. The SW will
  try initially to call the driver with sw_backup set to false, meaning
  that the HW should implement completely the role. If the driver returns
  -EOPNOTSUPP, the SW will try again with sw_backup set to false,
  meaning that the SW will detect when it stops receiving the frames but
  it needs HW support to redirect the frames to CPU. In case the driver
  returns 0 then the SW will continue to configure the node accordingly.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_switchdev.c | 171 +++++++++++++++++++++-------------
 net/bridge/br_private_mrp.h   |  24 +++--
 2 files changed, 118 insertions(+), 77 deletions(-)

diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
index c971030adeea..8beb00827186 100644
--- a/net/bridge/br_mrp_switchdev.c
+++ b/net/bridge/br_mrp_switchdev.c
@@ -4,6 +4,30 @@
 
 #include "br_private_mrp.h"
 
+static enum br_mrp_hw_support
+br_mrp_switchdev_port_obj(struct net_bridge *br,
+			  const struct switchdev_obj *obj, bool add)
+{
+	int err;
+
+	if (add)
+		err = switchdev_port_obj_add(br->dev, obj, NULL);
+	else
+		err = switchdev_port_obj_del(br->dev, obj);
+
+	/* In case of success just return and notify the SW that doesn't need
+	 * to do anything
+	 */
+	if (!err)
+		return BR_MRP_HW;
+
+	if (err != -EOPNOTSUPP)
+		return BR_MRP_NONE;
+
+	/* Continue with SW backup */
+	return BR_MRP_SW;
+}
+
 int br_mrp_switchdev_add(struct net_bridge *br, struct br_mrp *mrp)
 {
 	struct switchdev_obj_mrp mrp_obj = {
@@ -14,14 +38,11 @@ int br_mrp_switchdev_add(struct net_bridge *br, struct br_mrp *mrp)
 		.ring_id = mrp->ring_id,
 		.prio = mrp->prio,
 	};
-	int err;
 
-	err = switchdev_port_obj_add(br->dev, &mrp_obj.obj, NULL);
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return 0;
 
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	return 0;
+	return switchdev_port_obj_add(br->dev, &mrp_obj.obj, NULL);
 }
 
 int br_mrp_switchdev_del(struct net_bridge *br, struct br_mrp *mrp)
@@ -33,40 +54,54 @@ int br_mrp_switchdev_del(struct net_bridge *br, struct br_mrp *mrp)
 		.s_port = NULL,
 		.ring_id = mrp->ring_id,
 	};
-	int err;
-
-	err = switchdev_port_obj_del(br->dev, &mrp_obj.obj);
 
-	if (err && err != -EOPNOTSUPP)
-		return err;
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return 0;
 
-	return 0;
+	return switchdev_port_obj_del(br->dev, &mrp_obj.obj);
 }
 
-int br_mrp_switchdev_set_ring_role(struct net_bridge *br,
-				   struct br_mrp *mrp,
-				   enum br_mrp_ring_role_type role)
+enum br_mrp_hw_support
+br_mrp_switchdev_set_ring_role(struct net_bridge *br, struct br_mrp *mrp,
+			       enum br_mrp_ring_role_type role)
 {
 	struct switchdev_obj_ring_role_mrp mrp_role = {
 		.obj.orig_dev = br->dev,
 		.obj.id = SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
 		.ring_role = role,
 		.ring_id = mrp->ring_id,
+		.sw_backup = false,
 	};
+	enum br_mrp_hw_support support;
 	int err;
 
-	if (role == BR_MRP_RING_ROLE_DISABLED)
-		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
-	else
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return BR_MRP_SW;
+
+	support = br_mrp_switchdev_port_obj(br, &mrp_role.obj,
+					    role != BR_MRP_RING_ROLE_DISABLED);
+	if (support != BR_MRP_SW)
+		return support;
+
+	/* If the driver can't configure to run completely the protocol in HW,
+	 * then try again to configure the HW so the SW can run the protocol.
+	 */
+	mrp_role.sw_backup = true;
+	if (role != BR_MRP_RING_ROLE_DISABLED)
 		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
+	else
+		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
 
-	return err;
+	if (!err)
+		return BR_MRP_SW;
+
+	return BR_MRP_NONE;
 }
 
-int br_mrp_switchdev_send_ring_test(struct net_bridge *br,
-				    struct br_mrp *mrp, u32 interval,
-				    u8 max_miss, u32 period,
-				    bool monitor)
+enum br_mrp_hw_support
+br_mrp_switchdev_send_ring_test(struct net_bridge *br, struct br_mrp *mrp,
+				u32 interval, u8 max_miss, u32 period,
+				bool monitor)
 {
 	struct switchdev_obj_ring_test_mrp test = {
 		.obj.orig_dev = br->dev,
@@ -77,14 +112,11 @@ int br_mrp_switchdev_send_ring_test(struct net_bridge *br,
 		.period = period,
 		.monitor = monitor,
 	};
-	int err;
 
-	if (interval == 0)
-		err = switchdev_port_obj_del(br->dev, &test.obj);
-	else
-		err = switchdev_port_obj_add(br->dev, &test.obj, NULL);
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return BR_MRP_SW;
 
-	return err;
+	return br_mrp_switchdev_port_obj(br, &test.obj, interval != 0);
 }
 
 int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
@@ -97,19 +129,17 @@ int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
 		.ring_state = state,
 		.ring_id = mrp->ring_id,
 	};
-	int err;
-
-	err = switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
 
-	if (err && err != -EOPNOTSUPP)
-		return err;
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return 0;
 
-	return 0;
+	return switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
 }
 
-int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
-				 u16 in_id, u32 ring_id,
-				 enum br_mrp_in_role_type role)
+enum br_mrp_hw_support
+br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
+			     u16 in_id, u32 ring_id,
+			     enum br_mrp_in_role_type role)
 {
 	struct switchdev_obj_in_role_mrp mrp_role = {
 		.obj.orig_dev = br->dev,
@@ -118,15 +148,32 @@ int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
 		.in_id = mrp->in_id,
 		.ring_id = mrp->ring_id,
 		.i_port = rtnl_dereference(mrp->i_port)->dev,
+		.sw_backup = false,
 	};
+	enum br_mrp_hw_support support;
 	int err;
 
-	if (role == BR_MRP_IN_ROLE_DISABLED)
-		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
-	else
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return BR_MRP_SW;
+
+	support = br_mrp_switchdev_port_obj(br, &mrp_role.obj,
+					    role != BR_MRP_IN_ROLE_DISABLED);
+	if (support != BR_MRP_NONE)
+		return support;
+
+	/* If the driver can't configure to run completely the protocol in HW,
+	 * then try again to configure the HW so the SW can run the protocol.
+	 */
+	mrp_role.sw_backup = true;
+	if (role != BR_MRP_IN_ROLE_DISABLED)
 		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
+	else
+		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
+
+	if (!err)
+		return BR_MRP_SW;
 
-	return err;
+	return BR_MRP_NONE;
 }
 
 int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
@@ -138,18 +185,16 @@ int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
 		.in_state = state,
 		.in_id = mrp->in_id,
 	};
-	int err;
-
-	err = switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
 
-	if (err && err != -EOPNOTSUPP)
-		return err;
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return 0;
 
-	return 0;
+	return switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
 }
 
-int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
-				  u32 interval, u8 max_miss, u32 period)
+enum br_mrp_hw_support
+br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
+			      u32 interval, u8 max_miss, u32 period)
 {
 	struct switchdev_obj_in_test_mrp test = {
 		.obj.orig_dev = br->dev,
@@ -159,14 +204,11 @@ int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
 		.in_id = mrp->in_id,
 		.period = period,
 	};
-	int err;
 
-	if (interval == 0)
-		err = switchdev_port_obj_del(br->dev, &test.obj);
-	else
-		err = switchdev_port_obj_add(br->dev, &test.obj, NULL);
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return BR_MRP_SW;
 
-	return err;
+	return br_mrp_switchdev_port_obj(br, &test.obj, interval != 0);
 }
 
 int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
@@ -177,14 +219,11 @@ int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
 		.id = SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 		.u.stp_state = state,
 	};
-	int err;
 
-	err = switchdev_port_attr_set(p->dev, &attr);
-	if (err && err != -EOPNOTSUPP)
-		br_warn(p->br, "error setting offload MRP state on port %u(%s)\n",
-			(unsigned int)p->port_no, p->dev->name);
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return 0;
 
-	return err;
+	return switchdev_port_attr_set(p->dev, &attr);
 }
 
 int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
@@ -195,11 +234,9 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 		.id = SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
 		.u.mrp_port_role = role,
 	};
-	int err;
 
-	err = switchdev_port_attr_set(p->dev, &attr);
-	if (err && err != -EOPNOTSUPP)
-		return err;
+	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
+		return 0;
 
-	return 0;
+	return switchdev_port_attr_set(p->dev, &attr);
 }
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index a94017f86cda..587a0381a6ce 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -79,24 +79,28 @@ int br_mrp_start_in_test(struct net_bridge *br,
 /* br_mrp_switchdev.c */
 int br_mrp_switchdev_add(struct net_bridge *br, struct br_mrp *mrp);
 int br_mrp_switchdev_del(struct net_bridge *br, struct br_mrp *mrp);
-int br_mrp_switchdev_set_ring_role(struct net_bridge *br, struct br_mrp *mrp,
-				   enum br_mrp_ring_role_type role);
+enum br_mrp_hw_support
+br_mrp_switchdev_set_ring_role(struct net_bridge *br, struct br_mrp *mrp,
+			       enum br_mrp_ring_role_type role);
 int br_mrp_switchdev_set_ring_state(struct net_bridge *br, struct br_mrp *mrp,
 				    enum br_mrp_ring_state_type state);
-int br_mrp_switchdev_send_ring_test(struct net_bridge *br, struct br_mrp *mrp,
-				    u32 interval, u8 max_miss, u32 period,
-				    bool monitor);
+enum br_mrp_hw_support
+br_mrp_switchdev_send_ring_test(struct net_bridge *br, struct br_mrp *mrp,
+				u32 interval, u8 max_miss, u32 period,
+				bool monitor);
 int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
 				    enum br_mrp_port_state_type state);
 int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 				   enum br_mrp_port_role_type role);
-int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
-				 u16 in_id, u32 ring_id,
-				 enum br_mrp_in_role_type role);
+enum br_mrp_hw_support
+br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
+			     u16 in_id, u32 ring_id,
+			     enum br_mrp_in_role_type role);
 int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
 				  enum br_mrp_in_state_type state);
-int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
-				  u32 interval, u8 max_miss, u32 period);
+enum br_mrp_hw_support
+br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
+			      u32 interval, u8 max_miss, u32 period);
 
 /* br_mrp_netlink.c  */
 int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
-- 
2.27.0

