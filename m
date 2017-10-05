Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=CMdHliaXIdpISmtzVqEJu1ow3W/vuzsHuLVSS6eC4+I=;
	b=oOaOJP4dNNO9uU0tSG5j/f93CYN0jtvnoQJMO/pr7AVVvKg+vhFgTJrH0X1VHa+BJE
	lhoCWh9sGldXFqa8pwXOeTZ04azi2e1VF27NQJhFpBavm8ZLm5R/bZI5qTFEvbVCcd/M
	Vim+Wc2C98QZujR7lrMawL9ceJ1jpCbTUzYvnXf+vzACGVKMqchP94h3jdC33GFDPlcZ
	WrVuwMn+wL7leN2sjPGYyd+VzbOdZbXp+hYm7T/SI03mRGWl99O+KfRncdLxzrhe0vpg
	QjhzA63xnFyeWo3HXHN4t0vV9E+9qtohPSG+fslspiWI1Jdq+ylbw7qm/YicAjTA0sFa
	606g==
From: David Ahern <dsahern@gmail.com>
Date: Wed,  4 Oct 2017 17:48:51 -0700
Message-Id: <1507164531-17732-8-git-send-email-dsahern@gmail.com>
In-Reply-To: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
References: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH v2 net-next 7/7] mlxsw: spectrum: Add extack
	messages for enslave failures
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: j.vosburgh@gmail.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, David Ahern <dsahern@gmail.com>, davem@davemloft.net

mlxsw fails device enslavement for a number of reasons. Use the extack
facility to return an error message to the user stating why the enslave
is failing.

Messages are prefixed with "spectrum" so users know it is a constraint
imposed by the hardware driver. For example:
    $ ip li add br0.11 link br0 type vlan id 11
    $ ip li set swp11 master br0
    Error: spectrum: Enslaving a port to a device that already has an upper device is not supported.

Signed-off-by: David Ahern <dsahern@gmail.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 47 ++++++++++++++++++++------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3adf237c951a..5cd4df08ce97 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4019,14 +4019,21 @@ static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 static bool
 mlxsw_sp_master_lag_check(struct mlxsw_sp *mlxsw_sp,
 			  struct net_device *lag_dev,
-			  struct netdev_lag_upper_info *lag_upper_info)
+			  struct netdev_lag_upper_info *lag_upper_info,
+			  struct netlink_ext_ack *extack)
 {
 	u16 lag_id;
 
-	if (mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id) != 0)
+	if (mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id) != 0) {
+		NL_SET_ERR_MSG(extack,
+			       "spectrum: Exceeded number of supported LAG devices");
 		return false;
-	if (lag_upper_info->tx_type != NETDEV_LAG_TX_TYPE_HASH)
+	}
+	if (lag_upper_info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG(extack,
+			       "spectrum: LAG device using unsupported Tx type");
 		return false;
+	}
 	return true;
 }
 
@@ -4231,6 +4238,7 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 {
 	struct netdev_notifier_changeupper_info *info;
 	struct mlxsw_sp_port *mlxsw_sp_port;
+	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
 	struct mlxsw_sp *mlxsw_sp;
 	int err = 0;
@@ -4238,6 +4246,7 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 	mlxsw_sp_port = netdev_priv(dev);
 	mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	info = ptr;
+	extack = netdev_notifier_info_to_extack(&info->info);
 
 	switch (event) {
 	case NETDEV_PRECHANGEUPPER:
@@ -4245,25 +4254,43 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 		if (!is_vlan_dev(upper_dev) &&
 		    !netif_is_lag_master(upper_dev) &&
 		    !netif_is_bridge_master(upper_dev) &&
-		    !netif_is_ovs_master(upper_dev))
+		    !netif_is_ovs_master(upper_dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "spectrum: Unknown upper device type");
 			return -EINVAL;
+		}
 		if (!info->linking)
 			break;
-		if (netdev_has_any_upper_dev(upper_dev))
+		if (netdev_has_any_upper_dev(upper_dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "spectrum: Enslaving a port to a device that already has an upper device is not supported");
 			return -EINVAL;
+		}
 		if (netif_is_lag_master(upper_dev) &&
 		    !mlxsw_sp_master_lag_check(mlxsw_sp, upper_dev,
-					       info->upper_info))
+					       info->upper_info, extack))
 			return -EINVAL;
-		if (netif_is_lag_master(upper_dev) && vlan_uses_dev(dev))
+		if (netif_is_lag_master(upper_dev) && vlan_uses_dev(dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "spectrum: Master device is a LAG master and this device has a VLAN");
 			return -EINVAL;
+		}
 		if (netif_is_lag_port(dev) && is_vlan_dev(upper_dev) &&
-		    !netif_is_lag_master(vlan_dev_real_dev(upper_dev)))
+		    !netif_is_lag_master(vlan_dev_real_dev(upper_dev))) {
+			NL_SET_ERR_MSG(extack,
+				       "spectrum: Can not put a VLAN on a LAG port");
 			return -EINVAL;
-		if (netif_is_ovs_master(upper_dev) && vlan_uses_dev(dev))
+		}
+		if (netif_is_ovs_master(upper_dev) && vlan_uses_dev(dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "spectrum: Master device is an OVS master and this device has a VLAN");
 			return -EINVAL;
-		if (netif_is_ovs_port(dev) && is_vlan_dev(upper_dev))
+		}
+		if (netif_is_ovs_port(dev) && is_vlan_dev(upper_dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "spectrum: Can not put a VLAN on an OVS port");
 			return -EINVAL;
+		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
-- 
2.1.4

