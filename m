Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT++v7JIFEgiUTptbNQ1BXpNA0iMewfhGYU1bgX7trE=;
 b=GolA3UTacK2bJaq+NmouKbX+snDzuIYGmAPc+aVKgZNo53x9tuH1QfsUHvL/kOQUy8VnTm/8Es/pvX6DNaaUVkT2RYuGlhxL9/gzeYoaiYkrj9imFFdcHBZ2GchDGYRovY8mGxCz6lwMFR4w1wTkisgY2+nzpZqRiBEfOtXDeAA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 22 Jul 2021 18:55:41 +0300
Message-Id: <20210722155542.2897921-5-vladimir.oltean@nxp.com>
In-Reply-To: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
References: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 4/5] net: dsa: mv88e6xxx: map virtual
	bridges with forwarding offload in the PVT
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

The mv88e6xxx switches have the ability to receive FORWARD (data plane)
frames from the CPU port and route them according to the FDB. We can use
this to offload the forwarding process of packets sent by the software
bridge.

Because DSA supports bridge domain isolation between user ports, just
sending FORWARD frames is not enough, as they might leak the intended
broadcast domain of the bridge on behalf of which the packets are sent.

It should be noted that FORWARD frames are also (and typically) used to
forward data plane packets on DSA links in cross-chip topologies. The
FORWARD frame header contains the source port and switch ID, and
switches receiving this frame header forward the packet according to
their cross-chip port-based VLAN table (PVT).

To address the bridging domain isolation in the context of offloading
the forwarding on TX, the idea is that we can reuse the parts of the PVT
that don't have any physical switch mapped to them, one entry for each
software bridge. The switches will therefore think that behind their
upstream port lie many switches, all in fact backed up by software
bridges through tag_dsa.c, which constructs FORWARD packets with the
right switch ID corresponding to each bridge.

The mapping we use is absolutely trivial: DSA gives us a unique bridge
number, and we add the number of the physical switches in the DSA switch
tree to that, to obtain a unique virtual bridge device number to use in
the PVT.

Co-developed-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
v1->v2: keep Tobias' idea, reimplement using just dp->bridge_num instead
        of hooking a dst->priv pointer and cooking the same thing within
        mv88e6xxx, drop his authorship since patch is basically
        rewritten.
v2->v4: none
v4->v5: rename functions for naming consistency

 drivers/net/dsa/mv88e6xxx/chip.c | 78 ++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index beb41572d04e..af764b8445b7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1221,14 +1221,36 @@ static u16 mv88e6xxx_port_vlan(struct mv88e6xxx_chip *chip, int dev, int port)
 	bool found = false;
 	u16 pvlan;
 
-	list_for_each_entry(dp, &dst->ports, list) {
-		if (dp->ds->index == dev && dp->index == port) {
+	/* dev is a physical switch */
+	if (dev <= dst->last_switch) {
+		list_for_each_entry(dp, &dst->ports, list) {
+			if (dp->ds->index == dev && dp->index == port) {
+				/* dp might be a DSA link or a user port, so it
+				 * might or might not have a bridge_dev
+				 * pointer. Use the "found" variable for both
+				 * cases.
+				 */
+				br = dp->bridge_dev;
+				found = true;
+				break;
+			}
+		}
+	/* dev is a virtual bridge */
+	} else {
+		list_for_each_entry(dp, &dst->ports, list) {
+			if (dp->bridge_num < 0)
+				continue;
+
+			if (dp->bridge_num + 1 + dst->last_switch != dev)
+				continue;
+
+			br = dp->bridge_dev;
 			found = true;
 			break;
 		}
 	}
 
-	/* Prevent frames from unknown switch or port */
+	/* Prevent frames from unknown switch or virtual bridge */
 	if (!found)
 		return 0;
 
@@ -1236,7 +1258,6 @@ static u16 mv88e6xxx_port_vlan(struct mv88e6xxx_chip *chip, int dev, int port)
 	if (dp->type == DSA_PORT_TYPE_CPU || dp->type == DSA_PORT_TYPE_DSA)
 		return mv88e6xxx_port_mask(chip);
 
-	br = dp->bridge_dev;
 	pvlan = 0;
 
 	/* Frames from user ports can egress any local DSA links and CPU ports,
@@ -2422,6 +2443,44 @@ static void mv88e6xxx_crosschip_bridge_leave(struct dsa_switch *ds,
 	mv88e6xxx_reg_unlock(chip);
 }
 
+/* Treat the software bridge as a virtual single-port switch behind the
+ * CPU and map in the PVT. First dst->last_switch elements are taken by
+ * physical switches, so start from beyond that range.
+ */
+static int mv88e6xxx_map_virtual_bridge_to_pvt(struct dsa_switch *ds,
+					       int bridge_num)
+{
+	u8 dev = bridge_num + ds->dst->last_switch + 1;
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_pvt_map(chip, dev, 0);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+static int mv88e6xxx_bridge_tx_fwd_offload(struct dsa_switch *ds, int port,
+					   struct net_device *br,
+					   int bridge_num)
+{
+	return mv88e6xxx_map_virtual_bridge_to_pvt(ds, bridge_num);
+}
+
+static void mv88e6xxx_bridge_tx_fwd_unoffload(struct dsa_switch *ds, int port,
+					      struct net_device *br,
+					      int bridge_num)
+{
+	int err;
+
+	err = mv88e6xxx_map_virtual_bridge_to_pvt(ds, bridge_num);
+	if (err) {
+		dev_err(ds->dev, "failed to remap cross-chip Port VLAN: %pe\n",
+			ERR_PTR(err));
+	}
+}
+
 static int mv88e6xxx_software_reset(struct mv88e6xxx_chip *chip)
 {
 	if (chip->info->ops->reset)
@@ -3025,6 +3084,15 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	chip->ds = ds;
 	ds->slave_mii_bus = mv88e6xxx_default_mdio_bus(chip);
 
+	/* Since virtual bridges are mapped in the PVT, the number we support
+	 * depends on the physical switch topology. We need to let DSA figure
+	 * that out and therefore we cannot set this at dsa_register_switch()
+	 * time.
+	 */
+	if (mv88e6xxx_has_pvt(chip))
+		ds->num_fwd_offloading_bridges = MV88E6XXX_MAX_PVT_SWITCHES -
+						 ds->dst->last_switch - 1;
+
 	mv88e6xxx_reg_lock(chip);
 
 	if (chip->info->ops->setup_errata) {
@@ -6128,6 +6196,8 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.crosschip_lag_change	= mv88e6xxx_crosschip_lag_change,
 	.crosschip_lag_join	= mv88e6xxx_crosschip_lag_join,
 	.crosschip_lag_leave	= mv88e6xxx_crosschip_lag_leave,
+	.port_bridge_tx_fwd_offload = mv88e6xxx_bridge_tx_fwd_offload,
+	.port_bridge_tx_fwd_unoffload = mv88e6xxx_bridge_tx_fwd_unoffload,
 };
 
 static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
-- 
2.25.1

