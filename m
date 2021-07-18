Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvbeIVZl88ToICjHAmeKYYP1j/OuFxc9fvRDjVuotjE=;
 b=Sd4aeuSai407f7UpA0h3P78QAd+Ues01MzTqCmBudZ9q0/3vu0BjXabrYXHI1j/nl1TThmRvrpXJgdawJzntOFrMf5h/JMD3SW9WIRNhdTWomspOlGqwUx7FHwaoddO+tLNp3C+IDJldtHyKQ3cAbojqJdegLXNADDrTNhXDH6M=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 00:44:23 +0300
Message-Id: <20210718214434.3938850-5-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v4 net-next 04/15] mlxsw: spectrum: refactor
	leaving an 8021q upper that is a bridge port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

For symmetry with mlxsw_sp_port_lag_leave(), introduce a small function
called mlxsw_sp_port_vlan_leave() which checks whether the 8021q upper
we're leaving is a bridge port, and if it is, stop offloading that
bridge too.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: patch is new

 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index c1b78878e5cf..b3d1fdc2d094 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3994,6 +3994,19 @@ static void mlxsw_sp_port_ovs_leave(struct mlxsw_sp_port *mlxsw_sp_port)
 	mlxsw_sp_port_vp_mode_set(mlxsw_sp_port, false);
 }
 
+static void mlxsw_sp_port_vlan_leave(struct mlxsw_sp_port *mlxsw_sp_port,
+				     struct net_device *vlan_dev)
+{
+	struct net_device *br_dev;
+
+	if (!netif_is_bridge_port(vlan_dev))
+		return;
+
+	br_dev = netdev_master_upper_dev_get(vlan_dev);
+
+	mlxsw_sp_port_bridge_leave(mlxsw_sp_port, vlan_dev, br_dev);
+}
+
 static bool mlxsw_sp_bridge_has_multiple_vxlans(struct net_device *br_dev)
 {
 	unsigned int num_vxlans = 0;
@@ -4225,16 +4238,8 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 		} else if (netif_is_macvlan(upper_dev)) {
 			if (!info->linking)
 				mlxsw_sp_rif_macvlan_del(mlxsw_sp, upper_dev);
-		} else if (is_vlan_dev(upper_dev)) {
-			struct net_device *br_dev;
-
-			if (!netif_is_bridge_port(upper_dev))
-				break;
-			if (info->linking)
-				break;
-			br_dev = netdev_master_upper_dev_get(upper_dev);
-			mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev,
-						   br_dev);
+		} else if (is_vlan_dev(upper_dev) && !info->linking) {
+			mlxsw_sp_port_vlan_leave(mlxsw_sp_port, upper_dev);
 		}
 		break;
 	}
-- 
2.25.1

