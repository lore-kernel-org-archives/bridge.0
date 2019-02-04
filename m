Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FM7UbF1Ks8MhuNGG6C9onaIpALxRUEhyUABssROXJgE=;
	b=Y28K6ByfPxq3XZGVY2aKGYLL+csAot+zYO+BocYfpAWYIQ0M0MJnTZoW2mjjFbUWVZ
	hKIXF0FifyQrBjb1cQOKbRr9rFX6cBn2P118w0Mnd7aC5auFv4ln4kYzTqAO/vk6dDHC
	KddR8/kM+tWoViV6cGYI4VyDSbWyPgb8H4k3WEd0OLa0xQNtjehjdryRROVj+j2WiZmu
	ntcwWxi96XUQZY0tL+dU6qHV8cv7qmh27WxykvyDv2V0l0TG5PvhJNFUbSLEzA6+QNMg
	7nad0ZopkiaQHWa183mjuLEATLG9toTpcfxWkPGt11T/3STuvoyS5OP4MdurL2H6UmPb
	vhDQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:26 -0800
Message-Id: <20190204233633.20421-6-f.fainelli@gmail.com>
In-Reply-To: <20190204233633.20421-1-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 05/12] mlxsw: Implement ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, John Hurley <john.hurley@netronome.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, Eric Dumazet <edumazet@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Tyler Hicks <tyhicks@canonical.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ioana Radulescu <ruxandra.radulescu@nxp.com>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Saeed Mahameed <saeedm@mellanox.com>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Simon Horman <simon.horman@netronome.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Satanand Burla <sburla@marvell.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Edwin Peer <edwin.peer@netronome.com>, Michael Chan <michael.chan@broadcom.com>, Christian Brauner <christian@brauner.io>, Felix Manlunas <fmanlunas@marvell.com>, Leon Romanovsky <leon@kernel.org>, Nic Viljoen <nick.viljoen@netronome.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, David Ahern <dsahern@gmail.com>, Joe Perches <joe@perches.com>, Derek Chickles <dchickles@marvell.com>, "David S. Miller" <davem@davemloft.net>

mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 ---
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 36 +++++++------------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index a88169738b4a..8dd808b7f931 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1700,6 +1700,18 @@ static int mlxsw_sp_set_features(struct net_device *dev,
 				       mlxsw_sp_feature_hw_tc);
 }
 
+static int mlxsw_sp_port_get_port_parent_id(struct net_device *dev,
+					    struct netdev_phys_item_id *ppid)
+{
+	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+
+	ppid->id_len = sizeof(mlxsw_sp->base_mac);
+	memcpy(&ppid->id, &mlxsw_sp->base_mac, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
 	.ndo_open		= mlxsw_sp_port_open,
 	.ndo_stop		= mlxsw_sp_port_stop,
@@ -1715,6 +1727,7 @@ static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= mlxsw_sp_port_kill_vid,
 	.ndo_get_phys_port_name	= mlxsw_sp_port_get_phys_port_name,
 	.ndo_set_features	= mlxsw_sp_set_features,
+	.ndo_get_port_parent_id	= mlxsw_sp_port_get_port_parent_id,
 };
 
 static void mlxsw_sp_port_get_drvinfo(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a4a9fe992193..95e37de3e48f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -451,11 +451,6 @@ static int mlxsw_sp_port_attr_get(struct net_device *dev,
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(mlxsw_sp->base_mac);
-		memcpy(&attr->u.ppid.id, &mlxsw_sp->base_mac,
-		       attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
 					       &attr->u.brport_flags);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
index 2d4f213e154d..3814ba8af517 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
@@ -390,6 +390,18 @@ static int mlxsw_sx_port_get_phys_port_name(struct net_device *dev, char *name,
 						  name, len);
 }
 
+static int mlxsw_sx_port_get_port_parent_id(struct net_device *dev,
+					    struct netdev_phys_item_id *ppid)
+{
+	struct mlxsw_sx_port *mlxsw_sx_port = netdev_priv(dev);
+	struct mlxsw_sx *mlxsw_sx = mlxsw_sx_port->mlxsw_sx;
+
+	ppid->id_len = sizeof(mlxsw_sx->hw_id);
+	memcpy(&ppid->id, &mlxsw_sx->hw_id, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops mlxsw_sx_port_netdev_ops = {
 	.ndo_open		= mlxsw_sx_port_open,
 	.ndo_stop		= mlxsw_sx_port_stop,
@@ -397,6 +409,7 @@ static const struct net_device_ops mlxsw_sx_port_netdev_ops = {
 	.ndo_change_mtu		= mlxsw_sx_port_change_mtu,
 	.ndo_get_stats64	= mlxsw_sx_port_get_stats64,
 	.ndo_get_phys_port_name = mlxsw_sx_port_get_phys_port_name,
+	.ndo_get_port_parent_id	= mlxsw_sx_port_get_port_parent_id,
 };
 
 static void mlxsw_sx_port_get_drvinfo(struct net_device *dev,
@@ -901,28 +914,6 @@ static const struct ethtool_ops mlxsw_sx_port_ethtool_ops = {
 	.set_link_ksettings	= mlxsw_sx_port_set_link_ksettings,
 };
 
-static int mlxsw_sx_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	struct mlxsw_sx_port *mlxsw_sx_port = netdev_priv(dev);
-	struct mlxsw_sx *mlxsw_sx = mlxsw_sx_port->mlxsw_sx;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(mlxsw_sx->hw_id);
-		memcpy(&attr->u.ppid.id, &mlxsw_sx->hw_id, attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static const struct switchdev_ops mlxsw_sx_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sx_port_attr_get,
-};
-
 static int mlxsw_sx_hw_id_get(struct mlxsw_sx *mlxsw_sx)
 {
 	char spad_pl[MLXSW_REG_SPAD_LEN] = {0};
@@ -1034,7 +1025,6 @@ static int __mlxsw_sx_port_eth_create(struct mlxsw_sx *mlxsw_sx, u8 local_port,
 
 	dev->netdev_ops = &mlxsw_sx_port_netdev_ops;
 	dev->ethtool_ops = &mlxsw_sx_port_ethtool_ops;
-	dev->switchdev_ops = &mlxsw_sx_port_switchdev_ops;
 
 	err = mlxsw_sx_port_dev_addr_get(mlxsw_sx_port);
 	if (err) {
-- 
2.17.1

