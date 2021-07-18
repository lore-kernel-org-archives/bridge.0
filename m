Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qocFjnfds/Q3esaj8xNKnBZ3Tz/PgB7Ko5kKVsqifIo=;
 b=mVK+uhJ7oQr7QJ1cqJj2JVgEBB3tp85sUvGAYC21syOlqmuDjK4bjLFlsDqavpt9sial0QQ3fDzkti9uKyjOKcRoft1EqPkzAaf7vmFW6lCayQg4a3hSu3emia9vzy/B3uYukWBNFONs4O+aOkSYXaGhoE3xUUlnMk1pkSoAz1o=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 00:44:24 +0300
Message-Id: <20210718214434.3938850-6-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v4 net-next 05/15] net: marvell: prestera: refactor
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Vadym Kochan <vkochan@marvell.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Taras Chornyi <tchornyi@marvell.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

In preparation of adding more code to the NETDEV_PRECHANGEUPPER handler,
move the existing sanity checks into a dedicated function.

Cc: Vadym Kochan <vkochan@marvell.com>
Cc: Taras Chornyi <tchornyi@marvell.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: patch is new
v3->v4: none

 .../ethernet/marvell/prestera/prestera_main.c | 71 ++++++++++++-------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 226f4ff29f6e..1f3c8cd6ced2 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -699,6 +699,45 @@ static bool prestera_lag_master_check(struct net_device *lag_dev,
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
@@ -707,40 +746,18 @@ static int prestera_netdev_port_event(struct net_device *lower,
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

