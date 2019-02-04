Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LOdPamGnEvrnPAL3BHb1FemYywRsRn5UwffgYhI4ULw=;
	b=i1zkUKvo3xjClOGVPDpCGnUXTo+D5DrDrXwt18i/GaYOFezJmhS1MoWDe0/SRRU679
	25o0/Mh8EUf1l/Ta5PwGi+xwSITUdVNbAOVwrfVjWXO5QIih7lKfSH5f4cwAu8rGbXJh
	CSQNsUnSQ3qz6zb/Nw5pPuvCQ1Lqg/fKvUjiFbQJOtgelNIK3GDpm2n6N/tbFjpBlPep
	Z+HDVRo3DldFWyd0D6SpJxNcDcIxi7/Ow8UNe9tMHYIsCyRuFtzYpsfagydJE2MCsxQR
	T0t5jWidNfpYjuK47t4+zJIS66eZcm8yaOivKWVwQcCESR3UXYbsRoxNFun2SQhjGTsw
	usmg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:25 -0800
Message-Id: <20190204233633.20421-5-f.fainelli@gmail.com>
In-Reply-To: <20190204233633.20421-1-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 04/12] net/mlx5e: Implement ndo_get_port_parent_id()
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

mlx5e only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 31 +++++++------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 5d2e0c2f6624..0b1988b330f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -381,7 +381,8 @@ static const struct ethtool_ops mlx5e_uplink_rep_ethtool_ops = {
 	.set_pauseparam    = mlx5e_uplink_rep_set_pauseparam,
 };
 
-static int mlx5e_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int mlx5e_rep_get_port_parent_id(struct net_device *dev,
+					struct netdev_phys_item_id *ppid)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
@@ -398,20 +399,14 @@ static int mlx5e_attr_get(struct net_device *dev, struct switchdev_attr *attr)
 		uplink_priv = netdev_priv(uplink_dev);
 	}
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = ETH_ALEN;
-		if (uplink_upper && mlx5_lag_is_sriov(uplink_priv->mdev)) {
-			ether_addr_copy(attr->u.ppid.id, uplink_upper->dev_addr);
-		} else {
-			struct mlx5e_rep_priv *rpriv = priv->ppriv;
-			struct mlx5_eswitch_rep *rep = rpriv->rep;
+	ppid->id_len = ETH_ALEN;
+	if (uplink_upper && mlx5_lag_is_sriov(uplink_priv->mdev)) {
+		ether_addr_copy(ppid->id, uplink_upper->dev_addr);
+	} else {
+		struct mlx5e_rep_priv *rpriv = priv->ppriv;
+		struct mlx5_eswitch_rep *rep = rpriv->rep;
 
-			ether_addr_copy(attr->u.ppid.id, rep->hw_id);
-		}
-		break;
-	default:
-		return -EOPNOTSUPP;
+		ether_addr_copy(ppid->id, rep->hw_id);
 	}
 
 	return 0;
@@ -1284,10 +1279,6 @@ static int mlx5e_uplink_rep_set_vf_vlan(struct net_device *dev, int vf, u16 vlan
 	return 0;
 }
 
-static const struct switchdev_ops mlx5e_rep_switchdev_ops = {
-	.switchdev_port_attr_get	= mlx5e_attr_get,
-};
-
 static const struct net_device_ops mlx5e_netdev_ops_vf_rep = {
 	.ndo_open                = mlx5e_vf_rep_open,
 	.ndo_stop                = mlx5e_vf_rep_close,
@@ -1298,6 +1289,7 @@ static const struct net_device_ops mlx5e_netdev_ops_vf_rep = {
 	.ndo_has_offload_stats	 = mlx5e_rep_has_offload_stats,
 	.ndo_get_offload_stats	 = mlx5e_rep_get_offload_stats,
 	.ndo_change_mtu          = mlx5e_vf_rep_change_mtu,
+	.ndo_get_port_parent_id	 = mlx5e_rep_get_port_parent_id,
 };
 
 static const struct net_device_ops mlx5e_netdev_ops_uplink_rep = {
@@ -1319,6 +1311,7 @@ static const struct net_device_ops mlx5e_netdev_ops_uplink_rep = {
 	.ndo_get_vf_config       = mlx5e_get_vf_config,
 	.ndo_get_vf_stats        = mlx5e_get_vf_stats,
 	.ndo_set_vf_vlan         = mlx5e_uplink_rep_set_vf_vlan,
+	.ndo_get_port_parent_id	 = mlx5e_rep_get_port_parent_id,
 };
 
 bool mlx5e_eswitch_rep(struct net_device *netdev)
@@ -1393,8 +1386,6 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev)
 	netdev->watchdog_timeo    = 15 * HZ;
 
 
-	netdev->switchdev_ops = &mlx5e_rep_switchdev_ops;
-
 	netdev->features	 |= NETIF_F_HW_TC | NETIF_F_NETNS_LOCAL;
 	netdev->hw_features      |= NETIF_F_HW_TC;
 
-- 
2.17.1

