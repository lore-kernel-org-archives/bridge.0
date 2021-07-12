Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1D061jnBAD0XbtV38n3i24VJY2RK3DQPlT/pABNFSo=;
 b=IHY0Lks8Npr9kpjSCNbxzrmpftBieLO7O1RTHtgJwc31TMWP8zjAEH6N8DzeKX6DTcuNarBL0GDEiGt6FO2DNCKjPkFkzCkoADOLQVqWHL0/PUVKXkal6JxrMZhkvnkZ85pD0qDhGa25i8virHRSHEldndXb4u7pLmi6RpdKeFc=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:24 +0300
Message-Id: <20210712152142.800651-7-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 06/24] net: prestera: refactor
	prechangeupper sanity checks
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

In preparation of adding more code to the NETDEV_PRECHANGEUPPER handler,
move the existing sanity checks into a dedicated function.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../ethernet/marvell/prestera/prestera_main.c | 71 ++++++++++++-------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 979214ce1952..508c03cc8edb 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -707,6 +707,45 @@ static bool prestera_lag_master_check(struct net_device *lag_dev,
 	return true;
 }
 
+static int prestera_prechangeupper_sanity_checks(struct net_device *dev,
+						 struct net_device *upper,
+						 struct netdev_notifier_changeupper_info *info,
+						 struct netlink_ext_ack *extack)
+{
+	if (!netif_is_bridge_master(upper) &&
+	    !netif_is_lag_master(upper)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
+		return -EINVAL;
+	}
+
+	if (!info->linking)
+		return 0;
+
+	if (netdev_has_any_upper_dev(upper)) {
+		NL_SET_ERR_MSG_MOD(extack, "Upper device is already enslaved");
+		return -EINVAL;
+	}
+
+	if (netif_is_lag_master(upper) &&
+	    !prestera_lag_master_check(upper, info->upper_info, extack))
+		return -EOPNOTSUPP;
+
+	if (netif_is_lag_master(upper) && vlan_uses_dev(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Master device is a LAG master and port has a VLAN");
+		return -EINVAL;
+	}
+
+	if (netif_is_lag_port(dev) && is_vlan_dev(upper) &&
+	    !netif_is_lag_master(vlan_dev_real_dev(upper))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can not put a VLAN on a LAG port");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int prestera_netdev_port_event(struct net_device *lower,
 				      struct net_device *dev,
 				      unsigned long event, void *ptr)
@@ -715,40 +754,18 @@ static int prestera_netdev_port_event(struct net_device *lower,
 	struct prestera_port *port = netdev_priv(dev);
 	struct netlink_ext_ack *extack;
 	struct net_device *upper;
+	int err;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
 	upper = info->upper_dev;
 
 	switch (event) {
 	case NETDEV_PRECHANGEUPPER:
-		if (!netif_is_bridge_master(upper) &&
-		    !netif_is_lag_master(upper)) {
-			NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
-			return -EINVAL;
-		}
-
-		if (!info->linking)
-			break;
-
-		if (netdev_has_any_upper_dev(upper)) {
-			NL_SET_ERR_MSG_MOD(extack, "Upper device is already enslaved");
-			return -EINVAL;
-		}
+		err = prestera_prechangeupper_sanity_checks(dev, upper, info,
+							    extack);
+		if (err)
+			return err;
 
-		if (netif_is_lag_master(upper) &&
-		    !prestera_lag_master_check(upper, info->upper_info, extack))
-			return -EOPNOTSUPP;
-		if (netif_is_lag_master(upper) && vlan_uses_dev(dev)) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Master device is a LAG master and port has a VLAN");
-			return -EINVAL;
-		}
-		if (netif_is_lag_port(dev) && is_vlan_dev(upper) &&
-		    !netif_is_lag_master(vlan_dev_real_dev(upper))) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Can not put a VLAN on a LAG port");
-			return -EINVAL;
-		}
 		break;
 
 	case NETDEV_CHANGEUPPER:
-- 
2.25.1

