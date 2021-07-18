Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoptCvtMYckutX3UYnBp22q3YaR9C53XqvXQwtsth70=;
 b=U8uBUd8ke08amNOkpUgUd3CiTnvs1LyeWkUJbUMt99O9fSUKdPO31JnySmgvtn9ZdFiMVJYXofhvca4ItwVORHPctTLkxtK4NM/s++lLCJ9FndYQAkpI5lgNuSDvWW10me3YQf3SL6YtNi0pts25k3raTGuZPnSyi9EwxhO2Qdk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 00:44:32 +0300
Message-Id: <20210718214434.3938850-14-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v4 net-next 13/15] net: dsa: add support for bridge
	TX forwarding offload
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
v2->v3:
- signal the offloading capability via switchdev_bridge_port_offload()
- drop "bool bridge_fwd_offload" from the tagger
- drop "struct dsa_bridge_fwd_accel_priv" from struct dsa_port and
  replace it with a simple "int bridge_num"
- drop .crosschip_bridge_fwd_offload_{add,del}()
- drop the DSA_NOTIFIER_BRIDGE_FWD_OFFLOAD_{ADD,DEL} cross-chip notifier
  and call the driver directly on the port
v3->v4:
- use dsa_tree_find_bridge_dev() in the unprepare code path to allow the
  bridge_num to be properly reused when there is no port offloading a
  given bridge anymore
- drop the stray netif_set_real_num_tx_queues() change from v2
- properly call dsa_port_bridge_tx_fwd_unprepare() instead of prepare()
  in dsa_port_pre_bridge_leave()
- fix dp->bridge_num remaining -1 in dsa_port_bridge_tx_fwd_prepare() by
  removing the stray "int bridge_num" declaration which was shadowing
  the variable which had the function-wide scope

 include/net/dsa.h  |  18 ++++++++
 net/dsa/dsa2.c     |   1 +
 net/dsa/dsa_priv.h |   6 +++
 net/dsa/port.c     | 111 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 89626eab92b9..74f559ee517a 100644
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
@@ -262,6 +265,7 @@ struct dsa_port {
 	bool			vlan_filtering;
 	u8			stp_state;
 	struct net_device	*bridge_dev;
+	int			bridge_num;
 	struct devlink_port	devlink_port;
 	bool			devlink_port_setup;
 	struct phylink		*pl;
@@ -410,6 +414,12 @@ struct dsa_switch {
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
 
@@ -693,6 +703,14 @@ struct dsa_switch_ops {
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
index f201c33980bf..28a99a6a59ce 100644
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
index fce69cf3f8e3..05072de9ddc0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -230,6 +230,87 @@ static void dsa_port_switchdev_unsync_attrs(struct dsa_port *dp)
 	 */
 }
 
+static int dsa_tree_find_bridge_num(struct dsa_switch_tree *dst,
+				    struct net_device *bridge_dev)
+{
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dp->bridge_dev == bridge_dev)
+			return dp->bridge_num;
+
+	return -1;
+}
+
+static struct net_device *dsa_tree_find_bridge_dev(struct dsa_switch_tree *dst,
+						   int bridge_num)
+{
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dp->bridge_num == bridge_num)
+			return dp->bridge_dev;
+
+	return NULL;
+}
+
+static void dsa_port_bridge_tx_fwd_unprepare(struct dsa_port *dp,
+					     struct net_device *bridge_dev)
+{
+	int bridge_num = dp->bridge_num;
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_switch_tree *dst;
+
+	dst = ds->dst;
+
+	dp->bridge_num = -1;
+
+	/* Check if the bridge is still in use, otherwise it is time to clean
+	 * it up. Note that we are in the pre_bridge_leave path, so
+	 * dp->bridge_dev is still a valid pointer. We need to search by
+	 * dp->bridge_num instead.
+	 */
+	if (!dsa_tree_find_bridge_dev(dst, bridge_num))
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
@@ -241,6 +322,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	};
 	struct net_device *dev = dp->slave;
 	struct net_device *brport_dev;
+	bool tx_fwd_offload;
 	int err;
 
 	/* Here the interface is already bridged. Reflect the current
@@ -254,10 +336,12 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	if (err)
 		goto out_rollback;
 
+	tx_fwd_offload = dsa_port_bridge_tx_fwd_prepare(dp, br);
+
 	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
 					    &dsa_slave_switchdev_notifier,
 					    &dsa_slave_switchdev_blocking_notifier,
-					    false, extack);
+					    tx_fwd_offload, extack);
 	if (err)
 		goto out_rollback_unbridge;
 
@@ -285,6 +369,8 @@ int dsa_port_pre_bridge_leave(struct dsa_port *dp, struct net_device *br,
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	struct net_device *dev = dp->slave;
 
+	dsa_port_bridge_tx_fwd_unprepare(dp, br);
+
 	return switchdev_bridge_port_unoffload(brport_dev, dev, dp,
 					       &dsa_slave_switchdev_notifier,
 					       &dsa_slave_switchdev_blocking_notifier,
@@ -313,6 +399,29 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
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
-- 
2.25.1

