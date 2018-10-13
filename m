Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Od5BG0bQVspCDCTA2VxlIDeUDdh3GOMvFEy3MsteksY=;
	b=jac52jHNG+6WzbGaU/QBnCuXJ1yG6FqeFRBDXLPtnKiHLxxeopUjW6jK/GrSe6ppfJoBiE7c4vvW5Pr30F0n+GEwyyzQcxon7zeZWFFfYQaF+iaX0aMGiQ6uq8bux1uqwld3Ny9vrEf4PtwAczDUpbOCijsK7pBKlPIF50MS1YM=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:51 +0000
Message-ID: <20181013171725.3261-19-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 18/18] mlxsw: spectrum_switchdev: Add
 support for VxLAN encapsulation
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

In the device, VxLAN encapsulation takes place in the FDB table where
certain {MAC, FID} entries are programmed with an underlay unicast IP.
MAC addresses that are not programmed in the FDB are flooded to the
relevant local ports and also to a list of underlay unicast IPs that are
programmed using the all zeros MAC address in the VxLAN driver.

One difference between the hardware and software data paths is the fact
that in the software data path there are two FDB lookups prior to the
encapsulation of the packet. First in the bridge's FDB table using {MAC,
VID} and another in the VxLAN's FDB table using {MAC, VNI}.

Therefore, when a new VxLAN FDB entry is notified, it is only programmed
to the device if there is a corresponding entry in the bridge's FDB
table. Similarly, when a new bridge FDB entry pointing to the VxLAN
device is notified, it is only programmed to the device if there is a
corresponding entry in the VxLAN's FDB table.

Note that the above scheme will result in a discrepancy between both
data paths if only one FDB table is populated in the software data path.
For example, if only the bridge's FDB is populated with an entry
pointing to a VxLAN device, then a packet hitting the entry will only be
flooded by the kernel to remote VTEPs whereas the device will also flood
the packets to other local ports member in the VLAN.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 406 +++++++++++++++++-
 1 file changed, 405 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index bab7712e1721..bc60d7a8b49d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -92,6 +92,11 @@ struct mlxsw_sp_bridge_ops {
 	struct mlxsw_sp_fid *
 		(*fid_get)(struct mlxsw_sp_bridge_device *bridge_device,
 			   u16 vid);
+	struct mlxsw_sp_fid *
+		(*fid_lookup)(struct mlxsw_sp_bridge_device *bridge_device,
+			      u16 vid);
+	u16 (*fid_vid)(struct mlxsw_sp_bridge_device *bridge_device,
+		       const struct mlxsw_sp_fid *fid);
 };
=20
 static int
@@ -1242,6 +1247,51 @@ static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool ad=
ding)
 			MLXSW_REG_SFD_OP_WRITE_REMOVE;
 }
