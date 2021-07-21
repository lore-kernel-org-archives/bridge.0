Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMlAATUQNoiSpSLH6nwNifBU3P3Yztf287tfE98zNq0=;
 b=nL1BeQIi/hYAN11fQrVG/AhMjitSXPJ0/16oXxbAUFmZG6jAnYMBEZjYFC/Qw4AAF4oSKfLjN19bikHsXsImzDI0hKJORBHgLriUVGM0+xzy360z8J7IN4/b+IdxiA168V5p5qA7TPSnuYyJ/3ccZb5tjObf0rzlqLQFZOSXtTo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 22 Jul 2021 02:05:55 +0300
Message-Id: <20210721230555.2207542-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next] net: switchdev: fix FDB entries towards
	foreign ports not getting propagated to us
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Eric Woudstra <ericwouds@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

The newly introduced switchdev_handle_fdb_{add,del}_to_device helpers
solved a problem but introduced another one. They have a severe design
bug: they do not propagate FDB events on foreign interfaces to us, i.e.
this use case:

         br0
        /   \
       /     \
      /       \
     /         \
   swp0       eno0
(switchdev)  (foreign)

when an address is learned on eno0, what is supposed to happen is that
this event should also be propagated towards swp0. Somehow I managed to
convince myself that this did work correctly, but obviously it does not.

The trouble with foreign interfaces is that we must reach a switchdev
net_device pointer through a foreign net_device that has no direct
upper/lower relationship with it. So we need to do exploratory searching
through the lower interfaces of the foreign net_device's bridge upper
(to reach swp0 from eno0, we must check its upper, br0, for lower
interfaces that pass the check_cb and foreign_dev_check_cb). This is
something that the previous code did not do, it just assumed that "dev"
will become a switchdev interface at some point, somehow, probably by
magic.

With this patch, assisted address learning on the CPU port works again
in DSA:

ip link add br0 type bridge
ip link set swp0 master br0
ip link set eno0 master br0
ip link set br0 up

[   46.708929] mscc_felix 0000:00:00.5 swp0: Adding FDB entry towards eno0, addr 00:04:9f:05:f4:ab vid 0 as host address

Fixes: 8ca07176ab00 ("net: switchdev: introduce a fanout helper for SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE")
Reported-by: Eric Woudstra <ericwouds@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/switchdev/switchdev.c | 214 +++++++++++++++++++++++++-------------
 1 file changed, 142 insertions(+), 72 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 42e88d3d66a7..0ae3478561f4 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -378,6 +378,56 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
