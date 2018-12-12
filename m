Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=yEx3tjHdv26Ihp1Vi7WcyEZ05s+QQuxRaeNR9RfW8n0=;
	b=PMc6RUytDgXGwtxj7qVqwsb/kXKRSfQFsT4lfAVe28vbKLYA2nvnlMtBewL2xwmP8kilClidV+hB2MFv2cW84xamzy81FtMrWVLHGhbbprv+4rCHpaIhSkckzZGAQugkiRVtJFAzFkx1Zlyl7ZG0ill0LMM49yvCSnd4VL3gw0o=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:03:00 +0000
Message-ID: <48c3e657f42efc52132789e6abaf77ddde8bf1b5.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 6/9] mlxsw: spectrum_switchdev:
 Propagate extack on VXLAN VLAN events
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

Now that VLAN port object addition notifications carry an extack,
propagate it from mlxsw_sp_switchdev_vxlan_vlans_add() through
mlxsw_sp_switchdev_vxlan_vlan_add() to
mlxsw_sp_bridge_8021q_vxlan_join().

This code path is used when a VLAN is added to a VXLAN netdevice that
cannot be offloaded.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 4b9292289256..906dfded3098 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3205,7 +3205,8 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *ml=
xsw_sp,
 				  struct mlxsw_sp_bridge_device *bridge_device,
 				  const struct net_device *vxlan_dev, u16 vid,
 				  bool flag_untagged, bool flag_pvid,
-				  struct switchdev_trans *trans)
+				  struct switchdev_trans *trans,
+				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan =3D netdev_priv(vxlan_dev);
 	__be32 vni =3D vxlan->cfg.vni;
@@ -3237,7 +3238,7 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *ml=
xsw_sp,
 		if (!flag_untagged || !flag_pvid)
 			return 0;
 		return mlxsw_sp_bridge_8021q_vxlan_join(bridge_device,
-							vxlan_dev, vid, NULL);
+							vxlan_dev, vid, extack);
 	}
=20
 	/* Second case: FID is associated with the VNI and the VLAN associated
@@ -3277,7 +3278,7 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *ml=
xsw_sp,
 		return 0;
=20
 	err =3D mlxsw_sp_bridge_8021q_vxlan_join(bridge_device, vxlan_dev, vid,
-					       NULL);
+					       extack);
 	if (err)
 		goto err_vxlan_join;
=20
@@ -3326,10 +3327,12 @@ mlxsw_sp_switchdev_vxlan_vlans_add(struct net_devic=
e *vxlan_dev,
 	bool flag_pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	struct switchdev_trans *trans =3D port_obj_info->trans;
 	struct mlxsw_sp_bridge_device *bridge_device;
+	struct netlink_ext_ack *extack;
 	struct mlxsw_sp *mlxsw_sp;
 	struct net_device *br_dev;
 	u16 vid;
=20
+	extack =3D switchdev_notifier_info_to_extack(&port_obj_info->info);
 	br_dev =3D netdev_master_upper_dev_get(vxlan_dev);
 	if (!br_dev)
 		return 0;
@@ -3353,7 +3356,8 @@ mlxsw_sp_switchdev_vxlan_vlans_add(struct net_device =
*vxlan_dev,
 		err =3D mlxsw_sp_switchdev_vxlan_vlan_add(mlxsw_sp, bridge_device,
 							vxlan_dev, vid,
 							flag_untagged,
-							flag_pvid, trans);
+							flag_pvid, trans,
+							extack);
 		if (err)
 			return err;
 	}
--=20
2.4.11

