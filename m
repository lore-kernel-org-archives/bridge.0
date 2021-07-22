Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIyOdgOJmzR2/wDE+ObKRA/618GSd4mK0KWd8UjTGS0=;
 b=JaIniru+1ysTrkV4bra6cE3NeKSXfo6hAbUcY6xOAB9Cl09AaYZhfN3GQApWbsRmAXMd9yvAWs/hr4bUEUWBf50B46i5u11XfA6lWC1RLfevdLQFPcjCWr2QIkzkzj0irxJzyVUDtnWU8eUk+BiBSob6HdUKoYOLPhkV77wxEGk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 22 Jul 2021 18:55:40 +0300
Message-Id: <20210722155542.2897921-4-vladimir.oltean@nxp.com>
In-Reply-To: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
References: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 3/5] net: dsa: add support for bridge
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

DSA keeps for each bridge port a zero-based index (the number of the
bridge). Multiple ports performing TX forwarding offload to the same
bridge have the same dp->bridge_num value, and ports not offloading the
TX data plane of a bridge have dp->bridge_num = -1.

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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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
v4->v5:
- rename functions for naming consistency
- move dsa_port_bridge_tx_fwd_unoffload to dsa_port_bridge_leave instead
  of pre_leave, so that we won't have the problem with dp->bridge_dev
  still being populated

 include/net/dsa.h  | 18 ++++++++++
 net/dsa/dsa2.c     |  1 +
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 84 +++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 929bcaec4d41..f8eb2dc3fbef 100644
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
@@ -413,6 +417,12 @@ struct dsa_switch {
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
 
@@ -696,6 +706,14 @@ struct dsa_switch_ops {
 				    struct net_device *bridge);
 	void	(*port_bridge_leave)(struct dsa_switch *ds, int port,
 				     struct net_device *bridge);
+	/* Called right after .port_bridge_join() */
+	int	(*port_bridge_tx_fwd_offload)(struct dsa_switch *ds, int port,
+					      struct net_device *bridge,
+					      int bridge_num);
+	/* Called right before .port_bridge_leave() */
+	void	(*port_bridge_tx_fwd_unoffload)(struct dsa_switch *ds, int port,
+						struct net_device *bridge,
+						int bridge_num);
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
index 78c70f5bdab5..b1d9aa4d313c 100644
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
diff --git a/net/dsa/port.c b/net/dsa/port.c
index f2704f101ccf..7b9bf45a76b6 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -230,6 +230,83 @@ static void dsa_port_switchdev_unsync_attrs(struct dsa_port *dp)
 	 */
 }
 
+static int dsa_tree_find_bridge_num(struct dsa_switch_tree *dst,
+				    struct net_device *bridge_dev)
+{
+	struct dsa_port *dp;
+
+	/* When preparing the offload for a port, it will have a valid
+	 * dp->bridge_dev pointer but a not yet valid dp->bridge_num.
+	 * However there might be other ports having the same dp->bridge_dev
+	 * and a valid dp->bridge_num, so just ignore this port.
+	 */
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dp->bridge_dev == bridge_dev && dp->bridge_num != -1)
+			return dp->bridge_num;
+
+	return -1;
+}
+
+static void dsa_port_bridge_tx_fwd_unoffload(struct dsa_port *dp,
+					     struct net_device *bridge_dev)
+{
+	struct dsa_switch_tree *dst = dp->ds->dst;
+	int bridge_num = dp->bridge_num;
+	struct dsa_switch *ds = dp->ds;
+
+	/* No bridge TX forwarding offload => do nothing */
+	if (!ds->ops->port_bridge_tx_fwd_unoffload || dp->bridge_num == -1)
+		return;
+
+	dp->bridge_num = -1;
+
+	/* Check if the bridge is still in use, otherwise it is time
+	 * to clean it up so we can reuse this bridge_num later.
+	 */
+	if (!dsa_tree_find_bridge_num(dst, bridge_dev))
+		clear_bit(bridge_num, &dst->fwd_offloading_bridges);
+
+	/* Notify the chips only once the offload has been deactivated, so
+	 * that they can update their configuration accordingly.
+	 */
+	ds->ops->port_bridge_tx_fwd_unoffload(ds, dp->index, bridge_dev,
+					      bridge_num);
+}
+
+static bool dsa_port_bridge_tx_fwd_offload(struct dsa_port *dp,
+					   struct net_device *bridge_dev)
+{
+	struct dsa_switch_tree *dst = dp->ds->dst;
+	struct dsa_switch *ds = dp->ds;
+	int bridge_num, err;
+
+	if (!ds->ops->port_bridge_tx_fwd_offload)
+		return false;
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
+	err = ds->ops->port_bridge_tx_fwd_offload(ds, dp->index, bridge_dev,
+						  bridge_num);
+	if (err) {
+		dsa_port_bridge_tx_fwd_unoffload(dp, bridge_dev);
+		return false;
+	}
+
+	return true;
+}
+
 int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 			 struct netlink_ext_ack *extack)
 {
@@ -241,6 +318,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	};
 	struct net_device *dev = dp->slave;
 	struct net_device *brport_dev;
+	bool tx_fwd_offload;
 	int err;
 
 	/* Here the interface is already bridged. Reflect the current
@@ -254,10 +332,12 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	if (err)
 		goto out_rollback;
 
+	tx_fwd_offload = dsa_port_bridge_tx_fwd_offload(dp, br);
+
 	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
 					    &dsa_slave_switchdev_notifier,
 					    &dsa_slave_switchdev_blocking_notifier,
-					    false, extack);
+					    tx_fwd_offload, extack);
 	if (err)
 		goto out_rollback_unbridge;
 
@@ -302,6 +382,8 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
 	 */
 	dp->bridge_dev = NULL;
 
+	dsa_port_bridge_tx_fwd_unoffload(dp, br);
+
 	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
 	if (err)
 		pr_err("DSA: failed to notify DSA_NOTIFIER_BRIDGE_LEAVE\n");
-- 
2.25.1

