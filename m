Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ZwB8h2us0ABt7cEto8hppA/4dpgdBopoyjYPvxdb4=;
 b=FHuWGCJxIoa6ocgaKZLiF7b3TLIFriOlI43fO6WpcP5MJJzXy8R2ifiYVUSznN+YyDjzbOkFQCArQ2ovEkWflk5Er1AOqy0hnd3KjC1CyY9MGL/pDxPBKNTaBddZ6uVvdUxhkWKjHP+mlXn0JORrWblHxtN9YU3VBTwcKLG4V3U=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:33 +0300
Message-Id: <20210712152142.800651-16-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 15/24] net: bridge: propagate ctx
	to switchdev_port_obj_{add, del}
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

We would like to make br_mdb_replay() and br_vlan_replay() use the
public switchdev blocking notifier chain, and in order for that to
happen, we need to pass the void *ctx pointer that the replay helpers
use through switchdev_port_obj_add() and switchdev_port_obj_del().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/switchdev.h       |  8 ++++++--
 net/bridge/br_mdb.c           | 10 ++++++----
 net/bridge/br_mrp_switchdev.c | 20 +++++++++++---------
 net/bridge/br_switchdev.c     |  4 ++--
 net/switchdev/switchdev.c     | 30 +++++++++++++++++++-----------
 5 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 68face5dca91..edc6670ed867 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -246,9 +246,11 @@ int switchdev_port_attr_set(struct net_device *dev,
 			    struct netlink_ext_ack *extack);
 int switchdev_port_obj_add(struct net_device *dev,
 			   const struct switchdev_obj *obj,
+			   const void *ctx,
 			   struct netlink_ext_ack *extack);
 int switchdev_port_obj_del(struct net_device *dev,
-			   const struct switchdev_obj *obj);
+			   const struct switchdev_obj *obj,
+			   const void *ctx);
 
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
@@ -296,13 +298,15 @@ static inline int switchdev_port_attr_set(struct net_device *dev,
 
 static inline int switchdev_port_obj_add(struct net_device *dev,
 					 const struct switchdev_obj *obj,
+					 const void *ctx,
 					 struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline int switchdev_port_obj_del(struct net_device *dev,
-					 const struct switchdev_obj *obj)
+					 const struct switchdev_obj *obj,
+					 const void *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 17a720b4473f..209aea7de6a8 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -705,10 +705,10 @@ static void br_mdb_switchdev_host_port(struct net_device *dev,
 
 	switch (type) {
 	case RTM_NEWMDB:
-		switchdev_port_obj_add(lower_dev, &mdb.obj, NULL);
+		switchdev_port_obj_add(lower_dev, &mdb.obj, NULL, NULL);
 		break;
 	case RTM_DELMDB:
-		switchdev_port_obj_del(lower_dev, &mdb.obj);
+		switchdev_port_obj_del(lower_dev, &mdb.obj, NULL);
 		break;
 	}
 }
@@ -752,11 +752,13 @@ void br_mdb_notify(struct net_device *dev,
 			complete_info->ip = mp->addr;
 			mdb.obj.complete_priv = complete_info;
 			mdb.obj.complete = br_mdb_complete;
-			if (switchdev_port_obj_add(pg->key.port->dev, &mdb.obj, NULL))
+			if (switchdev_port_obj_add(pg->key.port->dev, &mdb.obj,
+						   NULL, NULL))
 				kfree(complete_info);
 			break;
 		case RTM_DELMDB:
-			switchdev_port_obj_del(pg->key.port->dev, &mdb.obj);
+			switchdev_port_obj_del(pg->key.port->dev, &mdb.obj,
+					       NULL);
 			break;
 		}
 	} else {
diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
index cb54b324fa8c..4fb1f6c57db9 100644
--- a/net/bridge/br_mrp_switchdev.c
+++ b/net/bridge/br_mrp_switchdev.c
@@ -11,9 +11,9 @@ br_mrp_switchdev_port_obj(struct net_bridge *br,
 	int err;
 
 	if (add)
-		err = switchdev_port_obj_add(br->dev, obj, NULL);
+		err = switchdev_port_obj_add(br->dev, obj, NULL, NULL);
 	else
-		err = switchdev_port_obj_del(br->dev, obj);
+		err = switchdev_port_obj_del(br->dev, obj, NULL);
 
 	/* In case of success just return and notify the SW that doesn't need
 	 * to do anything
@@ -42,7 +42,7 @@ int br_mrp_switchdev_add(struct net_bridge *br, struct br_mrp *mrp)
 	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
 		return 0;
 
-	return switchdev_port_obj_add(br->dev, &mrp_obj.obj, NULL);
+	return switchdev_port_obj_add(br->dev, &mrp_obj.obj, NULL, NULL);
 }
 
 int br_mrp_switchdev_del(struct net_bridge *br, struct br_mrp *mrp)
@@ -88,9 +88,10 @@ br_mrp_switchdev_set_ring_role(struct net_bridge *br, struct br_mrp *mrp,
 	 */
 	mrp_role.sw_backup = true;
 	if (role != BR_MRP_RING_ROLE_DISABLED)
-		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
+		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL,
+					     NULL);
 	else
-		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
+		err = switchdev_port_obj_del(br->dev, &mrp_role.obj, NULL);
 
 	if (!err)
 		return BR_MRP_SW;
@@ -133,7 +134,7 @@ int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
 	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
 		return 0;
 
-	return switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
+	return switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL, NULL);
 }
 
 enum br_mrp_hw_support
@@ -166,9 +167,10 @@ br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
 	 */
 	mrp_role.sw_backup = true;
 	if (role != BR_MRP_IN_ROLE_DISABLED)
