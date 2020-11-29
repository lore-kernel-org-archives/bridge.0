Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ESOaBNnNxJNHPiBFMVKbv2S1rT/H+17nOXR1Q+mGQf4=; b=lHZSU6WU
 lJvURKFPuD1rtzoN3qsSgFNb9yqHeWllAbDDw87hmYHO5CLSaPZ2wEy+VIz+SxC7
 SMXuLfVL65/fkcNBAZYlzoMscYo6B8/izcC8I9hE6lYAMNhOAoUgb/mnm5tw0PIp
 bPiPyna9a/f7uEOwsOBeECpCRmQ9HCpsFeidqfv2zU7qYJLlIhOUD+gjroRlyqyh
 RLUIJZ7RPKQmv017Q2YlN4Smuo3GrCgQLXR+VEarAGKq1SFX/dDvL/6/nkepaelg
 y1urEcd+MLwdagxXh+HwwTCG0BPIFW8sEdpqJWRs3L0hpT84t/KVJuOtsb5vYfZ9
 joBF1Vw8n3+SGA==
From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 29 Nov 2020 14:54:06 +0200
Message-Id: <20201129125407.1391557-9-idosch@idosch.org>
In-Reply-To: <20201129125407.1391557-1-idosch@idosch.org>
References: <20201129125407.1391557-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 8/9] mlxsw: Add QinQ configuration vetoes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, petrm@nvidia.com, amcohen@nvidia.com, danieller@nvidia.com, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>, jiri@nvidia.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Danielle Ratson <danieller@nvidia.com>

After adding support for QinQ, a.k.a 802.1ad protocol, there are a few
scenarios that should be vetoed.

The vetoes are motivated by various ASIC limitations.
For example, a port that is member in a 802.1ad bridge cannot have 802.1q
uppers as the port needs to be configured to treat 802.1q packets as
untagged packets.

Veto all those unsupported scenarios and return suitable messages.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 44 +++++++++++++++++++
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  9 ++++
 .../mellanox/mlxsw/spectrum_switchdev.c       | 24 ++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index fe954e87c5a7..385eb3c3b362 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3893,6 +3893,7 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 	struct net_device *upper_dev;
 	struct mlxsw_sp *mlxsw_sp;
 	int err = 0;
+	u16 proto;
 
 	mlxsw_sp_port = netdev_priv(dev);
 	mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
@@ -3950,6 +3951,36 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 			NL_SET_ERR_MSG_MOD(extack, "Can not put a VLAN on an OVS port");
 			return -EINVAL;
 		}
+		if (netif_is_bridge_master(upper_dev)) {
+			br_vlan_get_proto(upper_dev, &proto);
+			if (br_vlan_enabled(upper_dev) &&
+			    proto != ETH_P_8021Q && proto != ETH_P_8021AD) {
+				NL_SET_ERR_MSG_MOD(extack, "Enslaving a port to a bridge with unknown VLAN protocol is not supported");
+				return -EOPNOTSUPP;
+			}
+			if (vlan_uses_dev(lower_dev) &&
+			    br_vlan_enabled(upper_dev) &&
+			    proto == ETH_P_8021AD) {
+				NL_SET_ERR_MSG_MOD(extack, "Enslaving a port that already has a VLAN upper to an 802.1ad bridge is not supported");
+				return -EOPNOTSUPP;
+			}
+		}
+		if (netif_is_bridge_port(lower_dev) && is_vlan_dev(upper_dev)) {
+			struct net_device *br_dev = netdev_master_upper_dev_get(lower_dev);
+
+			if (br_vlan_enabled(br_dev)) {
+				br_vlan_get_proto(br_dev, &proto);
+				if (proto == ETH_P_8021AD) {
+					NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are not supported on a port enslaved to an 802.1ad bridge");
+					return -EOPNOTSUPP;
+				}
+			}
+		}
+		if (is_vlan_dev(upper_dev) &&
+		    ntohs(vlan_dev_vlan_proto(upper_dev)) != ETH_P_8021Q) {
+			NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are only supported with 802.1q VLAN protocol");
+			return -EOPNOTSUPP;
+		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
@@ -4215,6 +4246,7 @@ static int mlxsw_sp_netdevice_bridge_event(struct net_device *br_dev,
 	struct netdev_notifier_changeupper_info *info = ptr;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
+	u16 proto;
 
 	if (!mlxsw_sp)
 		return 0;
@@ -4230,6 +4262,18 @@ static int mlxsw_sp_netdevice_bridge_event(struct net_device *br_dev,
 		}
 		if (!info->linking)
 			break;
+		if (br_vlan_enabled(br_dev)) {
+			br_vlan_get_proto(br_dev, &proto);
+			if (proto == ETH_P_8021AD) {
+				NL_SET_ERR_MSG_MOD(extack, "Uppers are not supported on top of an 802.1ad bridge");
+				return -EOPNOTSUPP;
+			}
+		}
+		if (is_vlan_dev(upper_dev) &&
+		    ntohs(vlan_dev_vlan_proto(upper_dev)) != ETH_P_8021Q) {
+			NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are only supported with 802.1q VLAN protocol");
+			return -EOPNOTSUPP;
+		}
 		if (netif_is_macvlan(upper_dev) &&
 		    !mlxsw_sp_rif_exists(mlxsw_sp, br_dev)) {
 			NL_SET_ERR_MSG_MOD(extack, "macvlan is only supported on top of router interfaces");
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 12b5d7fbe1e2..85223647fdb6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -7857,6 +7857,15 @@ static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
 
 	switch (event) {
 	case NETDEV_UP:
+		if (netif_is_bridge_master(l3_dev) && br_vlan_enabled(l3_dev)) {
+			u16 proto;
+
+			br_vlan_get_proto(l3_dev, &proto);
+			if (proto == ETH_P_8021AD) {
+				NL_SET_ERR_MSG_MOD(extack, "Adding an IP address to 802.1ad bridge is not supported");
+				return -EOPNOTSUPP;
+			}
+		}
 		rif = mlxsw_sp_rif_create(mlxsw_sp, &params, extack);
 		if (IS_ERR(rif))
 			return PTR_ERR(rif);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index d8ee8801331c..9c4e17607e6a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -764,6 +764,25 @@ static int mlxsw_sp_port_attr_br_vlan_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return -EINVAL;
 }
 
+static int mlxsw_sp_port_attr_br_vlan_proto_set(struct mlxsw_sp_port *mlxsw_sp_port,
+						struct switchdev_trans *trans,
+						struct net_device *orig_dev,
+						u16 vlan_proto)
+{
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	struct mlxsw_sp_bridge_device *bridge_device;
+
+	if (!switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, orig_dev);
+	if (WARN_ON(!bridge_device))
+		return -EINVAL;
+
+	netdev_err(bridge_device->dev, "VLAN protocol can't be changed on existing bridge\n");
+	return -EINVAL;
+}
+
 static int mlxsw_sp_port_attr_mrouter_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					  struct switchdev_trans *trans,
 					  struct net_device *orig_dev,
@@ -933,6 +952,11 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 						     attr->orig_dev,
 						     attr->u.vlan_filtering);
 		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL:
+		err = mlxsw_sp_port_attr_br_vlan_proto_set(mlxsw_sp_port, trans,
+							   attr->orig_dev,
+							   attr->u.vlan_protocol);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_MROUTER:
 		err = mlxsw_sp_port_attr_mrouter_set(mlxsw_sp_port, trans,
 						     attr->orig_dev,
-- 
2.28.0

