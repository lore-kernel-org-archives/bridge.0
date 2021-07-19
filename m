Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+wlcFQmlttP1MyZSwz0f2uvGjTh91BntK9D0CsW3mk=;
 b=aQuHUCSKrboL8uyuzfSn8llHui/B5s9XMoi9zOl88bBfrdcbgd0G9piKg0mjtyxpViAe0GzI5VUuWjj/oZPJBK/rpD4HnjBmagiwAMioT4wc0h+Vl+G5bPqdOPN7EJkVU17a3utMJvgGDf4okPcKJpmE076VNLF7e5KLwiFFt4I=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 16:51:40 +0300
Message-Id: <20210719135140.278938-4-vladimir.oltean@nxp.com>
In-Reply-To: <20210719135140.278938-1-vladimir.oltean@nxp.com>
References: <20210719135140.278938-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 3/3] net: dsa: use
	switchdev_handle_fdb_{add, del}_to_device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Using the new fan-out helper for FDB entries installed on the software
bridge, we can install host addresses with the proper refcount on the
CPU port, such that this case:

ip link set swp0 master br0
ip link set swp1 master br0
ip link set swp2 master br0
ip link set swp3 master br0
ip link set br0 address 00:01:02:03:04:05
ip link set swp3 nomaster

works properly and the br0 address remains installed as a host entry
with refcount 3 instead of getting deleted.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa_priv.h |  19 ++++-
 net/dsa/slave.c    | 199 ++++++++++++++++++++++-----------------------
 2 files changed, 113 insertions(+), 105 deletions(-)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f201c33980bf..e4b2e9f2a020 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -256,13 +256,13 @@ void dsa_port_hsr_leave(struct dsa_port *dp, struct net_device *hsr);
 extern const struct phylink_mac_ops dsa_port_phylink_mac_ops;
 
 static inline bool dsa_port_offloads_bridge_port(struct dsa_port *dp,
-						 struct net_device *dev)
+						 const struct net_device *dev)
 {
 	return dsa_port_to_bridge_port(dp) == dev;
 }
 
 static inline bool dsa_port_offloads_bridge(struct dsa_port *dp,
-					    struct net_device *bridge_dev)
+					    const struct net_device *bridge_dev)
 {
 	/* DSA ports connected to a bridge, and event was emitted
 	 * for the bridge.
@@ -272,7 +272,7 @@ static inline bool dsa_port_offloads_bridge(struct dsa_port *dp,
 
 /* Returns true if any port of this tree offloads the given net_device */
 static inline bool dsa_tree_offloads_bridge_port(struct dsa_switch_tree *dst,
-						 struct net_device *dev)
+						 const struct net_device *dev)
 {
 	struct dsa_port *dp;
 
@@ -283,6 +283,19 @@ static inline bool dsa_tree_offloads_bridge_port(struct dsa_switch_tree *dst,
 	return false;
 }
 
+/* Returns true if any port of this tree offloads the given bridge */
+static inline bool dsa_tree_offloads_bridge(struct dsa_switch_tree *dst,
+					    const struct net_device *bridge_dev)
+{
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dsa_port_offloads_bridge(dp, bridge_dev))
+			return true;
+
+	return false;
+}
+
 /* slave.c */
 extern const struct dsa_device_ops notag_netdev_ops;
 extern struct notifier_block dsa_slave_switchdev_notifier;
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index feb64f58faed..22ce11cd770e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2353,26 +2353,98 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 	kfree(switchdev_work);
 }
 
-static int dsa_lower_dev_walk(struct net_device *lower_dev,
-			      struct netdev_nested_priv *priv)
+static bool dsa_foreign_dev_check(const struct net_device *dev,
+				  const struct net_device *foreign_dev)
 {
-	if (dsa_slave_dev_check(lower_dev)) {
-		priv->data = (void *)netdev_priv(lower_dev);
-		return 1;
-	}
+	const struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch_tree *dst = dp->ds->dst;
 
-	return 0;
+	if (netif_is_bridge_master(foreign_dev))
+		return !dsa_tree_offloads_bridge(dst, foreign_dev);
+
+	if (netif_is_bridge_port(foreign_dev))
+		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
+
+	/* Everything else is foreign */
+	return true;
 }
 
