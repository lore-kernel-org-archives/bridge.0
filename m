Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD52k5CHDZVcs9/FaEqP8gNttkNWEcNmP7+01jQIHwc=;
 b=K6Kop54/Dk4OjO5y5Cb+b7/cFxyIBJ59AQ1SxrpfWPIlGpEr8zlssfwyjwqmN8rJCpAzJDs7xi4PvWayH1CvOLamcO8AvY5Fd6FVKBrvGAIWq0UJsqmsfUsyTfEiShSzOqPw/p2aZy/VwUvLIbdudjiGMGt2nmzjhMWSF7BhBoI=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:57:03 +0300
Message-Id: <20210703115705.1034112-9-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 08/10] net: dsa: add support for
	bridge forwarding offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

For a DSA switch, to offload the forwarding process of a bridge device
means to send the packets coming from the software bridge as data plane
packets. This is contrary to everything that DSA has done so far,
because the current taggers only know to send control packets (ones that
target a specific destination port), whereas data plane packets are
supposed to be forwarded according to the FDB lookup, much like packets
ingressing on any regular ingress port. If the FDB lookup process
returns multiple destination ports (flooding, multicast), then
replication is also handled by the switch hardware - the bridge only
sends a single packet and avoids the skb_clone().

DSA plays a substantial role in backing the forwarding offload, and
leaves relatively few things up to the switch driver. In particular, DSA
creates an accel_priv structure per port associated with each possible
bridge upper, and for each bridge it keeps a zero-based index (the
number of the bridge). Multiple ports enslaved to the same bridge have
a pointer to the same accel_priv structure.

The way this offloading scheme (borrowed from macvlan offloading on
Intel hardware) works is that lower interfaces are supposed to reserve a
netdev TX queue corresponding to each offloadable upper ("subordinate")
interface. DSA reserves a single TX queue per port, a queue outside the
num_real_tx_queues range. That special TX queue has a ->sb_dev pointer,
which is the reason why we use it in the first place (to have access to
the sb_dev from .ndo_start_xmit). DSA then implements a custom
.ndo_select_queue to direct packets on behalf of the bridge to that
special queue, and leaves netdev_pick_tx to pick among the
num_real_tx_queues (excluding the sb_dev queue) using the default policies.

It is assumed that both the tagger must support forwarding offload (it
must search for the subordinate device - the bridge), and must therefore
set the ".bridge_fwd_offload = true" capability, as well as the switch
driver (this must set in ds->num_fwd_offloading_bridges the maximum
number of bridges for which it can offload forwarding).

The tagger can check if the TX queue that the skb is being transmitted
on has a subordinate device (sb_dev) associated with it or not. If it
does, it can be sure that the subordinate device is a bridge, and it can
use the dp->accel_priv to get further information about that bridge,
such as the bridge number. It can then compose a DSA tag for injecting a
data plane packet into that bridge number.

For the switch driver side, we offer two new pair of dsa_switch_ops
methods which are modeled after .port_bridge_{join,leave} and
.crosschip_bridge_{join,leave}.
These are .port_bridge_fwd_offload_{add,del} and the cross-chip
equivalents. These methods are provided in case the driver needs to
configure the hardware to treat packets coming from that bridge software
interface as data plane packets. The bridge calls our
.ndo_dfwd_add_station immediately after netdev_master_upper_dev_link(),
so to switch drivers, the effect is that the
.port_bridge_fwd_offload_add() method is called immediately after
.port_bridge_join().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h  |  34 ++++++++++++
 net/dsa/dsa_priv.h |  17 ++++++
 net/dsa/port.c     |  35 ++++++++++++
 net/dsa/slave.c    | 134 ++++++++++++++++++++++++++++++++++++++++++++-
 net/dsa/switch.c   |  58 ++++++++++++++++++++
 5 files changed, 277 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 89626eab92b9..5d111cc2e403 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -103,6 +103,7 @@ struct dsa_device_ops {
 	 * its RX filter.
 	 */
 	bool promisc_on_master;
+	bool bridge_fwd_offload;
 };
 
 /* This structure defines the control interfaces that are overlayed by the
@@ -162,6 +163,9 @@ struct dsa_switch_tree {
 
 	/* Track the largest switch index within a tree */
 	unsigned int last_switch;
