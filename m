Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBi/m/e9fTm98LFndmKnwMPNFVaW1NGhQCY9cnxGwhM=;
 b=cCT851NTRm1GhX/3C0/+46MRVyQMRNK5yVju2SYzb6TZuzOfHjQq07DibOLuGV1acPpc8coHtAx0nPCOnsLKXqETCNGuZE63iHBA0hgEIzlKJtBl9ktTEgdV3LsUxPr7K593GIv0ehSsEZ5wtfAkOu6YhMYO41ax1OeJ+8+M03U=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 16:46:51 +0300
Message-Id: <20210720134655.892334-7-vladimir.oltean@nxp.com>
In-Reply-To: <20210720134655.892334-1-vladimir.oltean@nxp.com>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 06/10] net: switchdev: guard drivers
	against multiple obj replays on same bridge port
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

Prepare the drivers which support LAG offload but don't have support for
switchdev object replay yet, i.e. the mlxsw and prestera drivers, to
deal with bridge switchdev objects being replayed on the LAG bridge port
multiple times, once for each time a physical port beneath the LAG calls
switchdev_bridge_port_offload().

Cc: Vadym Kochan <vkochan@marvell.com>
Cc: Taras Chornyi <tchornyi@marvell.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
v3->v4: squash mlxsw and prestera into a single patch
v4->v5: none

 drivers/net/ethernet/marvell/prestera/prestera_switchdev.c | 6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
index 0b3e8f2db294..a1fc4ab53ccf 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
@@ -1047,6 +1047,9 @@ static int prestera_port_obj_add(struct net_device *dev, const void *ctx,
 	struct prestera_port *port = netdev_priv(dev);
 	const struct switchdev_obj_port_vlan *vlan;
 
+	if (ctx && ctx != port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
@@ -1083,6 +1086,9 @@ static int prestera_port_obj_del(struct net_device *dev, const void *ctx,
 {
 	struct prestera_port *port = netdev_priv(dev);
 
+	if (ctx && ctx != port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		return prestera_port_vlans_del(port, SWITCHDEV_OBJ_PORT_VLAN(obj));
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 61911fed6aeb..5a0c7c94874e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1772,6 +1772,9 @@ static int mlxsw_sp_port_obj_add(struct net_device *dev, const void *ctx,
 	const struct switchdev_obj_port_vlan *vlan;
 	int err = 0;
 
+	if (ctx && ctx != mlxsw_sp_port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
@@ -1920,6 +1923,9 @@ static int mlxsw_sp_port_obj_del(struct net_device *dev, const void *ctx,
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

