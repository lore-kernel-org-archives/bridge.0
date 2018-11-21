Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8q4w+C876aoLe1ai4z1NhagO6Kwp/bZVjdapj+JgbxM=;
	b=LRvFf6r+s/UxiGxudaaNAafm34+hDNJxB3t1CxVZ0qWB7KT0Sx/Y1yc7btuE5uUK95GdIYpW9ffJne2awVkYVb6IHNn1vLpb+ky/PkF0sN8CBUygmSwDAKtuEZ+vBWBb6g9br/vM9LRONvByWZB6k1Kstj5XYri8z/oLIvm1a3I=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:47 +0000
Message-ID: <20181121080141.16676-13-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 12/16] mlxsw: spectrum_switchdev: Process
 learned VxLAN FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Start processing two new entry types in addition to current ones:
* Learned unicast tunnel entry
* Aged-out unicast tunnel entry

In both cases the device reports on a new {MAC, FID, IP address} tuple
that was learned / aged-out. Based on this notification, the driver
instructs the device to add / delete the entry to / from its database.

The driver also makes sure to notify the bridge and VxLAN drivers about
the new entry.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 203 ++++++++++++++++--
 1 file changed, 189 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 739a51f0a366..d3d1c1d00d98 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2311,6 +2311,71 @@ void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *ml=
