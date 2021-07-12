Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKBM7Fl6q1XMHGHXHcaKF/ZFWalOLNVhEubPkfDeL4w=;
 b=f8OW6qD//2ld8FH9FLRr5yy1/9SLRXFAxM3wNxhJR6WCMYXmw3SarqI931pJYs0jdSAi0p/tsuflxbTPsPfqOir4Af9N4Zh1IRak/pFW6FkMrcZqaMhrVbznTRugywbxcRcJZT4Aorwij0CbVNNE8pvRJHAX2ropJuV9XRWEjp0=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:31 +0300
Message-Id: <20210712152142.800651-14-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 13/24] net: bridge: use the public
	notifier chain for br_fdb_replay
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

Currently, switchdev users of br_fdb_replay pass a pointer to their
atomic notifier block for the bridge to replay the FDB entries on the
port and local to the bridge, and the bridge whispers those FDB entries
to that driver only, and not publicly on the switchdev atomic notifier
call chain.

Going forward we would like to introduce push-mode FDB replays for all
switchdev drivers, and there are at least two reasons why the current
setup is not ideal.

First and most obvious, every driver would have to be changed to pass
its atomic notifier block to the switchdev_bridge_port_offload() and
switchdev_bridge_port_unoffload() calls, which gets a bit cumbersome.

The second is that it wasn't a good idea in the first place for the
other switchdev drivers to not hear anything about the FDB entries on
foreign interfaces. For example, DSA treats these FDB entries in a
special way since commit 3068d466a67e ("net: dsa: sync static FDB
entries on foreign interfaces to hardware"). With the static FDB entry
addition being public on everybody's notifier block but the deletion
being whispered only to the driver whose port leaves the bridge, DSA
would have a lingering static FDB entry pointing towards the host.

Making br_fdb_replay() use the atomic switchdev call chain solves both
problems.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/if_bridge.h |  4 ++--
 net/bridge/br_fdb.c       | 43 +++++++--------------------------------
 net/dsa/dsa_priv.h        |  1 -
 net/dsa/port.c            | 10 ++++-----
 net/dsa/slave.c           |  2 +-
 5 files changed, 14 insertions(+), 46 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 13acc1ff476c..8d4a157d249d 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -168,7 +168,7 @@ bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 u8 br_port_get_stp_state(const struct net_device *dev);
 clock_t br_get_ageing_time(const struct net_device *br_dev);
 int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
-		  bool adding, struct notifier_block *nb);
+		  bool adding);
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -200,7 +200,7 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 
 static inline int br_fdb_replay(const struct net_device *br_dev,
 				const struct net_device *dev,
-				bool adding, struct notifier_block *nb)
+				bool adding)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c93a2b3a0ad8..4434aee4cfbc 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -732,31 +732,12 @@ static inline size_t fdb_nlmsg_size(void)
 		+ nla_total_size(sizeof(u8)); /* NFEA_ACTIVITY_NOTIFY */
 }
 
-static int br_fdb_replay_one(struct notifier_block *nb,
-			     const struct net_bridge_fdb_entry *fdb,
-			     struct net_device *dev, unsigned long action)
-{
-	struct switchdev_notifier_fdb_info item;
-	int err;
-
-	item.addr = fdb->key.addr.addr;
-	item.vid = fdb->key.vlan_id;
-	item.added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-	item.offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
-	item.is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
-	item.info.dev = dev;
-
-	err = nb->notifier_call(nb, action, &item);
-	return notifier_to_errno(err);
-}
-
 int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
-		  bool adding, struct notifier_block *nb)
+		  bool adding)
 {
 	struct net_bridge_fdb_entry *fdb;
 	struct net_bridge *br;
-	unsigned long action;
-	int err = 0;
+	int type;
 
 	if (!netif_is_bridge_master(br_dev))
 		return -EINVAL;
@@ -767,28 +748,18 @@ int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
 	br = netdev_priv(br_dev);
 
 	if (adding)
-		action = SWITCHDEV_FDB_ADD_TO_DEVICE;
+		type = RTM_NEWNEIGH;
 	else
-		action = SWITCHDEV_FDB_DEL_TO_DEVICE;
+		type = RTM_DELNEIGH;
 
 	rcu_read_lock();
 
-	hlist_for_each_entry_rcu(fdb, &br->fdb_list, fdb_node) {
-		const struct net_bridge_port *dst = READ_ONCE(fdb->dst);
-		struct net_device *dst_dev;
-
-		dst_dev = dst ? dst->dev : br->dev;
-		if (dst_dev != br_dev && dst_dev != dev)
-			continue;
-
-		err = br_fdb_replay_one(nb, fdb, dst_dev, action);
-		if (err)
-			break;
-	}
+	hlist_for_each_entry_rcu(fdb, &br->fdb_list, fdb_node)
+		br_switchdev_fdb_notify(br, fdb, type);
 
 	rcu_read_unlock();
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(br_fdb_replay);
 
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f201c33980bf..20003512d8f8 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -285,7 +285,6 @@ static inline bool dsa_tree_offloads_bridge_port(struct dsa_switch_tree *dst,
 
 /* slave.c */
 extern const struct dsa_device_ops notag_netdev_ops;
-extern struct notifier_block dsa_slave_switchdev_notifier;
 extern struct notifier_block dsa_slave_switchdev_blocking_notifier;
 
 void dsa_slave_mii_bus_init(struct dsa_switch *ds);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 34b7f64348c2..ccf11bc518fe 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -200,13 +200,12 @@ static int dsa_port_switchdev_sync(struct dsa_port *dp,
 		return err;
 
 	/* Forwarding and termination FDB entries on the port */
-	err = br_fdb_replay(br, brport_dev, true,
-			    &dsa_slave_switchdev_notifier);
+	err = br_fdb_replay(br, brport_dev, true);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
 	/* Termination FDB entries on the bridge itself */
-	err = br_fdb_replay(br, br, true, &dsa_slave_switchdev_notifier);
+	err = br_fdb_replay(br, br, true);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
@@ -232,13 +231,12 @@ static int dsa_port_switchdev_unsync_objs(struct dsa_port *dp,
 		return err;
 
 	/* Forwarding and termination FDB entries on the port */
-	err = br_fdb_replay(br, brport_dev, false,
-			    &dsa_slave_switchdev_notifier);
+	err = br_fdb_replay(br, brport_dev, false);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
 	/* Termination FDB entries on the bridge itself */
-	err = br_fdb_replay(br, br, false, &dsa_slave_switchdev_notifier);
+	err = br_fdb_replay(br, br, false);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ffbba1e71551..461c80bc066a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2517,7 +2517,7 @@ static struct notifier_block dsa_slave_nb __read_mostly = {
 	.notifier_call  = dsa_slave_netdevice_event,
 };
 
-struct notifier_block dsa_slave_switchdev_notifier = {
+static struct notifier_block dsa_slave_switchdev_notifier = {
 	.notifier_call = dsa_slave_switchdev_event,
 };
 
-- 
2.25.1

