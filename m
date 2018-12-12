Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GWYO5PBr/sZfRkn22wopIGzYUq4ZAQuvoHKftLggC7A=;
	b=k5+RdPJKTOILXiaRM/N2H6xDfz5SN0N/f0M/FhzIQtXCEVDEdZfGzU4lIXbWU2wjlZ3tJds5SwGwrhI4rlj92FKttrbnIHhg47VN75RF4eWXCJTdvRlqYd0FqWnXBpcRWRKkN2bUa9klRVTZ1RLYZLYV+NuyhaR0VoihDv9WXkA=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:03:02 +0000
Message-ID: <668adce0a31b5b196fc2ee832a4c1662a09084b5.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 7/9] mlxsw: spectrum_switchdev:
 Propagate extack on port VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "dsa@cumulusnetworks.com" <dsa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

After switchdev_handle_port_obj_add() was extended in a preceding patch,
mlxsw_sp_port_obj_add() now takes an extack argument. Propagate it
further by extending a callee chain from mlxsw_sp_port_vlans_add(), via
mlxsw_sp_bridge_port_vlan_add() via mlxsw_sp_port_vlan_bridge_join() via
mlxsw_sp_port_vlan_fid_join() to mlxsw_sp_bridge_ops.fid_get, adding an
extack argument for each of them.

This code path is used when a VLAN is added to a port netdevice if there
already is an unoffloadable VXLAN device with that VLAN mapped.

mlxsw_sp_bridge_8021d_port_join() is updated to obey the new interfaces
changed by the abovementioned code, propagating extack ultimately from
NETDEV_CHANGEUPPER events.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 38 +++++++++++++-----=
----
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 906dfded3098..627efe7a6eef 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -89,7 +89,7 @@ struct mlxsw_sp_bridge_ops {
 			  struct netlink_ext_ack *extack);
 	struct mlxsw_sp_fid *
 		(*fid_get)(struct mlxsw_sp_bridge_device *bridge_device,
-			   u16 vid);
+			   u16 vid, struct netlink_ext_ack *extack);
 	struct mlxsw_sp_fid *
 		(*fid_lookup)(struct mlxsw_sp_bridge_device *bridge_device,
 			      u16 vid);
@@ -933,7 +933,8 @@ static int mlxsw_sp_port_attr_set(struct net_device *de=
v,
=20
 static int
 mlxsw_sp_port_vlan_fid_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
-			    struct mlxsw_sp_bridge_port *bridge_port)
+			    struct mlxsw_sp_bridge_port *bridge_port,
+			    struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port =3D mlxsw_sp_port_vlan->mlxsw_sp_port=
;
 	struct mlxsw_sp_bridge_device *bridge_device;
