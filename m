Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=nsoTPbQ3gK+2NOAMcVz9btjLns72C32iPXrYhr04RyQ=;
	b=Hr88RD0aDxIM3Chruik2+LpEO/3tKHT3RIpY/iXxzczgnpSd02tAI/DqD3WF18LRds
	yHEmv6KvUQd2NxDDskWlbmh2fjDtH1lxG0W1yOUmUA/mYNb54OV7bp3c5nidy6EQRD8u
	BUMmiIde9XeoSsNSDJky1fkvynKV+cMknhWEPNKQ1A8hCssY9yI4/VLL1LoB4cc4N4DB
	cHOphkZXiHRzFN66yZOSfmVBVyDee2Bk3b+GVkA0xyEJI0yDoIhLvKUpYtabtD3FThwJ
	t0KIFcnOe8W3jaVSL2Hxcw3+BrJBRAhh/B+lUdgNGxwQIX69YVIS4Oblw+I2cDvzCwDb
	G44w==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 13:17:47 -0800
Message-Id: <20190211211749.19847-2-f.fainelli@gmail.com>
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 1/3] mlxsw: spectrum_switchdev: Remove
	getting PORT_BRIDGE_FLAGS
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

There is no code that will query the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
attribute remove support for that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c         | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 95e37de3e48f..4c5780f8f4b2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,19 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static void mlxsw_sp_port_bridge_flags_get(struct mlxsw_sp_bridge *bridge,
-					   struct net_device *dev,
-					   unsigned long *brport_flags)
-{
-	struct mlxsw_sp_bridge_port *bridge_port;
-
-	bridge_port = mlxsw_sp_bridge_port_find(bridge, dev);
-	if (WARN_ON(!bridge_port))
-		return;
-
-	memcpy(brport_flags, &bridge_port->flags, sizeof(*brport_flags));
-}
-
 static int mlxsw_sp_port_attr_get(struct net_device *dev,
 				  struct switchdev_attr *attr)
 {
@@ -451,10 +438,6 @@ static int mlxsw_sp_port_attr_get(struct net_device *dev,
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
-					       &attr->u.brport_flags);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
 					       BR_MCAST_FLOOD;
-- 
2.17.1

