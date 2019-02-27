Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LyKdp20X8t4ovPHYE9CH/9hVrvQZYs4Dq33a5OBgkXM=;
	b=o2FA62BnB5vfqvE9uANqgGYsKnlq/OF2lifybXrCMuoNW4XtsgVRmOp+u9HsI0YXqO
	WMT7aAWUx2e5r7r9g6LDBn4ygH2remUJVlK9eE+HWJlOymjuN++uXBS/t/RUlFRMCp1p
	FwTXy2vwhRh3A128FH5egRyeWi/Uh/Dir+CnPlx2aRSdzk1rQAVPCLsM9zfd1i7eH69H
	Xvkk4iDSOFcncdFqRBWFOfFriAUyYJBMp3lVhy0q2jrwWzYkcI3wA5tBcFz0xGlY2jrl
	MTfu/Z2XEWScwpZC+CBxRLnNSCO4r7O0KrvibSPuAOS1RtZlyzUaehdgjQl8tFELCD/V
	1PGw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 26 Feb 2019 17:14:25 -0800
Message-Id: <20190227011427.16487-7-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 6/8] staging: fsl-dpaa2: ethsw: Handle
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
attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 018399ee8731..b0d2d9bf2532 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -929,6 +929,19 @@ static const struct switchdev_ops ethsw_port_switchdev_ops = {
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
+static int
+ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1047,6 +1060,12 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1115,6 +1134,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

