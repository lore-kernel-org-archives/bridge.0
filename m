Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVuzK7reJCuI4yRzD9WG98378U703iZhMxQNX+fD/gs=;
 b=UYM/yjg5dQDUM2scXlqIp090obfJHKa+ao78wQVIahHJZbch7tjdBqF8Lq44aBQiURmciguQMlOMjEbbblWPAQbu3fTDXdG3HalEF1Trb8XRFJ7aOGF1gwga8rbuSPI1W93utfssWUTI6W0iGz/PRPWtfhJtcQEWcWxHqtqt5uw=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:35 +0300
Message-Id: <20210712152142.800651-18-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 17/24] net: bridge: replay mdb
	entries on the public switchdev notifier chain
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

In preparation of making br_mdb_replay() be called automatically for
every switchdev driver, we need to drop the extra argument to the
blocking notifier block so it becomes a less bureaucratic process, and
just emit the replayed events on the public chain.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_net.c |  3 +-
 include/linux/if_bridge.h              |  6 ++--
 net/bridge/br_mdb.c                    | 40 +++++++++++++-------------
 net/dsa/port.c                         |  6 ++--
 4 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index dcb393a35c0e..863437990f92 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1175,8 +1175,7 @@ static int ocelot_switchdev_sync(struct ocelot *ocelot, int port,
 	ageing_time = br_get_ageing_time(bridge_dev);
 	ocelot_port_attr_ageing_set(ocelot, port, ageing_time);
 
-	err = br_mdb_replay(bridge_dev, brport_dev, priv, true,
-			    &ocelot_switchdev_blocking_nb, extack);
+	err = br_mdb_replay(bridge_dev, brport_dev, priv, true, extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 8d4a157d249d..c7ed22b22256 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -71,8 +71,7 @@ bool br_multicast_has_router_adjacent(struct net_device *dev, int proto);
 bool br_multicast_enabled(const struct net_device *dev);
 bool br_multicast_router(const struct net_device *dev);
 int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
-		  const void *ctx, bool adding, struct notifier_block *nb,
-		  struct netlink_ext_ack *extack);
+		  const void *ctx, bool adding, struct netlink_ext_ack *extack);
 #else
 static inline int br_multicast_list_adjacent(struct net_device *dev,
 					     struct list_head *br_ip_list)
@@ -106,8 +105,7 @@ static inline bool br_multicast_router(const struct net_device *dev)
 }
 static inline int br_mdb_replay(const struct net_device *br_dev,
 				const struct net_device *dev, const void *ctx,
-				bool adding, struct notifier_block *nb,
-				struct netlink_ext_ack *extack)
+				bool adding, struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 209aea7de6a8..7753510a2099 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -566,23 +566,25 @@ static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
 	mdb->vid = mp->addr.vid;
 }
 
-static int br_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
+static int br_mdb_replay_one(struct net_device *dev,
 			     const struct switchdev_obj_port_mdb *mdb,
-			     unsigned long action, const void *ctx,
+			     int type, const void *ctx,
 			     struct netlink_ext_ack *extack)
 {
-	struct switchdev_notifier_port_obj_info obj_info = {
-		.info = {
-			.dev = dev,
-			.extack = extack,
-			.ctx = ctx,
-		},
-		.obj = &mdb->obj,
-	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
-	return notifier_to_errno(err);
+	switch (type) {
+	case RTM_NEWMDB:
+		err = switchdev_port_obj_add(dev, &mdb->obj, ctx, extack);
+		break;
+	case RTM_DELMDB:
+		err = switchdev_port_obj_del(dev, &mdb->obj, ctx);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
 }
 
 static int br_mdb_queue_one(struct list_head *mdb_list,
@@ -605,15 +607,13 @@ static int br_mdb_queue_one(struct list_head *mdb_list,
 }
 
 int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
-		  const void *ctx, bool adding, struct notifier_block *nb,
-		  struct netlink_ext_ack *extack)
+		  const void *ctx, bool adding, struct netlink_ext_ack *extack)
 {
 	const struct net_bridge_mdb_entry *mp;
 	struct switchdev_obj *obj, *tmp;
 	struct net_bridge *br;
-	unsigned long action;
 	LIST_HEAD(mdb_list);
-	int err = 0;
+	int type, err = 0;
 
 	ASSERT_RTNL();
 
@@ -667,13 +667,13 @@ int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 	rcu_read_unlock();
 
 	if (adding)
-		action = SWITCHDEV_PORT_OBJ_ADD;
+		type = RTM_NEWMDB;
 	else
-		action = SWITCHDEV_PORT_OBJ_DEL;
+		type = RTM_DELMDB;
 
 	list_for_each_entry(obj, &mdb_list, list) {
-		err = br_mdb_replay_one(nb, dev, SWITCHDEV_OBJ_PORT_MDB(obj),
-					action, ctx, extack);
+		err = br_mdb_replay_one(dev, SWITCHDEV_OBJ_PORT_MDB(obj),
+					type, ctx, extack);
 		if (err)
 			goto out_free_mdb;
 	}
diff --git a/net/dsa/port.c b/net/dsa/port.c
index ccf11bc518fe..c86121e9d87d 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -194,8 +194,7 @@ static int dsa_port_switchdev_sync(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	err = br_mdb_replay(br, brport_dev, dp, true,
-			    &dsa_slave_switchdev_blocking_notifier, extack);
+	err = br_mdb_replay(br, brport_dev, dp, true, extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
@@ -225,8 +224,7 @@ static int dsa_port_switchdev_unsync_objs(struct dsa_port *dp,
 	int err;
 
 	/* Delete the switchdev objects left on this port */
-	err = br_mdb_replay(br, brport_dev, dp, false,
-			    &dsa_slave_switchdev_blocking_notifier, extack);
+	err = br_mdb_replay(br, brport_dev, dp, false, extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-- 
2.25.1

