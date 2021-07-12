Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQGZqA4YLYAdJOm/W3LrzcL1Llu3tBJ7wawN8JJFNl0=;
 b=mOGXrMWfOZ51fpM8UYk0FlhfkAuSpJVolRUGgvBmUo44XMtWAD7Rx2fPtktrAqZ57tSQzgbEWniB2cVjMS4sT6dx8xWzxn3Ph2jtQBFdjSDXBB7Xl7AyOXdD6XDQ5PIx3432SsjGhTyj5yU8wgRCasjIjS5CXxxvB04AcQay34c=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:22 +0300
Message-Id: <20210712152142.800651-5-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 04/24] net: ocelot: fix switchdev
	objects synced for wrong netdev with LAG offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

The point with a *dev and a *brport_dev is that when we have a LAG net
device that is a bridge port, *dev is an ocelot net device and
*brport_dev is the bonding/team net device. The ocelot net device
beneath the LAG does not exist from the bridge's perspective, so we need
to sync the switchdev objects belonging to the brport_dev and not to the
dev.

Fixes: e4bd44e89dcf ("net: ocelot: replay switchdev events when joining bridge")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 3e89e34f86d5..e9d260d84bf3 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -1298,6 +1298,7 @@ static int ocelot_netdevice_lag_leave(struct net_device *dev,
 }
 
 static int ocelot_netdevice_changeupper(struct net_device *dev,
+					struct net_device *brport_dev,
 					struct netdev_notifier_changeupper_info *info)
 {
 	struct netlink_ext_ack *extack;
@@ -1307,11 +1308,11 @@ static int ocelot_netdevice_changeupper(struct net_device *dev,
 
 	if (netif_is_bridge_master(info->upper_dev)) {
 		if (info->linking)
-			err = ocelot_netdevice_bridge_join(dev, dev,
+			err = ocelot_netdevice_bridge_join(dev, brport_dev,
 							   info->upper_dev,
 							   extack);
 		else
-			err = ocelot_netdevice_bridge_leave(dev, dev,
+			err = ocelot_netdevice_bridge_leave(dev, brport_dev,
 							    info->upper_dev);
 	}
 	if (netif_is_lag_master(info->upper_dev)) {
@@ -1346,7 +1347,7 @@ ocelot_netdevice_lag_changeupper(struct net_device *dev,
 		if (ocelot_port->bond != dev)
 			return NOTIFY_OK;
 
-		err = ocelot_netdevice_changeupper(lower, info);
+		err = ocelot_netdevice_changeupper(lower, dev, info);
 		if (err)
 			return notifier_from_errno(err);
 	}
@@ -1385,7 +1386,7 @@ static int ocelot_netdevice_event(struct notifier_block *unused,
 		struct netdev_notifier_changeupper_info *info = ptr;
 
 		if (ocelot_netdevice_dev_check(dev))
-			return ocelot_netdevice_changeupper(dev, info);
+			return ocelot_netdevice_changeupper(dev, dev, info);
 
 		if (netif_is_lag_master(dev))
 			return ocelot_netdevice_lag_changeupper(dev, info);
-- 
2.25.1

