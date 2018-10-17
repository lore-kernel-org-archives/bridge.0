Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=O633f3KptEBIOAczPcPThwRTHqm+KdIt5OyS/k606Kg=;
	b=flf5k7g3avOUeTBdJNUpcpnzn1k9o0RFriwCBnAdgcLAblMhD8lCBXcuhr5TX5TQmZD3ZfZtmTdE5VpaMGoyy9436nbg74zWBXKb9wWGJko//6+dFsIJNv7EuEtI359oiuGadtj7m2TnglthsE4MD16S10IVC/udzHayS10U+gQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:03 +0000
Message-ID: <20181017085215.26607-2-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 01/18] mlxsw: spectrum_fid: Allow
 setting and clearing NVE properties on FID
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

In the device, the VNI and the list of remote VTEPs a packet should be
flooded to is a property of the filtering identifier (FID).

During encapsulation, the VNI is taken from the FID the packet was
classified to. During decapsulation, the overlay packet is injected into
a bridge and classified to a FID based on the VNI it came with.

Allow NVE configuration for a FID. Currently, this is only supported
with 802.1D FIDs which are used for VLAN-unaware bridges. However, NVE
configuration is going to be supported with 802.1Q FIDs which is why the
related fields are placed in the common FID struct.

Since the device requires a 1:1 mapping between FID and VNI, the driver
maintains a hashtable keyed by VNI and checks if the VNI is already
associated with an existing FID.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   8 +
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 178 ++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 1f68ac2a20f4..7f96953f0409 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -679,6 +679,14 @@ int mlxsw_sp_setup_tc_prio(struct mlxsw_sp_port *mlxsw=
_sp_port,
 			   struct tc_prio_qopt_offload *p);
=20
 /* spectrum_fid.c */
+int mlxsw_sp_fid_vni(const struct mlxsw_sp_fid *fid, __be32 *vni);
+int mlxsw_sp_fid_nve_flood_index_set(struct mlxsw_sp_fid *fid,
+				     u32 nve_flood_index);
+void mlxsw_sp_fid_nve_flood_index_clear(struct mlxsw_sp_fid *fid);
+bool mlxsw_sp_fid_nve_flood_index_is_set(const struct mlxsw_sp_fid *fid);
+int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni);
+void mlxsw_sp_fid_vni_clear(struct mlxsw_sp_fid *fid);
+bool mlxsw_sp_fid_vni_is_set(const struct mlxsw_sp_fid *fid);
 int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
 			   enum mlxsw_sp_flood_type packet_type, u8 local_port,
 			   bool member);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index 715d24ff937e..7e07cf368e90 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -6,6 +6,7 @@
 #include <linux/if_vlan.h>
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
+#include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
=20
 #include "spectrum.h"
@@ -14,6 +15,7 @@
 struct mlxsw_sp_fid_family;
=20
 struct mlxsw_sp_fid_core {
+	struct rhashtable vni_ht;
 	struct mlxsw_sp_fid_family *fid_family_arr[MLXSW_SP_FID_TYPE_MAX];
 	unsigned int *port_fid_mappings;
 };
@@ -24,6 +26,12 @@ struct mlxsw_sp_fid {
 	unsigned int ref_count;
 	u16 fid_index;
 	struct mlxsw_sp_fid_family *fid_family;
+
+	struct rhash_head vni_ht_node;
+	__be32 vni;
+	u32 nve_flood_index;
+	u8 vni_valid:1,
+	   nve_flood_index_valid:1;
 };
