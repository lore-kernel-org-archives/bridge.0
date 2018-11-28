Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CWH+RgTG5sDYSKxMGueQVKjn0sKfGHyL3bIon8uf5+M=;
	b=PaW/6Q4u0GLKiFlHE2kYo9H0Xw7yi4SpCtm3MQdeUxTjtcybjjagUrogjpORMCd3YpGddoJpcvgJazbQOdzZMkkIBCIyaYWv/pb1RO/v8rbtXp3OeyoLe5CGbpAK9pvuOEqHKr6dXSKjvq9p6ykpgMxJlMatIgMUnrj961bSiIo=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:07:02 +0000
Message-ID: <20181128200558.31343-5-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 4/8] mlxsw: spectrum_switchdev: Prepare
 function for VLAN-aware bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

The vxlan_join() function resolves the FID on which the VNI should be
set and then sets the VNI. Currently, the FID is simply resolved
according to the ifindex of the bridge device to which the VxLAN device
is enslaved. This works because only VLAN-unaware bridges are supported.

With VLAN-aware bridges the FID would need to be resolved based on the
VLAN to which the VNI is mapped to.

Add the VLAN ID to the argument list of the function.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 14 ++++++++------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.c
index 9cc063af6f7b..d215e3270376 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -5172,7 +5172,7 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxs=
w_sp *mlxsw_sp,
 			if (!netif_running(dev))
 				return 0;
 			return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev,
-							  dev, extack);
+							  dev, 0, extack);
 		} else {
 			mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, dev);
 		}
@@ -5185,7 +5185,7 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxs=
w_sp *mlxsw_sp,
 			return 0;
 		if (!mlxsw_sp_lower_get(upper_dev))
 			return 0;
-		return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev, dev,
+		return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev, dev, 0,
 						  extack);
 	case NETDEV_DOWN:
 		upper_dev =3D netdev_master_upper_dev_get(dev);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 696c2360fbb4..0361d0d1b1e2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -358,7 +358,7 @@ bool mlxsw_sp_bridge_device_is_offloaded(const struct m=
lxsw_sp *mlxsw_sp,
 					 const struct net_device *br_dev);
 int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
 			       const struct net_device *br_dev,
-			       const struct net_device *vxlan_dev,
+			       const struct net_device *vxlan_dev, u16 vid,
 			       struct netlink_ext_ack *extack);
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 				 const struct net_device *vxlan_dev);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 801c1af81916..30c861129c8d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -85,7 +85,7 @@ struct mlxsw_sp_bridge_ops {
 			   struct mlxsw_sp_bridge_port *bridge_port,
 			   struct mlxsw_sp_port *mlxsw_sp_port);
 	int (*vxlan_join)(struct mlxsw_sp_bridge_device *bridge_device,
-			  const struct net_device *vxlan_dev,
+			  const struct net_device *vxlan_dev, u16 vid,
 			  struct netlink_ext_ack *extack);
 	struct mlxsw_sp_fid *
 		(*fid_get)(struct mlxsw_sp_bridge_device *bridge_device,
@@ -2003,7 +2003,7 @@ mlxsw_sp_bridge_8021q_port_leave(struct mlxsw_sp_brid=
ge_device *bridge_device,
=20
 static int
 mlxsw_sp_bridge_8021q_vxlan_join(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
-				 const struct net_device *vxlan_dev,
+				 const struct net_device *vxlan_dev, u16 vid,
 				 struct netlink_ext_ack *extack)
 {
 	WARN_ON(1);
@@ -2107,7 +2107,7 @@ mlxsw_sp_bridge_8021d_port_leave(struct mlxsw_sp_brid=
ge_device *bridge_device,
=20
 static int
 mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
-				 const struct net_device *vxlan_dev,
+				 const struct net_device *vxlan_dev, u16 vid,
 				 struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
@@ -2166,7 +2166,8 @@ mlxsw_sp_bridge_8021d_fid_get(struct mlxsw_sp_bridge_=
device *bridge_device,
 	if (!netif_running(vxlan_dev))
 		return fid;
=20
-	err =3D mlxsw_sp_bridge_8021d_vxlan_join(bridge_device, vxlan_dev, NULL);
+	err =3D mlxsw_sp_bridge_8021d_vxlan_join(bridge_device, vxlan_dev, 0,
+					       NULL);
 	if (err)
 		goto err_vxlan_join;
=20
@@ -2255,7 +2256,7 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port =
*mlxsw_sp_port,
=20
 int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
 			       const struct net_device *br_dev,
-			       const struct net_device *vxlan_dev,
+			       const struct net_device *vxlan_dev, u16 vid,
 			       struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_bridge_device *bridge_device;
@@ -2264,7 +2265,8 @@ int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw=
_sp,
 	if (WARN_ON(!bridge_device))
 		return -EINVAL;
=20
-	return bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, extack);
+	return bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, vid,
+					      extack);
 }
=20
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
--=20
2.19.1

