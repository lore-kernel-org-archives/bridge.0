Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4P/Ge6nAiLAVsMDRwyL9wXn+6pB1DS52kTcU2VFkUhE=;
	b=HrdP6Rcnor0p+zjb0ivUa+7LDZTBS1/NU4C65nY6Swn3iLwaJmUrnMiuPD+gvautlfwz+EsHlY3LMHQ2ylqCVv2fZp0Fp3ilE8cMmhj+51vaV3IgaTAY3NmL9lHkNr7DDmtxlQ3kR5XE5bl3LPvrfMLJhA/KcgBw94xqs5zNuPg=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:07:01 +0000
Message-ID: <20181128200558.31343-4-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 3/8] mlxsw: spectrum_switchdev: Unify
 VxLAN leave function
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

The function mlxsw_sp_bridge_vxlan_leave() is currently split between
VLAN-aware and VLAN-unaware bridges, but actually both types can use the
same function.

The function needs to resolve the FID that corresponds to the VxLAN
device and disable NVE encapsulation on it. Instead of looking up the
FID differently for VLAN-aware and VLAN-unaware bridges, we can always
use the VxLAN's device VNI.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  4 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  1 -
 .../mellanox/mlxsw/spectrum_switchdev.c       | 42 ++++---------------
 3 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.c
index 93378d507962..9cc063af6f7b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -5174,7 +5174,7 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxs=
w_sp *mlxsw_sp,
 			return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev,
 							  dev, extack);
 		} else {
-			mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, upper_dev, dev);
+			mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, dev);
 		}
 		break;
 	case NETDEV_PRE_UP:
@@ -5195,7 +5195,7 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxs=
w_sp *mlxsw_sp,
 			return 0;
 		if (!mlxsw_sp_lower_get(upper_dev))
 			return 0;
-		mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, upper_dev, dev);
+		mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, dev);
 		break;
 	}
=20
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 55ed69038796..696c2360fbb4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -361,7 +361,6 @@ int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_s=
p,
 			       const struct net_device *vxlan_dev,
 			       struct netlink_ext_ack *extack);
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
-				 const struct net_device *br_dev,
 				 const struct net_device *vxlan_dev);
=20
 /* spectrum.c */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 108dbb764c77..801c1af81916 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -87,8 +87,6 @@ struct mlxsw_sp_bridge_ops {
 	int (*vxlan_join)(struct mlxsw_sp_bridge_device *bridge_device,
 			  const struct net_device *vxlan_dev,
 			  struct netlink_ext_ack *extack);
-	void (*vxlan_leave)(struct mlxsw_sp_bridge_device *bridge_device,
-			    const struct net_device *vxlan_dev);
 	struct mlxsw_sp_fid *
 		(*fid_get)(struct mlxsw_sp_bridge_device *bridge_device,
 			   u16 vid);
@@ -2012,12 +2010,6 @@ mlxsw_sp_bridge_8021q_vxlan_join(struct mlxsw_sp_bri=
dge_device *bridge_device,
 	return -EINVAL;
 }
=20
-static void
-mlxsw_sp_bridge_8021q_vxlan_leave(struct mlxsw_sp_bridge_device *bridge_de=
vice,
-				  const struct net_device *vxlan_dev)
-{
-}
-
 static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridge_device *bridge_device=
,
 			      u16 vid)
@@ -2047,7 +2039,6 @@ static const struct mlxsw_sp_bridge_ops mlxsw_sp_brid=
ge_8021q_ops =3D {
 	.port_join	=3D mlxsw_sp_bridge_8021q_port_join,
 	.port_leave	=3D mlxsw_sp_bridge_8021q_port_leave,
 	.vxlan_join	=3D mlxsw_sp_bridge_8021q_vxlan_join,
-	.vxlan_leave	=3D mlxsw_sp_bridge_8021q_vxlan_leave,
 	.fid_get	=3D mlxsw_sp_bridge_8021q_fid_get,
 	.fid_lookup	=3D mlxsw_sp_bridge_8021q_fid_lookup,
 	.fid_vid	=3D mlxsw_sp_bridge_8021q_fid_vid,
@@ -2152,26 +2143,6 @@ mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_bri=
dge_device *bridge_device,
 	return err;
 }
=20
-static void
-mlxsw_sp_bridge_8021d_vxlan_leave(struct mlxsw_sp_bridge_device *bridge_de=
vice,
-				  const struct net_device *vxlan_dev)
-{
-	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
-	struct mlxsw_sp_fid *fid;
-
-	fid =3D mlxsw_sp_fid_8021d_lookup(mlxsw_sp, bridge_device->dev->ifindex);
-	if (WARN_ON(!fid))
-		return;
-
-	/* If the VxLAN device is down, then the FID does not have a VNI */
-	if (!mlxsw_sp_fid_vni_is_set(fid))
-		goto out;
-
-	mlxsw_sp_nve_fid_disable(mlxsw_sp, fid);
-out:
-	mlxsw_sp_fid_put(fid);
-}
-
 static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021d_fid_get(struct mlxsw_sp_bridge_device *bridge_device=
,
 			      u16 vid)
@@ -2230,7 +2201,6 @@ static const struct mlxsw_sp_bridge_ops mlxsw_sp_brid=
ge_8021d_ops =3D {
 	.port_join	=3D mlxsw_sp_bridge_8021d_port_join,
 	.port_leave	=3D mlxsw_sp_bridge_8021d_port_leave,
 	.vxlan_join	=3D mlxsw_sp_bridge_8021d_vxlan_join,
-	.vxlan_leave	=3D mlxsw_sp_bridge_8021d_vxlan_leave,
 	.fid_get	=3D mlxsw_sp_bridge_8021d_fid_get,
 	.fid_lookup	=3D mlxsw_sp_bridge_8021d_fid_lookup,
 	.fid_vid	=3D mlxsw_sp_bridge_8021d_fid_vid,
@@ -2298,16 +2268,18 @@ int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlx=
sw_sp,
 }
=20
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
-				 const struct net_device *br_dev,
 				 const struct net_device *vxlan_dev)
 {
-	struct mlxsw_sp_bridge_device *bridge_device;
+	struct vxlan_dev *vxlan =3D netdev_priv(vxlan_dev);
+	struct mlxsw_sp_fid *fid;
=20
-	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
-	if (WARN_ON(!bridge_device))
+	/* If the VxLAN device is down, then the FID does not have a VNI */
+	fid =3D mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan->cfg.vni);
+	if (!fid)
 		return;
=20
-	bridge_device->ops->vxlan_leave(bridge_device, vxlan_dev);
+	mlxsw_sp_nve_fid_disable(mlxsw_sp, fid);
+	mlxsw_sp_fid_put(fid);
 }
=20
 static void
--=20
2.19.1