=20
 struct mlxsw_sp_fid_8021q {
@@ -36,6 +44,12 @@ struct mlxsw_sp_fid_8021d {
 	int br_ifindex;
 };
=20
+static const struct rhashtable_params mlxsw_sp_fid_vni_ht_params =3D {
+	.key_len =3D sizeof_field(struct mlxsw_sp_fid, vni),
+	.key_offset =3D offsetof(struct mlxsw_sp_fid, vni),
+	.head_offset =3D offsetof(struct mlxsw_sp_fid, vni_ht_node),
+};
+
 struct mlxsw_sp_flood_table {
 	enum mlxsw_sp_flood_type packet_type;
 	enum mlxsw_reg_sfgc_bridge_type bridge_type;
@@ -56,6 +70,11 @@ struct mlxsw_sp_fid_ops {
 			    struct mlxsw_sp_port *port, u16 vid);
 	void (*port_vid_unmap)(struct mlxsw_sp_fid *fid,
 			       struct mlxsw_sp_port *port, u16 vid);
+	int (*vni_set)(struct mlxsw_sp_fid *fid, __be32 vni);
+	void (*vni_clear)(struct mlxsw_sp_fid *fid);
+	int (*nve_flood_index_set)(struct mlxsw_sp_fid *fid,
+				   u32 nve_flood_index);
+	void (*nve_flood_index_clear)(struct mlxsw_sp_fid *fid);
 };
=20
 struct mlxsw_sp_fid_family {
@@ -94,6 +113,104 @@ static const int *mlxsw_sp_packet_type_sfgc_types[] =
=3D {
 	[MLXSW_SP_FLOOD_TYPE_MC]	=3D mlxsw_sp_sfgc_mc_packet_types,
 };
=20
+int mlxsw_sp_fid_vni(const struct mlxsw_sp_fid *fid, __be32 *vni)
+{
+	if (!fid->vni_valid)
+		return -EINVAL;
+
+	*vni =3D fid->vni;
+
+	return 0;
+}
+
+int mlxsw_sp_fid_nve_flood_index_set(struct mlxsw_sp_fid *fid,
+				     u32 nve_flood_index)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
+	int err;
+
+	if (WARN_ON(!ops->nve_flood_index_set || fid->nve_flood_index_valid))
+		return -EINVAL;
+
+	err =3D ops->nve_flood_index_set(fid, nve_flood_index);
+	if (err)
+		return err;
+
+	fid->nve_flood_index =3D nve_flood_index;
+	fid->nve_flood_index_valid =3D true;
+
+	return 0;
+}
+
+void mlxsw_sp_fid_nve_flood_index_clear(struct mlxsw_sp_fid *fid)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
+
+	if (WARN_ON(!ops->nve_flood_index_clear || !fid->nve_flood_index_valid))
+		return;
+
+	fid->nve_flood_index_valid =3D false;
+	ops->nve_flood_index_clear(fid);
+}
+
+bool mlxsw_sp_fid_nve_flood_index_is_set(const struct mlxsw_sp_fid *fid)
+{
+	return fid->nve_flood_index_valid;
+}
+
+int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
+	struct mlxsw_sp *mlxsw_sp =3D fid_family->mlxsw_sp;
+	int err;
+
+	if (WARN_ON(!ops->vni_set || fid->vni_valid))
+		return -EINVAL;
+
+	fid->vni =3D vni;
+	err =3D rhashtable_lookup_insert_fast(&mlxsw_sp->fid_core->vni_ht,
+					    &fid->vni_ht_node,
+					    mlxsw_sp_fid_vni_ht_params);
+	if (err)
+		return err;
+
+	err =3D ops->vni_set(fid, vni);
+	if (err)
+		goto err_vni_set;
+
+	fid->vni_valid =3D true;
+
+	return 0;
+
+err_vni_set:
+	rhashtable_remove_fast(&mlxsw_sp->fid_core->vni_ht, &fid->vni_ht_node,
+			       mlxsw_sp_fid_vni_ht_params);
+	return err;
+}
+
+void mlxsw_sp_fid_vni_clear(struct mlxsw_sp_fid *fid)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
+	struct mlxsw_sp *mlxsw_sp =3D fid_family->mlxsw_sp;
+
+	if (WARN_ON(!ops->vni_clear || !fid->vni_valid))
+		return;
+
+	fid->vni_valid =3D false;
+	ops->vni_clear(fid);
+	rhashtable_remove_fast(&mlxsw_sp->fid_core->vni_ht, &fid->vni_ht_node,
+			       mlxsw_sp_fid_vni_ht_params);
+}
+
+bool mlxsw_sp_fid_vni_is_set(const struct mlxsw_sp_fid *fid)
+{
+	return fid->vni_valid;
+}
+
 static const struct mlxsw_sp_flood_table *
 mlxsw_sp_fid_flood_table_lookup(const struct mlxsw_sp_fid *fid,
 				enum mlxsw_sp_flood_type packet_type)
@@ -217,6 +334,21 @@ static int mlxsw_sp_fid_op(struct mlxsw_sp *mlxsw_sp, =
u16 fid_index,
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfmr), sfmr_pl);
 }
