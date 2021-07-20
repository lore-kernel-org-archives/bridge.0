Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j4DWG2oB5ZSG+uXAIUIJKSEvSTanwfJbyyxTGGzw0Y=;
 b=PW8gvqGqTYnVmSdMQb93UCI69MTUPKCDBYmic1ibYB02abVselUVdprbqhjD2WxdN++pMCLRH8rx9Hu3S8lkqoLObBIe+qvnBpavnoVLxuH+sSkZo3HYjG4IJ53ggLR9f6nWAN/IWAgDqPN6gcQLnoidyl4lbgY8TRDfEu07LGA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 16:46:48 +0300
Message-Id: <20210720134655.892334-4-vladimir.oltean@nxp.com>
In-Reply-To: <20210720134655.892334-1-vladimir.oltean@nxp.com>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 03/10] mlxsw: spectrum: refactor
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Make more room for extra code in the NETDEV_PRECHANGEUPPER handlers from
mlxsw by moving the existing sanity checks to 2 new dedicated functions.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
v2->v3: patch is new
v3->v5: none

 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 272 +++++++++++-------
 1 file changed, 169 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 88699e678544..c1b78878e5cf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4055,6 +4055,118 @@ static bool mlxsw_sp_bridge_vxlan_is_valid(struct net_device *br_dev,
 	return true;
 }
 
