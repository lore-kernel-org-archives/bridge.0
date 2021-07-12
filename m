Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJtISRQwqEYwY3zuU92Rf7AGd7DBy2+7is3NX6MZN+Y=;
 b=VDha82fyW9ItugiiorcaikB8GIiyhI1HPsftUYfG/yYhXPzZDejWK7bXB9F8D5lcNeIvfTMiV2rTG37Eh9vkITkJwnnmWdzYLZQjrOu/lkgrPrwHSODI/qEjlZRmguqcuscnsNeDDRg8brVfXCWyG5rmq7dWht78LPJdkvnI60A=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:29 +0300
Message-Id: <20210712152142.800651-12-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 11/24] net: mlxsw: guard against
	multiple switchdev obj replays on same bridge port
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

Prepare the mlxsw driver, which supports LAG offload, to deal with
bridge switchdev objects being replayed on the LAG bridge port multiple
times, once for each time a physical port beneath the LAG calls
switchdev_bridge_port_offload().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index cbcf38338f3e..9f72912e4982 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1774,6 +1774,9 @@ static int mlxsw_sp_port_obj_add(struct net_device *dev, const void *ctx,
 	const struct switchdev_obj_port_vlan *vlan;
 	int err = 0;
 
+	if (ctx && ctx != mlxsw_sp_port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
@@ -1922,6 +1925,9 @@ static int mlxsw_sp_port_obj_del(struct net_device *dev, const void *ctx,
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 	int err = 0;
 
+	if (ctx && ctx != mlxsw_sp_port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = mlxsw_sp_port_vlans_del(mlxsw_sp_port,
-- 
2.25.1