=20
+static int mlxsw_sp_fid_vni_op(struct mlxsw_sp *mlxsw_sp, u16 fid_index,
+			       __be32 vni, bool vni_valid, u32 nve_flood_index,
+			       bool nve_flood_index_valid)
+{
+	char sfmr_pl[MLXSW_REG_SFMR_LEN];
+
+	mlxsw_reg_sfmr_pack(sfmr_pl, MLXSW_REG_SFMR_OP_CREATE_FID, fid_index,
+			    0);
+	mlxsw_reg_sfmr_vv_set(sfmr_pl, vni_valid);
+	mlxsw_reg_sfmr_vni_set(sfmr_pl, be32_to_cpu(vni));
+	mlxsw_reg_sfmr_vtfp_set(sfmr_pl, nve_flood_index_valid);
+	mlxsw_reg_sfmr_nve_tunnel_flood_ptr_set(sfmr_pl, nve_flood_index);
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfmr), sfmr_pl);
+}
+
 static int mlxsw_sp_fid_vid_map(struct mlxsw_sp *mlxsw_sp, u16 fid_index,
 				u16 vid, bool valid)
 {
@@ -531,6 +663,41 @@ mlxsw_sp_fid_8021d_port_vid_unmap(struct mlxsw_sp_fid =
*fid,
 				    mlxsw_sp_port->local_port, vid, false);
 }
=20
+static int mlxsw_sp_fid_8021d_vni_set(struct mlxsw_sp_fid *fid, __be32 vni=
)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+
+	return mlxsw_sp_fid_vni_op(fid_family->mlxsw_sp, fid->fid_index, vni,
+				   true, fid->nve_flood_index,
+				   fid->nve_flood_index_valid);
+}
+
+static void mlxsw_sp_fid_8021d_vni_clear(struct mlxsw_sp_fid *fid)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+
+	mlxsw_sp_fid_vni_op(fid_family->mlxsw_sp, fid->fid_index, 0, false,
+			    fid->nve_flood_index, fid->nve_flood_index_valid);
+}
+
+static int mlxsw_sp_fid_8021d_nve_flood_index_set(struct mlxsw_sp_fid *fid=
,
+						  u32 nve_flood_index)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+
+	return mlxsw_sp_fid_vni_op(fid_family->mlxsw_sp, fid->fid_index,
+				   fid->vni, fid->vni_valid, nve_flood_index,
+				   true);
+}
+
+static void mlxsw_sp_fid_8021d_nve_flood_index_clear(struct mlxsw_sp_fid *=
fid)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+
+	mlxsw_sp_fid_vni_op(fid_family->mlxsw_sp, fid->fid_index, fid->vni,
+			    fid->vni_valid, 0, false);
+}
+
 static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops =3D {
 	.setup			=3D mlxsw_sp_fid_8021d_setup,
 	.configure		=3D mlxsw_sp_fid_8021d_configure,
@@ -540,6 +707,10 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021=
d_ops =3D {
 	.flood_index		=3D mlxsw_sp_fid_8021d_flood_index,
 	.port_vid_map		=3D mlxsw_sp_fid_8021d_port_vid_map,
 	.port_vid_unmap		=3D mlxsw_sp_fid_8021d_port_vid_unmap,
+	.vni_set		=3D mlxsw_sp_fid_8021d_vni_set,
+	.vni_clear		=3D mlxsw_sp_fid_8021d_vni_clear,
+	.nve_flood_index_set	=3D mlxsw_sp_fid_8021d_nve_flood_index_set,
+	.nve_flood_index_clear	=3D mlxsw_sp_fid_8021d_nve_flood_index_clear,
 };
=20
 static const struct mlxsw_sp_flood_table mlxsw_sp_fid_8021d_flood_tables[]=
 =3D {
@@ -918,6 +1089,10 @@ int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
 		return -ENOMEM;
 	mlxsw_sp->fid_core =3D fid_core;
=20
+	err =3D rhashtable_init(&fid_core->vni_ht, &mlxsw_sp_fid_vni_ht_params);
+	if (err)
+		goto err_rhashtable_init;
+
 	fid_core->port_fid_mappings =3D kcalloc(max_ports, sizeof(unsigned int),
 					      GFP_KERNEL);
 	if (!fid_core->port_fid_mappings) {
@@ -944,6 +1119,8 @@ int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
 	}
 	kfree(fid_core->port_fid_mappings);
 err_alloc_port_fid_mappings:
+	rhashtable_destroy(&fid_core->vni_ht);
+err_rhashtable_init:
 	kfree(fid_core);
 	return err;
 }
@@ -957,5 +1134,6 @@ void mlxsw_sp_fids_fini(struct mlxsw_sp *mlxsw_sp)
 		mlxsw_sp_fid_family_unregister(mlxsw_sp,
 					       fid_core->fid_family_arr[i]);
 	kfree(fid_core->port_fid_mappings);
+	rhashtable_destroy(&fid_core->vni_ht);
 	kfree(fid_core);
 }
--=20
2.17.2

