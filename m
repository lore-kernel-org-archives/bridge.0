Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PQg9HVQIYqiPsBwNT6JyGAohQPDs6z9iGbY5s51mdrw=;
	b=ooggOJlx9eNugsNcErrVth1sEPtj3KdzUNJ0KHhgfgVYuleCK3JfCCy/g3VGEIOCLr
	JtapHDTkiAprmlSwVuIG0BzIMFN4SM10PKqy3AwI6EJiRIpVTJ/xDWF1QTIlXIUyI9bI
	vsdEPXS4wKM5/Py0Ery9JMlGvyMUCXwYWnIn/hnMwvK+8tY8VkEzjZ0HAhrqYB9ptPVQ
	GuPQnq48CC3VIGGrT67RdPcBwPv9kbpWQEt54BcCUEVwUlX0mQrCg+GGyQFs5eTKFGyf
	VkFk4QdtERNr0QUsC1wzN6JUKP1Qo3fXjq+o7B82PtO6vbXuK3k9Y8EziOWkXB883F7+
	nt3Q==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 22 Feb 2019 15:59:22 -0800
Message-Id: <20190222235927.10295-5-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 4/8] mlxsw: spectrum_switchdev: Handle
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
attribute and use a notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
to handle stacking of devices.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 766f5b5f1cf5..c1aedfea3a31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 	struct net_device *br_dev;
 	int err;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
 	/* Tunnel devices are not our uppers, so check their master instead */
 	br_dev = netdev_master_upper_dev_get_rcu(dev);
 	if (!br_dev)
@@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

