Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLMbPaoN3FMzym7hsZyiIWH3QIQDCDi4v1MvQHkMpNU=;
 b=drbKA5HPplGiRW4dHtAxZS8RVBKYSeDOW8zsrtBrSbPEE0k7OME1ZCjt2YiyGqjTi9x57/V4E8TnFvc9FQxJMyS32QwgBTSSoxzS2nBO8Z6z5ZFwMUPOcRj+mqxdv+Jtnve4L0PluHOdpGtty5iEXdCMIr4ISh1V5fj9uVME8xA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 16:51:39 +0300
Message-Id: <20210719135140.278938-3-vladimir.oltean@nxp.com>
In-Reply-To: <20210719135140.278938-1-vladimir.oltean@nxp.com>
References: <20210719135140.278938-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 2/3] net: switchdev: introduce a fanout
	helper for SWITCHDEV_FDB_{ADD, DEL}_TO_DEVICE
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

Currently DSA has an issue with FDB entries pointing towards the bridge
in the presence of br_fdb_replay() being called at port join and leave
time.

In particular, each bridge port will ask for a replay for the FDB
entries pointing towards the bridge when it joins, and for another
replay when it leaves.

This means that for example, a bridge with 4 switch ports will notify
DSA 4 times of the bridge MAC address.

But if the MAC address of the bridge changes during the normal runtime
of the system, the bridge notifies switchdev [ once ] of the deletion of
the old MAC address as a local FDB towards the bridge, and of the
insertion [ again once ] of the new MAC address as a local FDB.

This is a problem, because DSA keeps the old MAC address as a host FDB
entry with refcount 4 (4 ports asked for it using br_fdb_replay). So the
old MAC address will not be deleted. Additionally, the new MAC address
will only be installed with refcount 1, and when the first switch port
leaves the bridge (leaving 3 others as still members), it will delete
with it the new MAC address of the bridge from the local FDB entries
kept by DSA (because the br_fdb_replay call on deletion will bring the
entry's refcount from 1 to 0).

So the problem, really, is that the number of br_fdb_replay() calls is
not matched with the refcount that a host FDB is offloaded to DSA during
normal runtime.

An elegant way to solve the problem would be to make the switchdev
notification emitted by br_fdb_change_mac_address() result in a host FDB
kept by DSA which has a refcount exactly equal to the number of ports
under that bridge. Then, no matter how many DSA ports join or leave that
bridge, the host FDB entry will always be deleted when there are exactly
zero remaining DSA switch ports members of the bridge.

To implement the proposed solution, we remember that the switchdev
objects and port attributes have some helpers provided by switchdev,
which can be optionally called by drivers:
switchdev_handle_port_obj_{add,del} and switchdev_handle_port_attr_set.
These helpers:
- fan out a switchdev object/attribute emitted for the bridge towards
  all the lower interfaces that pass the check_cb().
- fan out a switchdev object/attribute emitted for a bridge port that is
  a LAG towards all the lower interfaces that pass the check_cb().

In other words, this is the model we need for the FDB events too:
something that will keep an FDB entry emitted towards a physical port as
it is, but translate an FDB entry emitted towards the bridge into N FDB
entries, one per physical port.

Of course, there are many differences between fanning out a switchdev
object (VLAN) on 3 lower interfaces of a LAG and fanning out an FDB
entry on 3 lower interfaces of a LAG. Intuitively, an FDB entry towards
a LAG should be treated specially, because FDB entries are unicast, we
can't just install the same address towards 3 destinations. It is
imaginable that drivers might want to treat this case specifically, so
create some methods for this case and do not recurse into the LAG lower
ports, just the bridge ports.

DSA also listens for FDB entries on "foreign" interfaces, aka interfaces
bridged with us which are not part of our hardware domain: think an
Ethernet switch bridged with a Wi-Fi AP. For those addresses, DSA
installs host FDB entries. However, there we have the same problem
(those host FDB entries are installed with a refcount of only 1) and an
even bigger one which we did not have with FDB entries towards the
bridge:

br_fdb_replay() is currently not called for FDB entries on foreign
interfaces, just for the physical port and for the bridge itself.

So when DSA sniffs an address learned by the software bridge towards a
foreign interface like an e1000 port, and then that e1000 leaves the
bridge, DSA remains with the dangling host FDB address. That will be
fixed separately by replaying all FDB entries and not just the ones
towards the port and the bridge.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/switchdev.h   |  56 +++++++++++
 net/switchdev/switchdev.c | 190 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 745eb25fb8c4..6f57eb2e89cc 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -272,6 +272,30 @@ void switchdev_port_fwd_mark_set(struct net_device *dev,
 				 struct net_device *group_dev,
 				 bool joining);
 
+int switchdev_handle_fdb_add_to_device(struct net_device *dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*add_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_add_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info));
+
+int switchdev_handle_fdb_del_to_device(struct net_device *dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*del_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_del_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info));
+
 int switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
 			bool (*check_cb)(const struct net_device *dev),
@@ -355,6 +379,38 @@ call_switchdev_blocking_notifiers(unsigned long val,
 	return NOTIFY_DONE;
 }
 
+static inline int
+switchdev_handle_fdb_add_to_device(struct net_device *dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*add_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_add_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info))
+{
+	return 0;
+}
+
+static inline int
+switchdev_handle_fdb_del_to_device(struct net_device *dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*del_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_del_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info));
+{
+	return 0;
+}
+
 static inline int
 switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 070698dd19bc..82dd4e4e86f5 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -378,6 +378,196 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
