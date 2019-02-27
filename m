Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xdJhj6/KPsXtmI8sxeS4sEhQiluHyols6G0sMJAn/vE=;
	b=tzr2PeEkAhYSplvnsv1G0ptCpq6TDu3RAuaemwmV/PJsb0+xwobUzQo8MrqDRafRGu
	0XsG0kIpc20QpBEWrnnHI48kE6Ts9Mr59QnixwyCywPRO1/0Q8NtBgyLNdrmYr0nNSnH
	8yqwc/Q3S2lisXY2IiANpAnOSZ9zgTwJm0wN4Zpfxf4d0c6KGhxWzSa2Kahca4Pom8fL
	3/bLXPVtIrdG010D5XoE5pDcqSWUu2kllpkSASAf5t9cOqHOt8dA0bdbWyRn6f2qul8L
	2QFZR4Y5tHdSjeeStns9BoRmjDYpsJWPhCRBpadpeY8S8ZH6uD68MR6KEO9ODwm0TqzJ
	clbQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 26 Feb 2019 17:14:24 -0800
Message-Id: <20190227011427.16487-6-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 5/8] net: mscc: ocelot: Handle
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
attribute and use notifiers to perform those tasks.

Ocelot does not currently have an atomic notifier registered for
switchdev events, so we need to register one in order to deal with
atomic context SWITCHDEV_PORT_ATTR_SET events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c       | 27 ++++++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h       |  1 +
 drivers/net/ethernet/mscc/ocelot_board.c |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..83a678b11757 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,28 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int ocelot_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ocelot_netdevice_dev_check,
+						     ocelot_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	return NOTIFY_DONE;
+}
+
+struct notifier_block ocelot_switchdev_nb __read_mostly = {
+	.notifier_call = ocelot_switchdev_event,
+};
+EXPORT_SYMBOL(ocelot_switchdev_nb);
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1622,11 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ocelot_netdevice_dev_check,
+						     ocelot_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 086775f7b52f..ba3b3380b4d0 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -499,6 +499,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 		      struct phy_device *phy);
 
 extern struct notifier_block ocelot_netdevice_nb;
+extern struct notifier_block ocelot_switchdev_nb;
 extern struct notifier_block ocelot_switchdev_blocking_nb;
 
 #endif
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index ca3ea2fbfcd0..2c1121d86edf 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -329,6 +329,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	}
 
 	register_netdevice_notifier(&ocelot_netdevice_nb);
+	register_switchdev_notifier(&ocelot_switchdev_nb);
 	register_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
 
 	dev_info(&pdev->dev, "Ocelot switch probed\n");
@@ -345,6 +346,7 @@ static int mscc_ocelot_remove(struct platform_device *pdev)
 
 	ocelot_deinit(ocelot);
 	unregister_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
+	unregister_switchdev_notifier(&ocelot_switchdev_nb);
 	unregister_netdevice_notifier(&ocelot_netdevice_nb);
 
 	return 0;
-- 
2.17.1

