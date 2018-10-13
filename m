Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=waSOtTn1jPlrhtwVa8gXU3acYJbpcNgUi0SljFkdPpg=;
	b=SnDxOvtUoapW/fx/sf0ODG+natUE4B8+RHuDavZY2h9bKBpLi9F1yK99iRycL273Ld8fBox1Xwqid5F8A4zk9NehOXuDMJ3+9qKBtY17M4G4JkSdCp+ncRaOOAt35zFkjVWoYCD2YNcpF3czJKcrYCu7LsYwQUS3qsXtKs0+okY=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:49 +0000
Message-ID: <20181013171725.3261-18-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 17/18] mlxsw: spectrum: Enable VxLAN
 enslavement to bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Enslavement of VxLAN devices to offloaded bridges was never forbidden by
mlxsw, but this patch makes sure the required configuration is performed
in order to allow VxLAN encapsulation and decapsulation to take place in
the device.

The patch handles both the case where a VxLAN device is enslaved to an
already offloaded bridge and the case where the first mlxsw port is
enslaved to a bridge that already has VxLAN device configured.

Invalid configurations are sanitized and an error string is returned via
extack.

Since encapsulation and decapsulation do not occur when the VxLAN device
is down, the driver makes sure to enable / disable these functionalities
based on NETDEV_PRE_UP and NETDEV_DOWN events.

Note that NETDEV_PRE_UP is used in favor of NETDEV_UP, as the former
allows to veto the operation, if necessary.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 104 +++++++++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  26 ++++
 .../mellanox/mlxsw/spectrum_switchdev.c       | 137 +++++++++++++++++-
 3 files changed, 266 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.c
index 68079b16adfa..8a4983adae94 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4587,6 +4587,41 @@ static void mlxsw_sp_port_ovs_leave(struct mlxsw_sp_=
port *mlxsw_sp_port)
 	mlxsw_sp_port_vp_mode_set(mlxsw_sp_port, false);
 }
