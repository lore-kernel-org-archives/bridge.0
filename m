Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5kGvhU5O5W3c+xTYjvp0gh4fgBo+L7qCVntucXMgK8E=;
	b=ZfG+xiTIVtoMrhK8xbUuKxPkfYQPDkdNk4IDuSSPIdYjbbYI4hAdsLfteiwARaio0Dslt7OIFU319cS3ewfuXWW4fezD/EoQEscyWeM5NECZ3dQZx45Yt577oPdgw/Jr+X/QgeNdJZ2212PDnHKsI8vc2tqEAnuxyJnXx5IPQ5Y=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:07:04 +0000
Message-ID: <20181128200558.31343-6-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 5/8] mlxsw: spectrum: Enable VxLAN
 enslavement to VLAN-aware bridges
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

Commit 1c30d1836aeb ("mlxsw: spectrum: Enable VxLAN enslavement to
bridges") enabled the enslavement of VxLAN devices to bridges that have
mlxsw ports (or their upper) as slaves. This patch extends mlxsw to also
support VLAN-aware bridges.

The patch is similar in nature to mentioned commit, but there is one
major difference. With VLAN-aware bridges, the VxLAN device's VNI is
mapped to the VLAN that is configured as PVID and egress untagged on the
bridge port.

Therefore, the driver is extended to listen to VLAN configuration on
VxLAN devices of interest and enable / disable NVE encapsulation on the
corresponding 802.1Q FIDs.

To prevent ambiguity, the driver makes sure that a given VLAN is not
configured as PVID and egress untagged on multiple VxLAN devices. This
sanitization takes place both when a port is enslaved to a bridge with
existing VxLAN devices and when a VLAN is added to / removed from a
VxLAN device of interest.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  45 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  21 ++
 .../mellanox/mlxsw/spectrum_switchdev.c       | 352 +++++++++++++++++-
 3 files changed, 404 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.c
index d215e3270376..3b3b59314125 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4782,6 +4782,30 @@ static bool mlxsw_sp_bridge_has_multiple_vxlans(stru=
ct net_device *br_dev)
 	return num_vxlans > 1;
 }