+static int __switchdev_handle_fdb_add_to_device(struct net_device *dev,
+		const struct net_device *orig_dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*add_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_add_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info))
+{
+	const struct switchdev_notifier_info *info = &fdb_info->info;
+	struct net_device *lower_dev;
+	struct list_head *iter;
+	int err = -EOPNOTSUPP;
+
+	if (check_cb(dev)) {
+		/* Handle FDB entries on foreign interfaces as FDB entries
+		 * towards the software bridge.
+		 */
+		if (foreign_dev_check_cb && foreign_dev_check_cb(dev, orig_dev)) {
+			struct net_device *br = netdev_master_upper_dev_get_rcu(dev);
+
+			if (!br || !netif_is_bridge_master(br))
+				return 0;
+
+			/* No point in handling FDB entries on a foreign bridge */
+			if (foreign_dev_check_cb(dev, br))
+				return 0;
+
+			return __switchdev_handle_fdb_add_to_device(br, orig_dev,
+								    fdb_info, check_cb,
+								    foreign_dev_check_cb,
+								    add_cb, lag_add_cb);
+		}
+
+		return add_cb(dev, orig_dev, info->ctx, fdb_info);
+	}
+
+	/* If we passed over the foreign check, it means that the LAG interface
+	 * is offloaded.
+	 */
+	if (netif_is_lag_master(dev)) {
+		if (!lag_add_cb)
+			return -EOPNOTSUPP;
+
+		return lag_add_cb(dev, orig_dev, info->ctx, fdb_info);
+	}
+
+	/* Recurse through lower interfaces in case the FDB entry is pointing
+	 * towards a bridge device.
+	 */
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		/* Do not propagate FDB entries across bridges */
+		if (netif_is_bridge_master(lower_dev))
+			continue;
+
+		err = __switchdev_handle_fdb_add_to_device(lower_dev, orig_dev,
+							   fdb_info, check_cb,
+							   foreign_dev_check_cb,
+							   add_cb, lag_add_cb);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	return err;
+}
+
+int switchdev_handle_fdb_add_to_device(struct net_device *dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*add_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_add_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info))
+{
+	int err;
+
+	err = __switchdev_handle_fdb_add_to_device(dev, dev, fdb_info,
+						   check_cb,
+						   foreign_dev_check_cb,
+						   add_cb, lag_add_cb);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(switchdev_handle_fdb_add_to_device);
+
+static int __switchdev_handle_fdb_del_to_device(struct net_device *dev,
+		const struct net_device *orig_dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*del_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_del_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info))
+{
+	const struct switchdev_notifier_info *info = &fdb_info->info;
+	struct net_device *lower_dev;
+	struct list_head *iter;
+	int err = -EOPNOTSUPP;
+
+	if (check_cb(dev)) {
+		/* Handle FDB entries on foreign interfaces as FDB entries
+		 * towards the software bridge.
+		 */
+		if (foreign_dev_check_cb && foreign_dev_check_cb(dev, orig_dev)) {
+			struct net_device *br = netdev_master_upper_dev_get_rcu(dev);
+
+			if (!br || !netif_is_bridge_master(br))
+				return 0;
+
+			/* No point in handling FDB entries on a foreign bridge */
+			if (foreign_dev_check_cb(dev, br))
+				return 0;
+
+			return __switchdev_handle_fdb_del_to_device(br, orig_dev,
+								    fdb_info, check_cb,
+								    foreign_dev_check_cb,
+								    del_cb, lag_del_cb);
+		}
+
+		return del_cb(dev, orig_dev, info->ctx, fdb_info);
+	}
+
+	/* If we passed over the foreign check, it means that the LAG interface
+	 * is offloaded.
+	 */
+	if (netif_is_lag_master(dev)) {
+		if (!lag_del_cb)
+			return -EOPNOTSUPP;
+
+		return lag_del_cb(dev, orig_dev, info->ctx, fdb_info);
+	}
+
+	/* Recurse through lower interfaces in case the FDB entry is pointing
+	 * towards a bridge device.
+	 */
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		/* Do not propagate FDB entries across bridges */
+		if (netif_is_bridge_master(lower_dev))
+			continue;
+
+		err = switchdev_handle_fdb_del_to_device(lower_dev, fdb_info,
+							 check_cb,
+							 foreign_dev_check_cb,
+							 del_cb, lag_del_cb);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	return err;
+}
+
+int switchdev_handle_fdb_del_to_device(struct net_device *dev,
+		const struct switchdev_notifier_fdb_info *fdb_info,
+		bool (*check_cb)(const struct net_device *dev),
+		bool (*foreign_dev_check_cb)(const struct net_device *dev,
+					     const struct net_device *foreign_dev),
+		int (*del_cb)(struct net_device *dev,
+			      const struct net_device *orig_dev, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info),
+		int (*lag_del_cb)(struct net_device *dev,
+				  const struct net_device *orig_dev, const void *ctx,
+				  const struct switchdev_notifier_fdb_info *fdb_info))
+{
+	int err;
+
+	err = __switchdev_handle_fdb_del_to_device(dev, dev, fdb_info,
+						   check_cb,
+						   foreign_dev_check_cb,
+						   del_cb, lag_del_cb);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(switchdev_handle_fdb_del_to_device);
+
 static int __switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
 			bool (*check_cb)(const struct net_device *dev),
-- 
2.25.1

