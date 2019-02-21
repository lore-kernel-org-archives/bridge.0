Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oEsRiOyoTDS2Il8WB9wmLIZuhUcjnS7BnvM3RAeCqbk=;
	b=Hx5uDgr/gFZ9Uyu/47qLgrNO2f2Br0O933scvBL9J+2CR4jGP0x29l+ms4J3Qd+kEj
	LkplyFWTgHu/ujiwoGR8F4IvvMQT7DOK8iZlq+/E18tVLUZAjZdJs28fUWtsWgDl+Wm6
	0tlHZL774YcNFgzqYxbre8gnUNyZx+8iWIiaoOsoCms89Aop1SQllMCp1SWIFxDbJgVu
	5LCJBa/9X/MlFgSQ7VyRTWyViCod//uEc21QCNqfqVTbuD+YxGNdKNlWtPAyQaUAEQuz
	vvhGsWirostpm4JfR0mK2/Nw6tsSYLJaTH/SxEGpZj+cRj7oYTFvaNZh/wXn59DPc7dl
	MadQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:23 -0800
Message-Id: <20190221005826.26317-6-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 5/8] rocker: Check Handle
	PORT_PRE_BRIDGE_FLAGS
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

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 55 +++++++++++++++++------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5ce8d5aba603..25129f7b5583 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1566,34 +1566,57 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 }
 
 static int
-rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
-					unsigned long brport_flags,
-					struct switchdev_trans *trans)
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
+static int
+rocker_world_port_attr_pre_bridge_flags_set(struct rocker_port *rocker_port,
+					    unsigned long brport_flags,
+					    struct switchdev_trans *trans)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
+
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
-		return 0;
+	err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+	if (err)
+		return err;
 
-	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
-						trans);
+	if (brport_flags & ~brport_flags_s)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
+rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
+					unsigned long brport_flags,
+					struct switchdev_trans *trans)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
-	if (!wops->port_attr_bridge_flags_support_get)
+	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
+						trans);
 }
 
 static int
@@ -2074,6 +2097,10 @@ static int rocker_port_attr_set(struct net_device *dev,
 							   attr->u.stp_state,
 							   trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = rocker_world_port_attr_pre_bridge_flags_set(rocker_port,
+							      attr->u.brport_flags,
+							      trans);
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
-- 
2.17.1

