Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcyOeW/UOtXNlODGtAoSq/H1C6jv4cdEUQKkgqqcs54=;
 b=UejPmDPQPHijyrTg9km04KTweVLElWo9Cy2wyxFFHFlNS5EWyB3TkEyHpAX3+nRoMco5XLZUzLZ7Jj76CbTFBuU6aqvHndPuVtebA2cN3MkRUrt9Bqfvj/9opq4iwiGf3M3w7pB7Nv55Aa3RBWWm6/VTsDDkWm+RiQBHXTHON9Q=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:19 +0300
Message-Id: <20210712152142.800651-2-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 01/24] net: dpaa2-switch: use
	extack in dpaa2_switch_port_bridge_join
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

We need to propagate the extack argument for
dpaa2_switch_port_bridge_join to use it in a future patch, and it looks
like there is already an error message there which is currently printed
to the console. Move it over netlink so it is properly transmitted to
user space.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index f3d12d0714fb..62d322ebf1f2 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1890,7 +1890,8 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 }
 
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
-					 struct net_device *upper_dev)
+					 struct net_device *upper_dev,
+					 struct netlink_ext_ack *extack)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -1906,8 +1907,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 
 		other_port_priv = netdev_priv(other_dev);
 		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
-			netdev_err(netdev,
-				   "Interface from a different DPSW is in the bridge already!\n");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Interface from a different DPSW is in the bridge already");
 			return -EINVAL;
 		}
 	}
@@ -2067,7 +2068,9 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 		upper_dev = info->upper_dev;
 		if (netif_is_bridge_master(upper_dev)) {
 			if (info->linking)
-				err = dpaa2_switch_port_bridge_join(netdev, upper_dev);
+				err = dpaa2_switch_port_bridge_join(netdev,
+								    upper_dev,
+								    extack);
 			else
 				err = dpaa2_switch_port_bridge_leave(netdev);
 		}
-- 
2.25.1

