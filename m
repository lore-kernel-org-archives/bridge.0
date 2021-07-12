Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+KVIVbzF/qsJO5Fqwixkq4iaulIzPKoUTb3Hy7E3rE=;
 b=rxxjx85DkbYYDMKFiqHMiAgYud85HrCaV5qVRJT1iSXl4LhIsXr2+RYKBk/j49gEYPA21Y4LWx1IpV5472323pd9xz7GieJJTxFOOt9luXyFNSsZQrYecGZQLvcgpAhE0THvGd/3KGr/guQo0zbUgPkUjVXMsgBLo1EMBsUfvZ8=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:40 +0300
Message-Id: <20210712152142.800651-23-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 22/24] net: dsa: add support for
	bridge TX forwarding offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

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
keeps for each bridge port a zero-based index (the number of the
bridge). Multiple ports enslaved to the same bridge have a pointer to
the same accel_priv structure.

The tagger can check if the packet that is being transmitted on has
skb->offload_fwd_mark = true or not. If it does, it can be sure that the
packet belongs to the data plane of a bridge, further information about
which can be obtained based on dp->bridge_dev and dp->bridge_num.
It can then compose a DSA tag for injecting a data plane packet into
that bridge number.

For the switch driver side, we offer two new dsa_switch_ops methods,
called .port_bridge_fwd_offload_{add,del}, which are modeled after
.port_bridge_{join,leave}.
These methods are provided in case the driver needs to configure the
hardware to treat packets coming from that bridge software interface as
data plane packets. The switchdev <-> bridge interaction happens during
the netdev_master_upper_dev_link() call, so to switch drivers, the
effect is that the .port_bridge_fwd_offload_add() method is called
immediately after .port_bridge_join().

If the bridge number exceeds the number of bridges for which the switch
driver can offload the TX data plane (and this includes the case where
the driver can offload none), DSA falls back to simply returning
tx_fwd_offload = false in the switchdev_bridge_port_offload() call.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h  |  19 ++++++++-
 net/dsa/dsa2.c     |   1 +
 net/dsa/dsa_priv.h |   6 +++
 net/dsa/port.c     | 100 ++++++++++++++++++++++++++++++++++++++++++++-
 net/dsa/slave.c    |  13 +++++-
 5 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 89626eab92b9..99b4e23b003b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -162,6 +162,9 @@ struct dsa_switch_tree {
 
 	/* Track the largest switch index within a tree */
 	unsigned int last_switch;
+
+	/* Track the bridges with forwarding offload enabled */
+	unsigned long fwd_offloading_bridges;
 };
 
 #define dsa_lags_foreach_id(_id, _dst)				\
@@ -224,7 +227,6 @@ struct dsa_mall_tc_entry {
 	};
 };
 
-
 struct dsa_port {
 	/* A CPU port is physically connected to a master device.
 	 * A user port exposed to userspace has a slave device.
@@ -262,6 +264,7 @@ struct dsa_port {
 	bool			vlan_filtering;
 	u8			stp_state;
 	struct net_device	*bridge_dev;
+	int			bridge_num;
 	struct devlink_port	devlink_port;
 	bool			devlink_port_setup;
 	struct phylink		*pl;
@@ -410,6 +413,12 @@ struct dsa_switch {
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
 
@@ -693,6 +702,14 @@ struct dsa_switch_ops {
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
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index de5e93ba2a9d..c7fa85fb3086 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1044,6 +1044,7 @@ static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
 
 	dp->ds = ds;
 	dp->index = index;
+	dp->bridge_num = -1;
 
 	INIT_LIST_HEAD(&dp->list);
 	list_add_tail(&dp->list, &dst->ports);
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 3b51aaa26760..ff70e5afe3f2 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -14,6 +14,8 @@
 #include <net/dsa.h>
 #include <net/gro_cells.h>
 
+#define DSA_MAX_NUM_OFFLOADING_BRIDGES		BITS_PER_LONG
+
 enum {
 	DSA_NOTIFIER_AGEING_TIME,
 	DSA_NOTIFIER_BRIDGE_JOIN,
@@ -197,6 +199,10 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
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
index fce02db6a845..283726f5121b 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -230,6 +230,75 @@ static void dsa_port_switchdev_unsync_attrs(struct dsa_port *dp)
 	 */
 }
 