=20
+static int mlxsw_sp_port_fdb_tunnel_uc_op(struct mlxsw_sp *mlxsw_sp,
+					  const char *mac, u16 fid,
+					  enum mlxsw_sp_l3proto proto,
+					  const union mlxsw_sp_l3addr *addr,
+					  bool adding, bool dynamic)
+{
+	enum mlxsw_reg_sfd_uc_tunnel_protocol sfd_proto;
+	char *sfd_pl;
+	u8 num_rec;
+	u32 uip;
+	int err;
+
+	switch (proto) {
+	case MLXSW_SP_L3_PROTO_IPV4:
+		uip =3D be32_to_cpu(addr->addr4);
+		sfd_proto =3D MLXSW_REG_SFD_UC_TUNNEL_PROTOCOL_IPV4;
+		break;
+	case MLXSW_SP_L3_PROTO_IPV6: /* fall through */
+	default:
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
+
+	sfd_pl =3D kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
+	if (!sfd_pl)
+		return -ENOMEM;
+
+	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
+	mlxsw_reg_sfd_uc_tunnel_pack(sfd_pl, 0,
+				     mlxsw_sp_sfd_rec_policy(dynamic), mac, fid,
+				     MLXSW_REG_SFD_REC_ACTION_NOP, uip,
+				     sfd_proto);
+	num_rec =3D mlxsw_reg_sfd_num_rec_get(sfd_pl);
+	err =3D mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
+	if (err)
+		goto out;
+
+	if (num_rec !=3D mlxsw_reg_sfd_num_rec_get(sfd_pl))
+		err =3D -EBUSY;
+
+out:
+	kfree(sfd_pl);
+	return err;
+}
+
 static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_p=
ort,
 				     const char *mac, u16 fid, bool adding,
 				     enum mlxsw_reg_sfd_rec_action action,
@@ -1979,12 +2029,29 @@ mlxsw_sp_bridge_8021q_fid_get(struct mlxsw_sp_bridg=
e_device *bridge_device,
 	return mlxsw_sp_fid_8021q_get(mlxsw_sp, vid);
 }
=20
+static struct mlxsw_sp_fid *
+mlxsw_sp_bridge_8021q_fid_lookup(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
+				 u16 vid)
+{
+	WARN_ON(1);
+	return NULL;
+}
+
+static u16
+mlxsw_sp_bridge_8021q_fid_vid(struct mlxsw_sp_bridge_device *bridge_device=
,
+			      const struct mlxsw_sp_fid *fid)
+{
+	return mlxsw_sp_fid_8021q_vid(fid);
+}
+
 static const struct mlxsw_sp_bridge_ops mlxsw_sp_bridge_8021q_ops =3D {
 	.port_join	=3D mlxsw_sp_bridge_8021q_port_join,
 	.port_leave	=3D mlxsw_sp_bridge_8021q_port_leave,
 	.vxlan_join	=3D mlxsw_sp_bridge_8021q_vxlan_join,
 	.vxlan_leave	=3D mlxsw_sp_bridge_8021q_vxlan_leave,
 	.fid_get	=3D mlxsw_sp_bridge_8021q_fid_get,
+	.fid_lookup	=3D mlxsw_sp_bridge_8021q_fid_lookup,
+	.fid_vid	=3D mlxsw_sp_bridge_8021q_fid_vid,
 };
=20
 static bool
@@ -2140,12 +2207,34 @@ mlxsw_sp_bridge_8021d_fid_get(struct mlxsw_sp_bridg=
e_device *bridge_device,
 	return ERR_PTR(err);
 }
=20
+static struct mlxsw_sp_fid *
+mlxsw_sp_bridge_8021d_fid_lookup(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
+				 u16 vid)
+{
+	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
+
+	/* The only valid VLAN for a VLAN-unaware bridge is 0 */
+	if (vid)
+		return NULL;
+
+	return mlxsw_sp_fid_8021d_lookup(mlxsw_sp, bridge_device->dev->ifindex);
+}
+
+static u16
+mlxsw_sp_bridge_8021d_fid_vid(struct mlxsw_sp_bridge_device *bridge_device=
,
+			      const struct mlxsw_sp_fid *fid)
+{
+	return 0;
+}
+
 static const struct mlxsw_sp_bridge_ops mlxsw_sp_bridge_8021d_ops =3D {
 	.port_join	=3D mlxsw_sp_bridge_8021d_port_join,
 	.port_leave	=3D mlxsw_sp_bridge_8021d_port_leave,
 	.vxlan_join	=3D mlxsw_sp_bridge_8021d_vxlan_join,
 	.vxlan_leave	=3D mlxsw_sp_bridge_8021d_vxlan_leave,
 	.fid_get	=3D mlxsw_sp_bridge_8021d_fid_get,
+	.fid_lookup	=3D mlxsw_sp_bridge_8021d_fid_lookup,
+	.fid_vid	=3D mlxsw_sp_bridge_8021d_fid_vid,
 };
=20
 int mlxsw_sp_port_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
@@ -2419,11 +2508,126 @@ static void mlxsw_sp_fdb_notify_work(struct work_s=
truct *work)
=20
 struct mlxsw_sp_switchdev_event_work {
 	struct work_struct work;
-	struct switchdev_notifier_fdb_info fdb_info;
+	union {
+		struct switchdev_notifier_fdb_info fdb_info;
+		struct switchdev_notifier_vxlan_fdb_info vxlan_fdb_info;
+	};
 	struct net_device *dev;
 	unsigned long event;
 };
=20
+static void
+mlxsw_sp_switchdev_vxlan_addr_convert(const union vxlan_addr *vxlan_addr,
+				      enum mlxsw_sp_l3proto *proto,
+				      union mlxsw_sp_l3addr *addr)
+{
+	if (vxlan_addr->sa.sa_family =3D=3D AF_INET) {
+		addr->addr4 =3D vxlan_addr->sin.sin_addr.s_addr;
+		*proto =3D MLXSW_SP_L3_PROTO_IPV4;
+	} else {
+		addr->addr6 =3D vxlan_addr->sin6.sin6_addr;
+		*proto =3D MLXSW_SP_L3_PROTO_IPV6;
+	}
+}
+
+static void
+mlxsw_sp_switchdev_bridge_vxlan_fdb_event(struct mlxsw_sp *mlxsw_sp,
+					  struct mlxsw_sp_switchdev_event_work *
+					  switchdev_work,
+					  struct mlxsw_sp_fid *fid, __be32 vni)
+{
+	struct switchdev_notifier_vxlan_fdb_info vxlan_fdb_info;
+	struct switchdev_notifier_fdb_info *fdb_info;
+	struct net_device *dev =3D switchdev_work->dev;
+	enum mlxsw_sp_l3proto proto;
+	union mlxsw_sp_l3addr addr;
+	int err;
+
+	fdb_info =3D &switchdev_work->fdb_info;
+	err =3D vxlan_fdb_find_uc(dev, fdb_info->addr, vni, &vxlan_fdb_info);
+	if (err)
+		return;
+
+	mlxsw_sp_switchdev_vxlan_addr_convert(&vxlan_fdb_info.remote_ip,
+					      &proto, &addr);
+
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		err =3D mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp,
+						     vxlan_fdb_info.eth_addr,
+						     mlxsw_sp_fid_index(fid),
+						     proto, &addr, true, false);
+		if (err)
+			return;
+		vxlan_fdb_info.offloaded =3D true;
+		call_switchdev_notifiers(SWITCHDEV_VXLAN_FDB_OFFLOADED, dev,
+					 &vxlan_fdb_info.info);
+		mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
+					    vxlan_fdb_info.eth_addr,
+					    fdb_info->vid, dev, true);
+		break;
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		err =3D mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp,
+						     vxlan_fdb_info.eth_addr,
+						     mlxsw_sp_fid_index(fid),
+						     proto, &addr, false,
+						     false);
+		vxlan_fdb_info.offloaded =3D false;
+		call_switchdev_notifiers(SWITCHDEV_VXLAN_FDB_OFFLOADED, dev,
+					 &vxlan_fdb_info.info);
+		break;
+	}
+}
+
+static void
+mlxsw_sp_switchdev_bridge_nve_fdb_event(struct mlxsw_sp_switchdev_event_wo=
rk *
+					switchdev_work)
+{
+	struct mlxsw_sp_bridge_device *bridge_device;
+	struct net_device *dev =3D switchdev_work->dev;
+	struct net_device *br_dev;
+	struct mlxsw_sp *mlxsw_sp;
+	struct mlxsw_sp_fid *fid;
+	__be32 vni;
+	int err;
+
+	if (switchdev_work->event !=3D SWITCHDEV_FDB_ADD_TO_DEVICE &&
+	    switchdev_work->event !=3D SWITCHDEV_FDB_DEL_TO_DEVICE)
+		return;
+
+	if (!switchdev_work->fdb_info.added_by_user)
+		return;
+
+	if (!netif_running(dev))
+		return;
+	br_dev =3D netdev_master_upper_dev_get(dev);
+	if (!br_dev)
+		return;
+	if (!netif_is_bridge_master(br_dev))
+		return;
+	mlxsw_sp =3D mlxsw_sp_lower_get(br_dev);
+	if (!mlxsw_sp)
+		return;
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (!bridge_device)
+		return;
+
+	fid =3D bridge_device->ops->fid_lookup(bridge_device,
+					     switchdev_work->fdb_info.vid);
+	if (!fid)
+		return;
+
+	err =3D mlxsw_sp_fid_vni(fid, &vni);
+	if (err)
+		goto out;
+
+	mlxsw_sp_switchdev_bridge_vxlan_fdb_event(mlxsw_sp, switchdev_work, fid,
+						  vni);
+
+out:
+	mlxsw_sp_fid_put(fid);
+}
+
 static void mlxsw_sp_switchdev_bridge_fdb_event_work(struct work_struct *w=
ork)
 {
 	struct mlxsw_sp_switchdev_event_work *switchdev_work =3D
@@ -2434,6 +2638,11 @@ static void mlxsw_sp_switchdev_bridge_fdb_event_work=
(struct work_struct *work)
 	int err;
=20
 	rtnl_lock();
+	if (netif_is_vxlan(dev)) {
+		mlxsw_sp_switchdev_bridge_nve_fdb_event(switchdev_work);
+		goto out;
+	}
+
 	mlxsw_sp_port =3D mlxsw_sp_port_dev_lower_find(dev);
 	if (!mlxsw_sp_port)
 		goto out;
@@ -2473,6 +2682,189 @@ static void mlxsw_sp_switchdev_bridge_fdb_event_wor=
k(struct work_struct *work)
 	dev_put(dev);
 }