-		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
+		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL,
+					     NULL);
 	else
-		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
+		err = switchdev_port_obj_del(br->dev, &mrp_role.obj, NULL);
 
 	if (!err)
 		return BR_MRP_SW;
@@ -189,7 +191,7 @@ int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
 	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
 		return 0;
 
-	return switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
+	return switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL, NULL);
 }
 
 enum br_mrp_hw_support
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index e335cbcc8ce5..c961d86bc323 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -111,7 +111,7 @@ int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 		.vid = vid,
 	};
 
-	return switchdev_port_obj_add(dev, &v.obj, extack);
+	return switchdev_port_obj_add(dev, &v.obj, NULL, extack);
 }
 
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
@@ -122,7 +122,7 @@ int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 		.vid = vid,
 	};
 
-	return switchdev_port_obj_del(dev, &v.obj);
+	return switchdev_port_obj_del(dev, &v.obj, NULL);
 }
 
 static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7b20b4b50474..bbb187bc0ef5 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -38,9 +38,11 @@ struct switchdev_deferred_item {
 static int
 call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				  struct switchdev_notifier_info *info,
+				  const void *ctx,
 				  struct netlink_ext_ack *extack)
 {
 	info->dev = dev;
+	info->ctx = ctx;
 	info->extack = extack;
 	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
 					    val, info);
@@ -125,8 +127,8 @@ static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
 		.handled = false,
 	};
 
-	rc = call_switchdev_blocking_notifiers(nt, dev,
-					       &attr_info.info, extack);
+	rc = call_switchdev_blocking_notifiers(nt, dev, &attr_info.info,
+					       NULL, extack);
 	err = notifier_to_errno(rc);
 	if (err) {
 		WARN_ON(!attr_info.handled);
@@ -207,6 +209,7 @@ static size_t switchdev_obj_size(const struct switchdev_obj *obj)
 static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
 				     struct net_device *dev,
 				     const struct switchdev_obj *obj,
+				     const void *ctx,
 				     struct netlink_ext_ack *extack)
 {
 	int rc;
@@ -217,7 +220,8 @@ static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
 		.handled = false,
 	};
 
-	rc = call_switchdev_blocking_notifiers(nt, dev, &obj_info.info, extack);
+	rc = call_switchdev_blocking_notifiers(nt, dev, &obj_info.info, ctx,
+					       extack);
 	err = notifier_to_errno(rc);
 	if (err) {
 		WARN_ON(!obj_info.handled);
@@ -236,7 +240,7 @@ static void switchdev_port_obj_add_deferred(struct net_device *dev,
 
 	ASSERT_RTNL();
 	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
-					dev, obj, NULL);
+					dev, obj, NULL, NULL);
 	if (err && err != -EOPNOTSUPP)
 		netdev_err(dev, "failed (err=%d) to add object (id=%d)\n",
 			   err, obj->id);
@@ -256,28 +260,30 @@ static int switchdev_port_obj_add_defer(struct net_device *dev,
  *
  *	@dev: port device
  *	@obj: object to add
+ *	@ctx: driver private data in case of bridge port with multiple lowers
  *	@extack: netlink extended ack
  *
  *	rtnl_lock must be held and must not be in atomic section,
  *	in case SWITCHDEV_F_DEFER flag is not set.
  */
 int switchdev_port_obj_add(struct net_device *dev,
-			   const struct switchdev_obj *obj,
+			   const struct switchdev_obj *obj, const void *ctx,
 			   struct netlink_ext_ack *extack)
 {
 	if (obj->flags & SWITCHDEV_F_DEFER)
 		return switchdev_port_obj_add_defer(dev, obj);
 	ASSERT_RTNL();
 	return switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
-					 dev, obj, extack);
+					 dev, obj, ctx, extack);
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_add);
 
 static int switchdev_port_obj_del_now(struct net_device *dev,
-				      const struct switchdev_obj *obj)
+				      const struct switchdev_obj *obj,
+				      const void *ctx)
 {
 	return switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_DEL,
-					 dev, obj, NULL);
+					 dev, obj, ctx, NULL);
 }
 
 static void switchdev_port_obj_del_deferred(struct net_device *dev,
@@ -286,7 +292,7 @@ static void switchdev_port_obj_del_deferred(struct net_device *dev,
 	const struct switchdev_obj *obj = data;
 	int err;
 
-	err = switchdev_port_obj_del_now(dev, obj);
+	err = switchdev_port_obj_del_now(dev, obj, NULL);
 	if (err && err != -EOPNOTSUPP)
 		netdev_err(dev, "failed (err=%d) to del object (id=%d)\n",
 			   err, obj->id);
@@ -306,17 +312,19 @@ static int switchdev_port_obj_del_defer(struct net_device *dev,
  *
  *	@dev: port device
  *	@obj: object to delete
+ *	@ctx: driver private data in case of bridge port with multiple lowers
  *
  *	rtnl_lock must be held and must not be in atomic section,
  *	in case SWITCHDEV_F_DEFER flag is not set.
  */
 int switchdev_port_obj_del(struct net_device *dev,
-			   const struct switchdev_obj *obj)
+			   const struct switchdev_obj *obj,
+			   const void *ctx)
 {
 	if (obj->flags & SWITCHDEV_F_DEFER)
 		return switchdev_port_obj_del_defer(dev, obj);
 	ASSERT_RTNL();
-	return switchdev_port_obj_del_now(dev, obj);
+	return switchdev_port_obj_del_now(dev, obj, ctx);
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
-- 
2.25.1

