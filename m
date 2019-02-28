Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=EVF8TFklj6ku/SWCRFvN/VHaP/kvLrKr8It+KHGLIuE=;
	b=VZz8gwzp+jpZgsquSGWjD03qxBlj242+yQvW+ZBvEHaHOaH7nXa2L7Cdqse686+NX3
	a4I7m91pkpJawf1jx33uIPsrrPwQrhsNzR4iUfVhNEe3A4Oq7hTnklevnNSMXRCB38kK
	DIUeUablNA1k3auZVTn/zRFyfyGKhz7AwzMOlBzKhLm9RZQHOsk1II1cAPLiA1S3/x0q
	pilRAq3zc1iFHmCIctFXne8kRUTNLywpe/oSQ0yRyawIADurO9ak3uquaf1Ml5IdvNo2
	vez0mf9rd3fnUd5BUNxYH/152SNvtC/gFmhif1cJkwPiSO5oBppRqbJ8aZ5GAup99DoD
	NJCg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 27 Feb 2019 16:29:16 -0800
Message-Id: <20190228002916.24904-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next] switchdev: Remove unused transaction item
	queue
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

There are no more in tree users of the
switchdev_trans_item_{dequeue,enqueue} or switchdev_trans_item structure
in the kernel since commit 00fc0c51e35b ("rocker: Change world_ops API
and implementation to be switchdev independant").

Remove this unused code and update the documentation accordingly since.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt |  19 -----
 include/net/switchdev.h                |  12 ---
 net/switchdev/switchdev.c              | 100 +------------------------
 3 files changed, 2 insertions(+), 129 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index 633dd1fd81b7..86174ce8cd13 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -371,22 +371,3 @@ The driver can monitor for updates to arp_tbl using the netevent notifier
 NETEVENT_NEIGH_UPDATE.  The device can be programmed with resolved nexthops
 for the routes as arp_tbl updates.  The driver implements ndo_neigh_destroy
 to know when arp_tbl neighbor entries are purged from the port.
-
-Transaction item queue
-^^^^^^^^^^^^^^^^^^^^^^
-
-For switchdev ops attr_set and obj_add, there is a 2 phase transaction model
-used. First phase is to "prepare" anything needed, including various checks,
-memory allocation, etc. The goal is to handle the stuff that is not unlikely
-to fail here. The second phase is to "commit" the actual changes.
-
-Switchdev provides an infrastructure for sharing items (for example memory
-allocations) between the two phases.
-
-The object created by a driver in "prepare" phase and it is queued up by:
-switchdev_trans_item_enqueue()
-During the "commit" phase, the driver gets the object by:
-switchdev_trans_item_dequeue()
-
-If a transaction is aborted during "prepare" phase, switchdev code will handle
-cleanup of the queued-up objects.
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index e4f751e19ecf..0ebd67ae7012 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -20,14 +20,7 @@
 #define SWITCHDEV_F_SKIP_EOPNOTSUPP	BIT(1)
 #define SWITCHDEV_F_DEFER		BIT(2)
 
-struct switchdev_trans_item {
-	struct list_head list;
-	void *data;
-	void (*destructor)(const void *data);
-};
-
 struct switchdev_trans {
-	struct list_head item_list;
 	bool ph_prepare;
 };
 
@@ -105,11 +98,6 @@ struct switchdev_obj_port_mdb {
 #define SWITCHDEV_OBJ_PORT_MDB(OBJ) \
 	container_of((OBJ), struct switchdev_obj_port_mdb, obj)
 
-void switchdev_trans_item_enqueue(struct switchdev_trans *trans,
-				  void *data, void (*destructor)(void const *),
-				  struct switchdev_trans_item *tritem);
-void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
-
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
 enum switchdev_notifier_type {
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index d81cfcee9ad9..90ba4a1f0a6d 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -23,78 +23,6 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
-/**
- *	switchdev_trans_item_enqueue - Enqueue data item to transaction queue
- *
- *	@trans: transaction
- *	@data: pointer to data being queued
- *	@destructor: data destructor
- *	@tritem: transaction item being queued
- *
- *	Enqeueue data item to transaction queue. tritem is typically placed in
- *	cointainter pointed at by data pointer. Destructor is called on
- *	transaction abort and after successful commit phase in case
- *	the caller did not dequeue the item before.
- */
-void switchdev_trans_item_enqueue(struct switchdev_trans *trans,
-				  void *data, void (*destructor)(void const *),
-				  struct switchdev_trans_item *tritem)
-{
-	tritem->data = data;
-	tritem->destructor = destructor;
-	list_add_tail(&tritem->list, &trans->item_list);
-}
-EXPORT_SYMBOL_GPL(switchdev_trans_item_enqueue);
-
-static struct switchdev_trans_item *
-__switchdev_trans_item_dequeue(struct switchdev_trans *trans)
-{
-	struct switchdev_trans_item *tritem;
-
-	if (list_empty(&trans->item_list))
-		return NULL;
-	tritem = list_first_entry(&trans->item_list,
-				  struct switchdev_trans_item, list);
-	list_del(&tritem->list);
-	return tritem;
-}
-
-/**
- *	switchdev_trans_item_dequeue - Dequeue data item from transaction queue
- *
- *	@trans: transaction
- */
-void *switchdev_trans_item_dequeue(struct switchdev_trans *trans)
-{
-	struct switchdev_trans_item *tritem;
-
-	tritem = __switchdev_trans_item_dequeue(trans);
-	BUG_ON(!tritem);
-	return tritem->data;
-}
-EXPORT_SYMBOL_GPL(switchdev_trans_item_dequeue);
-
-static void switchdev_trans_init(struct switchdev_trans *trans)
-{
-	INIT_LIST_HEAD(&trans->item_list);
-}
-
-static void switchdev_trans_items_destroy(struct switchdev_trans *trans)
-{
-	struct switchdev_trans_item *tritem;
-
-	while ((tritem = __switchdev_trans_item_dequeue(trans)))
-		tritem->destructor(tritem->data);
-}
-
-static void switchdev_trans_items_warn_destroy(struct net_device *dev,
-					       struct switchdev_trans *trans)
-{
-	WARN(!list_empty(&trans->item_list), "%s: transaction item queue is not empty.\n",
-	     dev->name);
-	switchdev_trans_items_destroy(trans);
-}
-
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
@@ -208,8 +136,6 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	struct switchdev_trans trans;
 	int err;
 
-	switchdev_trans_init(&trans);
-
 	/* Phase I: prepare for attr set. Driver/device should fail
 	 * here if there are going to be issues in the commit phase,
 	 * such as lack of resources or support.  The driver/device
@@ -220,17 +146,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	trans.ph_prepare = true;
 	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
 					 &trans);
-	if (err) {
-		/* Prepare phase failed: abort the transaction.  Any
-		 * resources reserved in the prepare phase are
-		 * released.
-		 */
-
-		if (err != -EOPNOTSUPP)
-			switchdev_trans_items_destroy(&trans);
-
+	if (err)
 		return err;
-	}
 
 	/* Phase II: commit attr set.  This cannot fail as a fault
 	 * of driver/device.  If it does, it's a bug in the driver/device
@@ -242,7 +159,6 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
-	switchdev_trans_items_warn_destroy(dev, &trans);
 
 	return err;
 }
@@ -341,8 +257,6 @@ static int switchdev_port_obj_add_now(struct net_device *dev,
 
 	ASSERT_RTNL();
 
-	switchdev_trans_init(&trans);
-
 	/* Phase I: prepare for obj add. Driver/device should fail
 	 * here if there are going to be issues in the commit phase,
 	 * such as lack of resources or support.  The driver/device
@@ -353,17 +267,8 @@ static int switchdev_port_obj_add_now(struct net_device *dev,
 	trans.ph_prepare = true;
 	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
 					dev, obj, &trans, extack);
-	if (err) {
-		/* Prepare phase failed: abort the transaction.  Any
-		 * resources reserved in the prepare phase are
-		 * released.
-		 */
-
-		if (err != -EOPNOTSUPP)
-			switchdev_trans_items_destroy(&trans);
-
+	if (err)
 		return err;
-	}
 
 	/* Phase II: commit obj add.  This cannot fail as a fault
 	 * of driver/device.  If it does, it's a bug in the driver/device
@@ -374,7 +279,6 @@ static int switchdev_port_obj_add_now(struct net_device *dev,
 	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
 					dev, obj, &trans, extack);
 	WARN(err, "%s: Commit of object (id=%d) failed.\n", dev->name, obj->id);
-	switchdev_trans_items_warn_destroy(dev, &trans);
 
 	return err;
 }
-- 
2.17.1

