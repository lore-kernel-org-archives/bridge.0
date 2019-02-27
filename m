Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
	b=Kq+GvGKF34FGKEtRSFVfLhm6jO6TuOKRh0qVtw9NvnM+5ST5rdAdvJ8zRejVB7DtIv
	53Jn+RX2v3RPsEXNOoyTMQps3aAUDw49WbeE70Ujhe7epx8R29fFvPQMkYRuf/hyaLzB
	E8KGL2kyfHLznSdoilwgQpLdx5d45bKV3ax+I2YgJqn/DgSxwbKDhejDDyFUXBag/8h4
	assRohbRzP01vow9av3BYtuGKU9qEVbNX64o2qmG7r6Lq6BUYuagUBldAH8hi4iYELLc
	w6X/35T36JVEDZjOL0YhS1APyH9dgs/xp793WGKtxaRkZi69nZVkL5zgULeIVIsqIv0M
	C+lA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 26 Feb 2019 17:14:21 -0800
Message-Id: <20190227011427.16487-3-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 2/8] rocker: Handle
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

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
rocker_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 309a6bf9130c..fc772cf079cc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2710,6 +2710,19 @@ static bool rocker_port_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &rocker_port_netdev_ops;
 }
 
+static int
+rocker_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = rocker_port_attr_set(netdev, port_attr_info->attr,
+				   port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct rocker_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -2779,6 +2792,9 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 	if (!rocker_port_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
+
 	rocker_port = netdev_priv(dev);
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (WARN_ON(!switchdev_work))
@@ -2841,6 +2857,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

