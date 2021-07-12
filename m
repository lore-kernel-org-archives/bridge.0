Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fa/GIxMWj0fNCHBGxwYOP+lgVtD3UA9ZDx31dli7Pw=;
 b=s5FkBeqg0yyHqFKzJDdmQQAHFISYBCizsiW0mIRSXOx0ov3lgf/QiQwS0UMDb/u35BtZB2afouG7YJgEs17xxlP1bYZZ6i2jxRn1ZFkcCyzSmuUKUvgdUPi0p6U2/6QkHqUNZD20eqeidxzmP9M9DOKD5eCq/Vr+iJahageXxSk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:20 +0300
Message-Id: <20210712152142.800651-3-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 02/24] net: dpaa2-switch: refactor
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

Make more room for some extra code in the NETDEV_PRECHANGEUPPER handler
by moving what already exists into a dedicated function.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 37 +++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 62d322ebf1f2..f6d4cf053ff7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2030,6 +2030,28 @@ static int dpaa2_switch_prevent_bridging_with_8021q_upper(struct net_device *net
 	return 0;
 }
 
+static int
+dpaa2_switch_prechangeupper_sanity_checks(struct net_device *dev,
+					  struct net_device *upper_dev,
+					  struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (!br_vlan_enabled(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot join a VLAN-unaware bridge");
+		return -EOPNOTSUPP;
+	}
+
+	err = dpaa2_switch_prevent_bridging_with_8021q_upper(netdev);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot join a bridge while VLAN uppers are present");
+		return 0;
+	}
+
+	return 0;
+}
+
 static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 					     unsigned long event, void *ptr)
 {
@@ -2050,18 +2072,11 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 		if (!netif_is_bridge_master(upper_dev))
 			break;
 
-		if (!br_vlan_enabled(upper_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "Cannot join a VLAN-unaware bridge");
-			err = -EOPNOTSUPP;
-			goto out;
-		}
-
-		err = dpaa2_switch_prevent_bridging_with_8021q_upper(netdev);
-		if (err) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Cannot join a bridge while VLAN uppers are present");
+		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
+								upper_dev,
+								extack);
+		if (err)
 			goto out;
-		}
 
 		break;
 	case NETDEV_CHANGEUPPER:
-- 
2.25.1