+static int
+mlxsw_sp_prechangeupper_sanity_checks(struct mlxsw_sp *mlxsw_sp,
+				      struct net_device *dev,
+				      struct net_device *lower_dev,
+				      struct net_device *upper_dev,
+				      struct netdev_notifier_changeupper_info *info,
+				      struct netlink_ext_ack *extack)
+{
+	u16 proto;
+
+	if (!is_vlan_dev(upper_dev) &&
+	    !netif_is_lag_master(upper_dev) &&
+	    !netif_is_bridge_master(upper_dev) &&
+	    !netif_is_ovs_master(upper_dev) &&
+	    !netif_is_macvlan(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
+		return -EINVAL;
+	}
+
+	if (!info->linking)
+		return 0;
+
+	if (netif_is_bridge_master(upper_dev) &&
+	    !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp, upper_dev) &&
+	    mlxsw_sp_bridge_has_vxlan(upper_dev) &&
+	    !mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
+		return -EOPNOTSUPP;
+
+	if (netdev_has_any_upper_dev(upper_dev) &&
+	    (!netif_is_bridge_master(upper_dev) ||
+	     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
+						  upper_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Enslaving a port to a device that already has an upper device is not supported");
+		return -EINVAL;
+	}
+
+	if (netif_is_lag_master(upper_dev) &&
+	    !mlxsw_sp_master_lag_check(mlxsw_sp, upper_dev,
+				       info->upper_info, extack))
+		return -EINVAL;
+
+	if (netif_is_lag_master(upper_dev) && vlan_uses_dev(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Master device is a LAG master and this device has a VLAN");
+		return -EINVAL;
+	}
+
+	if (netif_is_lag_port(dev) && is_vlan_dev(upper_dev) &&
+	    !netif_is_lag_master(vlan_dev_real_dev(upper_dev))) {
+		NL_SET_ERR_MSG_MOD(extack, "Can not put a VLAN on a LAG port");
+		return -EINVAL;
+	}
+
+	if (netif_is_macvlan(upper_dev) &&
+	    !mlxsw_sp_rif_exists(mlxsw_sp, lower_dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "macvlan is only supported on top of router interfaces");
+		return -EOPNOTSUPP;
+	}
+
+	if (netif_is_ovs_master(upper_dev) && vlan_uses_dev(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Master device is an OVS master and this device has a VLAN");
+		return -EINVAL;
+	}
+
+	if (netif_is_ovs_port(dev) && is_vlan_dev(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Can not put a VLAN on an OVS port");
+		return -EINVAL;
+	}
+
+	if (netif_is_bridge_master(upper_dev)) {
+		br_vlan_get_proto(upper_dev, &proto);
+		if (br_vlan_enabled(upper_dev) &&
+		    proto != ETH_P_8021Q && proto != ETH_P_8021AD) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Enslaving a port to a bridge with unknown VLAN protocol is not supported");
+			return -EOPNOTSUPP;
+		}
+		if (vlan_uses_dev(lower_dev) &&
+		    br_vlan_enabled(upper_dev) &&
+		    proto == ETH_P_8021AD) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Enslaving a port that already has a VLAN upper to an 802.1ad bridge is not supported");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (netif_is_bridge_port(lower_dev) && is_vlan_dev(upper_dev)) {
+		struct net_device *br_dev = netdev_master_upper_dev_get(lower_dev);
+
+		if (br_vlan_enabled(br_dev)) {
+			br_vlan_get_proto(br_dev, &proto);
+			if (proto == ETH_P_8021AD) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "VLAN uppers are not supported on a port enslaved to an 802.1ad bridge");
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	if (is_vlan_dev(upper_dev) &&
+	    ntohs(vlan_dev_vlan_proto(upper_dev)) != ETH_P_8021Q) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "VLAN uppers are only supported with 802.1q VLAN protocol");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 					       struct net_device *dev,
 					       unsigned long event, void *ptr)
@@ -4065,7 +4177,6 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 	struct net_device *upper_dev;
 	struct mlxsw_sp *mlxsw_sp;
 	int err = 0;
-	u16 proto;
 
 	mlxsw_sp_port = netdev_priv(dev);
 	mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
@@ -4075,84 +4186,15 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 	switch (event) {
 	case NETDEV_PRECHANGEUPPER:
 		upper_dev = info->upper_dev;
-		if (!is_vlan_dev(upper_dev) &&
-		    !netif_is_lag_master(upper_dev) &&
-		    !netif_is_bridge_master(upper_dev) &&
-		    !netif_is_ovs_master(upper_dev) &&
-		    !netif_is_macvlan(upper_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
-			return -EINVAL;
-		}
-		if (!info->linking)
-			break;
-		if (netif_is_bridge_master(upper_dev) &&
-		    !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp, upper_dev) &&
-		    mlxsw_sp_bridge_has_vxlan(upper_dev) &&
-		    !mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
-			return -EOPNOTSUPP;
-		if (netdev_has_any_upper_dev(upper_dev) &&
-		    (!netif_is_bridge_master(upper_dev) ||
-		     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
-							  upper_dev))) {
-			NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a device that already has an upper device is not supported");
-			return -EINVAL;
-		}
-		if (netif_is_lag_master(upper_dev) &&
-		    !mlxsw_sp_master_lag_check(mlxsw_sp, upper_dev,
-					       info->upper_info, extack))
-			return -EINVAL;
-		if (netif_is_lag_master(upper_dev) && vlan_uses_dev(dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "Master device is a LAG master and this device has a VLAN");
-			return -EINVAL;
-		}
-		if (netif_is_lag_port(dev) && is_vlan_dev(upper_dev) &&
-		    !netif_is_lag_master(vlan_dev_real_dev(upper_dev))) {
-			NL_SET_ERR_MSG_MOD(extack, "Can not put a VLAN on a LAG port");
-			return -EINVAL;
-		}
-		if (netif_is_macvlan(upper_dev) &&
-		    !mlxsw_sp_rif_exists(mlxsw_sp, lower_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-			return -EOPNOTSUPP;
-		}
-		if (netif_is_ovs_master(upper_dev) && vlan_uses_dev(dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "Master device is an OVS master and this device has a VLAN");
-			return -EINVAL;
-		}
-		if (netif_is_ovs_port(dev) && is_vlan_dev(upper_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "Can not put a VLAN on an OVS port");
-			return -EINVAL;
-		}
-		if (netif_is_bridge_master(upper_dev)) {
-			br_vlan_get_proto(upper_dev, &proto);
-			if (br_vlan_enabled(upper_dev) &&
-			    proto != ETH_P_8021Q && proto != ETH_P_8021AD) {
-				NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a bridge with unknown VLAN protocol is not supported");
-				return -EOPNOTSUPP;
-			}
-			if (vlan_uses_dev(lower_dev) &&
-			    br_vlan_enabled(upper_dev) &&
-			    proto == ETH_P_8021AD) {
-				NL_SET_ERR_MSG_MOD(extack, "Enslaving a port that already has a VLAN upper to an 802.1ad bridge is not supported");
-				return -EOPNOTSUPP;
-			}
-		}
-		if (netif_is_bridge_port(lower_dev) && is_vlan_dev(upper_dev)) {
-			struct net_device *br_dev = netdev_master_upper_dev_get(lower_dev);
-
-			if (br_vlan_enabled(br_dev)) {
-				br_vlan_get_proto(br_dev, &proto);
-				if (proto == ETH_P_8021AD) {
-					NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are not supported on a port enslaved to an 802.1ad bridge");
-					return -EOPNOTSUPP;
-				}
-			}
-		}
-		if (is_vlan_dev(upper_dev) &&
-		    ntohs(vlan_dev_vlan_proto(upper_dev)) != ETH_P_8021Q) {
-			NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are only supported with 802.1q VLAN protocol");
-			return -EOPNOTSUPP;
-		}
+
+		err = mlxsw_sp_prechangeupper_sanity_checks(mlxsw_sp,
+							    dev, lower_dev,
+							    upper_dev,
+							    info,
+							    extack);
+		if (err)
+			return err;
+
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
@@ -4260,6 +4302,46 @@ static int mlxsw_sp_netdevice_lag_event(struct net_device *lag_dev,
 	return 0;
 }
 
+static int
+mlxsw_sp_vlan_prechangeupper_sanity_checks(struct mlxsw_sp *mlxsw_sp,
+					   struct net_device *vlan_dev,
+					   struct net_device *upper_dev,
+					   struct netdev_notifier_changeupper_info *info,
+					   struct netlink_ext_ack *extack)
+{
+	if (!netif_is_bridge_master(upper_dev) &&
+	    !netif_is_macvlan(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
+		return -EINVAL;
+	}
+
+	if (!info->linking)
+		return 0;
+
+	if (netif_is_bridge_master(upper_dev) &&
+	    !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp, upper_dev) &&
+	    mlxsw_sp_bridge_has_vxlan(upper_dev) &&
+	    !mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
+		return -EOPNOTSUPP;
+
+	if (netdev_has_any_upper_dev(upper_dev) &&
+	    (!netif_is_bridge_master(upper_dev) ||
+	     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
+						  upper_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Enslaving a port to a device that already has an upper device is not supported");
+		return -EINVAL;
+	}
+
+	if (netif_is_macvlan(upper_dev) &&
+	    !mlxsw_sp_rif_exists(mlxsw_sp, vlan_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
 					      struct net_device *dev,
 					      unsigned long event, void *ptr,
@@ -4277,30 +4359,14 @@ static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
 	switch (event) {
 	case NETDEV_PRECHANGEUPPER:
 		upper_dev = info->upper_dev;
-		if (!netif_is_bridge_master(upper_dev) &&
-		    !netif_is_macvlan(upper_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "Unknown upper device type");
-			return -EINVAL;
-		}
-		if (!info->linking)
-			break;
-		if (netif_is_bridge_master(upper_dev) &&
-		    !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp, upper_dev) &&
-		    mlxsw_sp_bridge_has_vxlan(upper_dev) &&
-		    !mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
-			return -EOPNOTSUPP;
-		if (netdev_has_any_upper_dev(upper_dev) &&
-		    (!netif_is_bridge_master(upper_dev) ||
-		     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
-							  upper_dev))) {
-			NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a device that already has an upper device is not supported");
-			return -EINVAL;
-		}
-		if (netif_is_macvlan(upper_dev) &&
-		    !mlxsw_sp_rif_exists(mlxsw_sp, vlan_dev)) {
-			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
-			return -EOPNOTSUPP;
-		}
+
+		err = mlxsw_sp_vlan_prechangeupper_sanity_checks(mlxsw_sp,
+								 vlan_dev,
+								 upper_dev,
+								 info, extack);
+		if (err)
+			return err;
+
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
-- 
2.25.1

