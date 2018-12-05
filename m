Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Wu249u6QPOK34YhlvZ3d1mxQEYQiIhbxXhaSX6/Ayvs=;
	b=hkCFzaFOAfekhWD5cmEkZ92du1AM/675WwWlh+hVVFY2gtUITYhEeRJDGqLDoFzVUOObBJf9Hg3fOA69nbzEOcn9cfpE+LtdyhiO8yUO0EHiKCS9V7hSTQdoEByzffyptI1K+cvVAaS7lX9rfkmdJerFzok39oznSPk/O9NdLRE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:29 +0000
Message-ID: <20181205154958.20262-6-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 05/12] mlxsw: spectrum: Track NVE type at
	FIDs
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

From: Petr Machata <petrm@mellanox.com>

A follow-up patch will add support for replay and for clearing of
offload marks. These are NVE type-sensitive operations, and to be able
to dispatch them properly, a FID needs to know what NVE type is attached
to it.

Therefore, track the NVE type at struct mlxsw_sp_fid. Extend
mlxsw_sp_fid_vni_set() to take it as an argument, and add
mlxsw_sp_fid_nve_type().

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h   | 13 ++++++++-----
 .../net/ethernet/mellanox/mlxsw/spectrum_fid.c   | 16 +++++++++++++++-
 .../net/ethernet/mellanox/mlxsw/spectrum_nve.c   |  3 ++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index a3e564e0da39..00d783136d11 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -81,6 +81,10 @@ enum mlxsw_sp_fid_type {
 	MLXSW_SP_FID_TYPE_MAX,
 };
=20
+enum mlxsw_sp_nve_type {
+	MLXSW_SP_NVE_TYPE_VXLAN,
+};
+
 struct mlxsw_sp_mid {
 	struct list_head list;
 	unsigned char addr[ETH_ALEN];
@@ -745,6 +749,8 @@ bool mlxsw_sp_fid_lag_vid_valid(const struct mlxsw_sp_f=
id *fid);
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_s=
p,
 						  u16 fid_index);
 int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid *fid, int *nve_ifin=
dex);
+int mlxsw_sp_fid_nve_type(const struct mlxsw_sp_fid *fid,
+			  enum mlxsw_sp_nve_type *p_type);
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
 						__be32 vni);
 int mlxsw_sp_fid_vni(const struct mlxsw_sp_fid *fid, __be32 *vni);
@@ -752,7 +758,8 @@ int mlxsw_sp_fid_nve_flood_index_set(struct mlxsw_sp_fi=
d *fid,
 				     u32 nve_flood_index);
 void mlxsw_sp_fid_nve_flood_index_clear(struct mlxsw_sp_fid *fid);
 bool mlxsw_sp_fid_nve_flood_index_is_set(const struct mlxsw_sp_fid *fid);
-int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni, int nve_ifi=
ndex);
+int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, enum mlxsw_sp_nve_type =
type,
+			 __be32 vni, int nve_ifindex);
 void mlxsw_sp_fid_vni_clear(struct mlxsw_sp_fid *fid);
 bool mlxsw_sp_fid_vni_is_set(const struct mlxsw_sp_fid *fid);
 int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
@@ -823,10 +830,6 @@ extern const struct mlxsw_sp_mr_tcam_ops mlxsw_sp1_mr_=
tcam_ops;
 extern const struct mlxsw_sp_mr_tcam_ops mlxsw_sp2_mr_tcam_ops;
=20
 /* spectrum_nve.c */
-enum mlxsw_sp_nve_type {
-	MLXSW_SP_NVE_TYPE_VXLAN,
-};
-
 struct mlxsw_sp_nve_params {
 	enum mlxsw_sp_nve_type type;
 	__be32 vni;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index f9af68230455..fe16e0be716e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -30,6 +30,7 @@ struct mlxsw_sp_fid {
 	struct rhash_head ht_node;
=20
 	struct rhash_head vni_ht_node;
+	enum mlxsw_sp_nve_type nve_type;
 	__be32 vni;
 	u32 nve_flood_index;
 	int nve_ifindex;
@@ -151,6 +152,17 @@ int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid=
 *fid, int *nve_ifindex)
 	return 0;
 }
=20
+int mlxsw_sp_fid_nve_type(const struct mlxsw_sp_fid *fid,
+			  enum mlxsw_sp_nve_type *p_type)
+{
+	if (!fid->vni_valid)
+		return -EINVAL;
+
+	*p_type =3D fid->nve_type;
+
+	return 0;
+}
+
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
 						__be32 vni)
 {
@@ -211,7 +223,8 @@ bool mlxsw_sp_fid_nve_flood_index_is_set(const struct m=
lxsw_sp_fid *fid)
 	return fid->nve_flood_index_valid;
 }
=20
-int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni, int nve_ifi=
ndex)
+int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, enum mlxsw_sp_nve_type =
type,
+			 __be32 vni, int nve_ifindex)
 {
 	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
 	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
@@ -221,6 +234,7 @@ int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be=
32 vni, int nve_ifindex)
 	if (WARN_ON(!ops->vni_set || fid->vni_valid))
 		return -EINVAL;
=20
+	fid->nve_type =3D type;
 	fid->nve_ifindex =3D nve_ifindex;
 	fid->vni =3D vni;
 	err =3D rhashtable_lookup_insert_fast(&mlxsw_sp->fid_core->vni_ht,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.c
index c4d5a0865c8f..e8e4cb6dfd38 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -817,7 +817,8 @@ int mlxsw_sp_nve_fid_enable(struct mlxsw_sp *mlxsw_sp, =
struct mlxsw_sp_fid *fid,
 		return err;
 	}
=20
-	err =3D mlxsw_sp_fid_vni_set(fid, params->vni, params->dev->ifindex);
+	err =3D mlxsw_sp_fid_vni_set(fid, params->type, params->vni,
+				   params->dev->ifindex);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to set VNI on FID");
 		goto err_fid_vni_set;
--=20
2.19.1