=20
+static bool mlxsw_sp_bridge_has_multiple_vxlans(struct net_device *br_dev)
+{
+	unsigned int num_vxlans =3D 0;
+	struct net_device *dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(br_dev, dev, iter) {
+		if (netif_is_vxlan(dev))
+			num_vxlans++;
+	}
+
+	return num_vxlans > 1;
+}
+
+static bool mlxsw_sp_bridge_vxlan_is_valid(struct net_device *br_dev,
+					   struct netlink_ext_ack *extack)
+{
+	if (br_multicast_enabled(br_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Multicast can not be enabled on a bridge wit=
h a VxLAN device");
+		return false;
+	}
+
+	if (br_vlan_enabled(br_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "VLAN filtering can not be enabled on a bridg=
e with a VxLAN device");
+		return false;
+	}
+
+	if (mlxsw_sp_bridge_has_multiple_vxlans(br_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Multiple VxLAN devices are not supported in =
a VLAN-unaware bridge");
+		return false;
+	}
+
+	return true;
+}
+
 static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_de=
v,
 					       struct net_device *dev,
 					       unsigned long event, void *ptr)
@@ -4616,6 +4651,11 @@ static int mlxsw_sp_netdevice_port_upper_event(struc=
t net_device *lower_dev,
 		}
 		if (!info->linking)
 			break;
+		if (netif_is_bridge_master(upper_dev) &&
+		    !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp, upper_dev) &&
+		    mlxsw_sp_bridge_has_vxlan(upper_dev) &&
+		    !mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
+			return -EOPNOTSUPP;
 		if (netdev_has_any_upper_dev(upper_dev) &&
 		    (!netif_is_bridge_master(upper_dev) ||
 		     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
@@ -4773,6 +4813,11 @@ static int mlxsw_sp_netdevice_port_vlan_event(struct=
 net_device *vlan_dev,
 		}
 		if (!info->linking)
 			break;
+		if (netif_is_bridge_master(upper_dev) &&
+		    !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp, upper_dev) &&
+		    mlxsw_sp_bridge_has_vxlan(upper_dev) &&
+		    !mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
+			return -EOPNOTSUPP;
 		if (netdev_has_any_upper_dev(upper_dev) &&
 		    (!netif_is_bridge_master(upper_dev) ||
 		     !mlxsw_sp_bridge_device_is_offloaded(mlxsw_sp,
@@ -4919,6 +4964,63 @@ static bool mlxsw_sp_is_vrf_event(unsigned long even=
t, void *ptr)
 	return netif_is_l3_master(info->upper_dev);
 }
=20
+static int mlxsw_sp_netdevice_vxlan_event(struct mlxsw_sp *mlxsw_sp,
+					  struct net_device *dev,
+					  unsigned long event, void *ptr)
+{
+	struct netdev_notifier_changeupper_info *cu_info;
+	struct netdev_notifier_info *info =3D ptr;
+	struct netlink_ext_ack *extack;
+	struct net_device *upper_dev;
+
+	extack =3D netdev_notifier_info_to_extack(info);
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		cu_info =3D container_of(info,
+				       struct netdev_notifier_changeupper_info,
+				       info);
+		upper_dev =3D cu_info->upper_dev;
+		if (!netif_is_bridge_master(upper_dev))
+			return 0;
+		if (!mlxsw_sp_lower_get(upper_dev))
+			return 0;
+		if (!mlxsw_sp_bridge_vxlan_is_valid(upper_dev, extack))
+			return -EOPNOTSUPP;
+		if (cu_info->linking) {
+			if (!netif_running(dev))
+				return 0;
+			return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev,
+							  dev, extack);
+		} else {
+			mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, upper_dev, dev);
+		}
+		break;
+	case NETDEV_PRE_UP:
+		upper_dev =3D netdev_master_upper_dev_get(dev);
+		if (!upper_dev)
+			return 0;
+		if (!netif_is_bridge_master(upper_dev))
+			return 0;
+		if (!mlxsw_sp_lower_get(upper_dev))
+			return 0;
+		return mlxsw_sp_bridge_vxlan_join(mlxsw_sp, upper_dev, dev,
+						  extack);
+	case NETDEV_DOWN:
+		upper_dev =3D netdev_master_upper_dev_get(dev);
+		if (!upper_dev)
+			return 0;
+		if (!netif_is_bridge_master(upper_dev))
+			return 0;
+		if (!mlxsw_sp_lower_get(upper_dev))
+			return 0;
+		mlxsw_sp_bridge_vxlan_leave(mlxsw_sp, upper_dev, dev);
+		break;
+	}
+
+	return 0;
+}
+
 static int mlxsw_sp_netdevice_event(struct notifier_block *nb,
 				    unsigned long event, void *ptr)
 {
@@ -4935,6 +5037,8 @@ static int mlxsw_sp_netdevice_event(struct notifier_b=
lock *nb,
 	}
 	mlxsw_sp_span_respin(mlxsw_sp);
=20
+	if (netif_is_vxlan(dev))
+		err =3D mlxsw_sp_netdevice_vxlan_event(mlxsw_sp, dev, event, ptr);
 	if (mlxsw_sp_netdev_is_ipip_ol(mlxsw_sp, dev))
 		err =3D mlxsw_sp_netdevice_ipip_ol_event(mlxsw_sp, dev,
 						       event, ptr);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 2d5eca78576a..0db27b7a9727 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -241,6 +241,25 @@ struct mlxsw_sp_port {
 	struct mlxsw_sp_acl_block *eg_acl_block;
 };
=20
+static inline struct net_device *
+mlxsw_sp_bridge_vxlan_dev_find(struct net_device *br_dev)
+{
+	struct net_device *dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(br_dev, dev, iter) {
+		if (netif_is_vxlan(dev))
+			return dev;
+	}
+
+	return NULL;
+}
+
+static inline bool mlxsw_sp_bridge_has_vxlan(struct net_device *br_dev)
+{
+	return !!mlxsw_sp_bridge_vxlan_dev_find(br_dev);
+}
+
 static inline bool
 mlxsw_sp_port_is_pause_en(const struct mlxsw_sp_port *mlxsw_sp_port)
 {
@@ -336,6 +355,13 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port *=
mlxsw_sp_port,
 				struct net_device *br_dev);
 bool mlxsw_sp_bridge_device_is_offloaded(const struct mlxsw_sp *mlxsw_sp,
 					 const struct net_device *br_dev);
+int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
+			       const struct net_device *br_dev,
+			       const struct net_device *vxlan_dev,
+			       struct netlink_ext_ack *extack);
+void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
+				 const struct net_device *br_dev,
+				 const struct net_device *vxlan_dev);
=20
 /* spectrum.c */
 int mlxsw_sp_port_ets_set(struct mlxsw_sp_port *mlxsw_sp_port,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a89075beef94..bab7712e1721 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -15,6 +15,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/netlink.h>
 #include <net/switchdev.h>
+#include <net/vxlan.h>
=20
 #include "spectrum_span.h"
 #include "spectrum_switchdev.h"
@@ -83,6 +84,11 @@ struct mlxsw_sp_bridge_ops {
 	void (*port_leave)(struct mlxsw_sp_bridge_device *bridge_device,
 			   struct mlxsw_sp_bridge_port *bridge_port,
 			   struct mlxsw_sp_port *mlxsw_sp_port);
+	int (*vxlan_join)(struct mlxsw_sp_bridge_device *bridge_device,
+			  const struct net_device *vxlan_dev,
+			  struct netlink_ext_ack *extack);
+	void (*vxlan_leave)(struct mlxsw_sp_bridge_device *bridge_device,
+			    const struct net_device *vxlan_dev);
 	struct mlxsw_sp_fid *
 		(*fid_get)(struct mlxsw_sp_bridge_device *bridge_device,
 			   u16 vid);
@@ -1949,6 +1955,21 @@ mlxsw_sp_bridge_8021q_port_leave(struct mlxsw_sp_bri=
dge_device *bridge_device,
 	mlxsw_sp_port_pvid_set(mlxsw_sp_port, 1);
 }
=20
+static int
+mlxsw_sp_bridge_8021q_vxlan_join(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
+				 const struct net_device *vxlan_dev,
+				 struct netlink_ext_ack *extack)
+{
+	WARN_ON(1);
+	return -EINVAL;
+}
+
+static void
+mlxsw_sp_bridge_8021q_vxlan_leave(struct mlxsw_sp_bridge_device *bridge_de=
vice,
+				  const struct net_device *vxlan_dev)
+{
+}
+
 static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridge_device *bridge_device=
,
 			      u16 vid)
@@ -1961,6 +1982,8 @@ mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridge_=
device *bridge_device,
 static const struct mlxsw_sp_bridge_ops mlxsw_sp_bridge_8021q_ops =3D {
 	.port_join	=3D mlxsw_sp_bridge_8021q_port_join,
 	.port_leave	=3D mlxsw_sp_bridge_8021q_port_leave,
+	.vxlan_join	=3D mlxsw_sp_bridge_8021q_vxlan_join,
+	.vxlan_leave	=3D mlxsw_sp_bridge_8021q_vxlan_leave,
 	.fid_get	=3D mlxsw_sp_bridge_8021q_fid_get,
 };
=20
@@ -2025,18 +2048,103 @@ mlxsw_sp_bridge_8021d_port_leave(struct mlxsw_sp_b=
ridge_device *bridge_device,
 	mlxsw_sp_port_vlan_bridge_leave(mlxsw_sp_port_vlan);
 }
=20
+static int
+mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
+				 const struct net_device *vxlan_dev,
+				 struct netlink_ext_ack *extack)
+{
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
+	fid =3D mlxsw_sp_fid_8021d_lookup(mlxsw_sp, bridge_device->dev->ifindex);
+	if (!fid)
+		return -EINVAL;
+
+	if (mlxsw_sp_fid_vni_is_set(fid))
+		return -EINVAL;
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
+	mlxsw_sp_fid_put(fid);
+	return err;
+}
+
+static void
+mlxsw_sp_bridge_8021d_vxlan_leave(struct mlxsw_sp_bridge_device *bridge_de=
vice,
+				  const struct net_device *vxlan_dev)
+{
+	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
+	struct mlxsw_sp_fid *fid;
+
+	fid =3D mlxsw_sp_fid_8021d_lookup(mlxsw_sp, bridge_device->dev->ifindex);
+	if (WARN_ON(!fid))
+		return;
+
+	/* If the VxLAN device is down, then the FID does not have a VNI */
+	if (!mlxsw_sp_fid_vni_is_set(fid))
+		goto out;
+
+	mlxsw_sp_nve_fid_disable(mlxsw_sp, fid);
+out:
+	mlxsw_sp_fid_put(fid);
+}
+
 static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021d_fid_get(struct mlxsw_sp_bridge_device *bridge_device=
,
 			      u16 vid)
 {
 	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
+	struct net_device *vxlan_dev;
+	struct mlxsw_sp_fid *fid;
+	int err;
=20
-	return mlxsw_sp_fid_8021d_get(mlxsw_sp, bridge_device->dev->ifindex);
+	fid =3D mlxsw_sp_fid_8021d_get(mlxsw_sp, bridge_device->dev->ifindex);
+	if (IS_ERR(fid))
+		return fid;
+
+	if (mlxsw_sp_fid_vni_is_set(fid))
+		return fid;
+
+	vxlan_dev =3D mlxsw_sp_bridge_vxlan_dev_find(bridge_device->dev);
+	if (!vxlan_dev)
+		return fid;
+
+	if (!netif_running(vxlan_dev))
+		return fid;
+
+	err =3D mlxsw_sp_bridge_8021d_vxlan_join(bridge_device, vxlan_dev, NULL);
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
 static const struct mlxsw_sp_bridge_ops mlxsw_sp_bridge_8021d_ops =3D {
 	.port_join	=3D mlxsw_sp_bridge_8021d_port_join,
 	.port_leave	=3D mlxsw_sp_bridge_8021d_port_leave,
+	.vxlan_join	=3D mlxsw_sp_bridge_8021d_vxlan_join,
+	.vxlan_leave	=3D mlxsw_sp_bridge_8021d_vxlan_leave,
 	.fid_get	=3D mlxsw_sp_bridge_8021d_fid_get,
 };
=20
@@ -2087,6 +2195,33 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port=
 *mlxsw_sp_port,
 	mlxsw_sp_bridge_port_put(mlxsw_sp->bridge, bridge_port);
 }
=20
+int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_sp,
+			       const struct net_device *br_dev,
+			       const struct net_device *vxlan_dev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_bridge_device *bridge_device;
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (WARN_ON(!bridge_device))
+		return -EINVAL;
+
+	return bridge_device->ops->vxlan_join(bridge_device, vxlan_dev, extack);
+}
+
+void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
+				 const struct net_device *br_dev,
+				 const struct net_device *vxlan_dev)
+{
+	struct mlxsw_sp_bridge_device *bridge_device;
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (WARN_ON(!bridge_device))
+		return;
+
+	bridge_device->ops->vxlan_leave(bridge_device, vxlan_dev);
+}
+
 static void
 mlxsw_sp_fdb_call_notifiers(enum switchdev_notifier_type type,
 			    const char *mac, u16 vid,
--=20
2.17.2

