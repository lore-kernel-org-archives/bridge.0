Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sMuPubZ45bqcqp7F8mYy1wbLZt7y2eQbAhZhBI5pduQ=;
 b=E6IkE+EEEAbE0TKB4FhAcQL0fn5pBQkSvkaQTo99WVLWEKXka6frrJqeOmlHcibsdn
 XWVJEIkNFXdVUNJhmXJESmEh5zkOij/Hc51cAFOxLXDLA3vr77Zx+9pYcGZ0XE/vtAaH
 cIcWfRxImTW5gQRljjrEsMqRNCxWOKm/xx+MFtP0J/On7hizsAlpEL819U5Kj/v7p/rz
 0kLjGK03xzWh5O0Zt/1A0rSsejT3hNQivdSC9IytGlklNW4ekVkxil4pK//jCsre5evU
 XhnQs5WnfbRHEHOXVwrWE92kijxc7D7sOj82FbM0v1BZFZN0Kouwp5EwOdKHmXGQrnSd
 3nQw==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon,  8 Feb 2021 01:21:41 +0200
Message-Id: <20210207232141.2142678-10-olteanv@gmail.com>
In-Reply-To: <20210207232141.2142678-1-olteanv@gmail.com>
References: <20210207232141.2142678-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 9/9] net: mscc: ocelot: support multiple
	bridges
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

The ocelot switches are a bit odd in that they do not have an STP state
to put the ports into. Instead, the forwarding configuration is delayed
from the typical port_bridge_join into stp_state_set, when the port enters
the BR_STATE_FORWARDING state.

I can only guess that the implementation of this quirk is the reason that
led to the simplification of the driver such that only one bridge could
be offloaded at a time.

We can simplify the data structures somewhat, and introduce a per-port
bridge device pointer and STP state, similar to how the LAG offload
works now (there we have a per-port bonding device pointer and TX
enabled state). This allows offloading multiple bridges with relative
ease, while still keeping in place the quirk to delay the programming of
the PGIDs.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c         | 69 +++++++++++-----------
 drivers/net/ethernet/mscc/ocelot_vsc7514.c |  2 +-
 include/soc/mscc/ocelot.h                  |  7 +--
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c8bfc2f9534a..6f2967376210 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -912,6 +912,26 @@ static u32 ocelot_get_bond_mask(struct ocelot *ocelot, struct net_device *bond,
 	return mask;
 }
 
