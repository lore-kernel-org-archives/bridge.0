Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BqrkBPBZOpaqz5GXIcdMet1Dw1hbY5LkY4oijejMFis=;
	b=oDcSTu5Wgm7LNd8mow1o3qmHLWU/9uIdCKMHAQqm5Szth7y3Q0x5mYXKDuuRv32cE9
	epemrQQEOG5hHUlPuB5F2+ITDQ7BvdBIW2PyuWX4GR6rM6bUde1XzpZ72j+Vq1K6Y7eY
	iom/4PqJS2Akdmf84MoBtAfBqxvI0/81minDv5eaeHJ3CKXPabKuwdFNeOyHsIYoCj3Z
	VOYssfnDcFvCVoUGOytsNQJ6VyBjfswz/1ABoxXa1zf6GjLYcGlCGzH9t1zPNQWcr1se
	ykVeRuo876XZ8a4cvExPhHwMyWHhXdXDVUKu/WNUzTymW3vCQIONAQqCy1NB/SC8+nH5
	qTQw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 27 Feb 2019 11:44:25 -0800
Message-Id: <20190227194432.725-2-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 1/8] switchdev: Add
	SWITCHDEV_PORT_ATTR_SET
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

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   | 27 +++++++++++++++++++++
 net/switchdev/switchdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index be4b13e66668..5087c06ceb4b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -132,6 +132,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -160,6 +161,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
@@ -212,7 +220,15 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 			int (*del_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj));
 
+int switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans));
+
 #define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
+
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -299,6 +315,17 @@ switchdev_handle_port_obj_del(struct net_device *dev,
 	return 0;
 }
 
+static inline int
+switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	return 0;
+}
+
 #define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
 
 #endif
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 362413c9b389..3560c19aa7e2 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -655,3 +655,54 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(switchdev_handle_port_obj_del);
+
+static int __switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	struct net_device *lower_dev;
+	struct list_head *iter;
+	int err = -EOPNOTSUPP;
+
+	if (check_cb(dev)) {
+		port_attr_info->handled = true;
+		return set_cb(dev, port_attr_info->attr,
+			      port_attr_info->trans);
+	}
+
+	/* Switch ports might be stacked under e.g. a LAG. Ignore the
+	 * unsupported devices, another driver might be able to handle them. But
+	 * propagate to the callers any hard errors.
+	 *
+	 * If the driver does its own bookkeeping of stacked ports, it's not
+	 * necessary to go through this helper.
+	 */
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		err = __switchdev_handle_port_attr_set(lower_dev, port_attr_info,
+						       check_cb, set_cb);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	return err;
+}
+
+int switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	int err;
+
+	err = __switchdev_handle_port_attr_set(dev, port_attr_info, check_cb,
+					       set_cb);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+	return err;
+}
+EXPORT_SYMBOL_GPL(switchdev_handle_port_attr_set);
-- 
2.17.1