=20
+static void
+mlxsw_sp_switchdev_vxlan_fdb_add(struct mlxsw_sp *mlxsw_sp,
+				 struct mlxsw_sp_switchdev_event_work *
+				 switchdev_work)
+{
+	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
+	struct mlxsw_sp_bridge_device *bridge_device;
+	struct net_device *dev =3D switchdev_work->dev;
+	u8 all_zeros_mac[ETH_ALEN] =3D { 0 };
+	enum mlxsw_sp_l3proto proto;
+	union mlxsw_sp_l3addr addr;
+	struct net_device *br_dev;
+	struct mlxsw_sp_fid *fid;
+	u16 vid;
+	int err;
+
+	vxlan_fdb_info =3D &switchdev_work->vxlan_fdb_info;
+	br_dev =3D netdev_master_upper_dev_get(dev);
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (!bridge_device)
+		return;
+
+	fid =3D mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan_fdb_info->vni);
+	if (!fid)
+		return;
+
+	mlxsw_sp_switchdev_vxlan_addr_convert(&vxlan_fdb_info->remote_ip,
+					      &proto, &addr);
+
+	if (ether_addr_equal(vxlan_fdb_info->eth_addr, all_zeros_mac)) {
+		err =3D mlxsw_sp_nve_flood_ip_add(mlxsw_sp, fid, proto, &addr);
+		if (err) {
+			mlxsw_sp_fid_put(fid);
+			return;
+		}
+		vxlan_fdb_info->offloaded =3D true;
+		call_switchdev_notifiers(SWITCHDEV_VXLAN_FDB_OFFLOADED, dev,
+					 &vxlan_fdb_info->info);
+		mlxsw_sp_fid_put(fid);
+		return;
+	}
+
+	/* The device has a single FDB table, whereas Linux has two - one
+	 * in the bridge driver and another in the VxLAN driver. We only
+	 * program an entry to the device if the MAC points to the VxLAN
+	 * device in the bridge's FDB table
+	 */
+	vid =3D bridge_device->ops->fid_vid(bridge_device, fid);
+	if (br_fdb_find_port(br_dev, vxlan_fdb_info->eth_addr, vid) !=3D dev)
+		goto err_br_fdb_find;
+
+	err =3D mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp, vxlan_fdb_info->eth_addr=
,
+					     mlxsw_sp_fid_index(fid), proto,
+					     &addr, true, false);
+	if (err)
+		goto err_fdb_tunnel_uc_op;
+	vxlan_fdb_info->offloaded =3D true;
+	call_switchdev_notifiers(SWITCHDEV_VXLAN_FDB_OFFLOADED, dev,
+				 &vxlan_fdb_info->info);
+	mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				    vxlan_fdb_info->eth_addr, vid, dev, true);
+
+	mlxsw_sp_fid_put(fid);
+
+	return;
+
+err_fdb_tunnel_uc_op:
+err_br_fdb_find:
+	mlxsw_sp_fid_put(fid);
+}
+
+static void
+mlxsw_sp_switchdev_vxlan_fdb_del(struct mlxsw_sp *mlxsw_sp,
+				 struct mlxsw_sp_switchdev_event_work *
+				 switchdev_work)
+{
+	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
+	struct mlxsw_sp_bridge_device *bridge_device;
+	struct net_device *dev =3D switchdev_work->dev;
+	struct net_device *br_dev =3D netdev_master_upper_dev_get(dev);
+	u8 all_zeros_mac[ETH_ALEN] =3D { 0 };
+	enum mlxsw_sp_l3proto proto;
+	union mlxsw_sp_l3addr addr;
+	struct mlxsw_sp_fid *fid;
+	u16 vid;
+
+	vxlan_fdb_info =3D &switchdev_work->vxlan_fdb_info;
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (!bridge_device)
+		return;
+
+	fid =3D mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan_fdb_info->vni);
+	if (!fid)
+		return;
+
+	mlxsw_sp_switchdev_vxlan_addr_convert(&vxlan_fdb_info->remote_ip,
+					      &proto, &addr);
+
+	if (ether_addr_equal(vxlan_fdb_info->eth_addr, all_zeros_mac)) {
+		mlxsw_sp_nve_flood_ip_del(mlxsw_sp, fid, proto, &addr);
+		mlxsw_sp_fid_put(fid);
+		return;
+	}
+
+	mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp, vxlan_fdb_info->eth_addr,
+				       mlxsw_sp_fid_index(fid), proto, &addr,
+				       false, false);
+	vid =3D bridge_device->ops->fid_vid(bridge_device, fid);
+	mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				    vxlan_fdb_info->eth_addr, vid, dev, false);
+
+	mlxsw_sp_fid_put(fid);
+}
+
+static void mlxsw_sp_switchdev_vxlan_fdb_event_work(struct work_struct *wo=
rk)
+{
+	struct mlxsw_sp_switchdev_event_work *switchdev_work =3D
+		container_of(work, struct mlxsw_sp_switchdev_event_work, work);
+	struct net_device *dev =3D switchdev_work->dev;
+	struct mlxsw_sp *mlxsw_sp;
+	struct net_device *br_dev;
+
+	rtnl_lock();
+
+	if (!netif_running(dev))
+		goto out;
+	br_dev =3D netdev_master_upper_dev_get(dev);
+	if (!br_dev)
+		goto out;
+	if (!netif_is_bridge_master(br_dev))
+		goto out;
+	mlxsw_sp =3D mlxsw_sp_lower_get(br_dev);
+	if (!mlxsw_sp)
+		goto out;
+
+	switch (switchdev_work->event) {
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE:
+		mlxsw_sp_switchdev_vxlan_fdb_add(mlxsw_sp, switchdev_work);
+		break;
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
+		mlxsw_sp_switchdev_vxlan_fdb_del(mlxsw_sp, switchdev_work);
+		break;
+	}
+
+out:
+	rtnl_unlock();
+	kfree(switchdev_work);
+	dev_put(dev);
+}
+
+static int
+mlxsw_sp_switchdev_vxlan_work_prepare(struct mlxsw_sp_switchdev_event_work=
 *
+				      switchdev_work,
+				      struct switchdev_notifier_info *info)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(switchdev_work->dev);
+	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
+	struct vxlan_config *cfg =3D &vxlan->cfg;
+
+	vxlan_fdb_info =3D container_of(info,
+				      struct switchdev_notifier_vxlan_fdb_info,
+				      info);
+
+	if (vxlan_fdb_info->remote_port !=3D cfg->dst_port)
+		return -EOPNOTSUPP;
+	if (vxlan_fdb_info->remote_vni !=3D cfg->vni)
+		return -EOPNOTSUPP;
+	if (vxlan_fdb_info->vni !=3D cfg->vni)
+		return -EOPNOTSUPP;
+	if (vxlan_fdb_info->remote_ifindex)
+		return -EOPNOTSUPP;
+	if (is_multicast_ether_addr(vxlan_fdb_info->eth_addr))
+		return -EOPNOTSUPP;
+	if (vxlan_addr_multicast(&vxlan_fdb_info->remote_ip))
+		return -EOPNOTSUPP;
+
+	switchdev_work->vxlan_fdb_info =3D *vxlan_fdb_info;
+
+	return 0;
+}
+
 /* Called under rcu_read_lock() */
 static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 				    unsigned long event, void *ptr)