-static struct dsa_slave_priv *dsa_slave_dev_lower_find(struct net_device *dev)
+static int dsa_slave_fdb_event(struct net_device *dev,
+			       const struct net_device *orig_dev,
+			       const void *ctx,
+			       const struct switchdev_notifier_fdb_info *fdb_info,
+			       unsigned long event)
 {
-	struct netdev_nested_priv priv = {
-		.data = NULL,
-	};
+	struct dsa_switchdev_event_work *switchdev_work;
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	bool host_addr = fdb_info->is_local;
+	struct dsa_switch *ds = dp->ds;
+
+	if (ctx && ctx != dp)
+		return 0;
+
+	if (!ds->ops->port_fdb_add || !ds->ops->port_fdb_del)
+		return -EOPNOTSUPP;
+
+	if (dsa_slave_dev_check(orig_dev) &&
+	    switchdev_fdb_is_dynamically_learned(fdb_info))
+		return 0;
+
+	/* FDB entries learned by the software bridge should be installed as
+	 * host addresses only if the driver requests assisted learning.
+	 */
+	if (switchdev_fdb_is_dynamically_learned(fdb_info) &&
+	    !ds->assisted_learning_on_cpu_port)
+		return 0;
+
+	/* Also treat FDB entries on foreign interfaces bridged with us as host
+	 * addresses.
+	 */
+	if (dsa_foreign_dev_check(dev, orig_dev))
+		host_addr = true;
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (!switchdev_work)
+		return -ENOMEM;
+
+	netdev_dbg(dev, "%s FDB entry towards %s, addr %pM vid %d%s\n",
+		   event == SWITCHDEV_FDB_ADD_TO_DEVICE ? "Adding" : "Deleting",
+		   orig_dev->name, fdb_info->addr, fdb_info->vid,
+		   host_addr ? " as host address" : "");
 
-	netdev_walk_all_lower_dev_rcu(dev, dsa_lower_dev_walk, &priv);
+	INIT_WORK(&switchdev_work->work, dsa_slave_switchdev_event_work);
+	switchdev_work->ds = ds;
+	switchdev_work->port = dp->index;
+	switchdev_work->event = event;
+	switchdev_work->dev = dev;
 
-	return (struct dsa_slave_priv *)priv.data;
+	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
+	switchdev_work->vid = fdb_info->vid;
+	switchdev_work->host_addr = host_addr;
+
+	/* Hold a reference for dsa_fdb_offload_notify */
+	dev_hold(dev);
+	dsa_schedule_work(&switchdev_work->work);
+
+	return 0;
+}
+
+static int
+dsa_slave_fdb_add_to_device(struct net_device *dev,
+			    const struct net_device *orig_dev, const void *ctx,
+			    const struct switchdev_notifier_fdb_info *fdb_info)
+{
+	return dsa_slave_fdb_event(dev, orig_dev, ctx, fdb_info,
+				   SWITCHDEV_FDB_ADD_TO_DEVICE);
+}
+
+static int
+dsa_slave_fdb_del_to_device(struct net_device *dev,
+			    const struct net_device *orig_dev, const void *ctx,
+			    const struct switchdev_notifier_fdb_info *fdb_info)
+{
+	return dsa_slave_fdb_event(dev, orig_dev, ctx, fdb_info,
+				   SWITCHDEV_FDB_DEL_TO_DEVICE);
 }
 
 /* Called under rcu_read_lock() */
