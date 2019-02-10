Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9fkZ8Pbunho/ROChBNcoRtJbkTRL9WKmA1WtJKIo9O4=;
	b=qDmhKikDDNTrsUJq3gj07F1+SEgorzAwYbmXFSZaille2smNGYGbr5ImIGdZZc6cED
	WH1B7zXuCRAWeiW3qS2j40hqhj12cQqhbuMNRbLoISs2AZheDJPsL3zBKmLRCbOzqTdN
	Fnh0QoOLfFFjl2Zy6zKaf0/8cmlNCQHV+SLbTwy+zbwZ01cDF/Ea/kGhwyk/8FrI56z9
	fI5oYUtIqlYldZuZnpZpog6L4+6EAKvcshlI+02L2zTQSgmH3WPWFbYsE1L+PsxRgGY7
	A9Zv0K7zVGW6BkPg02HSQrGqBuv9hDmfOc4WxWKx/2GRZ3Lvqn/1HDAq2BAeRumJkGZ5
	oqeg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 15:40:04 -0800
Message-Id: <20190210234007.16173-7-f.fainelli@gmail.com>
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 6/9] staging: fsl-dpaa2: ethsw: Handle
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

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
swdev_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..bc9e7de07200 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1111,6 +1111,27 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = swdev_port_attr_set(netdev, port_attr_info->attr,
+					  port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = swdev_port_attr_get(netdev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1123,6 +1144,9 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return ethsw_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