=20
+static bool mlxsw_sp_bridge_vxlan_vlan_is_valid(struct net_device *br_dev)
+{
+	DECLARE_BITMAP(vlans, VLAN_N_VID) =3D {0};
+	struct net_device *dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(br_dev, dev, iter) {
+		u16 pvid;
+		int err;
+
+		if (!netif_is_vxlan(dev))
+			continue;
+
+		err =3D mlxsw_sp_vxlan_mapped_vid(dev, &pvid);
+		if (err || !pvid)
+			continue;
+
+		if (test_and_set_bit(pvid, vlans))
+			return false;
+	}
+
+	return true;
+}
+
 static bool mlxsw_sp_bridge_vxlan_is_valid(struct net_device *br_dev,
 					   struct netlink_ext_ack *extack)
 {
@@ -4790,13 +4814,15 @@ static bool mlxsw_sp_bridge_vxlan_is_valid(struct n=
et_device *br_dev,
 		return false;
 	}
=20
-	if (br_vlan_enabled(br_dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "VLAN filtering can not be enabled on a bridg=
e with a VxLAN device");
+	if (!br_vlan_enabled(br_dev) &&
+	    mlxsw_sp_bridge_has_multiple_vxlans(br_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Multiple VxLAN devices are not supported in =
a VLAN-unaware bridge");
 		return false;
 	}
=20
-	if (mlxsw_sp_bridge_has_multiple_vxlans(br_dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Multiple VxLAN devices are not supported in =
a VLAN-unaware bridge");
+	if (br_vlan_enabled(br_dev) &&
+	    !mlxsw_sp_bridge_vxlan_vlan_is_valid(br_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Multiple VxLAN devices cannot have the same =
VLAN as PVID and egress untagged");
 		return false;
 	}
=20
@@ -5171,9 +5197,20 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlx=
sw_sp *mlxsw_sp,
 		if (cu_info->linking) {
 			if (!netif_running(dev))
 				return 0;
+			/* When the bridge is VLAN-aware, the VNI of the VxLAN
+			 * device needs to be mapped to a VLAN, but at this
+			 * point no VLANs are configured on the VxLAN device
+			 */
+			if (br_vlan_enabled(upper_dev))
+				return 0;
 			return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev,
 							  dev, 0, extack);
 		} else {
+			/* VLANs were already flushed, which triggered the
+			 * necessary cleanup
+			 */
+			if (br_vlan_enabled(upper_dev))
+				return 0;
 			mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, dev);
 		}
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 0361d0d1b1e2..a3e564e0da39 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/rhashtable.h>
 #include <linux/bitops.h>
+#include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/list.h>
 #include <linux/dcbnl.h>
@@ -261,6 +262,26 @@ static inline bool mlxsw_sp_bridge_has_vxlan(struct ne=
t_device *br_dev)
 	return !!mlxsw_sp_bridge_vxlan_dev_find(br_dev);
 }
=20
+static inline int
+mlxsw_sp_vxlan_mapped_vid(const struct net_device *vxlan_dev, u16 *p_vid)
+{
+	struct bridge_vlan_info vinfo;
+	u16 vid =3D 0;
+	int err;
+
+	err =3D br_vlan_get_pvid(vxlan_dev, &vid);
+	if (err || !vid)
+		goto out;
+
+	err =3D br_vlan_get_info(vxlan_dev, vid, &vinfo);
+	if (err || !(vinfo.flags & BRIDGE_VLAN_INFO_UNTAGGED))
+		vid =3D 0;
+
+out:
+	*p_vid =3D vid;
+	return err;
+}
+
 static inline bool
 mlxsw_sp_port_is_pause_en(const struct mlxsw_sp_port *mlxsw_sp_port)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 30c861129c8d..7c38231bbd89 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2006,8 +2006,76 @@ mlxsw_sp_bridge_8021q_vxlan_join(struct mlxsw_sp_bri=
dge_device *bridge_device,
 				 const struct net_device *vxlan_dev, u16 vid,
 				 struct netlink_ext_ack *extack)
 {
-	WARN_ON(1);
-	return -EINVAL;
+	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
+	struct vxlan_dev *vxlan =3D netdev_priv(vxlan_dev);
+	struct mlxsw_sp_nve_params params =3D {
+		.type =3D MLXSW_SP_NVE_TYPE_VXLAN,
+		.vni =3D vxlan->cfg.vni,
+		.dev =3D vxlan_dev,
+	};
+	struct mlxsw_sp_fid *fid;
+	int err;
+
+	/* If the VLAN is 0, we need to find the VLAN that is configured as
+	 * PVID and egress untagged on the bridge port of the VxLAN device.
+	 * It is possible no such VLAN exists
+	 */
+	if (!vid) {
+		err =3D mlxsw_sp_vxlan_mapped_vid(vxlan_dev, &vid);
+		if (err || !vid)
+			return err;
+	}
+
+	/* If no other port is member in the VLAN, then the FID does not exist.
+	 * NVE will be enabled on the FID once a port joins the VLAN
+	 */
+	fid =3D mlxsw_sp_fid_8021q_lookup(mlxsw_sp, vid);
+	if (!fid)
+		return 0;
+
+	if (mlxsw_sp_fid_vni_is_set(fid)) {
+		err =3D -EINVAL;
+		goto err_vni_exists;
+	}
+
+	err =3D mlxsw_sp_nve_fid_enable(mlxsw_sp, fid, &params, extack);
+	if (err)
+		goto err_nve_fid_enable;
+
+	/* The tunnel port does not hold a reference on the FID. Only
+	 * local ports and the router port
+	 */
+	mlxsw_sp_fid_put(fid);
+
+	return 0;
+
+err_nve_fid_enable:
+err_vni_exists:
+	mlxsw_sp_fid_put(fid);
+	return err;
+}
+
+static struct net_device *
+mlxsw_sp_bridge_8021q_vxlan_dev_find(struct net_device *br_dev, u16 vid)
+{
+	struct net_device *dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(br_dev, dev, iter) {
+		u16 pvid;
+		int err;
+
+		if (!netif_is_vxlan(dev))
+			continue;
+
+		err =3D mlxsw_sp_vxlan_mapped_vid(dev, &pvid);
+		if (err || pvid !=3D vid)
+			continue;
+
+		return dev;
+	}
+
+	return NULL;
 }
=20
 static struct mlxsw_sp_fid *
@@ -2015,8 +2083,38 @@ mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridge=
_device *bridge_device,
 			      u16 vid)
 {
 	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
+	struct net_device *vxlan_dev;
+	struct mlxsw_sp_fid *fid;
+	int err;
=20
-	return mlxsw_sp_fid_8021q_get(mlxsw_sp, vid);
+	fid =3D mlxsw_sp_fid_8021q_get(mlxsw_sp, vid);
+	if (IS_ERR(fid))
+		return fid;
+
+	if (mlxsw_sp_fid_vni_is_set(fid))
+		return fid;
+
+	/* Find the VxLAN device that has the specified VLAN configured as
+	 * PVID and egress untagged. There can be at most one such device
+	 */
+	vxlan_dev =3D mlxsw_sp_bridge_8021q_vxlan_dev_find(bridge_device->dev,
+							 vid);
+	if (!vxlan_dev)
+		return fid;
+
+	if (!netif_running(vxlan_dev))
+		return fid;
+
+	err =3D mlxsw_sp_bridge_8021q_vxlan_join(bridge_device, vxlan_dev, vid,
+					       NULL);
+	if (err)
+		goto err_vxlan_join;
+
+	return fid;
+
+err_vxlan_join:
+	mlxsw_sp_fid_put(fid);
+	return ERR_PTR(err);
 }
=20
 static struct mlxsw_sp_fid *
@@ -3092,22 +3190,256 @@ static struct notifier_block mlxsw_sp_switchdev_no=
tifier =3D {
 	.notifier_call =3D mlxsw_sp_switchdev_event,
 };
=20
+static int
+mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *mlxsw_sp,
+				  struct mlxsw_sp_bridge_device *bridge_device,
+				  const struct net_device *vxlan_dev, u16 vid,
+				  bool flag_untagged, bool flag_pvid,
+				  struct switchdev_trans *trans)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(vxlan_dev);
+	__be32 vni =3D vxlan->cfg.vni;
+	struct mlxsw_sp_fid *fid;
+	u16 old_vid;
+	int err;
+
+	/* We cannot have the same VLAN as PVID and egress untagged on multiple
+	 * VxLAN devices. Note that we get this notification before the VLAN is
+	 * actually added to the bridge's database, so it is not possible for
+	 * the lookup function to return 'vxlan_dev'
+	 */
+	if (flag_untagged && flag_pvid &&
+	    mlxsw_sp_bridge_8021q_vxlan_dev_find(bridge_device->dev, vid))
+		return -EINVAL;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (!netif_running(vxlan_dev))
+		return 0;
+
+	/* First case: FID is not associated with this VNI, but the new VLAN
+	 * is both PVID and egress untagged. Need to enable NVE on the FID, if
+	 * it exists
+	 */
+	fid =3D mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vni);
+	if (!fid) {
+		if (!flag_untagged || !flag_pvid)
+			return 0;
+		return mlxsw_sp_bridge_8021q_vxlan_join(bridge_device,
+							vxlan_dev, vid, NULL);
+	}
+
+	/* Second case: FID is associated with the VNI and the VLAN associated
+	 * with the FID is the same as the notified VLAN. This means the flags
+	 * (PVID / egress untagged) were toggled and that NVE should be
+	 * disabled on the FID
+	 */
+	old_vid =3D mlxsw_sp_fid_8021q_vid(fid);
+	if (vid =3D=3D old_vid) {
+		if (WARN_ON(flag_untagged && flag_pvid)) {
+			mlxsw_sp_fid_put(fid);
+			return -EINVAL;
+		}
+		mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+		mlxsw_sp_fid_put(fid);
+		return 0;
+	}
+
+	/* Third case: A new VLAN was configured on the VxLAN device, but this
+	 * VLAN is not PVID, so there is nothing to do.
+	 */
+	if (!flag_pvid) {
+		mlxsw_sp_fid_put(fid);
+		return 0;
+	}
+
+	/* Fourth case: Thew new VLAN is PVID, which means the VLAN currently
+	 * mapped to the VNI should be unmapped
+	 */
+	mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+	mlxsw_sp_fid_put(fid);
+
+	/* Fifth case: The new VLAN is also egress untagged, which means the
+	 * VLAN needs to be mapped to the VNI
+	 */
+	if (!flag_untagged)
+		return 0;
+
+	err =3D mlxsw_sp_bridge_8021q_vxlan_join(bridge_device, vxlan_dev, vid,
+					       NULL);
+	if (err)
+		goto err_vxlan_join;
+
+	return 0;
+
+err_vxlan_join:
+	mlxsw_sp_bridge_8021q_vxlan_join(bridge_device, vxlan_dev, old_vid,
+					 NULL);
+	return err;
+}
+
+static void
+mlxsw_sp_switchdev_vxlan_vlan_del(struct mlxsw_sp *mlxsw_sp,
+				  struct mlxsw_sp_bridge_device *bridge_device,
+				  const struct net_device *vxlan_dev, u16 vid)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(vxlan_dev);
+	__be32 vni =3D vxlan->cfg.vni;
+	struct mlxsw_sp_fid *fid;
+
+	if (!netif_running(vxlan_dev))
+		return;
+
+	fid =3D mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vni);
+	if (!fid)
+		return;
+
+	/* A different VLAN than the one mapped to the VNI is deleted */
+	if (mlxsw_sp_fid_8021q_vid(fid) !=3D vid)
+		goto out;
+
+	mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, vxlan_dev);
+
+out:
+	mlxsw_sp_fid_put(fid);
+}
+
+static int
+mlxsw_sp_switchdev_vxlan_vlans_add(struct net_device *vxlan_dev,
+				   struct switchdev_notifier_port_obj_info *
+				   port_obj_info)
+{
+	struct switchdev_obj_port_vlan *vlan =3D
+		SWITCHDEV_OBJ_PORT_VLAN(port_obj_info->obj);
+	bool flag_untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool flag_pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct switchdev_trans *trans =3D port_obj_info->trans;
+	struct mlxsw_sp_bridge_device *bridge_device;
+	struct mlxsw_sp *mlxsw_sp;
+	struct net_device *br_dev;
+	u16 vid;
+
+	br_dev =3D netdev_master_upper_dev_get(vxlan_dev);
+	if (!br_dev)
+		return 0;
+
+	mlxsw_sp =3D mlxsw_sp_lower_get(br_dev);
+	if (!mlxsw_sp)
+		return 0;
+
+	port_obj_info->handled =3D true;
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (!bridge_device)
+		return -EINVAL;
+
+	if (!bridge_device->vlan_enabled)
+		return 0;
+
+	for (vid =3D vlan->vid_begin; vid <=3D vlan->vid_end; vid++) {
+		int err;
+
+		err =3D mlxsw_sp_switchdev_vxlan_vlan_add(mlxsw_sp, bridge_device,
+							vxlan_dev, vid,
+							flag_untagged,
+							flag_pvid, trans);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void
+mlxsw_sp_switchdev_vxlan_vlans_del(struct net_device *vxlan_dev,
+				   struct switchdev_notifier_port_obj_info *
+				   port_obj_info)
+{
+	struct switchdev_obj_port_vlan *vlan =3D
+		SWITCHDEV_OBJ_PORT_VLAN(port_obj_info->obj);
+	struct mlxsw_sp_bridge_device *bridge_device;
+	struct mlxsw_sp *mlxsw_sp;
+	struct net_device *br_dev;
+	u16 vid;
+
+	br_dev =3D netdev_master_upper_dev_get(vxlan_dev);
+	if (!br_dev)
+		return;
+
+	mlxsw_sp =3D mlxsw_sp_lower_get(br_dev);
+	if (!mlxsw_sp)
+		return;
+
+	port_obj_info->handled =3D true;
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (!bridge_device)
+		return;
+
+	if (!bridge_device->vlan_enabled)
+		return;
+
+	for (vid =3D vlan->vid_begin; vid <=3D vlan->vid_end; vid++)
+		mlxsw_sp_switchdev_vxlan_vlan_del(mlxsw_sp, bridge_device,
+						  vxlan_dev, vid);
+}
+
+static int
+mlxsw_sp_switchdev_handle_vxlan_obj_add(struct net_device *vxlan_dev,
+					struct switchdev_notifier_port_obj_info *
+					port_obj_info)
+{
+	int err =3D 0;
+
+	switch (port_obj_info->obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err =3D mlxsw_sp_switchdev_vxlan_vlans_add(vxlan_dev,
+							 port_obj_info);
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static void
+mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
+					struct switchdev_notifier_port_obj_info *
+					port_obj_info)
+{
+	switch (port_obj_info->obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		mlxsw_sp_switchdev_vxlan_vlans_del(vxlan_dev, port_obj_info);
+		break;
+	default:
+		break;
+	}
+}
+
 static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused=
,
 					     unsigned long event, void *ptr)
 {
 	struct net_device *dev =3D switchdev_notifier_info_to_dev(ptr);
-	int err;
+	int err =3D 0;
=20
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
-		err =3D switchdev_handle_port_obj_add(dev, ptr,
-						    mlxsw_sp_port_dev_check,
-						    mlxsw_sp_port_obj_add);
+		if (netif_is_vxlan(dev))
+			err =3D mlxsw_sp_switchdev_handle_vxlan_obj_add(dev, ptr);
+		else
+			err =3D switchdev_handle_port_obj_add(dev, ptr,
+							mlxsw_sp_port_dev_check,
+							mlxsw_sp_port_obj_add);
 		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_OBJ_DEL:
-		err =3D switchdev_handle_port_obj_del(dev, ptr,
-						    mlxsw_sp_port_dev_check,
-						    mlxsw_sp_port_obj_del);
+		if (netif_is_vxlan(dev))
+			mlxsw_sp_switchdev_handle_vxlan_obj_del(dev, ptr);
+		else
+			err =3D switchdev_handle_port_obj_del(dev, ptr,
+							mlxsw_sp_port_dev_check,
+							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
 	}
=20
--=20
2.19.1