@@ -2380,10 +2452,6 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 				     unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
-	const struct switchdev_notifier_fdb_info *fdb_info;
-	struct dsa_switchdev_event_work *switchdev_work;
-	bool host_addr = false;
-	struct dsa_port *dp;
 	int err;
 
 	switch (event) {
@@ -2393,92 +2461,19 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 						     dsa_slave_port_attr_set);
 		return notifier_from_errno(err);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		err = switchdev_handle_fdb_add_to_device(dev, ptr,
+							 dsa_slave_dev_check,
+							 dsa_foreign_dev_check,
+							 dsa_slave_fdb_add_to_device,
+							 NULL);
+		return notifier_from_errno(err);
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		fdb_info = ptr;
-
-		if (dsa_slave_dev_check(dev)) {
-			dp = dsa_slave_to_port(dev);
-
-			if (fdb_info->is_local)
-				host_addr = true;
-			else if (!fdb_info->added_by_user)
-				return NOTIFY_OK;
-		} else {
-			/* Snoop addresses added to foreign interfaces
-			 * bridged with us, or the bridge
-			 * itself. Dynamically learned addresses can
-			 * also be added for switches that don't
-			 * automatically learn SA from CPU-injected
-			 * traffic.
-			 */
-			struct net_device *br_dev;
-			struct dsa_slave_priv *p;
-
-			if (netif_is_bridge_master(dev))
-				br_dev = dev;
-			else
-				br_dev = netdev_master_upper_dev_get_rcu(dev);
-
-			if (!br_dev)
-				return NOTIFY_DONE;
-
-			if (!netif_is_bridge_master(br_dev))
-				return NOTIFY_DONE;
-
-			p = dsa_slave_dev_lower_find(br_dev);
-			if (!p)
-				return NOTIFY_DONE;
-
-			dp = p->dp;
-			host_addr = fdb_info->is_local;
-
-			/* FDB entries learned by the software bridge should
-			 * be installed as host addresses only if the driver
-			 * requests assisted learning.
-			 * On the other hand, FDB entries for local termination
-			 * should always be installed.
-			 */
-			if (switchdev_fdb_is_dynamically_learned(fdb_info) &&
-			    !dp->ds->assisted_learning_on_cpu_port)
-				return NOTIFY_DONE;
-
-			/* When the bridge learns an address on an offloaded
-			 * LAG we don't want to send traffic to the CPU, the
-			 * other ports bridged with the LAG should be able to
-			 * autonomously forward towards it.
-			 * On the other hand, if the address is local
-			 * (therefore not learned) then we want to trap it to
-			 * the CPU regardless of whether the interface it
-			 * belongs to is offloaded or not.
-			 */
-			if (dsa_tree_offloads_bridge_port(dp->ds->dst, dev) &&
-			    !fdb_info->is_local)
-				return NOTIFY_DONE;
-		}
-
-		if (!dp->ds->ops->port_fdb_add || !dp->ds->ops->port_fdb_del)
-			return NOTIFY_DONE;
-
-		switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
-		if (!switchdev_work)
-			return NOTIFY_BAD;
-
-		INIT_WORK(&switchdev_work->work,
-			  dsa_slave_switchdev_event_work);
-		switchdev_work->ds = dp->ds;
-		switchdev_work->port = dp->index;
-		switchdev_work->event = event;
-		switchdev_work->dev = dev;
-
-		ether_addr_copy(switchdev_work->addr,
-				fdb_info->addr);
-		switchdev_work->vid = fdb_info->vid;
-		switchdev_work->host_addr = host_addr;
-
-		/* Hold a reference for dsa_fdb_offload_notify */
-		dev_hold(dev);
-		dsa_schedule_work(&switchdev_work->work);
-		break;
+		err = switchdev_handle_fdb_del_to_device(dev, ptr,
+							 dsa_slave_dev_check,
+							 dsa_foreign_dev_check,
+							 dsa_slave_fdb_del_to_device,
+							 NULL);
+		return notifier_from_errno(err);
 	default:
 		return NOTIFY_DONE;
 	}
-- 
2.25.1

