Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oBI12FenCDDfRE6eSCrjheZca+vUirHEjPRbN/cZFcI=;
	b=nNH3vmPNCqA5lArtC+jLENEEu0G2foBRlxxfiElJzRy/33NReasyZgmXnLw+uN4PuP
	2bgZaG7MLeswvSWoshu6mjKi4BBFZIR6gvz8nbqNOQLvtKskRaoOMYUSwDVToSMZDqHE
	eMNOteNFHw/w4lKuTz63z/XNLppIxCqQ4LGkrh579tQxnx4PUMT+PCiyMimreMffkQWS
	HPekdwFdcpn8A+HfwYSu3LZ/XI31m0erYxk5/gxLdV+pu1kiMDCmVGQ8yLSkzUAV1w71
	VC/P3YKZDNfC84nhm3QS7ndAA6ZmepATDtYjviPTsVG0yfDGkg9te5DxtL5ReuD5L2n1
	ZzJA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 22 Feb 2019 15:59:19 -0800
Message-Id: <20190222235927.10295-2-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
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
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   | 27 +++++++++++++++++++++
 net/switchdev/switchdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 45310ddf2d7e..ca56b7487540 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -136,6 +136,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -164,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
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
@@ -216,7 +224,15 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
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
@@ -303,6 +319,17 @@ switchdev_handle_port_obj_del(struct net_device *dev,
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
index 7e1357db33d7..94400f5b8e07 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -697,3 +697,54 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
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