@@ -943,7 +944,7 @@ mlxsw_sp_port_vlan_fid_join(struct mlxsw_sp_port_vlan *=
mlxsw_sp_port_vlan,
 	int err;
=20
 	bridge_device =3D bridge_port->bridge_device;
-	fid =3D bridge_device->ops->fid_get(bridge_device, vid);
+	fid =3D bridge_device->ops->fid_get(bridge_device, vid, extack);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
=20
@@ -1011,7 +1012,8 @@ mlxsw_sp_port_pvid_determine(const struct mlxsw_sp_po=
rt *mlxsw_sp_port,
=20
 static int
 mlxsw_sp_port_vlan_bridge_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vl=
an,
-			       struct mlxsw_sp_bridge_port *bridge_port)
+			       struct mlxsw_sp_bridge_port *bridge_port,
+			       struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port =3D mlxsw_sp_port_vlan->mlxsw_sp_port=
;
 	struct mlxsw_sp_bridge_vlan *bridge_vlan;
@@ -1024,7 +1026,8 @@ mlxsw_sp_port_vlan_bridge_join(struct mlxsw_sp_port_v=
lan *mlxsw_sp_port_vlan,
 		return 0;
 	}
=20
-	err =3D mlxsw_sp_port_vlan_fid_join(mlxsw_sp_port_vlan, bridge_port);
+	err =3D mlxsw_sp_port_vlan_fid_join(mlxsw_sp_port_vlan, bridge_port,
+					  extack);
 	if (err)
 		return err;
=20
@@ -1101,7 +1104,8 @@ mlxsw_sp_port_vlan_bridge_leave(struct mlxsw_sp_port_=
vlan *mlxsw_sp_port_vlan)
 static int
 mlxsw_sp_bridge_port_vlan_add(struct mlxsw_sp_port *mlxsw_sp_port,
 			      struct mlxsw_sp_bridge_port *bridge_port,
-			      u16 vid, bool is_untagged, bool is_pvid)
+			      u16 vid, bool is_untagged, bool is_pvid,
+			      struct netlink_ext_ack *extack)
 {
 	u16 pvid =3D mlxsw_sp_port_pvid_determine(mlxsw_sp_port, vid, is_pvid);
 	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
@@ -1121,7 +1125,8 @@ mlxsw_sp_bridge_port_vlan_add(struct mlxsw_sp_port *m=
lxsw_sp_port,
 	if (err)
 		goto err_port_pvid_set;
=20
-	err =3D mlxsw_sp_port_vlan_bridge_join(mlxsw_sp_port_vlan, bridge_port);
+	err =3D mlxsw_sp_port_vlan_bridge_join(mlxsw_sp_port_vlan, bridge_port,
+					     extack);
 	if (err)
 		goto err_port_vlan_bridge_join;
=20
@@ -1171,7 +1176,8 @@ mlxsw_sp_br_ban_rif_pvid_change(struct mlxsw_sp *mlxs=
w_sp,
=20
 static int mlxsw_sp_port_vlans_add(struct mlxsw_sp_port *mlxsw_sp_port,
 				   const struct switchdev_obj_port_vlan *vlan,
-				   struct switchdev_trans *trans)
+				   struct switchdev_trans *trans,
+				   struct netlink_ext_ack *extack)
 {
 	bool flag_untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool flag_pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
@@ -1208,7 +1214,7 @@ static int mlxsw_sp_port_vlans_add(struct mlxsw_sp_po=
rt *mlxsw_sp_port,
=20
 		err =3D mlxsw_sp_bridge_port_vlan_add(mlxsw_sp_port, bridge_port,
 						    vid, flag_untagged,
-						    flag_pvid);
+						    flag_pvid, extack);
 		if (err)
 			return err;
 	}
@@ -1787,7 +1793,8 @@ static int mlxsw_sp_port_obj_add(struct net_device *d=
ev,
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		vlan =3D SWITCHDEV_OBJ_PORT_VLAN(obj);
-		err =3D mlxsw_sp_port_vlans_add(mlxsw_sp_port, vlan, trans);
+		err =3D mlxsw_sp_port_vlans_add(mlxsw_sp_port, vlan, trans,
+					      extack);
=20
 		if (switchdev_trans_ph_prepare(trans)) {
 			/* The event is emitted before the changes are actually
@@ -2087,7 +2094,7 @@ mlxsw_sp_bridge_8021q_vxlan_dev_find(struct net_devic=
e *br_dev, u16 vid)
=20
 static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridge_device *bridge_device=
,
-			      u16 vid)
+			      u16 vid, struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
 	struct net_device *vxlan_dev;
@@ -2113,7 +2120,7 @@ mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridge_=
device *bridge_device,
 		return fid;
=20
 	err =3D mlxsw_sp_bridge_8021q_vxlan_join(bridge_device, vxlan_dev, vid,
-					       NULL);
+					       extack);
 	if (err)
 		goto err_vxlan_join;
=20
@@ -2190,7 +2197,8 @@ mlxsw_sp_bridge_8021d_port_join(struct mlxsw_sp_bridg=
e_device *bridge_device,
 	if (mlxsw_sp_port_vlan->fid)
 		mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port_vlan);
=20
-	return mlxsw_sp_port_vlan_bridge_join(mlxsw_sp_port_vlan, bridge_port);
+	return mlxsw_sp_port_vlan_bridge_join(mlxsw_sp_port_vlan, bridge_port,
+					      extack);
 }
=20
 static void
@@ -2253,7 +2261,7 @@ mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_brid=
ge_device *bridge_device,
=20
 static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021d_fid_get(struct mlxsw_sp_bridge_device *bridge_device=
,
-			      u16 vid)
+			      u16 vid, struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
 	struct net_device *vxlan_dev;
@@ -2275,7 +2283,7 @@ mlxsw_sp_bridge_8021d_fid_get(struct mlxsw_sp_bridge_=
device *bridge_device,
 		return fid;
=20
 	err =3D mlxsw_sp_bridge_8021d_vxlan_join(bridge_device, vxlan_dev, 0,
-					       NULL);
+					       extack);
 	if (err)
 		goto err_vxlan_join;
=20
--=20
2.4.11