+
+	/* Track the bridges with forwarding offload enabled */
+	unsigned long fwd_offloading_bridges;
 };
 
 #define dsa_lags_foreach_id(_id, _dst)				\
@@ -224,6 +228,10 @@ struct dsa_mall_tc_entry {
 	};
 };
 
+struct dsa_bridge_fwd_accel_priv {
+	struct net_device *sb_dev;
+	int bridge_num;
+};
 
 struct dsa_port {
 	/* A CPU port is physically connected to a master device.
@@ -294,6 +302,8 @@ struct dsa_port {
 	struct list_head	fdbs;
 	struct list_head	mdbs;
 
+	struct dsa_bridge_fwd_accel_priv *accel_priv;
+
 	bool setup;
 };
 
@@ -410,6 +420,12 @@ struct dsa_switch {
 	 */
 	unsigned int		num_lag_ids;
 
+	/* Drivers that support bridge forwarding offload should set this to
+	 * the maximum number of bridges spanning the same switch tree that can
+	 * be offloaded.
+	 */
+	unsigned int		num_fwd_offloading_bridges;
+
 	size_t num_ports;
 };
 
@@ -693,6 +709,14 @@ struct dsa_switch_ops {
 				    struct net_device *bridge);
 	void	(*port_bridge_leave)(struct dsa_switch *ds, int port,
 				     struct net_device *bridge);
+	/* Called right after .port_bridge_join() */
+	int	(*port_bridge_fwd_offload_add)(struct dsa_switch *ds, int port,
+					       struct net_device *bridge,
+					       int bridge_num);
+	/* Called right before .port_bridge_leave() */
+	void	(*port_bridge_fwd_offload_del)(struct dsa_switch *ds, int port,
+					       struct net_device *bridge,
+					       int bridge_num);
 	void	(*port_stp_state_set)(struct dsa_switch *ds, int port,
 				      u8 state);
 	void	(*port_fast_age)(struct dsa_switch *ds, int port);
@@ -777,6 +801,16 @@ struct dsa_switch_ops {
 				      struct netdev_lag_upper_info *info);
 	int	(*crosschip_lag_leave)(struct dsa_switch *ds, int sw_index,
 				       int port, struct net_device *lag);
+	int	(*crosschip_bridge_fwd_offload_add)(struct dsa_switch *ds,
+						    int tree_index,
+						    int sw_index, int port,
+						    struct net_device *br,
+						    int bridge_num);
+	void	(*crosschip_bridge_fwd_offload_del)(struct dsa_switch *ds,
+						    int tree_index,
+						    int sw_index, int port,
+						    struct net_device *br,
+						    int bridge_num);
 
 	/*
 	 * PTP functionality
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f201c33980bf..c577338b5bb7 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -14,10 +14,14 @@
 #include <net/dsa.h>
 #include <net/gro_cells.h>
 
+#define DSA_MAX_NUM_OFFLOADING_BRIDGES		BITS_PER_LONG
+
 enum {
 	DSA_NOTIFIER_AGEING_TIME,
 	DSA_NOTIFIER_BRIDGE_JOIN,
 	DSA_NOTIFIER_BRIDGE_LEAVE,
+	DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_ADD,
+	DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_DEL,
 	DSA_NOTIFIER_FDB_ADD,
 	DSA_NOTIFIER_FDB_DEL,
 	DSA_NOTIFIER_HOST_FDB_ADD,
@@ -54,6 +58,15 @@ struct dsa_notifier_bridge_info {
 	int port;
 };
 
+/* DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_* */
+struct dsa_notifier_bridge_fwd_offload_info {
+	struct net_device *br;
+	int tree_index;
+	int sw_index;
+	int port;
+	int bridge_num;
+};
+
 /* DSA_NOTIFIER_FDB_* */
 struct dsa_notifier_fdb_info {
 	int sw_index;
@@ -197,6 +210,10 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 int dsa_port_pre_bridge_leave(struct dsa_port *dp, struct net_device *br,
 			      struct netlink_ext_ack *extack);
 void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br);