xsw_sp,
 	bridge_device->ops->vxlan_leave(bridge_device, vxlan_dev);
 }
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
+mlxsw_sp_switchdev_addr_vxlan_convert(enum mlxsw_sp_l3proto proto,
+				      const union mlxsw_sp_l3addr *addr,
+				      union vxlan_addr *vxlan_addr)
+{
+	switch (proto) {
+	case MLXSW_SP_L3_PROTO_IPV4:
+		vxlan_addr->sa.sa_family =3D AF_INET;
+		vxlan_addr->sin.sin_addr.s_addr =3D addr->addr4;
+		break;
+	case MLXSW_SP_L3_PROTO_IPV6:
+		vxlan_addr->sa.sa_family =3D AF_INET6;
+		vxlan_addr->sin6.sin6_addr =3D addr->addr6;
+		break;
+	}
+}
+
+static void mlxsw_sp_fdb_vxlan_call_notifiers(struct net_device *dev,
+					      const char *mac,
+					      enum mlxsw_sp_l3proto proto,
+					      union mlxsw_sp_l3addr *addr,
+					      __be32 vni, bool adding)
+{
+	struct switchdev_notifier_vxlan_fdb_info info;
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	enum switchdev_notifier_type type;
+
+	type =3D adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE :
+			SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE;
+	mlxsw_sp_switchdev_addr_vxlan_convert(proto, addr, &info.remote_ip);
+	info.remote_port =3D vxlan->cfg.dst_port;
+	info.remote_vni =3D vni;
+	info.remote_ifindex =3D 0;
+	ether_addr_copy(info.eth_addr, mac);
+	info.vni =3D vni;
+	info.offloaded =3D adding;
+	call_switchdev_notifiers(type, dev, &info.info);
+}
+
+static void mlxsw_sp_fdb_nve_call_notifiers(struct net_device *dev,
+					    const char *mac,
+					    enum mlxsw_sp_l3proto proto,
+					    union mlxsw_sp_l3addr *addr,
+					    __be32 vni,
+					    bool adding)
+{
+	if (netif_is_vxlan(dev))
+		mlxsw_sp_fdb_vxlan_call_notifiers(dev, mac, proto, addr, vni,
+						  adding);
+}
+
 static void
 mlxsw_sp_fdb_call_notifiers(enum switchdev_notifier_type type,
 			    const char *mac, u16 vid,
@@ -2442,6 +2507,122 @@ static void mlxsw_sp_fdb_notify_mac_lag_process(str=
uct mlxsw_sp *mlxsw_sp,
 	goto do_fdb_op;
 }
=20
+static int
+__mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlxsw_sp,
+					    const struct mlxsw_sp_fid *fid,
+					    bool adding,
+					    struct net_device **nve_dev,
+					    u16 *p_vid, __be32 *p_vni)
+{
+	struct mlxsw_sp_bridge_device *bridge_device;
+	struct net_device *br_dev, *dev;
+	int nve_ifindex;
+	int err;
+
+	err =3D mlxsw_sp_fid_nve_ifindex(fid, &nve_ifindex);
+	if (err)
+		return err;
+
+	err =3D mlxsw_sp_fid_vni(fid, p_vni);
+	if (err)
+		return err;
+
+	dev =3D __dev_get_by_index(&init_net, nve_ifindex);
+	if (!dev)
+		return -EINVAL;
+	*nve_dev =3D dev;
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (adding && !br_port_flag_is_set(dev, BR_LEARNING))
+		return -EINVAL;
+
+	if (adding && netif_is_vxlan(dev)) {
+		struct vxlan_dev *vxlan =3D netdev_priv(dev);
+
+		if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+			return -EINVAL;
+	}
+
+	br_dev =3D netdev_master_upper_dev_get(dev);
+	if (!br_dev)
+		return -EINVAL;
+
+	bridge_device =3D mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
+	if (!bridge_device)
+		return -EINVAL;
+
+	*p_vid =3D bridge_device->ops->fid_vid(bridge_device, fid);
+
+	return 0;
+}
+
+static void mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlx=
sw_sp,
+						      char *sfn_pl,
+						      int rec_index,
+						      bool adding)
+{
+	enum mlxsw_reg_sfn_uc_tunnel_protocol sfn_proto;
+	enum switchdev_notifier_type type;
+	struct net_device *nve_dev;
+	union mlxsw_sp_l3addr addr;
+	struct mlxsw_sp_fid *fid;
+	char mac[ETH_ALEN];
+	u16 fid_index, vid;
+	__be32 vni;
+	u32 uip;
+	int err;
+
+	mlxsw_reg_sfn_uc_tunnel_unpack(sfn_pl, rec_index, mac, &fid_index,
+				       &uip, &sfn_proto);
+
+	fid =3D mlxsw_sp_fid_lookup_by_index(mlxsw_sp, fid_index);
+	if (!fid)
+		goto err_fid_lookup;
+
+	err =3D mlxsw_sp_nve_learned_ip_resolve(mlxsw_sp, uip,
+					      (enum mlxsw_sp_l3proto) sfn_proto,
+					      &addr);
+	if (err)
+		goto err_ip_resolve;
+
+	err =3D __mlxsw_sp_fdb_notify_mac_uc_tunnel_process(mlxsw_sp, fid, adding=
,
+							  &nve_dev, &vid, &vni);
+	if (err)
+		goto err_fdb_process;
+
+	err =3D mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp, mac, fid_index,
+					     (enum mlxsw_sp_l3proto) sfn_proto,
+					     &addr, adding, true);
+	if (err)
+		goto err_fdb_op;
+
+	mlxsw_sp_fdb_nve_call_notifiers(nve_dev, mac,
+					(enum mlxsw_sp_l3proto) sfn_proto,
+					&addr, vni, adding);
+
+	type =3D adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE :
+			SWITCHDEV_FDB_DEL_TO_BRIDGE;
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, nve_dev, adding);
+
+	mlxsw_sp_fid_put(fid);
+
+	return;
+
+err_fdb_op:
+err_fdb_process:
+err_ip_resolve:
+	mlxsw_sp_fid_put(fid);
+err_fid_lookup:
+	/* Remove an FDB entry in case we cannot process it. Otherwise the
+	 * device will keep sending the same notification over and over again.
+	 */
+	mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp, mac, fid_index,
+				       (enum mlxsw_sp_l3proto) sfn_proto, &addr,
+				       false, true);
+}
+
 static void mlxsw_sp_fdb_notify_rec_process(struct mlxsw_sp *mlxsw_sp,
 					    char *sfn_pl, int rec_index)
 {
@@ -2462,6 +2643,14 @@ static void mlxsw_sp_fdb_notify_rec_process(struct m=
lxsw_sp *mlxsw_sp,
 		mlxsw_sp_fdb_notify_mac_lag_process(mlxsw_sp, sfn_pl,
 						    rec_index, false);
 		break;
+	case MLXSW_REG_SFN_REC_TYPE_LEARNED_UNICAST_TUNNEL:
+		mlxsw_sp_fdb_notify_mac_uc_tunnel_process(mlxsw_sp, sfn_pl,
+							  rec_index, true);
+		break;
+	case MLXSW_REG_SFN_REC_TYPE_AGED_OUT_UNICAST_TUNNEL:
+		mlxsw_sp_fdb_notify_mac_uc_tunnel_process(mlxsw_sp, sfn_pl,
+							  rec_index, false);
+		break;
 	}
 }
=20
@@ -2516,20 +2705,6 @@ struct mlxsw_sp_switchdev_event_work {
 	unsigned long event;
 };
=20
-static void
-mlxsw_sp_switchdev_vxlan_addr_convert(const union vxlan_addr *vxlan_addr,
-				      enum mlxsw_sp_l3proto *proto,
-				      union mlxsw_sp_l3addr *addr)
-{
-	if (vxlan_addr->sa.sa_family =3D=3D AF_INET) {
-		addr->addr4 =3D vxlan_addr->sin.sin_addr.s_addr;
-		*proto =3D MLXSW_SP_L3_PROTO_IPV4;
-	} else {
-		addr->addr6 =3D vxlan_addr->sin6.sin6_addr;
-		*proto =3D MLXSW_SP_L3_PROTO_IPV6;
-	}
-}
-
 static void
 mlxsw_sp_switchdev_bridge_vxlan_fdb_event(struct mlxsw_sp *mlxsw_sp,
 					  struct mlxsw_sp_switchdev_event_work *
--=20
2.19.1

