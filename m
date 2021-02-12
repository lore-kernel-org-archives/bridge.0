Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kqw7XT67vB3iuTYck/y3AF7dnNG3j7qHv+MIXpLx/C0=;
 b=ZdKXOg4M3hXp5lhaHy9pbnF6JB/gjstV1ElJ9afVq+x7H5ZDP1BoatnHV6fu1VLE7E
 RdNwD5MwUYH5EWi452Ewwo0RpRe8qMeHsfOKrE8tMeDOwZEggq7os95VdbrZv5v8cmDC
 9+wPcjgal9CCy3zvN/zm5uPLRrLslVjd8jnj2rzcroNgJxOQYA0BuWbsAGHFN7e/OZ0d
 GMm/GWmPCSlFjuT3sG5WP6Atqzd6xjonLbxdJiG8FEzBKbzrd6sriRy/sAZd1rvG5ZMc
 It6VTArzdQEX8mhThfn+6rYZr6vPI4zlwiacVUCmPishLyc0oOjQgcyqpOcpqfamSgFU
 wNBA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 12 Feb 2021 03:05:30 +0200
Message-Id: <20210212010531.2722925-9-olteanv@gmail.com>
In-Reply-To: <20210212010531.2722925-1-olteanv@gmail.com>
References: <20210212010531.2722925-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 8/9] net: mscc: ocelot: offload bridge
	port flags to device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

We should not be unconditionally enabling address learning, since doing
that is actively detrimential when a port is standalone and not offloading
a bridge. Namely, if a port in the switch is standalone and others are
offloading the bridge, then we could enter a situation where we learn an
address towards the standalone port, but the bridged ports could not
forward the packet there, because the CPU is the only path between the
standalone and the bridged ports. The solution of course is to not
enable address learning unless the bridge asks for it.

We need to set up the initial port flags for no learning and flooding
everything, and also when the port joins and leaves the bridge.
The flood configuration was already configured ok for standalone mode
in ocelot_init, we just need to disable learning in ocelot_init_port.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v4:
- Applying the bridge port flags by hand at bridge join and leave, like
  DSA and other switchdev drivers.
- Put every bridge port flag in a separate function.
- Export ocelot_port_pre_bridge_flags for felix DSA to use.

Changes in v3:
None.

Changes in v2:
- Disable learning in ocelot_init_port.
- Keep a single bool ocelot_port->learn_ena instead of
  ocelot_port->brport_flags.
- Stop touching the brport_flags from ocelot_port_bridge_leave (which
  was a leftover).

 drivers/net/dsa/ocelot/felix.c         | 22 +++++++
 drivers/net/ethernet/mscc/ocelot.c     | 87 +++++++++++++++++++++++++-
 drivers/net/ethernet/mscc/ocelot_net.c | 49 +++++++++++++--
 include/soc/mscc/ocelot.h              |  5 ++
 4 files changed, 158 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 386468e66c41..96d9d13c5ae0 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -553,6 +553,26 @@ static void felix_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	return ocelot_bridge_stp_state_set(ocelot, port, state);
 }
 
