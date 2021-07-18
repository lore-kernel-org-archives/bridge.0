Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8Np/QoL3ecJ78o4XP98KhOw0MhI9YX918ommTqRqUg=;
 b=iorcxxEQlNSURNO/BcdoK9Lq4C7QgYzqkxG7Z8CKCr6AyyiJeLDUZKtAEDC7GkndWLZNftYl5OGDI7DqJIxSiNAwcYxAFopwnuAIW4OBs44nWc7xD2t1rLS6VgBZ4/bF59eshHnFqJ74eOD3Sr+ismZK5oWK7bYsdjE5gRyeG+Y=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 00:44:30 +0300
Message-Id: <20210718214434.3938850-12-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v4 net-next 11/15] net: bridge: switchdev: allow
	the TX data plane forwarding to be offloaded
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

From: Tobias Waldekranz <tobias@waldekranz.com>

Allow switchdevs to forward frames from the CPU in accordance with the
bridge configuration in the same way as is done between bridge
ports. This means that the bridge will only send a single skb towards
one of the ports under the switchdev's control, and expects the driver
to deliver the packet to all eligible ports in its domain.

Primarily this improves the performance of multicast flows with
multiple subscribers, as it allows the hardware to perform the frame
replication.

The basic flow between the driver and the bridge is as follows:

- When joining a bridge port, the switchdev driver calls
  switchdev_bridge_port_offload() with tx_fwd_offload = true.

- The bridge sends offloadable skbs to one of the ports under the
  switchdev's control using skb->offload_fwd_mark = true.

- The switchdev driver checks the skb->offload_fwd_mark field and lets
  its FDB lookup select the destination port mask for this packet.

v1->v2:
- convert br_input_skb_cb::fwd_hwdoms to a plain unsigned long
- introduce a static key "br_switchdev_fwd_offload_used" to minimize the
  impact of the newly introduced feature on all the setups which don't
  have hardware that can make use of it
- introduce a check for nbp->flags & BR_FWD_OFFLOAD to optimize cache
  line access
- reorder nbp_switchdev_frame_mark_accel() and br_handle_vlan() in
  __br_forward()
- do not strip VLAN on egress if forwarding offload on VLAN-aware bridge
  is being used
- propagate errors from .ndo_dfwd_add_station() if not EOPNOTSUPP

v2->v3:
- replace the solution based on .ndo_dfwd_add_station with a solution
  based on switchdev_bridge_port_offload
