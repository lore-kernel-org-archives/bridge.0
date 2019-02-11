Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bcLXrvybRxvEpRiDWi/DGfWF7hfDDl3K/0VgbGIyK88=;
	b=OUA1fDbKWOlIw6c+sWhOFHCM49ft0PxF5Fh7j/6krgbsrXP2V5Bi0pkEfrE8OBSkbB
	UpMWf+GXGgm6DBnt73I7sX4cpb28DRCmRUoqiT9b4Jk879+3mWJCEMg1jgToaAracHOJ
	0KQfVQ/nhHpqsStdlQiPFvwJ1A4OgE7V6Xu0wmc2RuEomd78io3O4Ha608P3pR8DfeGj
	VaBu1hXJ9LVf95/ClrRbDE+3iqq//vBFyleOIy07uxpTEGKAi2MW7H+25SNXb5SYYLuf
	0rtx1JUPUHMM0/mGmCJzBa0b6f8GnzkuSo2zfJJKpxn7RzlzaPDMo8IWkS5lp1b9JFZ9
	5Lmg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 11:09:55 -0800
Message-Id: <20190211191001.8623-4-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v4 3/9] rocker: Handle
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
rocker_port_attr_{set,get} calls.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..9a8fe49e32b6 100644
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
+	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
+	case SWITCHDEV_PORT_ATTR_GET:
+		return rocker_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

