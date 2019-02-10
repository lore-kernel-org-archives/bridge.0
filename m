Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xHCeq/zNU8Vz6vIUbaa4+CfDxZLSbpk+FdXHMruBdy8=;
	b=Ji9es3ngnoEFQk/V5XYuhKH9kud+ZWCCSh07BAcEfY67Vo1fFDHdSCxhdN9kuKQzcx
	osggmOvP6UvQggn1eoLoZ+oZQC383AkZ2aVEUdP2PelBIa1urYS1PJfpElQ4I/m00Gra
	zRZwLNb2BBH9Y/LnjI6fKANk0V7Us3W9tBfuDrkYBlgZ8Qo0vjGYYZnjsw5wkRIgrWQE
	GzCPDYth2p+viqkGcSg6vhyfERlcIqxXht/ge0Yt2IJ2u5/GawUKI7NjPiIq12lT8fnw
	Pfv5vl+ju5BEW0H+vLeohmFOrHrFiRBmlSsVBRZ1KJlf3Q9KotnNbwkUzcA+tMIH+V7h
	3WvA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:51:00 -0800
Message-Id: <20190210175105.31629-12-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 11/16] net: dsa: Handle
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
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
dsa_slave_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index d8eb33979368..ee4b94c5e68e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1547,6 +1547,20 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
 	return notifier_from_errno(err);
 }
 
+static int
+dsa_slave_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *netdev,
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
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 					      unsigned long event, void *ptr)
 {
@@ -1559,6 +1573,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

