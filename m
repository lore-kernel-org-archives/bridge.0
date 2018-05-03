Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=KZve4E6JMjq0LnjeLoHA+veOmzzMp+nHCaNTxAYdU5Q=;
	b=VzCHr8ctwYPRxam+crHU/JjA4EDBkGcKpRMf6NGvQo0X3Qdt/x1rEDwgsd4IxmxBmty7Gen6iUfaHDWIBGvL5C/AT10BpWhn1ISKxvI9i4q8kiLk1X1FFMl8FlFk18ScVwC8A/DZw7+y4+Mhafn4J5PCz8pZIOu3+qnbPxiCFsY=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1525350809.git.petrm@mellanox.com>
References: <cover.1525350809.git.petrm@mellanox.com>
Message-Id: <36a671d4d30995902f5c3acc68cf8317f8ce05cb.1525350809.git.petrm@mellanox.com>
Date: Thu, 03 May 2018 14:43:46 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 1/2] switchdev: Add
 fdb.added_by_user to switchdev notifications
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

The following patch enables sending notifications also for events on FDB
entries that weren't added by the user. Give the drivers the information
necessary to distinguish between the two origins of FDB entries.

To maintain the current behavior, have switchdev-implementing drivers
bail out on notifications about non-user-added FDB entries. In case of
mlxsw driver, allow a call to mlxsw_sp_span_respin() so that SPAN over
bridge catches up with the changed FDB.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |  4 ++++
 drivers/net/ethernet/rocker/rocker_main.c                |  2 ++
 include/net/switchdev.h                                  |  1 +
 net/bridge/br_switchdev.c                                | 10 +++++++---
 net/dsa/slave.c                                          |  5 ++++-
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1af99fe..3973d90 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2270,6 +2270,8 @@ static void mlxsw_sp_switchdev_event_work(struct work_struct *work)
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		fdb_info = &switchdev_work->fdb_info;
+		if (!fdb_info->added_by_user)
+			break;
 		err = mlxsw_sp_port_fdb_set(mlxsw_sp_port, fdb_info, true);
 		if (err)
 			break;
@@ -2279,6 +2281,8 @@ static void mlxsw_sp_switchdev_event_work(struct work_struct *work)
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb_info = &switchdev_work->fdb_info;
+		if (!fdb_info->added_by_user)
+			break;
 		mlxsw_sp_port_fdb_set(mlxsw_sp_port, fdb_info, false);
 		break;
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE: /* fall through */
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 056cb60..152d694 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2783,6 +2783,8 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE: /* fall through */
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (!fdb_info->added_by_user)
+			break;
 		memcpy(&switchdev_work->fdb_info, ptr,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 39bc855..d574ce6 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -155,6 +155,7 @@ struct switchdev_notifier_fdb_info {
 	struct switchdev_notifier_info info; /* must be first */
 	const unsigned char *addr;
 	u16 vid;
+	bool added_by_user;
 };
 
 static inline struct net_device *
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee775f4..71a03c4 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -102,13 +102,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 
 static void
 br_switchdev_fdb_call_notifiers(bool adding, const unsigned char *mac,
-				u16 vid, struct net_device *dev)
+				u16 vid, struct net_device *dev,
+				bool added_by_user)
 {
 	struct switchdev_notifier_fdb_info info;
 	unsigned long notifier_type;
 
 	info.addr = mac;
 	info.vid = vid;
+	info.added_by_user = added_by_user;
 	notifier_type = adding ? SWITCHDEV_FDB_ADD_TO_DEVICE : SWITCHDEV_FDB_DEL_TO_DEVICE;
 	call_switchdev_notifiers(notifier_type, dev, &info.info);
 }
@@ -123,12 +125,14 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 	case RTM_DELNEIGH:
 		br_switchdev_fdb_call_notifiers(false, fdb->key.addr.addr,
 						fdb->key.vlan_id,
-						fdb->dst->dev);
+						fdb->dst->dev,
+						fdb->added_by_user);
 		break;
 	case RTM_NEWNEIGH:
 		br_switchdev_fdb_call_notifiers(true, fdb->key.addr.addr,
 						fdb->key.vlan_id,
-						fdb->dst->dev);
+						fdb->dst->dev,
+						fdb->added_by_user);
 		break;
 	}
 }
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index f3fb3a0..c287f1e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1441,6 +1441,7 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 				     unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct dsa_switchdev_event_work *switchdev_work;
 
 	if (!dsa_slave_dev_check(dev))
@@ -1458,8 +1459,10 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE: /* fall through */
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (!fdb_info->added_by_user)
+			break;
 		if (dsa_slave_switchdev_fdb_work_init(switchdev_work,
-						      ptr))
+						      fdb_info))
 			goto err_fdb_work_init;
 		dev_hold(dev);
 		break;
-- 
2.4.11