@@ -2482,6 +2874,7 @@ static int mlxsw_sp_switchdev_event(struct notifier_b=
lock *unused,
 	struct switchdev_notifier_fdb_info *fdb_info;
 	struct switchdev_notifier_info *info =3D ptr;
 	struct net_device *br_dev;
+	int err;
=20
 	/* Tunnel devices are not our uppers, so check their master instead */
 	br_dev =3D netdev_master_upper_dev_get_rcu(dev);
@@ -2522,6 +2915,16 @@ static int mlxsw_sp_switchdev_event(struct notifier_=
block *unused,
 		 */
 		dev_hold(dev);
 		break;
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE: /* fall through */
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
+		INIT_WORK(&switchdev_work->work,
+			  mlxsw_sp_switchdev_vxlan_fdb_event_work);
+		err =3D mlxsw_sp_switchdev_vxlan_work_prepare(switchdev_work,
+							    info);
+		if (err)
+			goto err_vxlan_work_prepare;
+		dev_hold(dev);
+		break;
 	default:
 		kfree(switchdev_work);
 		return NOTIFY_DONE;
@@ -2531,6 +2934,7 @@ static int mlxsw_sp_switchdev_event(struct notifier_b=
lock *unused,
=20
 	return NOTIFY_DONE;
=20
+err_vxlan_work_prepare:
 err_addr_alloc:
 	kfree(switchdev_work);
 	return NOTIFY_BAD;
--=20
2.17.2