+int dsa_port_bridge_fwd_offload_add(struct dsa_port *dp,
+				    struct net_device *br, int bridge_num);
+void dsa_port_bridge_fwd_offload_del(struct dsa_port *dp,
+				     struct net_device *br, int bridge_num);
 int dsa_port_lag_change(struct dsa_port *dp,
 			struct netdev_lag_lower_state_info *linfo);
 int dsa_port_lag_join(struct dsa_port *dp, struct net_device *lag_dev,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 28b45b7e66df..3c268d00908c 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -344,6 +344,41 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
 	dsa_port_switchdev_unsync_attrs(dp);
 }
 
+int dsa_port_bridge_fwd_offload_add(struct dsa_port *dp,
+				    struct net_device *br, int bridge_num)
+{
+	struct dsa_notifier_bridge_fwd_offload_info info = {
+		.tree_index = dp->ds->dst->index,
+		.sw_index = dp->ds->index,
+		.port = dp->index,
+		.br = br,
+		.bridge_num = bridge_num,
+	};
+
+	return dsa_port_notify(dp, DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_ADD,
+			       &info);
+}
+
+void dsa_port_bridge_fwd_offload_del(struct dsa_port *dp,
+				     struct net_device *br, int bridge_num)
+{
+	struct dsa_notifier_bridge_fwd_offload_info info = {
+		.tree_index = dp->ds->dst->index,
+		.sw_index = dp->ds->index,
+		.port = dp->index,
+		.br = br,
+		.bridge_num = bridge_num,
+	};
+	struct net_device *dev = dp->slave;
+	int err;
+
+	err = dsa_port_notify(dp, DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_DEL,
+			      &info);
+	if (err)
+		netdev_err(dev, "failed to notify fwd offload del: %pe\n",
+			   ERR_PTR(err));
+}
+
 int dsa_port_lag_change(struct dsa_port *dp,
 			struct netdev_lag_lower_state_info *linfo)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ffbba1e71551..003f3bb9c51a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1679,6 +1679,119 @@ static int dsa_slave_fill_forward_path(struct net_device_path_ctx *ctx,
 	return 0;
 }
 
