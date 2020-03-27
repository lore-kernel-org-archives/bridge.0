Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 27 Mar 2020 10:21:23 +0100
Message-ID: <20200327092126.15407-7-horatiu.vultur@microchip.com>
In-Reply-To: <20200327092126.15407-1-horatiu.vultur@microchip.com>
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v4 6/9] bridge: switchdev: mrp Implement MRP
	API for switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Implement the MRP api for switchdev.
These functions will just eventually call the switchdev functions:
switchdev_port_obj_add/del and switchdev_port_attr_set.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_switchdev.c | 150 ++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 net/bridge/br_mrp_switchdev.c

diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
new file mode 100644
index 000000000000..7b27721fd4cf
--- /dev/null
+++ b/net/bridge/br_mrp_switchdev.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <net/switchdev.h>
+
+#include "br_private_mrp.h"
+
+int br_mrp_switchdev_add(struct br_mrp *mrp)
+{
+	struct net_bridge *br = mrp->br;
+	struct switchdev_obj_mrp mrp_obj = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_MRP,
+		.p_port = rcu_dereference(mrp->p_port)->dev,
+		.s_port = rcu_dereference(mrp->s_port)->dev,
+		.ring_id = mrp->ring_id,
+	};
+	int err = 0;
+
+	err = switchdev_port_obj_add(br->dev, &mrp_obj.obj, NULL);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_del(struct br_mrp *mrp)
+{
+	struct net_bridge *br = mrp->br;
+	struct switchdev_obj_mrp mrp_obj = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_MRP,
+		.p_port = rcu_dereference(mrp->p_port)->dev,
+		.s_port = rcu_dereference(mrp->s_port)->dev,
+		.ring_id = mrp->ring_id,
+	};
+	int err = 0;
+
+	err = switchdev_port_obj_del(br->dev, &mrp_obj.obj);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_set_ring_role(struct br_mrp *mrp,
+				   enum br_mrp_ring_role_type role)
+{
+	struct switchdev_obj_ring_role_mrp mrp_role = {
+		.obj.orig_dev = mrp->br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_RING_ROLE_MRP,
+		.ring_role = role,
+		.ring_id = mrp->ring_id,
+	};
+	int err = 0;
+
+	if (role == BR_MRP_RING_ROLE_DISABLED)
+		err = switchdev_port_obj_del(mrp->br->dev, &mrp_role.obj);
+	else
+		err = switchdev_port_obj_add(mrp->br->dev, &mrp_role.obj, NULL);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_send_ring_test(struct br_mrp *mrp, u32 interval,
+				    u8 max_miss, u32 period)
+{
+	struct switchdev_obj_ring_test_mrp test = {
+		.obj.orig_dev = mrp->br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_RING_TEST_MRP,
+		.interval = interval,
+		.max_miss = max_miss,
+		.ring_id = mrp->ring_id,
+		.period = period,
+	};
+	int err = 0;
+
+	if (interval == 0)
+		err = switchdev_port_obj_del(mrp->br->dev, &test.obj);
+	else
+		err = switchdev_port_obj_add(mrp->br->dev, &test.obj, NULL);
+
+	return err;
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
+	int err = 0;
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
+int br_mrp_switchdev_set_ring_state(struct br_mrp *mrp,
+				    enum br_mrp_ring_state_type state)
+{
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_MRP_RING_STATE,
+		.u.mrp_ring_state = state,
+	};
+	int err = 0;
+
+	rcu_read_lock();
+
+	attr.orig_dev = rcu_dereference(mrp->p_port)->dev,
+	err = switchdev_port_attr_set(attr.orig_dev, &attr);
+	if (err && err != -EOPNOTSUPP)
+		goto unlock;
+
+	attr.orig_dev = rcu_dereference(mrp->s_port)->dev;
+	err = switchdev_port_attr_set(attr.orig_dev, &attr);
+	if (err && err != -EOPNOTSUPP)
+		goto unlock;
+
+unlock:
+	rcu_read_unlock();
+
+	return err;
+}
-- 
2.17.1

