Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy44Rt/qej2ziZFekOaY9Z+pRTJ7MMlLa+bBRv26KYs=;
 b=f1h/2HSkFKJsL/p5O7li1kUcN62KiSLebTTXPiqS4M+8zSi9pqDScXxQVug26nrju0o8Ue33CwVUG0xZjDSLDsNE+9O5cGxSjy60P/lY4HLruQ0Ew4JhPYPWbJ22zy8JnLnB5ViN1fsTBUNjdWyq34HbbqQFY6zodsWadUtsGNE=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 16:46:55 +0300
Message-Id: <20210720134655.892334-11-vladimir.oltean@nxp.com>
In-Reply-To: <20210720134655.892334-1-vladimir.oltean@nxp.com>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 10/10] net: bridge: switchdev object
	replay helpers for everybody
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Vadym Kochan <vkochan@marvell.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, UNGLinuxDriver@microchip.com, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Taras Chornyi <tchornyi@marvell.com>, Vivien Didelot <vivien.didelot@gmail.com>, Lars Povlsen <lars.povlsen@microchip.com>, Tobias Waldekranz <tobias@waldekranz.com>

Starting with commit 4f2673b3a2b6 ("net: bridge: add helper to replay
port and host-joined mdb entries"), DSA has introduced some bridge
helpers that replay switchdev events (FDB/MDB/VLAN additions and
deletions) that can be lost by the switchdev drivers in a variety of
circumstances:

- an IP multicast group was host-joined on the bridge itself before any
  switchdev port joined the bridge, leading to the host MDB entries
  missing in the hardware database.
- during the bridge creation process, the MAC address of the bridge was
  added to the FDB as an entry pointing towards the bridge device
  itself, but with no switchdev ports being part of the bridge yet, this
  local FDB entry would remain unknown to the switchdev hardware
  database.
- a VLAN/FDB/MDB was added to a bridge port that is a LAG interface,
  before any switchdev port joined that LAG, leading to the hardware
  database missing those entries.
- a switchdev port left a LAG that is a bridge port, while the LAG
  remained part of the bridge, and all FDB/MDB/VLAN entries remained
  installed in the hardware database of the switchdev port.

Also, since commit 0d2cfbd41c4a ("net: bridge: ignore switchdev events
for LAG ports which didn't request replay"), DSA introduced a method,
based on a const void *ctx, to ensure that two switchdev ports under the
same LAG that is a bridge port do not see the same MDB/VLAN entry being
replayed twice by the bridge, once for every bridge port that joins the
LAG.

With so many ordering corner cases being possible, it seems unreasonable
to expect a switchdev driver writer to get it right from the first try.
Therefore, now that we are past the beta testing period for the bridge
replay helpers used in DSA only, it is time to roll them out to all
switchdev drivers.

To convert the switchdev object replay helpers from "pull mode" (where
the driver asks for them) to a "push mode" (where the bridge offers them
automatically), the biggest problem is that the bridge needs to be aware
when a switchdev port joins and leaves, even when the switchdev is only
indirectly a bridge port (for example when the bridge port is a LAG
upper of the switchdev).

Luckily, we already have a hook for that, in the form of the newly
introduced switchdev_bridge_port_offload() and
switchdev_bridge_port_unoffload() calls. These offer a natural place for
hooking the object addition and deletion replays.

Extend the above 2 functions with:
- pointers to the switchdev atomic notifier (for FDB replays) and the
  blocking notifier (for MDB and VLAN replays).
- the "const void *ctx" argument required for drivers to be able to
  disambiguate between which port is targeted, when multiple ports are
  lowers of the same LAG that is a bridge port. Most of the drivers pass
  NULL to this argument, except the ones that support LAG offload and have
  the proper context check already in place in the switchdev blocking
  notifier handler.

am65_cpsw and cpsw had the same name for the switchdev notifiers, so I
renamed the am65_cpsw ones with an am65_ prefix.

Also unexport the replay helpers, since nobody except the bridge calls
them directly now.

Note that:
(a) we abuse the terminology slightly, because FDB entries are not
    "switchdev objects", but we count them as objects nonetheless.
    With no direct way to prove it, I think they are not modeled as
    switchdev objects because those can only be installed by the bridge
    to the hardware (as opposed to FDB entries which can be propagated
    in the other direction too). This is merely an abuse of terms, FDB
    entries are replayed too, despite not being objects.
(b) the bridge does not attempt to sync port attributes to newly joined
    ports, just the countable stuff (the objects). The reason for this
    is simple: no universal and symmetric way to sync and unsync them is
    known. For example, VLAN filtering: what to do on unsync, disable or
    leave it enabled? Similarly, STP state, ageing timer, etc etc. What
    a switchdev port does when it becomes standalone again is not really
    up to the bridge's competence, and the driver should deal with it.
    On the other hand, replaying deletions of switchdev objects can be
    seen a matter of cleanup and therefore be treated by the bridge,
    hence this patch.
(c) I do not expect a lot of functional change introduced for drivers in
    this patch, because:
    - nbp_vlan_init() is called _after_ netdev_master_upper_dev_link(),
      so br_vlan_replay() should not do anything for the new drivers on
      which we call it. The existing drivers where there was even a
      slight possibility for there to exist a VLAN on a bridge port
      before they join it are already guarded against this: mlxsw and
      prestera deny joining LAG interfaces that are members of a bridge.
    - br_fdb_replay() should now notify of local FDB entries, but I
      patched all drivers except DSA to ignore these new entries in
      commit 2c4eca3ef716 ("net: bridge: switchdev: include local flag
      in FDB notifications"). Driver authors can lift this restriction
      as they wish.
    - br_mdb_replay() should now fix the issue described in commit
      4f2673b3a2b6 ("net: bridge: add helper to replay port and
      host-joined mdb entries") for all drivers, I don't see any
      downside.

Cc: Vadym Kochan <vkochan@marvell.com>
Cc: Taras Chornyi <tchornyi@marvell.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com> # dpaa2-switch
---
v2->v3: patch is new
v3->v4: passing the switchdev notifier blocks as argument to
        switchdev_bridge_port_offload()
v4->v5: fixed the reference to the proper br_mdb_replay() patch in the
        commit message

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 13 ++-
 .../marvell/prestera/prestera_switchdev.c     | 13 ++-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 13 ++-
 .../microchip/sparx5/sparx5_switchdev.c       | 11 ++-
 drivers/net/ethernet/mscc/ocelot_net.c        | 40 ++++-----
 drivers/net/ethernet/rocker/rocker.h          |  3 +
 drivers/net/ethernet/rocker/rocker_main.c     |  4 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    | 10 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      | 10 ++-
 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 14 +--
 drivers/net/ethernet/ti/am65-cpsw-switchdev.h |  3 +
 drivers/net/ethernet/ti/cpsw_new.c            | 10 ++-
 drivers/net/ethernet/ti/cpsw_switchdev.c      |  4 +-
 drivers/net/ethernet/ti/cpsw_switchdev.h      |  3 +
 include/linux/if_bridge.h                     | 56 ++++--------
 net/bridge/br_fdb.c                           |  1 -
 net/bridge/br_mdb.c                           |  1 -
 net/bridge/br_private.h                       | 26 ++++++
 net/bridge/br_switchdev.c                     | 86 ++++++++++++++++++-
 net/bridge/br_vlan.c                          |  1 -
 net/dsa/port.c                                | 79 ++++-------------
 21 files changed, 243 insertions(+), 158 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 2cd8a38e4f30..a7db964a9ee6 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1889,6 +1889,9 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static struct notifier_block dpaa2_switch_port_switchdev_nb;
+static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
+
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct net_device *upper_dev,
 					 struct netlink_ext_ack *extack)
@@ -1930,7 +1933,10 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		goto err_egress_flood;
 
-	return switchdev_bridge_port_offload(netdev, netdev, extack);
+	return switchdev_bridge_port_offload(netdev, netdev, NULL,
+					     &dpaa2_switch_port_switchdev_nb,
+					     &dpaa2_switch_port_switchdev_blocking_nb,
+					     extack);
 
 err_egress_flood:
 	dpaa2_switch_port_set_fdb(port_priv, NULL);
@@ -1961,7 +1967,10 @@ static int dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev,
 					      struct net_device *upper_dev,
 					      struct netlink_ext_ack *extack)
 {
-	return switchdev_bridge_port_unoffload(netdev, netdev, extack);
+	return switchdev_bridge_port_unoffload(netdev, netdev, NULL,
+					       &dpaa2_switch_port_switchdev_nb,
+					       &dpaa2_switch_port_switchdev_blocking_nb,
+					       extack);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
index 4be82c043991..0072b6251522 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
@@ -501,7 +501,10 @@ int prestera_bridge_port_join(struct net_device *br_dev,
 		goto err_brport_create;
 	}
 
-	err = switchdev_bridge_port_offload(br_port->dev, port->dev, extack);
+	err = switchdev_bridge_port_offload(br_port->dev, port->dev, port,
+					    &swdev->swdev_nb,
+					    &swdev->swdev_nb_blk,
+					    extack);
 	if (err)
 		goto err_brport_offload;
 
@@ -515,7 +518,9 @@ int prestera_bridge_port_join(struct net_device *br_dev,
 	return 0;
 
 err_port_join:
-	switchdev_bridge_port_unoffload(br_port->dev, port->dev, extack);
+	switchdev_bridge_port_unoffload(br_port->dev, port->dev, port,
+					&swdev->swdev_nb, &swdev->swdev_nb_blk,
+					extack);
 err_brport_offload:
 	prestera_bridge_port_put(br_port);
 err_brport_create:
@@ -539,7 +544,9 @@ int prestera_pre_bridge_port_leave(struct net_device *br_dev,
 	if (!br_port)
 		return -ENODEV;
 
-	return switchdev_bridge_port_unoffload(br_port->dev, port->dev,
+	return switchdev_bridge_port_unoffload(br_port->dev, port->dev, port,
+					       &swdev->swdev_nb,
+					       &swdev->swdev_nb_blk,
 					       extack);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 731234a2ace3..517cf5b498af 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2360,6 +2360,9 @@ static const struct mlxsw_sp_bridge_ops mlxsw_sp2_bridge_8021ad_ops = {
 	.fid_vid	= mlxsw_sp_bridge_8021q_fid_vid,
 };
 
+static struct notifier_block mlxsw_sp_switchdev_blocking_notifier;
+struct notifier_block mlxsw_sp_switchdev_notifier;
+
 int mlxsw_sp_port_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
 			      struct net_device *brport_dev,
 			      struct net_device *br_dev,
@@ -2382,7 +2385,10 @@ int mlxsw_sp_port_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (err)
 		goto err_port_join;
 
-	return switchdev_bridge_port_offload(brport_dev, dev, extack);
+	return switchdev_bridge_port_offload(brport_dev, dev, mlxsw_sp_port,
+					     &mlxsw_sp_switchdev_notifier,
+					     &mlxsw_sp_switchdev_blocking_notifier,
+					     extack);
 
 err_port_join:
 	mlxsw_sp_bridge_port_put(mlxsw_sp->bridge, bridge_port);
@@ -2396,7 +2402,10 @@ int mlxsw_sp_port_pre_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 {
 	struct net_device *dev = mlxsw_sp_port->dev;
 
-	return switchdev_bridge_port_unoffload(brport_dev, dev, extack);
+	return switchdev_bridge_port_unoffload(brport_dev, dev, mlxsw_sp_port,
+					       &mlxsw_sp_switchdev_notifier,
+					       &mlxsw_sp_switchdev_blocking_notifier,
+					       extack);
 }
 
 void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 270b9fabce91..f8b1deffbfb4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -116,15 +116,22 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 	 */
 	__dev_mc_unsync(ndev, sparx5_mc_unsync);
 
-	return switchdev_bridge_port_offload(ndev, ndev, extack);
+	return switchdev_bridge_port_offload(ndev, ndev, NULL,
+					     &sparx5->switchdev_nb,
+					     &sparx5->switchdev_blocking_nb,
+					     extack);
 }
 
 static int sparx5_port_pre_bridge_leave(struct sparx5_port *port,
 					struct netlink_ext_ack *extack)
 {
+	struct sparx5 *sparx5 = port->sparx5;
 	struct net_device *ndev = port->ndev;
 
-	return switchdev_bridge_port_unoffload(ndev, ndev, extack);
+	return switchdev_bridge_port_unoffload(ndev, ndev, NULL,
+					       &sparx5->switchdev_nb,
+					       &sparx5->switchdev_blocking_nb,
+					       extack);
 }
 
 static void sparx5_port_bridge_leave(struct sparx5_port *port,
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index dcb393a35c0e..f24f6a790814 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1154,38 +1154,19 @@ static int ocelot_switchdev_sync(struct ocelot *ocelot, int port,
 				 struct net_device *bridge_dev,
 				 struct netlink_ext_ack *extack)
 {
-	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	struct ocelot_port_private *priv;
 	clock_t ageing_time;
 	u8 stp_state;
-	int err;
-
-	priv = container_of(ocelot_port, struct ocelot_port_private, port);
 
 	ocelot_inherit_brport_flags(ocelot, port, brport_dev);
 
 	stp_state = br_port_get_stp_state(brport_dev);
 	ocelot_bridge_stp_state_set(ocelot, port, stp_state);
 
-	err = ocelot_port_vlan_filtering(ocelot, port,
-					 br_vlan_enabled(bridge_dev));
-	if (err)
-		return err;
-
 	ageing_time = br_get_ageing_time(bridge_dev);
 	ocelot_port_attr_ageing_set(ocelot, port, ageing_time);
 
-	err = br_mdb_replay(bridge_dev, brport_dev, priv, true,
-			    &ocelot_switchdev_blocking_nb, extack);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	err = br_vlan_replay(bridge_dev, brport_dev, priv, true,
-			     &ocelot_switchdev_blocking_nb, extack);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	return 0;
+	return ocelot_port_vlan_filtering(ocelot, port,
+					  br_vlan_enabled(bridge_dev));
 }
 
 static int ocelot_switchdev_unsync(struct ocelot *ocelot, int port)
@@ -1216,7 +1197,10 @@ static int ocelot_netdevice_bridge_join(struct net_device *dev,
 
 	ocelot_port_bridge_join(ocelot, port, bridge);
 
-	err = switchdev_bridge_port_offload(brport_dev, dev, extack);
+	err = switchdev_bridge_port_offload(brport_dev, dev, priv,
+					    &ocelot_netdevice_nb,
+					    &ocelot_switchdev_blocking_nb,
+					    extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -1227,7 +1211,10 @@ static int ocelot_netdevice_bridge_join(struct net_device *dev,
 	return 0;
 
 err_switchdev_sync:
-	switchdev_bridge_port_unoffload(brport_dev, dev, extack);
+	switchdev_bridge_port_unoffload(brport_dev, dev, priv,
+					&ocelot_netdevice_nb,
+					&ocelot_switchdev_blocking_nb,
+					extack);
 err_switchdev_offload:
 	ocelot_port_bridge_leave(ocelot, port, bridge);
 	return err;
@@ -1237,7 +1224,12 @@ static int ocelot_netdevice_pre_bridge_leave(struct net_device *dev,
 					     struct net_device *brport_dev,
 					     struct netlink_ext_ack *extack)
 {
-	return switchdev_bridge_port_unoffload(brport_dev, dev, extack);
+	struct ocelot_port_private *priv = netdev_priv(dev);
+
+	return switchdev_bridge_port_unoffload(brport_dev, dev, priv,
+					       &ocelot_netdevice_nb,
+					       &ocelot_switchdev_blocking_nb,
+					       extack);
 }
 
 static int ocelot_netdevice_bridge_leave(struct net_device *dev,
diff --git a/drivers/net/ethernet/rocker/rocker.h b/drivers/net/ethernet/rocker/rocker.h
index d31cee1cdda9..89854ba6f314 100644
--- a/drivers/net/ethernet/rocker/rocker.h
+++ b/drivers/net/ethernet/rocker/rocker.h
@@ -142,4 +142,7 @@ struct rocker_world_ops {
 
 extern struct rocker_world_ops rocker_ofdpa_ops;
 
+extern struct notifier_block rocker_switchdev_notifier;
+extern struct notifier_block rocker_switchdev_blocking_notifier;
+
 #endif
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 2e3e413406ac..c9f73e944a4f 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2861,11 +2861,11 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block rocker_switchdev_notifier = {
+struct notifier_block rocker_switchdev_notifier = {
 	.notifier_call = rocker_switchdev_event,
 };
 
-static struct notifier_block rocker_switchdev_blocking_notifier = {
+struct notifier_block rocker_switchdev_blocking_notifier = {
 	.notifier_call = rocker_switchdev_blocking_event,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index c32d076bcbf6..e1ffac8f78b8 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2598,7 +2598,10 @@ static int ofdpa_port_bridge_join(struct ofdpa_port *ofdpa_port,
 	if (err)
 		return err;
 
-	return switchdev_bridge_port_offload(dev, dev, extack);
+	return switchdev_bridge_port_offload(dev, dev, NULL,
+					     &rocker_switchdev_notifier,
+					     &rocker_switchdev_blocking_notifier,
+					     extack);
 }
 
 static int ofdpa_port_pre_bridge_leave(struct ofdpa_port *ofdpa_port,
@@ -2606,7 +2609,10 @@ static int ofdpa_port_pre_bridge_leave(struct ofdpa_port *ofdpa_port,
 {
 	struct net_device *dev = ofdpa_port->dev;
 
-	return switchdev_bridge_port_unoffload(dev, dev, extack);
+	return switchdev_bridge_port_unoffload(dev, dev, NULL,
+					       &rocker_switchdev_notifier,
+					       &rocker_switchdev_blocking_notifier,
+					       extack);
 }
 
 static int ofdpa_port_bridge_leave(struct ofdpa_port *ofdpa_port)
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 30e8b21dc6db..b6f9bc885c52 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2096,7 +2096,10 @@ static int am65_cpsw_netdevice_port_link(struct net_device *ndev,
 			return -EOPNOTSUPP;
 	}
 
-	err = switchdev_bridge_port_offload(ndev, ndev, extack);
+	err = switchdev_bridge_port_offload(ndev, ndev, NULL,
+					    &am65_cpsw_switchdev_notifier,
+					    &am65_cpsw_switchdev_bl_notifier,
+					    extack);
 	if (err)
 		return err;
 
@@ -2110,7 +2113,10 @@ static int am65_cpsw_netdevice_port_link(struct net_device *ndev,
 static int am65_cpsw_netdevice_port_pre_unlink(struct net_device *ndev,
 					       struct netlink_ext_ack *extack)
 {
-	return switchdev_bridge_port_unoffload(ndev, ndev, extack);
+	return switchdev_bridge_port_unoffload(ndev, ndev, NULL,
+					       &am65_cpsw_switchdev_notifier,
+					       &am65_cpsw_switchdev_bl_notifier,
+					       extack);
 }
 
 static void am65_cpsw_netdevice_port_unlink(struct net_device *ndev)
diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 9c29b363e9ae..744d76121d2c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -473,7 +473,7 @@ static int am65_cpsw_switchdev_event(struct notifier_block *unused,
 	return NOTIFY_BAD;
 }
 
-static struct notifier_block cpsw_switchdev_notifier = {
+struct notifier_block am65_cpsw_switchdev_notifier = {
 	.notifier_call = am65_cpsw_switchdev_event,
 };
 
@@ -506,7 +506,7 @@ static int am65_cpsw_switchdev_blocking_event(struct notifier_block *unused,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block cpsw_switchdev_bl_notifier = {
+struct notifier_block am65_cpsw_switchdev_bl_notifier = {
 	.notifier_call = am65_cpsw_switchdev_blocking_event,
 };
 
@@ -514,18 +514,18 @@ int am65_cpsw_switchdev_register_notifiers(struct am65_cpsw_common *cpsw)
 {
 	int ret = 0;
 
-	ret = register_switchdev_notifier(&cpsw_switchdev_notifier);
+	ret = register_switchdev_notifier(&am65_cpsw_switchdev_notifier);
 	if (ret) {
 		dev_err(cpsw->dev, "register switchdev notifier fail ret:%d\n",
 			ret);
 		return ret;
 	}
 
-	ret = register_switchdev_blocking_notifier(&cpsw_switchdev_bl_notifier);
+	ret = register_switchdev_blocking_notifier(&am65_cpsw_switchdev_bl_notifier);
 	if (ret) {
 		dev_err(cpsw->dev, "register switchdev blocking notifier ret:%d\n",
 			ret);
-		unregister_switchdev_notifier(&cpsw_switchdev_notifier);
+		unregister_switchdev_notifier(&am65_cpsw_switchdev_notifier);
 	}
 
 	return ret;
@@ -533,6 +533,6 @@ int am65_cpsw_switchdev_register_notifiers(struct am65_cpsw_common *cpsw)
 
 void am65_cpsw_switchdev_unregister_notifiers(struct am65_cpsw_common *cpsw)
 {
-	unregister_switchdev_blocking_notifier(&cpsw_switchdev_bl_notifier);
-	unregister_switchdev_notifier(&cpsw_switchdev_notifier);
+	unregister_switchdev_blocking_notifier(&am65_cpsw_switchdev_bl_notifier);
+	unregister_switchdev_notifier(&am65_cpsw_switchdev_notifier);
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.h b/drivers/net/ethernet/ti/am65-cpsw-switchdev.h
index a67a7606bc80..5f06383f3598 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.h
@@ -7,6 +7,9 @@
 
 #include <linux/skbuff.h>
 
+extern struct notifier_block am65_cpsw_switchdev_notifier;
+extern struct notifier_block am65_cpsw_switchdev_bl_notifier;
+
 #if IS_ENABLED(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV)
 static inline void am65_cpsw_nuss_set_offload_fwd_mark(struct sk_buff *skb, bool val)
 {
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 8c586d1ff7d7..c8f54d6d7e17 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1517,7 +1517,10 @@ static int cpsw_netdevice_port_link(struct net_device *ndev,
 			return -EOPNOTSUPP;
 	}
 
-	err = switchdev_bridge_port_offload(ndev, ndev, extack);
+	err = switchdev_bridge_port_offload(ndev, ndev, NULL,
+					    &cpsw_switchdev_notifier,
+					    &cpsw_switchdev_bl_notifier,
+					    extack);
 	if (err)
 		return err;
 
@@ -1531,7 +1534,10 @@ static int cpsw_netdevice_port_link(struct net_device *ndev,
 static int cpsw_netdevice_port_pre_unlink(struct net_device *ndev,
 					  struct netlink_ext_ack *extack)
 {
-	return switchdev_bridge_port_unoffload(ndev, ndev, extack);
+	return switchdev_bridge_port_unoffload(ndev, ndev, NULL,
+					       &cpsw_switchdev_notifier,
+					       &cpsw_switchdev_bl_notifier,
+					       extack);
 }
 
 static void cpsw_netdevice_port_unlink(struct net_device *ndev)
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
index f7fb6e17dadd..a6afe4cb71a0 100644
--- a/drivers/net/ethernet/ti/cpsw_switchdev.c
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.c
@@ -483,7 +483,7 @@ static int cpsw_switchdev_event(struct notifier_block *unused,
 	return NOTIFY_BAD;
 }
 
-static struct notifier_block cpsw_switchdev_notifier = {
+struct notifier_block cpsw_switchdev_notifier = {
 	.notifier_call = cpsw_switchdev_event,
 };
 
@@ -516,7 +516,7 @@ static int cpsw_switchdev_blocking_event(struct notifier_block *unused,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block cpsw_switchdev_bl_notifier = {
+struct notifier_block cpsw_switchdev_bl_notifier = {
 	.notifier_call = cpsw_switchdev_blocking_event,
 };
 
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.h b/drivers/net/ethernet/ti/cpsw_switchdev.h
index 04a045dba7d4..7c67d37e17fa 100644
--- a/drivers/net/ethernet/ti/cpsw_switchdev.h
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.h
@@ -12,4 +12,7 @@ bool cpsw_port_dev_check(const struct net_device *dev);
 int cpsw_switchdev_register_notifiers(struct cpsw_common *cpsw);
 void cpsw_switchdev_unregister_notifiers(struct cpsw_common *cpsw);
 
+extern struct notifier_block cpsw_switchdev_notifier;
+extern struct notifier_block cpsw_switchdev_bl_notifier;
+
 #endif /* DRIVERS_NET_ETHERNET_TI_CPSW_SWITCHDEV_H_ */
diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index d0bec83488b9..425a4196f9c6 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -70,9 +70,6 @@ bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto);
 bool br_multicast_has_router_adjacent(struct net_device *dev, int proto);
 bool br_multicast_enabled(const struct net_device *dev);
 bool br_multicast_router(const struct net_device *dev);
-int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
-		  const void *ctx, bool adding, struct notifier_block *nb,
-		  struct netlink_ext_ack *extack);
 #else
 static inline int br_multicast_list_adjacent(struct net_device *dev,
 					     struct list_head *br_ip_list)
@@ -104,13 +101,6 @@ static inline bool br_multicast_router(const struct net_device *dev)
 {
 	return false;
 }
-static inline int br_mdb_replay(const struct net_device *br_dev,
-				const struct net_device *dev, const void *ctx,
-				bool adding, struct notifier_block *nb,
-				struct netlink_ext_ack *extack)
-{
-	return -EOPNOTSUPP;
-}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
@@ -120,9 +110,6 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid);
 int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto);
 int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
-int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
-		   const void *ctx, bool adding, struct notifier_block *nb,
-		   struct netlink_ext_ack *extack);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -149,14 +136,6 @@ static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
-
-static inline int br_vlan_replay(struct net_device *br_dev,
-				 struct net_device *dev, const void *ctx,
-				 bool adding, struct notifier_block *nb,
-				 struct netlink_ext_ack *extack)
-{
-	return -EOPNOTSUPP;
-}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
@@ -167,8 +146,6 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
 bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 u8 br_port_get_stp_state(const struct net_device *dev);
 clock_t br_get_ageing_time(const struct net_device *br_dev);
-int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
-		  const void *ctx, bool adding, struct notifier_block *nb);
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -197,36 +174,39 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 {
 	return 0;
 }
-
-static inline int br_fdb_replay(const struct net_device *br_dev,
-				const struct net_device *dev, const void *ctx,
-				bool adding, struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_NET_SWITCHDEV)
 
 int switchdev_bridge_port_offload(struct net_device *brport_dev,
-				  struct net_device *dev,
+				  struct net_device *dev, const void *ctx,
+				  struct notifier_block *atomic_nb,
+				  struct notifier_block *blocking_nb,
 				  struct netlink_ext_ack *extack);
 int switchdev_bridge_port_unoffload(struct net_device *brport_dev,
-				    struct net_device *dev,
+				    struct net_device *dev, const void *ctx,
+				    struct notifier_block *atomic_nb,
+				    struct notifier_block *blocking_nb,
 				    struct netlink_ext_ack *extack);
 
 #else
 
-static inline int switchdev_bridge_port_offload(struct net_device *brport_dev,
-						struct net_device *dev,
-						struct netlink_ext_ack *extack)
+static inline int
+switchdev_bridge_port_offload(struct net_device *brport_dev,
+			      struct net_device *dev, const void *ctx,
+			      struct notifier_block *atomic_nb,
+			      struct notifier_block *blocking_nb,
+			      struct netlink_ext_ack *extack)
 {
 	return -EINVAL;
 }
 
-static inline int switchdev_bridge_port_unoffload(struct net_device *brport_dev,
-						  struct net_device *dev,
-						  struct netlink_ext_ack *extack)
+static inline int
+switchdev_bridge_port_unoffload(struct net_device *brport_dev,
+				struct net_device *dev, const void *ctx,
+				struct notifier_block *atomic_nb,
+				struct notifier_block *blocking_nb,
+				struct netlink_ext_ack *extack)
 {
 	return -EINVAL;
 }
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 2b862cffc03a..33c071462799 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -792,7 +792,6 @@ int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(br_fdb_replay);
 
 static void fdb_notify(struct net_bridge *br,
 		       const struct net_bridge_fdb_entry *fdb, int type,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 17a720b4473f..364cb1a851fc 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -686,7 +686,6 @@ int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(br_mdb_replay);
 
 static void br_mdb_switchdev_host_port(struct net_device *dev,
 				       struct net_device *lower_dev,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 46236302eed5..1d3e5957d4d5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -735,6 +735,8 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      bool swdev_notify);
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
 			  const unsigned char *addr, u16 vid, bool offloaded);
+int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
+		  const void *ctx, bool adding, struct notifier_block *nb);
 
 /* br_forward.c */
 enum br_pkt_type {
@@ -877,6 +879,10 @@ br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip);
 void br_multicast_del_group_src(struct net_bridge_group_src *src,
 				bool fastleave);
 
+int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
+		  const void *ctx, bool adding, struct notifier_block *nb,
+		  struct netlink_ext_ack *extack);
+
 static inline bool br_group_is_l2(const struct br_ip *group)
 {
 	return group->proto == 0;
@@ -1135,6 +1141,15 @@ static inline int br_multicast_igmp_type(const struct sk_buff *skb)
 {
 	return 0;
 }
+
+static inline int br_mdb_replay(struct net_device *br_dev,
+				struct net_device *dev, const void *ctx,
+				bool adding, struct notifier_block *nb,
+				struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 /* br_vlan.c */
@@ -1185,6 +1200,9 @@ void br_vlan_notify(const struct net_bridge *br,
 		    const struct net_bridge_port *p,
 		    u16 vid, u16 vid_range,
 		    int cmd);
+int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
+		   const void *ctx, bool adding, struct notifier_block *nb,
+		   struct netlink_ext_ack *extack);
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
@@ -1427,6 +1445,14 @@ static inline bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 {
 	return true;
 }
+
+static inline int br_vlan_replay(struct net_device *br_dev,
+				 struct net_device *dev, const void *ctx,
+				 bool adding, struct notifier_block *nb,
+				 struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /* br_vlan_options.c */
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 0eb4bc272bff..3252c8e78bb9 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -212,11 +212,74 @@ static void nbp_switchdev_del(struct net_bridge_port *p,
 		nbp_switchdev_hwdom_put(p);
 }
 
+static int nbp_switchdev_sync_objs(struct net_bridge_port *p, const void *ctx,
+				   struct notifier_block *atomic_nb,
+				   struct notifier_block *blocking_nb,
+				   struct netlink_ext_ack *extack)
+{
+	struct net_device *br_dev = p->br->dev;
+	struct net_device *dev = p->dev;
+	int err;
+
+	err = br_vlan_replay(br_dev, dev, ctx, true, blocking_nb, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	err = br_mdb_replay(br_dev, dev, ctx, true, blocking_nb, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	/* Forwarding and termination FDB entries on the port */
+	err = br_fdb_replay(br_dev, dev, ctx, true, atomic_nb);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	/* Termination FDB entries on the bridge itself */
+	err = br_fdb_replay(br_dev, br_dev, ctx, true, atomic_nb);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+static int nbp_switchdev_unsync_objs(struct net_bridge_port *p,
+				     const void *ctx,
+				     struct notifier_block *atomic_nb,
+				     struct notifier_block *blocking_nb,
+				     struct netlink_ext_ack *extack)
+{
+	struct net_device *br_dev = p->br->dev;
+	struct net_device *dev = p->dev;
+	int err;
+
+	err = br_vlan_replay(br_dev, dev, ctx, false, blocking_nb, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	err = br_mdb_replay(br_dev, dev, ctx, false, blocking_nb, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	/* Forwarding and termination FDB entries on the port */
+	err = br_fdb_replay(br_dev, dev, ctx, false, atomic_nb);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	/* Termination FDB entries on the bridge itself */
+	err = br_fdb_replay(br_dev, br_dev, ctx, false, atomic_nb);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
 /* Let the bridge know that this port is offloaded, so that it can assign a
  * switchdev hardware domain to it.
  */
 int switchdev_bridge_port_offload(struct net_device *brport_dev,
-				  struct net_device *dev,
+				  struct net_device *dev, const void *ctx,
+				  struct notifier_block *atomic_nb,
+				  struct notifier_block *blocking_nb,
 				  struct netlink_ext_ack *extack)
 {
 	struct netdev_phys_item_id ppid;
@@ -233,12 +296,27 @@ int switchdev_bridge_port_offload(struct net_device *brport_dev,
 	if (err)
 		return err;
 
-	return nbp_switchdev_add(p, ppid, extack);
+	err = nbp_switchdev_add(p, ppid, extack);
+	if (err)
+		return err;
+
+	err = nbp_switchdev_sync_objs(p, ctx, atomic_nb, blocking_nb, extack);
+	if (err)
+		goto out_switchdev_del;
+
+	return 0;
+
+out_switchdev_del:
+	nbp_switchdev_del(p, ppid);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(switchdev_bridge_port_offload);
 
 int switchdev_bridge_port_unoffload(struct net_device *brport_dev,
-				    struct net_device *dev,
+				    struct net_device *dev, const void *ctx,
+				    struct notifier_block *atomic_nb,
+				    struct notifier_block *blocking_nb,
 				    struct netlink_ext_ack *extack)
 {
 	struct netdev_phys_item_id ppid;
@@ -255,6 +333,8 @@ int switchdev_bridge_port_unoffload(struct net_device *brport_dev,
 	if (err)
 		return err;
 
+	nbp_switchdev_unsync_objs(p, ctx, atomic_nb, blocking_nb, extack);
+
 	nbp_switchdev_del(p, ppid);
 
 	return 0;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a08e9f193009..18f5d0380ee1 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1884,7 +1884,6 @@ int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(br_vlan_replay);
 
 /* check if v_curr can enter a range ending in range_end */
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index b824b6f8aa84..632c33c63064 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -167,8 +167,8 @@ static void dsa_port_clear_brport_flags(struct dsa_port *dp)
 	}
 }
 
-static int dsa_port_switchdev_sync(struct dsa_port *dp,
-				   struct netlink_ext_ack *extack)
+static int dsa_port_switchdev_sync_attrs(struct dsa_port *dp,
+					 struct netlink_ext_ack *extack)
 {
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	struct net_device *br = dp->bridge_dev;
@@ -194,59 +194,6 @@ static int dsa_port_switchdev_sync(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	err = br_mdb_replay(br, brport_dev, dp, true,
-			    &dsa_slave_switchdev_blocking_notifier, extack);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	/* Forwarding and termination FDB entries on the port */
-	err = br_fdb_replay(br, brport_dev, dp, true,
-			    &dsa_slave_switchdev_notifier);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	/* Termination FDB entries on the bridge itself */
-	err = br_fdb_replay(br, br, dp, true, &dsa_slave_switchdev_notifier);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	err = br_vlan_replay(br, brport_dev, dp, true,
-			     &dsa_slave_switchdev_blocking_notifier, extack);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	return 0;
-}
-
-static int dsa_port_switchdev_unsync_objs(struct dsa_port *dp,
-					  struct net_device *br,
-					  struct netlink_ext_ack *extack)
-{
-	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
-	int err;
-
-	/* Delete the switchdev objects left on this port */
-	err = br_mdb_replay(br, brport_dev, dp, false,
-			    &dsa_slave_switchdev_blocking_notifier, extack);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	/* Forwarding and termination FDB entries on the port */
-	err = br_fdb_replay(br, brport_dev, dp, false,
-			    &dsa_slave_switchdev_notifier);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	/* Termination FDB entries on the bridge itself */
-	err = br_fdb_replay(br, br, dp, false, &dsa_slave_switchdev_notifier);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
-	err = br_vlan_replay(br, brport_dev, dp, false,
-			     &dsa_slave_switchdev_blocking_notifier, extack);
-	if (err && err != -EOPNOTSUPP)
-		return err;
-
 	return 0;
 }
 
@@ -307,18 +254,24 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	if (err)
 		goto out_rollback;
 
-	err = switchdev_bridge_port_offload(brport_dev, dev, extack);
+	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
+					    &dsa_slave_switchdev_notifier,
+					    &dsa_slave_switchdev_blocking_notifier,
+					    extack);
 	if (err)
 		goto out_rollback_unbridge;
 
-	err = dsa_port_switchdev_sync(dp, extack);
+	err = dsa_port_switchdev_sync_attrs(dp, extack);
 	if (err)
 		goto out_rollback_unoffload;
 
 	return 0;
 
 out_rollback_unoffload:
-	switchdev_bridge_port_unoffload(brport_dev, dev, extack);
+	switchdev_bridge_port_unoffload(brport_dev, dev, dp,
+					&dsa_slave_switchdev_notifier,
+					&dsa_slave_switchdev_blocking_notifier,
+					extack);
 out_rollback_unbridge:
 	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
 out_rollback:
@@ -331,13 +284,11 @@ int dsa_port_pre_bridge_leave(struct dsa_port *dp, struct net_device *br,
 {
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	struct net_device *dev = dp->slave;
-	int err;
-
-	err = switchdev_bridge_port_unoffload(brport_dev, dev, extack);
-	if (err)
-		return err;
 
-	return dsa_port_switchdev_unsync_objs(dp, br, extack);
+	return switchdev_bridge_port_unoffload(brport_dev, dev, dp,
+					       &dsa_slave_switchdev_notifier,
+					       &dsa_slave_switchdev_blocking_notifier,
+					       extack);
 }
 
 void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
-- 
2.25.1

