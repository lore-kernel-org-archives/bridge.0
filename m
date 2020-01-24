Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 24 Jan 2020 17:18:26 +0100
Message-ID: <20200124161828.12206-9-horatiu.vultur@microchip.com>
In-Reply-To: <20200124161828.12206-1-horatiu.vultur@microchip.com>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v3 08/10] net: bridge: mrp: Connect MRP api
	with the switchev API
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com, olteanv@gmail.com, andrew@lunn.ch, jeffrey.t.kirsher@intel.com, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Implement the MRP api.
The functions are just a wrapper over the switchdev API with extra checks
regarding the MRP instances and ports.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 net/bridge/br_mrp.c

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
new file mode 100644
index 000000000000..69e1a3e526d5
--- /dev/null
+++ b/net/bridge/br_mrp.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "br_private_mrp.h"
+
+static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_nr)
+{
+	struct br_mrp *mrp;
+
+	list_for_each_entry(mrp, &br->mrp_list, list) {
+		if (mrp->ring_nr == ring_nr)
+			return mrp;
+	}
+
+	return NULL;
+}
+
+static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
+				       struct net_bridge_port *p)
+{
+	struct br_mrp *mrp;
+
+	list_for_each_entry(mrp, &br->mrp_list, list) {
+		if (mrp->p_port == p || mrp->s_port == p)
+			return mrp;
+	}
+
+	return NULL;
+}
+
+int br_mrp_add(struct net_bridge *br, u32 ring_nr)
+{
+	struct br_mrp *mrp;
+
+	/* If the ring exists, it is not possible to create another one with the
+	 * same ring_nr
+	 */
+	mrp = br_mrp_find_id(br, ring_nr);
+	if (mrp)
+		return -EINVAL;
+
+	mrp = devm_kzalloc(&br->dev->dev, sizeof(struct br_mrp), GFP_KERNEL);
+	if (!mrp)
+		return -ENOMEM;
+
+	mrp->br = br;
+	mrp->p_port = NULL;
+	mrp->s_port = NULL;
+	mrp->ring_nr = ring_nr;
+
+	list_add_tail(&mrp->list, &br->mrp_list);
+
+	return 0;
+}
+
+int br_mrp_add_port(struct net_bridge *br, u32 ring_nr,
+		    struct net_bridge_port *p)
+{
+	struct br_mrp *mrp = br_mrp_find_id(br, ring_nr);
+
+	if (!mrp)
+		return -EINVAL;
+
+	p->state = BR_STATE_FORWARDING;
+	p->mrp_aware = true;
+
+	br_mrp_port_switchdev_add(p, mrp->ring_nr);
+
+	return 0;
+}
+
+int br_mrp_del(struct net_bridge *br, u32 ring_nr)
+{
+	struct br_mrp *mrp = br_mrp_find_id(br, ring_nr);
+
+	if (!mrp)
+		return -EINVAL;
+
+	/* Stop sending MRP_Test frames */
+	br_mrp_switchdev_send_ring_test(mrp, 0, 0);
+
+	/* Destroy the ring */
+	mrp->br = NULL;
+	mrp->p_port = NULL;
+	mrp->s_port = NULL;
+
+	list_del(&mrp->list);
+	devm_kfree(&br->dev->dev, mrp);
+
+	return 0;
+}
+
+int br_mrp_del_port(struct net_bridge_port *p)
+{
+	struct net_bridge *br;
+	struct br_mrp *mrp;
+
+	br = p->br;
+	mrp = br_mrp_find_port(br, p);
+	if (!mrp)
+		return 0;
+
+	/* Stop sending MRP_Test frames */
+	br_mrp_switchdev_send_ring_test(mrp, 0, 0);
+
+	p->state = BR_STATE_FORWARDING;
+	p->mrp_aware = false;
+	if (p == mrp->p_port)
+		mrp->p_port = NULL;
+	if (p == mrp->s_port)
+		mrp->s_port = NULL;
+
+	br_mrp_port_switchdev_del(p, mrp->ring_nr);
+
+	return 0;
+}
+
+int br_mrp_set_port_state(struct net_bridge_port *p,
+			  enum br_mrp_port_state_type state)
+{
+	struct net_bridge *br;
+
+	br = p->br;
+	if (state == BR_MRP_PORT_STATE_FORWARDING)
+		p->state = BR_STATE_FORWARDING;
+	else
+		p->state = BR_STATE_BLOCKING;
+
+	br_mrp_port_switchdev_set_state(p, state);
+
+	return 0;
+}
+
+int br_mrp_set_port_role(struct net_bridge_port *p, u32 ring_nr,
+			 enum br_mrp_port_role_type role)
+{
+	struct br_mrp *mrp = br_mrp_find_id(p->br, ring_nr);
+
+	if (!mrp)
+		return -EINVAL;
+
+	if (role == BR_MRP_PORT_ROLE_PRIMARY)
+		mrp->p_port = p;
+	if (role == BR_MRP_PORT_ROLE_SECONDARY)
+		mrp->s_port = p;
+
+	br_mrp_port_switchdev_set_role(p, role);
+
+	return 0;
+}
+
+int br_mrp_set_ring_state(struct net_bridge *br, u32 ring_nr,
+			  enum br_mrp_ring_state_type state)
+{
+	struct br_mrp *mrp = br_mrp_find_id(br, ring_nr);
+
+	if (!mrp)
+		return -EINVAL;
+
+	br_mrp_switchdev_set_ring_state(mrp, state);
+
+	return 0;
+}
+
+int br_mrp_set_ring_role(struct net_bridge *br, u32 ring_nr,
+			 enum br_mrp_ring_role_type role)
+{
+	struct br_mrp *mrp = br_mrp_find_id(br, ring_nr);
+
+	if (!mrp)
+		return -EINVAL;
+
+	br_mrp_switchdev_set_ring_role(mrp, role);
+
+	return 0;
+}
+
+int br_mrp_start_test(struct net_bridge *br, u32 ring_nr, u32 interval,
+		      u8 max_miss)
+{
+	struct br_mrp *mrp = br_mrp_find_id(br, ring_nr);
+
+	if (!mrp)
+		return -EINVAL;
+
+	return br_mrp_switchdev_send_ring_test(mrp, interval, max_miss);
+}
+
+int br_mrp_flush(struct net_bridge *br, u32 ring_nr)
+{
+	br_fdb_flush(br);
+	return 0;
+}
+
-- 
2.17.1

