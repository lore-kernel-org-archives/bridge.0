Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=e2tsz5jbg/guxMG/1iQDXuLfuwvkh+FVhasH4O1rk6A=;
	b=QMD85WRzO2553XRdcHMVLv+cFUyOXICw0ykNvj1Rf18mrs6AMGPHx7MwiTwPkKVgG/CB5ks2jwmrH2DY9B2fzJNiqWRb9Cih5fVNlORO7s7BmegHuxJMW9UJkuYVR5rAKr4pOPM+8IHcHckIxjsFvCDmtl0p50bMHOtKpNNl3Gw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:45 +0000
Message-ID: <20181121080141.16676-11-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 10/16] mlxsw: spectrum_fid: Allow FID
 lookup by its index
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

When processing a notification about a new FDB entry learned from a
VxLAN tunnel, the driver is provided with the FID index among other
parameters.

The driver potentially needs to update the bridge and VxLAN drivers
about the new entry using a pointer to the VxLAN device and the
corresponding VNI.

These two parameters are stored in the FID, so add a new function that
allows looking up a FID based on its index.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 +
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 42 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index b8f00863a0c6..879ac65886af 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -721,6 +721,8 @@ int mlxsw_sp_setup_tc_prio(struct mlxsw_sp_port *mlxsw_=
sp_port,
 			   struct tc_prio_qopt_offload *p);
=20
 /* spectrum_fid.c */
+struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_s=
p,
+						  u16 fid_index);
 int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid *fid, int *nve_ifin=
dex);
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
 						__be32 vni);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index ad2bc8e3b2ed..71b2d20afcc2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -15,6 +15,7 @@
 struct mlxsw_sp_fid_family;
=20
 struct mlxsw_sp_fid_core {
+	struct rhashtable fid_ht;
 	struct rhashtable vni_ht;
 	struct mlxsw_sp_fid_family *fid_family_arr[MLXSW_SP_FID_TYPE_MAX];
 	unsigned int *port_fid_mappings;
@@ -26,6 +27,7 @@ struct mlxsw_sp_fid {
 	unsigned int ref_count;
 	u16 fid_index;
 	struct mlxsw_sp_fid_family *fid_family;
+	struct rhash_head ht_node;
=20
 	struct rhash_head vni_ht_node;
 	__be32 vni;
@@ -45,6 +47,12 @@ struct mlxsw_sp_fid_8021d {
 	int br_ifindex;
 };
=20
+static const struct rhashtable_params mlxsw_sp_fid_ht_params =3D {
+	.key_len =3D sizeof_field(struct mlxsw_sp_fid, fid_index),
+	.key_offset =3D offsetof(struct mlxsw_sp_fid, fid_index),
+	.head_offset =3D offsetof(struct mlxsw_sp_fid, ht_node),
+};
+
 static const struct rhashtable_params mlxsw_sp_fid_vni_ht_params =3D {
 	.key_len =3D sizeof_field(struct mlxsw_sp_fid, vni),
 	.key_offset =3D offsetof(struct mlxsw_sp_fid, vni),
@@ -114,6 +122,19 @@ static const int *mlxsw_sp_packet_type_sfgc_types[] =
=3D {
 	[MLXSW_SP_FLOOD_TYPE_MC]	=3D mlxsw_sp_sfgc_mc_packet_types,
 };
=20
+struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_s=
p,
+						  u16 fid_index)
+{
+	struct mlxsw_sp_fid *fid;
+
+	fid =3D rhashtable_lookup_fast(&mlxsw_sp->fid_core->fid_ht, &fid_index,
+				     mlxsw_sp_fid_ht_params);
+	if (fid)
+		fid->ref_count++;
+
+	return fid;
+}
+
 int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid *fid, int *nve_ifin=
dex)
 {
 	if (!fid->vni_valid)
@@ -956,10 +977,17 @@ static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct m=
lxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_configure;
=20
+	err =3D rhashtable_insert_fast(&mlxsw_sp->fid_core->fid_ht, &fid->ht_node=
,
+				     mlxsw_sp_fid_ht_params);
+	if (err)
+		goto err_rhashtable_insert;
+
 	list_add(&fid->list, &fid_family->fids_list);
 	fid->ref_count++;
 	return fid;
=20
+err_rhashtable_insert:
+	fid->fid_family->ops->deconfigure(fid);
 err_configure:
 	__clear_bit(fid_index - fid_family->start_index,
 		    fid_family->fids_bitmap);
@@ -971,6 +999,7 @@ static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct mlx=
sw_sp *mlxsw_sp,
 void mlxsw_sp_fid_put(struct mlxsw_sp_fid *fid)
 {
 	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+	struct mlxsw_sp *mlxsw_sp =3D fid_family->mlxsw_sp;
=20
 	if (--fid->ref_count =3D=3D 1 && fid->rif) {
 		/* Destroy the associated RIF and let it drop the last
@@ -979,6 +1008,8 @@ void mlxsw_sp_fid_put(struct mlxsw_sp_fid *fid)
 		return mlxsw_sp_rif_destroy(fid->rif);
 	} else if (fid->ref_count =3D=3D 0) {
 		list_del(&fid->list);
+		rhashtable_remove_fast(&mlxsw_sp->fid_core->fid_ht,
+				       &fid->ht_node, mlxsw_sp_fid_ht_params);
 		fid->fid_family->ops->deconfigure(fid);
 		__clear_bit(fid->fid_index - fid_family->start_index,
 			    fid_family->fids_bitmap);
@@ -1138,9 +1169,13 @@ int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
 		return -ENOMEM;
 	mlxsw_sp->fid_core =3D fid_core;
=20
+	err =3D rhashtable_init(&fid_core->fid_ht, &mlxsw_sp_fid_ht_params);
+	if (err)
+		goto err_rhashtable_fid_init;
+
 	err =3D rhashtable_init(&fid_core->vni_ht, &mlxsw_sp_fid_vni_ht_params);
 	if (err)
-		goto err_rhashtable_init;
+		goto err_rhashtable_vni_init;
=20
 	fid_core->port_fid_mappings =3D kcalloc(max_ports, sizeof(unsigned int),
 					      GFP_KERNEL);
@@ -1169,7 +1204,9 @@ int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
 	kfree(fid_core->port_fid_mappings);
 err_alloc_port_fid_mappings:
 	rhashtable_destroy(&fid_core->vni_ht);
-err_rhashtable_init:
+err_rhashtable_vni_init:
+	rhashtable_destroy(&fid_core->fid_ht);
+err_rhashtable_fid_init:
 	kfree(fid_core);
 	return err;
 }
@@ -1184,5 +1221,6 @@ void mlxsw_sp_fids_fini(struct mlxsw_sp *mlxsw_sp)
 					       fid_core->fid_family_arr[i]);
 	kfree(fid_core->port_fid_mappings);
 	rhashtable_destroy(&fid_core->vni_ht);
+	rhashtable_destroy(&fid_core->fid_ht);
 	kfree(fid_core);
 }
--=20
2.19.1

