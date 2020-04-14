Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1586863649; x=1618399649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=f3epdgnXRyZzpJEm4PhJjcbsZ8Kfu05a4/+SlqRcVPQ=;
 b=nFKDMs6rjFbMpzsMRovyN9Qi0CgDYx53dcwTmrsAgz99QvuqLBBstszN
 HNIq7/7G/ilOVo/TfBu7F08xVmITbKmDflIcH7RCqwgBW6DGQ+fiAzYZC
 AJgNuRYd+K2gdtNRWV5DOTmpqh+s6H5MMOygl2Vd/a/ja9Kjm56OprX32
 Z/moN0xjclrIJjy82YT9195CCujP50IIQ9VSMo/pbA19B43Ut1bucqERc
 tHHknuTILckaXps4V1DYwr865ZSyf8X8ufABQVTeq6qulPbEfGm//TNcq
 HrJ6JZsP16H4Lg64It9masXmsWbeq3w0rIu6SGlev4nmyxxSk3bi/fz/G A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 14 Apr 2020 13:26:15 +0200
Message-ID: <20200414112618.3644-7-horatiu.vultur@microchip.com>
In-Reply-To: <20200414112618.3644-1-horatiu.vultur@microchip.com>
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v5 6/9] bridge: switchdev: mrp: Implement
	MRP API for switchdev
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

Implement the MRP api for switchdev.
These functions will just eventually call the switchdev functions:
switchdev_port_obj_add/del and switchdev_port_attr_set.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_switchdev.c | 144 ++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 net/bridge/br_mrp_switchdev.c

diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
new file mode 100644
index 000000000000..2a9578f39835
--- /dev/null
+++ b/net/bridge/br_mrp_switchdev.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <net/switchdev.h>
+
+#include "br_private_mrp.h"
+
+int br_mrp_switchdev_add(struct net_bridge *br, struct br_mrp *mrp)
+{
+	struct switchdev_obj_mrp mrp_obj = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_MRP,
+		.p_port = rtnl_dereference(mrp->p_port)->dev,
+		.s_port = rtnl_dereference(mrp->s_port)->dev,
+		.ring_id = mrp->ring_id,
+	};
+	int err;
+
+	err = switchdev_port_obj_add(br->dev, &mrp_obj.obj, NULL);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_del(struct net_bridge *br, struct br_mrp *mrp)
+{
+	struct switchdev_obj_mrp mrp_obj = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_MRP,
+		.p_port = NULL,
+		.s_port = NULL,
+		.ring_id = mrp->ring_id,
+	};
+	int err;
+
+	err = switchdev_port_obj_del(br->dev, &mrp_obj.obj);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_set_ring_role(struct net_bridge *br,
+				   struct br_mrp *mrp,
+				   enum br_mrp_ring_role_type role)
+{
+	struct switchdev_obj_ring_role_mrp mrp_role = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
+		.ring_role = role,
+		.ring_id = mrp->ring_id,
+	};
+	int err;
+
+	if (role == BR_MRP_RING_ROLE_DISABLED)
+		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
+	else
+		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_send_ring_test(struct net_bridge *br,
+				    struct br_mrp *mrp, u32 interval,
+				    u8 max_miss, u32 period)
+{
+	struct switchdev_obj_ring_test_mrp test = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_RING_TEST_MRP,
+		.interval = interval,
+		.max_miss = max_miss,
+		.ring_id = mrp->ring_id,
+		.period = period,
+	};
+	int err;
+
+	if (interval == 0)
+		err = switchdev_port_obj_del(br->dev, &test.obj);
+	else
+		err = switchdev_port_obj_add(br->dev, &test.obj, NULL);
+
+	return err;
+}
+
+int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
+				    struct br_mrp *mrp,
+				    enum br_mrp_ring_state_type state)
+{
+	struct switchdev_obj_ring_state_mrp mrp_state = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_RING_STATE_MRP,
+		.ring_state = state,
+		.ring_id = mrp->ring_id,
+	};
+	int err;
+
+	err = switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
+				    enum br_mrp_port_state_type state)
+{
+	struct switchdev_attr attr = {
+		.orig_dev = p->dev,
+		.id = SWITCHDEV_ATTR_ID_MRP_PORT_STATE,
+		.u.mrp_port_state = state,
+	};
+	int err;
+
+	err = switchdev_port_attr_set(p->dev, &attr);
+	if (err && err != -EOPNOTSUPP)
+		br_warn(p->br, "error setting offload MRP state on port %u(%s)\n",
+			(unsigned int)p->port_no, p->dev->name);
+
+	return err;
+}
+
+int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
+				   enum br_mrp_port_role_type role)
+{
+	struct switchdev_attr attr = {
+		.orig_dev = p->dev,
+		.id = SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
+		.u.mrp_port_role = role,
+	};
+	int err;
+
+	err = switchdev_port_attr_set(p->dev, &attr);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
-- 
2.17.1

