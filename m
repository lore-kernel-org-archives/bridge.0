Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLP1enISVA6/MDMdAX4ko1JVDKim4QW0eI18R+Wa7Bs=;
 b=jJ4OK0i+cGXBtTuU7T1c4B77vtAH/lnacElMZjhcWt7Y9/R5Npul13RJXYUz0OBO5U4LxYzMtZ0PZ41Bj5qoW38ed+TDqQfFyYde6kOD4obXdg1YiJJB1GKDsE2U6lYb3+VFmLKjJCCpBxEYzO7CGGuervwJ0+F3+ZVhkRslRvo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:36 +0300
Message-Id: <20210712152142.800651-19-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 18/24] net: bridge: replay vlan
	entries on the public switchdev notifier
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

In preparation of making br_vlan_replay() be called automatically for
every switchdev driver, we need to drop the extra argument to the
blocking notifier block so it becomes a less bureaucratic process, and
just emit the replayed events on the public chain.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_net.c |  3 +--
 include/linux/if_bridge.h              |  6 ++---
 net/bridge/br_vlan.c                   | 32 ++++++++------------------
 net/dsa/dsa_priv.h                     |  1 -
 net/dsa/port.c                         |  6 ++---
 net/dsa/slave.c                        |  2 +-
 6 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 863437990f92..981adbf21200 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1179,8 +1179,7 @@ static int ocelot_switchdev_sync(struct ocelot *ocelot, int port,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	err = br_vlan_replay(bridge_dev, brport_dev, priv, true,
-			     &ocelot_switchdev_blocking_nb, extack);
+	err = br_vlan_replay(bridge_dev, brport_dev, priv, true, extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index c7ed22b22256..58624f393248 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,8 +119,7 @@ int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto);
 int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
-		   const void *ctx, bool adding, struct notifier_block *nb,
-		   struct netlink_ext_ack *extack);
+		   const void *ctx, bool adding, struct netlink_ext_ack *extack);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -150,8 +149,7 @@ static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
 
 static inline int br_vlan_replay(struct net_device *br_dev,
 				 struct net_device *dev, const void *ctx,
-				 bool adding, struct notifier_block *nb,
-				 struct netlink_ext_ack *extack)
+				 bool adding, struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 14f10203d121..ad2d1e56c6e4 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1807,35 +1807,28 @@ void br_vlan_notify(const struct net_bridge *br,
 	kfree_skb(skb);
 }
 
-static int br_vlan_replay_one(struct notifier_block *nb,
-			      struct net_device *dev,
+static int br_vlan_replay_one(struct net_device *dev,
 			      struct switchdev_obj_port_vlan *vlan,
-			      const void *ctx, unsigned long action,
+			      const void *ctx, bool adding,
 			      struct netlink_ext_ack *extack)
 {
-	struct switchdev_notifier_port_obj_info obj_info = {
-		.info = {
-			.dev = dev,
-			.extack = extack,
-			.ctx = ctx,
-		},
-		.obj = &vlan->obj,
-	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
-	return notifier_to_errno(err);
+	if (adding)
+		err = switchdev_port_obj_add(dev, &vlan->obj, ctx, extack);
+	else
+		err = switchdev_port_obj_del(dev, &vlan->obj, ctx);
+
+	return err;
 }
 
 int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
-		   const void *ctx, bool adding, struct notifier_block *nb,
-		   struct netlink_ext_ack *extack)
+		   const void *ctx, bool adding, struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
 	struct net_bridge_port *p;
 	struct net_bridge *br;
-	unsigned long action;
 	int err = 0;
 	u16 pvid;
 
@@ -1862,11 +1855,6 @@ int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
 	if (!vg)
 		return 0;
 
-	if (adding)
-		action = SWITCHDEV_PORT_OBJ_ADD;
-	else
-		action = SWITCHDEV_PORT_OBJ_DEL;
-
 	pvid = br_get_pvid(vg);
 
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
@@ -1880,7 +1868,7 @@ int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
 		if (!br_vlan_should_use(v))
 			continue;
 
-		err = br_vlan_replay_one(nb, dev, &vlan, ctx, action, extack);
+		err = br_vlan_replay_one(dev, &vlan, ctx, adding, extack);
 		if (err)
 			return err;
 	}
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 20003512d8f8..3b51aaa26760 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -285,7 +285,6 @@ static inline bool dsa_tree_offloads_bridge_port(struct dsa_switch_tree *dst,
 
 /* slave.c */
 extern const struct dsa_device_ops notag_netdev_ops;
-extern struct notifier_block dsa_slave_switchdev_blocking_notifier;
 
 void dsa_slave_mii_bus_init(struct dsa_switch *ds);
 int dsa_slave_create(struct dsa_port *dp);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index c86121e9d87d..63a244858e2b 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -208,8 +208,7 @@ static int dsa_port_switchdev_sync(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	err = br_vlan_replay(br, brport_dev, dp, true,
-			     &dsa_slave_switchdev_blocking_notifier, extack);
+	err = br_vlan_replay(br, brport_dev, dp, true, extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
@@ -238,8 +237,7 @@ static int dsa_port_switchdev_unsync_objs(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	err = br_vlan_replay(br, brport_dev, dp, false,
-			     &dsa_slave_switchdev_blocking_notifier, extack);
+	err = br_vlan_replay(br, brport_dev, dp, false, extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 461c80bc066a..f8f06756c6a3 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2521,7 +2521,7 @@ static struct notifier_block dsa_slave_switchdev_notifier = {
 	.notifier_call = dsa_slave_switchdev_event,
 };
 
-struct notifier_block dsa_slave_switchdev_blocking_notifier = {
+static struct notifier_block dsa_slave_switchdev_blocking_notifier = {
 	.notifier_call = dsa_slave_switchdev_blocking_event,
 };
 
-- 
2.25.1