+static int felix_pre_bridge_flags(struct dsa_switch *ds, int port,
+				  struct switchdev_brport_flags val,
+				  struct netlink_ext_ack *extack)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	return ocelot_port_pre_bridge_flags(ocelot, port, val);
+}
+
+static int felix_bridge_flags(struct dsa_switch *ds, int port,
+			      struct switchdev_brport_flags val,
+			      struct netlink_ext_ack *extack)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	ocelot_port_bridge_flags(ocelot, port, val);
+
+	return 0;
+}
+
 static int felix_bridge_join(struct dsa_switch *ds, int port,
 			     struct net_device *br)
 {
@@ -1373,6 +1393,8 @@ const struct dsa_switch_ops felix_switch_ops = {
 	.port_fdb_del			= felix_fdb_del,
 	.port_mdb_add			= felix_mdb_add,
 	.port_mdb_del			= felix_mdb_del,
+	.port_pre_bridge_flags		= felix_pre_bridge_flags,
+	.port_bridge_flags		= felix_bridge_flags,
 	.port_bridge_join		= felix_bridge_join,
 	.port_bridge_leave		= felix_bridge_leave,
 	.port_lag_join			= felix_lag_join,
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1a31598e2ae6..d1a9cdbf7a3e 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1038,6 +1038,7 @@ EXPORT_SYMBOL(ocelot_apply_bridge_fwd_mask);
 
 void ocelot_bridge_stp_state_set(struct ocelot *ocelot, int port, u8 state)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	u32 port_cfg;
 
 	if (!(BIT(port) & ocelot->bridge_mask))
@@ -1050,7 +1051,8 @@ void ocelot_bridge_stp_state_set(struct ocelot *ocelot, int port, u8 state)
 		ocelot->bridge_fwd_mask |= BIT(port);
 		fallthrough;
 	case BR_STATE_LEARNING:
-		port_cfg |= ANA_PORT_PORT_CFG_LEARN_ENA;
+		if (ocelot_port->learn_ena)
+			port_cfg |= ANA_PORT_PORT_CFG_LEARN_ENA;
 		break;
 
 	default:
@@ -1534,6 +1536,86 @@ int ocelot_get_max_mtu(struct ocelot *ocelot, int port)
 }
 EXPORT_SYMBOL(ocelot_get_max_mtu);
 
+static void ocelot_port_set_learning(struct ocelot *ocelot, int port,
+				     bool enabled)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	u32 val = 0;
+
+	if (enabled)
+		val = ANA_PORT_PORT_CFG_LEARN_ENA;
+
+	ocelot_rmw_gix(ocelot, val, ANA_PORT_PORT_CFG_LEARN_ENA,
+		       ANA_PORT_PORT_CFG, port);
+
+	ocelot_port->learn_ena = enabled;
+}
+
+static void ocelot_port_set_ucast_flood(struct ocelot *ocelot, int port,
+					bool enabled)
+{
+	u32 val = 0;
+
+	if (enabled)
+		val = BIT(port);
+
+	ocelot_rmw_rix(ocelot, val, BIT(port), ANA_PGID_PGID, PGID_UC);
+}
+
+static void ocelot_port_set_mcast_flood(struct ocelot *ocelot, int port,
+					bool enabled)
+{
+	u32 val = 0;
+
+	if (enabled)
+		val = BIT(port);
+
+	ocelot_rmw_rix(ocelot, val, BIT(port), ANA_PGID_PGID, PGID_MC);
+}
+
+static void ocelot_port_set_bcast_flood(struct ocelot *ocelot, int port,
+					bool enabled)
+{
+	u32 val = 0;
+
+	if (enabled)
+		val = BIT(port);
+
+	ocelot_rmw_rix(ocelot, val, BIT(port), ANA_PGID_PGID, PGID_BC);
+}
+
+int ocelot_port_pre_bridge_flags(struct ocelot *ocelot, int port,
+				 struct switchdev_brport_flags flags)
+{
+	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
+			   BR_BCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(ocelot_port_pre_bridge_flags);
+
+void ocelot_port_bridge_flags(struct ocelot *ocelot, int port,
+			      struct switchdev_brport_flags flags)
+{
+	if (flags.mask & BR_LEARNING)
+		ocelot_port_set_learning(ocelot, port,
+					 !!(flags.val & BR_LEARNING));
+
+	if (flags.mask & BR_FLOOD)
+		ocelot_port_set_ucast_flood(ocelot, port,
+					    !!(flags.val & BR_FLOOD));
+
+	if (flags.mask & BR_MCAST_FLOOD)
+		ocelot_port_set_mcast_flood(ocelot, port,
+					    !!(flags.val & BR_MCAST_FLOOD));
+
+	if (flags.mask & BR_BCAST_FLOOD)
+		ocelot_port_set_bcast_flood(ocelot, port,
+					    !!(flags.val & BR_BCAST_FLOOD));
+}
+EXPORT_SYMBOL(ocelot_port_bridge_flags);
+
 void ocelot_init_port(struct ocelot *ocelot, int port)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
@@ -1583,6 +1665,9 @@ void ocelot_init_port(struct ocelot *ocelot, int port)
 		       REW_PORT_VLAN_CFG_PORT_TPID_M,
 		       REW_PORT_VLAN_CFG, port);
 