+struct switchdev_nested_priv {
+	bool (*check_cb)(const struct net_device *dev);
+	bool (*foreign_dev_check_cb)(const struct net_device *dev,
+				     const struct net_device *foreign_dev);
+	const struct net_device *dev;
+	struct net_device *lower_dev;
+};
+
+static int switchdev_lower_dev_walk(struct net_device *lower_dev,
+				    struct netdev_nested_priv *priv)
+{
+	struct switchdev_nested_priv *switchdev_priv = priv->data;
+	bool (*foreign_dev_check_cb)(const struct net_device *dev,
+				     const struct net_device *foreign_dev);
+	bool (*check_cb)(const struct net_device *dev);
+	const struct net_device *dev;
+
+	check_cb = switchdev_priv->check_cb;
+	foreign_dev_check_cb = switchdev_priv->foreign_dev_check_cb;
+	dev = switchdev_priv->dev;
+
+	if (check_cb(lower_dev) && !foreign_dev_check_cb(lower_dev, dev)) {
+		switchdev_priv->lower_dev = lower_dev;
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct net_device *
+switchdev_lower_dev_find(struct net_device *dev,
+			 bool (*check_cb)(const struct net_device *dev),
+			 bool (*foreign_dev_check_cb)(const struct net_device *dev,
+						      const struct net_device *foreign_dev))
+{
+	struct switchdev_nested_priv switchdev_priv = {
+		.check_cb = check_cb,
+		.foreign_dev_check_cb = foreign_dev_check_cb,
+		.dev = dev,
+		.lower_dev = NULL,
+	};
+	struct netdev_nested_priv priv = {
+		.data = &switchdev_priv,
+	};
+
+	netdev_walk_all_lower_dev_rcu(dev, switchdev_lower_dev_walk, &priv);
+
+	return switchdev_priv.lower_dev;
+}
+
 static int __switchdev_handle_fdb_add_to_device(struct net_device *dev,
 		const struct net_device *orig_dev,
 		const struct switchdev_notifier_fdb_info *fdb_info,
@@ -392,37 +442,18 @@ static int __switchdev_handle_fdb_add_to_device(struct net_device *dev,
 				  const struct switchdev_notifier_fdb_info *fdb_info))
 {
 	const struct switchdev_notifier_info *info = &fdb_info->info;
-	struct net_device *lower_dev;
+	struct net_device *br, *lower_dev;
 	struct list_head *iter;
 	int err = -EOPNOTSUPP;
 
-	if (check_cb(dev)) {
-		/* Handle FDB entries on foreign interfaces as FDB entries
-		 * towards the software bridge.
-		 */
-		if (foreign_dev_check_cb && foreign_dev_check_cb(dev, orig_dev)) {
-			struct net_device *br = netdev_master_upper_dev_get_rcu(dev);
-
-			if (!br || !netif_is_bridge_master(br))
-				return 0;
-
-			/* No point in handling FDB entries on a foreign bridge */
-			if (foreign_dev_check_cb(dev, br))
-				return 0;
-
-			return __switchdev_handle_fdb_add_to_device(br, orig_dev,
-								    fdb_info, check_cb,
-								    foreign_dev_check_cb,
-								    add_cb, lag_add_cb);
-		}
-
+	if (check_cb(dev))
 		return add_cb(dev, orig_dev, info->ctx, fdb_info);
-	}
 
-	/* If we passed over the foreign check, it means that the LAG interface
-	 * is offloaded.
-	 */
 	if (netif_is_lag_master(dev)) {
+		if (!switchdev_lower_dev_find(dev, check_cb, foreign_dev_check_cb))
+			goto maybe_bridged_with_us;
+
+		/* This is a LAG interface that we offload */
 		if (!lag_add_cb)
 			return -EOPNOTSUPP;
 
@@ -432,20 +463,49 @@ static int __switchdev_handle_fdb_add_to_device(struct net_device *dev,
 	/* Recurse through lower interfaces in case the FDB entry is pointing
 	 * towards a bridge device.
 	 */
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		/* Do not propagate FDB entries across bridges */
-		if (netif_is_bridge_master(lower_dev))
-			continue;
+	if (netif_is_bridge_master(dev)) {
+		if (!switchdev_lower_dev_find(dev, check_cb, foreign_dev_check_cb))
+			return 0;
+
+		/* This is a bridge interface that we offload */
+		netdev_for_each_lower_dev(dev, lower_dev, iter) {
+			/* Do not propagate FDB entries across bridges */
+			if (netif_is_bridge_master(lower_dev))
+				continue;
+
+			/* Bridge ports might be either us, or LAG interfaces
+			 * that we offload.
+			 */
+			if (!check_cb(lower_dev) &&
+			    !switchdev_lower_dev_find(lower_dev, check_cb,
+						      foreign_dev_check_cb))
+				continue;
+
+			err = __switchdev_handle_fdb_add_to_device(lower_dev, orig_dev,
+								   fdb_info, check_cb,
+								   foreign_dev_check_cb,
+								   add_cb, lag_add_cb);
+			if (err && err != -EOPNOTSUPP)
+				return err;
+		}
 
-		err = __switchdev_handle_fdb_add_to_device(lower_dev, orig_dev,
-							   fdb_info, check_cb,
-							   foreign_dev_check_cb,
-							   add_cb, lag_add_cb);
-		if (err && err != -EOPNOTSUPP)
-			return err;
+		return 0;
 	}
 
-	return err;
+maybe_bridged_with_us:
+	/* Event is neither on a bridge nor a LAG. Check whether it is on an
+	 * interface that is in a bridge with us.
+	 */
+	br = netdev_master_upper_dev_get_rcu(dev);
+	if (!br || !netif_is_bridge_master(br))
+		return 0;
+
+	if (!switchdev_lower_dev_find(br, check_cb, foreign_dev_check_cb))
+		return 0;
+
+	return __switchdev_handle_fdb_add_to_device(br, orig_dev, fdb_info,
+						    check_cb, foreign_dev_check_cb,
+						    add_cb, lag_add_cb);
 }
 
 int switchdev_handle_fdb_add_to_device(struct net_device *dev,
@@ -487,37 +547,18 @@ static int __switchdev_handle_fdb_del_to_device(struct net_device *dev,
 				  const struct switchdev_notifier_fdb_info *fdb_info))
 {
 	const struct switchdev_notifier_info *info = &fdb_info->info;
-	struct net_device *lower_dev;
+	struct net_device *br, *lower_dev;
 	struct list_head *iter;
 	int err = -EOPNOTSUPP;
 
-	if (check_cb(dev)) {
-		/* Handle FDB entries on foreign interfaces as FDB entries
-		 * towards the software bridge.
-		 */
-		if (foreign_dev_check_cb && foreign_dev_check_cb(dev, orig_dev)) {
-			struct net_device *br = netdev_master_upper_dev_get_rcu(dev);
-
-			if (!br || !netif_is_bridge_master(br))
-				return 0;
-
-			/* No point in handling FDB entries on a foreign bridge */
-			if (foreign_dev_check_cb(dev, br))
-				return 0;
-
-			return __switchdev_handle_fdb_del_to_device(br, orig_dev,
-								    fdb_info, check_cb,
-								    foreign_dev_check_cb,
-								    del_cb, lag_del_cb);
-		}
-
+	if (check_cb(dev))
 		return del_cb(dev, orig_dev, info->ctx, fdb_info);
-	}
 
-	/* If we passed over the foreign check, it means that the LAG interface
-	 * is offloaded.
-	 */
 	if (netif_is_lag_master(dev)) {
+		if (!switchdev_lower_dev_find(dev, check_cb, foreign_dev_check_cb))
+			goto maybe_bridged_with_us;
+
+		/* This is a LAG interface that we offload */
 		if (!lag_del_cb)
 			return -EOPNOTSUPP;
 
@@ -527,20 +568,49 @@ static int __switchdev_handle_fdb_del_to_device(struct net_device *dev,
 	/* Recurse through lower interfaces in case the FDB entry is pointing
 	 * towards a bridge device.
 	 */
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		/* Do not propagate FDB entries across bridges */
-		if (netif_is_bridge_master(lower_dev))
-			continue;
+	if (netif_is_bridge_master(dev)) {
+		if (!switchdev_lower_dev_find(dev, check_cb, foreign_dev_check_cb))
+			return 0;
+
+		/* This is a bridge interface that we offload */
+		netdev_for_each_lower_dev(dev, lower_dev, iter) {
+			/* Do not propagate FDB entries across bridges */
+			if (netif_is_bridge_master(lower_dev))
+				continue;
+
+			/* Bridge ports might be either us, or LAG interfaces
+			 * that we offload.
+			 */
+			if (!check_cb(lower_dev) &&
+			    !switchdev_lower_dev_find(lower_dev, check_cb,
+						      foreign_dev_check_cb))
+				continue;
+
+			err = __switchdev_handle_fdb_del_to_device(lower_dev, orig_dev,
+								   fdb_info, check_cb,
+								   foreign_dev_check_cb,
+								   del_cb, lag_del_cb);
+			if (err && err != -EOPNOTSUPP)
+				return err;
+		}
 
-		err = __switchdev_handle_fdb_del_to_device(lower_dev, orig_dev,
-							   fdb_info, check_cb,
-							   foreign_dev_check_cb,
-							   del_cb, lag_del_cb);
-		if (err && err != -EOPNOTSUPP)
-			return err;
+		return 0;
 	}
 
-	return err;
+maybe_bridged_with_us:
+	/* Event is neither on a bridge nor a LAG. Check whether it is on an
+	 * interface that is in a bridge with us.
+	 */
+	br = netdev_master_upper_dev_get_rcu(dev);
+	if (!br || !netif_is_bridge_master(br))
+		return 0;
+
+	if (!switchdev_lower_dev_find(br, check_cb, foreign_dev_check_cb))
+		return 0;
+
+	return __switchdev_handle_fdb_del_to_device(br, orig_dev, fdb_info,
+						    check_cb, foreign_dev_check_cb,
+						    del_cb, lag_del_cb);
 }
 
 int switchdev_handle_fdb_del_to_device(struct net_device *dev,
-- 
2.25.1