+static int dsa_tree_find_bridge_num(struct dsa_switch_tree *dst,
+				    struct net_device *bridge_dev)
+{
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dp->bridge_dev  == bridge_dev)
+			return dp->bridge_num;
+
+	return -1;
+}
+
+static void dsa_port_bridge_tx_fwd_unprepare(struct dsa_port *dp,
+					     struct net_device *bridge_dev)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_switch_tree *dst;
+	int bridge_num;
+
+	dst = ds->dst;
+
+	bridge_num = dp->bridge_num;
+
+	dp->bridge_num = -1;
+
+	/* bridge no longer in use, time to clean it up */
+	if (!dsa_tree_find_bridge_num(dst, bridge_dev))
+		clear_bit(bridge_num, &dst->fwd_offloading_bridges);
+
+	/* Notify the chips only once the offload has been deactivated, so
+	 * that they can update their configuration accordingly.
+	 */
+	dsa_port_bridge_fwd_offload_del(dp, bridge_dev, bridge_num);
+}
+
+static bool dsa_port_bridge_tx_fwd_prepare(struct dsa_port *dp,
+					   struct net_device *bridge_dev)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_switch_tree *dst;
+	int bridge_num, err;
+
+	dst = ds->dst;
+
+	bridge_num = dsa_tree_find_bridge_num(dst, bridge_dev);
+	if (bridge_num < 0) {
+		/* First port that offloads TX forwarding for this bridge */
+		int bridge_num;
+
+		bridge_num = find_first_zero_bit(&dst->fwd_offloading_bridges,
+						 DSA_MAX_NUM_OFFLOADING_BRIDGES);
+		if (bridge_num >= ds->num_fwd_offloading_bridges)
+			return false;
+
+		set_bit(bridge_num, &dst->fwd_offloading_bridges);
+	}
+
+	dp->bridge_num = bridge_num;
+
+	/* Notify the driver */
+	err = dsa_port_bridge_fwd_offload_add(dp, bridge_dev, bridge_num);
+	if (err) {
+		dsa_port_bridge_tx_fwd_unprepare(dp, bridge_dev);
+		return false;
+	}
+
+	return true;
+}
+
 int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 			 struct netlink_ext_ack *extack)
 {
@@ -241,6 +310,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	};
 	struct net_device *dev = dp->slave;
 	struct net_device *brport_dev;
+	bool tx_fwd_offload;
 	int err;
 
 	/* Here the interface is already bridged. Reflect the current
@@ -254,7 +324,10 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	if (err)
 		goto out_rollback;
 
-	err = switchdev_bridge_port_offload(brport_dev, dev, dp, false, extack);
+	tx_fwd_offload = dsa_port_bridge_tx_fwd_prepare(dp, br);
+
+	err = switchdev_bridge_port_offload(brport_dev, dev, dp, tx_fwd_offload,
+					    extack);
 	if (err)
 		goto out_rollback_unbridge;
 
@@ -279,6 +352,8 @@ int dsa_port_pre_bridge_leave(struct dsa_port *dp, struct net_device *br,
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	struct net_device *dev = dp->slave;
 
+	dsa_port_bridge_tx_fwd_prepare(dp, br);
+
 	return switchdev_bridge_port_unoffload(brport_dev, dev, dp, extack);
 }
 
@@ -304,6 +379,29 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
 	dsa_port_switchdev_unsync_attrs(dp);
 }
 
+int dsa_port_bridge_fwd_offload_add(struct dsa_port *dp,
+				    struct net_device *br, int bridge_num)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_bridge_fwd_offload_add)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_bridge_fwd_offload_add(ds, dp->index, br,
+						    bridge_num);
+}
+
+void dsa_port_bridge_fwd_offload_del(struct dsa_port *dp,
+				     struct net_device *br, int bridge_num)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_bridge_fwd_offload_del)
+		return;
+
+	ds->ops->port_bridge_fwd_offload_del(ds, dp->index, br, bridge_num);
+}
+
 int dsa_port_lag_change(struct dsa_port *dp,
 			struct netdev_lag_lower_state_info *linfo)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index f8f06756c6a3..4eff63b4ef2a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1877,10 +1877,21 @@ int dsa_slave_create(struct dsa_port *port)
 
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
-- 
2.25.1