+static u32 ocelot_get_bridge_fwd_mask(struct ocelot *ocelot,
+				      struct net_device *bridge)
+{
+	u32 mask = 0;
+	int port;
+
+	for (port = 0; port < ocelot->num_phys_ports; port++) {
+		struct ocelot_port *ocelot_port = ocelot->ports[port];
+
+		if (!ocelot_port)
+			continue;
+
+		if (ocelot_port->stp_state == BR_STATE_FORWARDING &&
+		    ocelot_port->bridge == bridge)
+			mask |= BIT(port);
+	}
+
+	return mask;
+}
+
 static u32 ocelot_get_dsa_8021q_cpu_mask(struct ocelot *ocelot)
 {
 	u32 mask = 0;
@@ -961,10 +981,12 @@ void ocelot_apply_bridge_fwd_mask(struct ocelot *ocelot)
 			 */
 			mask = GENMASK(ocelot->num_phys_ports - 1, 0);
 			mask &= ~cpu_fwd_mask;
-		} else if (ocelot->bridge_fwd_mask & BIT(port)) {
+		} else if (ocelot_port->bridge) {
+			struct net_device *bridge = ocelot_port->bridge;
 			struct net_device *bond = ocelot_port->bond;
 
-			mask = ocelot->bridge_fwd_mask & ~BIT(port);
+			mask = ocelot_get_bridge_fwd_mask(ocelot, bridge);
+			mask &= ~BIT(port);
 			if (bond) {
 				mask &= ~ocelot_get_bond_mask(ocelot, bond,
 							      false);
@@ -985,29 +1007,16 @@ EXPORT_SYMBOL(ocelot_apply_bridge_fwd_mask);
 void ocelot_bridge_stp_state_set(struct ocelot *ocelot, int port, u8 state)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	u32 port_cfg;
-
-	if (!(BIT(port) & ocelot->bridge_mask))
-		return;
+	u32 learn_ena = 0;
 
-	port_cfg = ocelot_read_gix(ocelot, ANA_PORT_PORT_CFG, port);
+	ocelot_port->stp_state = state;
 
-	switch (state) {
-	case BR_STATE_FORWARDING:
-		ocelot->bridge_fwd_mask |= BIT(port);
-		fallthrough;
-	case BR_STATE_LEARNING:
-		if (ocelot_port->brport_flags & BR_LEARNING)
-			port_cfg |= ANA_PORT_PORT_CFG_LEARN_ENA;
-		break;
-
-	default:
-		port_cfg &= ~ANA_PORT_PORT_CFG_LEARN_ENA;
-		ocelot->bridge_fwd_mask &= ~BIT(port);
-		break;
-	}
+	if ((state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) &&
+	    ocelot_port->brport_flags & BR_LEARNING)
+		learn_ena = ANA_PORT_PORT_CFG_LEARN_ENA;
 
-	ocelot_write_gix(ocelot, port_cfg, ANA_PORT_PORT_CFG, port);
+	ocelot_rmw_gix(ocelot, learn_ena, ANA_PORT_PORT_CFG_LEARN_ENA,
+		       ANA_PORT_PORT_CFG, port);
 
 	ocelot_apply_bridge_fwd_mask(ocelot);
 }
@@ -1237,16 +1246,9 @@ EXPORT_SYMBOL(ocelot_port_mdb_del);
 int ocelot_port_bridge_join(struct ocelot *ocelot, int port,
 			    struct net_device *bridge)
 {
-	if (!ocelot->bridge_mask) {
-		ocelot->hw_bridge_dev = bridge;
-	} else {
-		if (ocelot->hw_bridge_dev != bridge)
-			/* This is adding the port to a second bridge, this is
-			 * unsupported */
-			return -ENODEV;
-	}
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 
-	ocelot->bridge_mask |= BIT(port);
+	ocelot_port->bridge = bridge;
 
 	return 0;
 }
@@ -1259,10 +1261,7 @@ int ocelot_port_bridge_leave(struct ocelot *ocelot, int port,
 	struct ocelot_vlan pvid = {0}, native_vlan = {0};
 	int ret;
 
-	ocelot->bridge_mask &= ~BIT(port);
-
-	if (!ocelot->bridge_mask)
-		ocelot->hw_bridge_dev = NULL;
+	ocelot_port->bridge = NULL;
 
 	ret = ocelot_port_vlan_filtering(ocelot, port, false);
 	if (ret)
diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 6b6eb92149ba..c366d96fc945 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -694,7 +694,7 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 		/* Everything we see on an interface that is in the HW bridge
 		 * has already been forwarded.
 		 */
-		if (ocelot->bridge_mask & BIT(info.port))
+		if (ocelot_port->bridge)
 			skb->offload_fwd_mark = 1;
 
 		skb->protocol = eth_type_trans(skb, dev);
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index d8b4b1d3be15..333300b14a97 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -617,6 +617,9 @@ struct ocelot_port {
 
 	struct net_device		*bond;
 	bool				lag_tx_active;
+
+	struct net_device		*bridge;
+	u8				stp_state;
 };
 
 struct ocelot {
@@ -636,10 +639,6 @@ struct ocelot {
 	int				num_frame_refs;
 	int				num_mact_rows;
 
-	struct net_device		*hw_bridge_dev;
-	u16				bridge_mask;
-	u16				bridge_fwd_mask;
-
 	struct ocelot_port		**ports;
 
 	u8				base_mac[ETH_ALEN];
-- 
2.25.1

