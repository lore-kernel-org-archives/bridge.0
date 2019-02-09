Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gC6qN8gW7l0/Xih4ramw9jRenVphqEEw7U5/9M1CtJo=;
	b=Z3p0JEGJ0tuQHURCXiZ/p8OP8gu/dORp5dMLVmKBAvRQdD0BBKtQ4ANFa23yEJ6snN
	1F+4EdDVm+VdWMSzuQekgQASBRStCBbZIBkzvCNwyZcxWIOxU7QAsuvARpPlN69dAhaY
	GJtVBklZ9I4YJ9aomca0qQtgkTtlQ4KqvFAu+0HHQDaEOGiEPBbuhggtnpECezB8rqtK
	iOUBktk03PHLKMThdzU6sMM9/Mjg0jYWxPfA/rWhtRhT9m2F1ibpJxGQFwPHzZcXHyA5
	ZpG+UjW2bnWM6Uzb9JN8KRuJ0oRXrsLWS7bEBD9WaO78739BRuGzxHaiyQ0HGldstZ8G
	OJ5g==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:43 -0800
Message-Id: <20190209003248.31088-12-f.fainelli@gmail.com>
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 11/16] net: dsa: Handle
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

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
dsa_slave_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ae34be949d79..f8c7c1b2cd2f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1544,6 +1544,24 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+					      port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1556,6 +1574,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET: /* fallthrough */
+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

