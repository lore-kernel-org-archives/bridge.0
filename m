Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wimd3qSTtcutL9MgW1a48UHpmMTASo5reWM4eIi7Glc=;
	b=k5UbIQ13VqZ3BL2ym1HzyqN8gelLKnUG1ahX+KmacsaMxbdj+Wahazyx1y2S56kpG/
	VPxkISx+s2VkfDcg4FBfIzEcQI5MDP8pmE9av23YaK9fn/GxW/zN9ag7pKHEvpmaNe49
	FLHsS1EhLorSo1ZFkoqd3BH3t6YW2nUPEf+CSHj0pWUHYAQGs3YwaGWO6j5vhLt6Hntq
	/5Uyvkp9tgV5ujbv9bqZvFDtPRGhqPNUSy1/F3MjAL5Mc7VaFZdiVxrxnFwK2vy9aedA
	9L8f/fDrqET1lEtQlKx56ZMh70qefIQDh1X1eNkpAYd3Sr2Cd0hEE0F0QCvYs9gm9Ft+
	FvtQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 20:55:50 -0800
Message-Id: <20190216045556.3514-4-f.fainelli@gmail.com>
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 3/9] rocker: Handle
	SWITCHDEV_PORT_ATTR_GET/SET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
rocker_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..591008c8fa74 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2835,6 +2835,27 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
+				 struct switchdev_notifier_port_attr_info
+				 *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = rocker_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = rocker_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -2847,6 +2868,9 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return rocker_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