+	/* Disable source address learning for standalone mode */
+	ocelot_port_set_learning(ocelot, port, false);
+
 	/* Enable vcap lookups */
 	ocelot_vcap_enable(ocelot, port);
 }
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index f9da4aa39444..b5ffe6724eb7 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1026,6 +1026,13 @@ static int ocelot_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED:
 		ocelot_port_attr_mc_set(ocelot, port, !attr->u.mc_disabled);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = ocelot_port_pre_bridge_flags(ocelot, port,
+						   attr->u.brport_flags);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ocelot_port_bridge_flags(ocelot, port, attr->u.brport_flags);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -1111,6 +1118,40 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
+static int ocelot_netdevice_bridge_join(struct ocelot *ocelot, int port,
+					struct net_device *bridge)
+{
+	struct switchdev_brport_flags flags;
+	int err;
+
+	flags.mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	flags.val = flags.mask;
+
+	err = ocelot_port_bridge_join(ocelot, port, bridge);
+	if (err)
+		return err;
+
+	ocelot_port_bridge_flags(ocelot, port, flags);
+
+	return 0;
+}
+
+static int ocelot_netdevice_bridge_leave(struct ocelot *ocelot, int port,
+					 struct net_device *bridge)
+{
+	struct switchdev_brport_flags flags;
+	int err;
+
+	flags.mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	flags.val = flags.mask & ~BR_LEARNING;
+
+	err = ocelot_port_bridge_leave(ocelot, port, bridge);
+
+	ocelot_port_bridge_flags(ocelot, port, flags);
+
+	return err;
+}
+
 static int ocelot_netdevice_changeupper(struct net_device *dev,
 					struct netdev_notifier_changeupper_info *info)
 {
@@ -1122,11 +1163,11 @@ static int ocelot_netdevice_changeupper(struct net_device *dev,
 
 	if (netif_is_bridge_master(info->upper_dev)) {
 		if (info->linking) {
-			err = ocelot_port_bridge_join(ocelot, port,
-						      info->upper_dev);
+			err = ocelot_netdevice_bridge_join(ocelot, port,
+							   info->upper_dev);
 		} else {
-			err = ocelot_port_bridge_leave(ocelot, port,
-						       info->upper_dev);
+			err = ocelot_netdevice_bridge_leave(ocelot, port,
+							    info->upper_dev);
 		}
 	}
 	if (netif_is_lag_master(info->upper_dev)) {
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 9acbef1416f1..40792b37bb9f 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -612,6 +612,7 @@ struct ocelot_port {
 
 	u8				*xmit_template;
 	bool				is_dsa_8021q_cpu;
+	bool				learn_ena;
 
 	struct net_device		*bond;
 	bool				lag_tx_active;
@@ -766,6 +767,10 @@ void ocelot_adjust_link(struct ocelot *ocelot, int port,
 int ocelot_port_vlan_filtering(struct ocelot *ocelot, int port, bool enabled);
 void ocelot_bridge_stp_state_set(struct ocelot *ocelot, int port, u8 state);
 void ocelot_apply_bridge_fwd_mask(struct ocelot *ocelot);
+int ocelot_port_pre_bridge_flags(struct ocelot *ocelot, int port,
+				 struct switchdev_brport_flags val);
+void ocelot_port_bridge_flags(struct ocelot *ocelot, int port,
+			      struct switchdev_brport_flags val);
 int ocelot_port_bridge_join(struct ocelot *ocelot, int port,
 			    struct net_device *bridge);
 int ocelot_port_bridge_leave(struct ocelot *ocelot, int port,
-- 
2.25.1

