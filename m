Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Gq/qAOtWNvcuwUtUaSW2EYY4Z4jqPnX1n6JjQenVLBM=;
	b=g4+NDr7r61K9ERC3quk5u63rKL/N4u3wkUo2s/Ez3fiOkzAyRQFgZvxxyxR6NpqaRM
	/Y6aGQsAS5AC5maDmuQ1fd6ah/WZUQhSGPS6/v8AE0ROwx7YwcQYMyYE2taCRdeQl5f7
	yPnV/xVbYZVOnjV/AuDDF9+9ZJuFq0ezRBXrwsF7cejTgNxJs6KwEKDT71keOJCSCPvP
	PE4xT02oQDO7/wbE7nSBhzP5MrHMtNgc32j2a7+lAZKz1WaH04MkTz2I8ErUEpgujTmf
	XMjRAQ8Qfa+dzGKsb95rDbsBn2ZIbQRtAbsl/ffFqs0XncQzwyPVKaxZEtieb1ZjMyP4
	rh1g==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 26 Feb 2019 17:14:22 -0800
Message-Id: <20190227011427.16487-4-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 3/8] net: dsa: Handle
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

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
dsa_slave_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 7274499293c9..b089b43120e1 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1524,6 +1524,19 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int
+dsa_slave_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+				      port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct dsa_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -1602,6 +1615,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1664,6 +1680,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

