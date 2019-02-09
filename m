Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MJWvt+TdfuA/uy8voeT4xQktPEVBZvrAuPqf9sc140s=;
	b=vJVK4lxH055RhItDTzBGcEY1DHlc7v3DXDJXqXJT9gPkVfk2izDo5OfUFtiKlAdIB5
	u6dDWGr17KvVTEKljFxSJ7qW1Saf3w0h55czcl2X6aJHcM+OFNZSefebotHy5L0G8dN0
	jgaXaVitMdYGBd5B0PCOs8aQUovCHmBOEjlbw8w6pPp0lVFr9VfwPZ5y9cMnu0+HkAsG
	OakPj3VrZyjWVw8+BDtFqL261TY7dcUfmGKlZRr9DAbDY7Z8sZ+CrbvTFeVptLVvPa2O
	UaN1KRS7UxcdZpGcvcSxhZ6ulWy4gcD/+E5afPM8qwLpplGGvXLMCVSHuatTS9EknBDw
	9mQA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:45 -0800
Message-Id: <20190209003248.31088-14-f.fainelli@gmail.com>
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 13/16] net: mscc: ocelot: Handle
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

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
ocelot_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..adab478d36f1 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1324,10 +1324,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
-static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_set	= ocelot_port_attr_set,
-};
-
 static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
 				   struct net_device *bridge)
 {
@@ -1582,6 +1578,24 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int
+ocelot_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = ocelot_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1614,8 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