+/* Direct packets coming from the data plane of the bridge to a dedicated TX
+ * queue, and let the generic netdev_pick_tx() handle the rest via hashing
+ * among TX queues of the same priority.
+ */
+static u16 dsa_slave_select_queue(struct net_device *dev, struct sk_buff *skb,
+				  struct net_device *sb_dev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (unlikely(sb_dev))
+		return ds->num_tx_queues;
+
+	return netdev_pick_tx(dev, skb, sb_dev);
+}
+
+static struct dsa_bridge_fwd_accel_priv *
+dsa_find_accel_priv_by_sb_dev(struct dsa_switch_tree *dst,
+			      struct net_device *sb_dev)
+{
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dp->accel_priv && dp->accel_priv->sb_dev == sb_dev)
+			return dp->accel_priv;
+
+	return NULL;
+}
+
+static void dsa_slave_fwd_offload_del(struct net_device *dev, void *sb_dev)
+{
+	struct dsa_bridge_fwd_accel_priv *accel_priv;
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_switch_tree *dst;
+	int bridge_num;
+
+	if (!netif_is_bridge_master(sb_dev))
+		return;
+
+	dst = ds->dst;
+
+	accel_priv = dp->accel_priv;
+	bridge_num = accel_priv->bridge_num;
+
+	dp->accel_priv = NULL;
+
+	/* accel_priv no longer in use, time to clean it up */
+	if (!dsa_find_accel_priv_by_sb_dev(dst, sb_dev)) {
+		clear_bit(accel_priv->bridge_num, &dst->fwd_offloading_bridges);
+		kfree(accel_priv);
+	}
+
+	netdev_unbind_tx_queues_from_sb_dev(dev, sb_dev);
+
+	/* Notify the chips only once the offload has been deactivated, so
+	 * that they can update their configuration accordingly.
+	 */
+	dsa_port_bridge_fwd_offload_del(dp, sb_dev, bridge_num);
+}
+
+static void *dsa_slave_fwd_offload_add(struct net_device *dev,
+				       struct net_device *sb_dev)
+{
+	struct dsa_bridge_fwd_accel_priv *accel_priv;
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_switch_tree *dst;
+	int err;
+
+	if (!netif_is_bridge_master(sb_dev))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	dst = ds->dst;
+
+	accel_priv = dsa_find_accel_priv_by_sb_dev(dst, sb_dev);
+	if (!accel_priv) {
+		/* First port that offloads forwarding for this bridge */
+		int bridge_num;
+
+		bridge_num = find_first_zero_bit(&dst->fwd_offloading_bridges,
+						 DSA_MAX_NUM_OFFLOADING_BRIDGES);
+		if (bridge_num >= ds->num_fwd_offloading_bridges)
+			return ERR_PTR(-EOPNOTSUPP);
+
+		accel_priv = kzalloc(sizeof(*accel_priv), GFP_KERNEL);
+		if (!accel_priv)
+			return ERR_PTR(-ENOMEM);
+
+		accel_priv->sb_dev = sb_dev;
+		accel_priv->bridge_num = bridge_num;
+
+		set_bit(bridge_num, &dst->fwd_offloading_bridges);
+	}
+
+	dp->accel_priv = accel_priv;
+
+	/* There can be only one master upper interface for each port in the
+	 * case of bridge forwarding offload, so just bind a single TX queue to
+	 * that subordinate device, the last one.
+	 */
+	netdev_bind_tx_queues_to_sb_dev(dev, sb_dev, 1, ds->num_tx_queues);
+
+	err = dsa_port_bridge_fwd_offload_add(dp, sb_dev,
+					      accel_priv->bridge_num);
+	if (err) {
+		dsa_slave_fwd_offload_del(dev, sb_dev);
+		return ERR_PTR(err);
+	}
+
+	return accel_priv;
+}
+
 static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_open	 	= dsa_slave_open,
 	.ndo_stop		= dsa_slave_close,
@@ -1703,6 +1816,9 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_devlink_port	= dsa_slave_get_devlink_port,
 	.ndo_change_mtu		= dsa_slave_change_mtu,
 	.ndo_fill_forward_path	= dsa_slave_fill_forward_path,
+	.ndo_dfwd_add_station	= dsa_slave_fwd_offload_add,
+	.ndo_dfwd_del_station	= dsa_slave_fwd_offload_del,
+	.ndo_select_queue	= dsa_slave_select_queue,
 };
 
 static struct device_type dsa_type = {
@@ -1819,6 +1935,11 @@ void dsa_slave_setup_tagger(struct net_device *slave)
 	slave->needed_tailroom += master->needed_tailroom;
 
 	p->xmit = cpu_dp->tag_ops->xmit;
+
+	if (cpu_dp->tag_ops->bridge_fwd_offload)
+		slave->features |= NETIF_F_HW_L2FW_DOFFLOAD;
+	else
+		slave->features &= ~NETIF_F_HW_L2FW_DOFFLOAD;
 }
 
 static struct lock_class_key dsa_slave_netdev_xmit_lock_key;
@@ -1877,10 +1998,21 @@ int dsa_slave_create(struct dsa_port *port)
 
 	slave_dev = alloc_netdev_mqs(sizeof(struct dsa_slave_priv), name,
 				     NET_NAME_UNKNOWN, ether_setup,
-				     ds->num_tx_queues, 1);
+				     ds->num_tx_queues + 1, 1);
 	if (slave_dev == NULL)
 		return -ENOMEM;
 