- rename BR_FWD_OFFLOAD to BR_TX_FWD_OFFLOAD
v3->v4: rebase

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  2 +-
 .../marvell/prestera/prestera_switchdev.c     |  2 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  2 +-
 .../microchip/sparx5/sparx5_switchdev.c       |  2 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |  2 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c            |  2 +-
 include/linux/if_bridge.h                     |  3 +
 net/bridge/br_forward.c                       |  9 +++
 net/bridge/br_private.h                       | 29 +++++++++
 net/bridge/br_switchdev.c                     | 59 +++++++++++++++++--
 net/bridge/br_vlan.c                          | 10 +++-
 net/dsa/port.c                                |  2 +-
 14 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a7db964a9ee6..b2518639a16b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1936,7 +1936,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	return switchdev_bridge_port_offload(netdev, netdev, NULL,
 					     &dpaa2_switch_port_switchdev_nb,
 					     &dpaa2_switch_port_switchdev_blocking_nb,
-					     extack);
+					     false, extack);
 
 err_egress_flood:
 	dpaa2_switch_port_set_fdb(port_priv, NULL);
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
index 0072b6251522..ba159894cbea 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
@@ -504,7 +504,7 @@ int prestera_bridge_port_join(struct net_device *br_dev,
 	err = switchdev_bridge_port_offload(br_port->dev, port->dev, port,
 					    &swdev->swdev_nb,
 					    &swdev->swdev_nb_blk,
-					    extack);
+					    false, extack);
 	if (err)
 		goto err_brport_offload;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 517cf5b498af..95c57af778af 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2388,7 +2388,7 @@ int mlxsw_sp_port_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	return switchdev_bridge_port_offload(brport_dev, dev, mlxsw_sp_port,
 					     &mlxsw_sp_switchdev_notifier,
 					     &mlxsw_sp_switchdev_blocking_notifier,
-					     extack);
+					     false, extack);
 
 err_port_join:
 	mlxsw_sp_bridge_port_put(mlxsw_sp->bridge, bridge_port);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index f8b1deffbfb4..bbbc6ff1ce85 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -119,7 +119,7 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 	return switchdev_bridge_port_offload(ndev, ndev, NULL,
 					     &sparx5->switchdev_nb,
 					     &sparx5->switchdev_blocking_nb,
-					     extack);
+					     false, extack);
 }
 
 static int sparx5_port_pre_bridge_leave(struct sparx5_port *port,
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index f24f6a790814..4b69af71a8fb 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1200,7 +1200,7 @@ static int ocelot_netdevice_bridge_join(struct net_device *dev,
 	err = switchdev_bridge_port_offload(brport_dev, dev, priv,
 					    &ocelot_netdevice_nb,
 					    &ocelot_switchdev_blocking_nb,
-					    extack);
+					    false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index e1ffac8f78b8..2bf7222491b8 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2601,7 +2601,7 @@ static int ofdpa_port_bridge_join(struct ofdpa_port *ofdpa_port,
 	return switchdev_bridge_port_offload(dev, dev, NULL,
 					     &rocker_switchdev_notifier,
 					     &rocker_switchdev_blocking_notifier,
-					     extack);
+					     false, extack);
 }
 
 static int ofdpa_port_pre_bridge_leave(struct ofdpa_port *ofdpa_port,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index b6f9bc885c52..aaac02f10586 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2099,7 +2099,7 @@ static int am65_cpsw_netdevice_port_link(struct net_device *ndev,
 	err = switchdev_bridge_port_offload(ndev, ndev, NULL,
 					    &am65_cpsw_switchdev_notifier,
 					    &am65_cpsw_switchdev_bl_notifier,
-					    extack);
+					    false, extack);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index c8f54d6d7e17..41a5fd3daba4 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1520,7 +1520,7 @@ static int cpsw_netdevice_port_link(struct net_device *ndev,
 	err = switchdev_bridge_port_offload(ndev, ndev, NULL,
 					    &cpsw_switchdev_notifier,
 					    &cpsw_switchdev_bl_notifier,
-					    extack);
+					    false, extack);
 	if (err)
 		return err;
 
diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 425a4196f9c6..b99291249ade 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -57,6 +57,7 @@ struct br_ip_list {
 #define BR_MRP_AWARE		BIT(17)
 #define BR_MRP_LOST_CONT	BIT(18)
 #define BR_MRP_LOST_IN_CONT	BIT(19)
+#define BR_TX_FWD_OFFLOAD	BIT(20)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
@@ -182,6 +183,7 @@ int switchdev_bridge_port_offload(struct net_device *brport_dev,
 				  struct net_device *dev, const void *ctx,
 				  struct notifier_block *atomic_nb,
 				  struct notifier_block *blocking_nb,
+				  bool tx_fwd_offload,
 				  struct netlink_ext_ack *extack);
 int switchdev_bridge_port_unoffload(struct net_device *brport_dev,
 				    struct net_device *dev, const void *ctx,
@@ -196,6 +198,7 @@ switchdev_bridge_port_offload(struct net_device *brport_dev,
 			      struct net_device *dev, const void *ctx,
 			      struct notifier_block *atomic_nb,
 			      struct notifier_block *blocking_nb,
+			      bool tx_fwd_offload,
 			      struct netlink_ext_ack *extack)
 {
 	return -EINVAL;
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 07856362538f..4873ecdc6f56 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -48,6 +48,8 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 		skb_set_network_header(skb, depth);
 	}
 
+	skb->offload_fwd_mark = br_switchdev_accels_skb(skb);
+
 	dev_queue_xmit(skb);
 
 	return 0;
@@ -76,6 +78,11 @@ static void __br_forward(const struct net_bridge_port *to,
 	struct net *net;
 	int br_hook;
 
+	/* Mark the skb for forwarding offload early so that br_handle_vlan()
+	 * can know whether to pop the VLAN header on egress or keep it.
+	 */
+	nbp_switchdev_frame_mark_accel(to, skb);
+
 	vg = nbp_vlan_group_rcu(to);
 	skb = br_handle_vlan(to->br, to, vg, skb);
 	if (!skb)
@@ -174,6 +181,8 @@ static struct net_bridge_port *maybe_deliver(
 	if (!should_deliver(p, skb))
 		return prev;
 
+	nbp_switchdev_frame_mark_tx_fwd(p, skb);
+
 	if (!prev)
 		goto out;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1d3e5957d4d5..0d965f35910c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -518,12 +518,20 @@ struct br_input_skb_cb {
 #endif
 
 #ifdef CONFIG_NET_SWITCHDEV
+	/* Set if TX data plane offloading is used towards at least one
+	 * hardware domain.
+	 */
+	u8 fwd_accel:1;
 	/* The switchdev hardware domain from which this packet was received.
 	 * If skb->offload_fwd_mark was set, then this packet was already
 	 * forwarded by hardware to the other ports in the source hardware
 	 * domain, otherwise it wasn't.
 	 */
 	int src_hwdom;
+	/* Bit mask of hardware domains towards this packet has already been
+	 * transmitted using the TX data plane offload.
+	 */
+	unsigned long fwd_hwdoms;
 #endif
 };
 
@@ -1688,6 +1696,12 @@ static inline void br_sysfs_delbr(struct net_device *dev) { return; }
 
 /* br_switchdev.c */
 #ifdef CONFIG_NET_SWITCHDEV
+bool br_switchdev_accels_skb(struct sk_buff *skb);
+
+void nbp_switchdev_frame_mark_accel(const struct net_bridge_port *p,
+				    struct sk_buff *skb);
+void nbp_switchdev_frame_mark_tx_fwd(const struct net_bridge_port *p,
+				     struct sk_buff *skb);
 void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb);
 bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
@@ -1708,6 +1722,21 @@ static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
 	skb->offload_fwd_mark = 0;
 }
 #else
+static inline bool br_switchdev_accels_skb(struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline void nbp_switchdev_frame_mark_accel(const struct net_bridge_port *p,
+						  struct sk_buff *skb)
+{
+}
+
+static inline void nbp_switchdev_frame_mark_tx_fwd(const struct net_bridge_port *p,
+						   struct sk_buff *skb)
+{
+}
+
 static inline void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 					    struct sk_buff *skb)
 {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 2a5acfaf8f92..1fdebbc63346 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -8,6 +8,40 @@
 
 #include "br_private.h"
 
+static struct static_key_false br_switchdev_fwd_offload_used;
+
+static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
+					     const struct sk_buff *skb)
+{
+	if (!static_branch_unlikely(&br_switchdev_fwd_offload_used))
+		return false;
+
+	return (p->flags & BR_TX_FWD_OFFLOAD) &&
+	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
+}
+
+bool br_switchdev_accels_skb(struct sk_buff *skb)
+{
+	if (!static_branch_unlikely(&br_switchdev_fwd_offload_used))
+		return false;
+
+	return BR_INPUT_SKB_CB(skb)->fwd_accel;
+}
+
+void nbp_switchdev_frame_mark_accel(const struct net_bridge_port *p,
+				    struct sk_buff *skb)
+{
+	if (nbp_switchdev_can_offload_tx_fwd(p, skb))
+		BR_INPUT_SKB_CB(skb)->fwd_accel = true;
+}
+
+void nbp_switchdev_frame_mark_tx_fwd(const struct net_bridge_port *p,
+				     struct sk_buff *skb)
+{
+	if (nbp_switchdev_can_offload_tx_fwd(p, skb))
+		set_bit(p->hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
+}
+
 void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb)
 {
@@ -18,8 +52,10 @@ void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 				  const struct sk_buff *skb)
 {
-	return !skb->offload_fwd_mark ||
-	       BR_INPUT_SKB_CB(skb)->src_hwdom != p->hwdom;
+	struct br_input_skb_cb *cb = BR_INPUT_SKB_CB(skb);
+
+	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
+		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);
 }
 
 /* Flags that can be offloaded to hardware */
@@ -164,8 +200,11 @@ static void nbp_switchdev_hwdom_put(struct net_bridge_port *leaving)
 
 static int nbp_switchdev_add(struct net_bridge_port *p,
 			     struct netdev_phys_item_id ppid,
+			     bool tx_fwd_offload,
 			     struct netlink_ext_ack *extack)
 {
+	int err;
+
 	if (p->offload_count) {
 		/* Prevent unsupported configurations such as a bridge port
 		 * which is a bonding interface, and the member ports are from
@@ -189,7 +228,16 @@ static int nbp_switchdev_add(struct net_bridge_port *p,
 	p->ppid = ppid;
 	p->offload_count = 1;
 
-	return nbp_switchdev_hwdom_set(p);
+	err = nbp_switchdev_hwdom_set(p);
+	if (err)
+		return err;
+
+	if (tx_fwd_offload) {
+		p->flags |= BR_TX_FWD_OFFLOAD;
+		static_branch_inc(&br_switchdev_fwd_offload_used);
+	}
+
+	return 0;
 }
 
 static void nbp_switchdev_del(struct net_bridge_port *p,
@@ -210,6 +258,8 @@ static void nbp_switchdev_del(struct net_bridge_port *p,
 
 	if (p->hwdom)
 		nbp_switchdev_hwdom_put(p);
+
+	p->flags &= ~BR_TX_FWD_OFFLOAD;
 }
 
 static int nbp_switchdev_sync_objs(struct net_bridge_port *p, const void *ctx,
@@ -280,6 +330,7 @@ int switchdev_bridge_port_offload(struct net_device *brport_dev,
 				  struct net_device *dev, const void *ctx,
 				  struct notifier_block *atomic_nb,
 				  struct notifier_block *blocking_nb,
+				  bool tx_fwd_offload,
 				  struct netlink_ext_ack *extack)
 {
 	struct netdev_phys_item_id ppid;
@@ -296,7 +347,7 @@ int switchdev_bridge_port_offload(struct net_device *brport_dev,
 	if (err)
 		return err;
 
-	err = nbp_switchdev_add(p, ppid, extack);
+	err = nbp_switchdev_add(p, ppid, tx_fwd_offload, extack);
 	if (err)
 		return err;
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 18f5d0380ee1..65334e5b8002 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -457,7 +457,15 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 		u64_stats_update_end(&stats->syncp);
 	}
 
-	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+	/* If the skb will be sent using forwarding offload, the assumption is
+	 * that the switchdev will inject the packet into hardware together
+	 * with the bridge VLAN, so that it can be forwarded according to that
+	 * VLAN. The switchdev should deal with popping the VLAN header in
+	 * hardware on each egress port as appropriate. So only strip the VLAN
+	 * header if forwarding offload is not being used.
+	 */
+	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED &&
+	    !br_switchdev_accels_skb(skb))
 		__vlan_hwaccel_clear_tag(skb);
 
 	if (p && (p->flags & BR_VLAN_TUNNEL) &&
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 632c33c63064..fce69cf3f8e3 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -257,7 +257,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
 					    &dsa_slave_switchdev_notifier,
 					    &dsa_slave_switchdev_blocking_notifier,
-					    extack);
+					    false, extack);
 	if (err)
 		goto out_rollback_unbridge;
 
-- 
2.25.1