+	/* To avoid changing the number of TX queues at runtime depending on
+	 * whether the tagging protocol in use supports bridge forwarding
+	 * offload or not, just assume that all tagging protocols do, and
+	 * unconditionally register one extra TX queue to back that offload.
+	 * Then set num_real_tx_queues such that it will never be selected by
+	 * netdev_pick_tx(), just by ourselves.
+	 */
+	ret = netif_set_real_num_tx_queues(slave_dev, ds->num_tx_queues);
+	if (ret)
+		goto out_free;
+
 	slave_dev->features = master->vlan_features | NETIF_F_HW_TC;
 	if (ds->ops->port_vlan_add && ds->ops->port_vlan_del)
 		slave_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 248455145982..f0033906f36b 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -154,6 +154,58 @@ static int dsa_switch_bridge_leave(struct dsa_switch *ds,
 	return 0;
 }
 
+static int
+dsa_switch_bridge_fwd_offload_add(struct dsa_switch *ds,
+				  struct dsa_notifier_bridge_fwd_offload_info *info)
+{
+	struct dsa_switch_tree *dst = ds->dst;
+	int tree_index = info->tree_index;
+	int bridge_num = info->bridge_num;
+	struct net_device *br = info->br;
+	int sw_index = info->sw_index;
+	int port = info->port;
+
+	if (dst->index == tree_index && ds->index == sw_index &&
+	    ds->ops->port_bridge_fwd_offload_add)
+		return ds->ops->port_bridge_fwd_offload_add(ds, port, br,
+							    bridge_num);
+
+	if ((dst->index != tree_index || ds->index != sw_index) &&
+	    ds->ops->crosschip_bridge_fwd_offload_add)
+		return ds->ops->crosschip_bridge_fwd_offload_add(ds,
+								 tree_index,
+								 sw_index,
+								 port, br,
+								 bridge_num);
+
+	return -EOPNOTSUPP;
+}
+
+static int
+dsa_switch_bridge_fwd_offload_del(struct dsa_switch *ds,
+				  struct dsa_notifier_bridge_fwd_offload_info *info)
+{
+	struct dsa_switch_tree *dst = ds->dst;
+	int tree_index = info->tree_index;
+	int bridge_num = info->bridge_num;
+	struct net_device *br = info->br;
+	int sw_index = info->sw_index;
+	int port = info->port;
+
+	if (dst->index == tree_index && ds->index == sw_index &&
+	    ds->ops->port_bridge_fwd_offload_del)
+		ds->ops->port_bridge_fwd_offload_del(ds, port, br,
+						     bridge_num);
+
+	if ((dst->index != info->tree_index || ds->index != info->sw_index) &&
+	    ds->ops->crosschip_bridge_fwd_offload_del)
+		ds->ops->crosschip_bridge_fwd_offload_del(ds, tree_index,
+							  sw_index, port, br,
+							  bridge_num);
+
+	return 0;
+}
+
 /* Matches for all upstream-facing ports (the CPU port and all upstream-facing
  * DSA links) that sit between the targeted port on which the notifier was
  * emitted and its dedicated CPU port.
@@ -663,6 +715,12 @@ static int dsa_switch_event(struct notifier_block *nb,
 	case DSA_NOTIFIER_BRIDGE_LEAVE:
 		err = dsa_switch_bridge_leave(ds, info);
 		break;
+	case DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_ADD:
+		err = dsa_switch_bridge_fwd_offload_add(ds, info);
+		break;
+	case DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_DEL:
+		err = dsa_switch_bridge_fwd_offload_del(ds, info);
+		break;
 	case DSA_NOTIFIER_FDB_ADD:
 		err = dsa_switch_fdb_add(ds, info);
 		break;
-- 
2.25.1

