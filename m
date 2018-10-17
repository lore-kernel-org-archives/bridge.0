Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fEZsrmpGXpz6DtnIoEV2JuQI1rSHBmqg6nLpxw7QP1k=;
	b=jHPnXYYCLe/d9YgUZbToAkMDHBkrrHfC3ylJSjRZU1PTYG6QDuHWqXI+EDDcfqYYVDwj2LBZ9bgL7A0Dqji4Qaijy48LzFsl2YuUz7NEj99M+spI2we1W7OWeDs17N/mJPsM6PAc9g8g+PXwVzAIBJzSZC2W9/QCBohkVpXle48=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:05 +0000
Message-ID: <20181017085215.26607-3-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 02/18] mlxsw: spectrum_fid: Add APIs to
 lookup FID without creating it
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

Current APIs only allow looking for a FID and creating it in case it
does not exist.

With VxLAN, in case the bridge to which the VxLAN device was enslaved
does not already have a corresponding FID, then it means that something
went wrong that we need to be aware of.

Add an API to look up a FID, but without creating it in order to catch
above-mentioned situation.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  4 ++
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 45 ++++++++++++++++---
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 7f96953f0409..f463be58c6dc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -679,6 +679,8 @@ int mlxsw_sp_setup_tc_prio(struct mlxsw_sp_port *mlxsw_=
sp_port,
 			   struct tc_prio_qopt_offload *p);
=20
 /* spectrum_fid.c */
+struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
+						__be32 vni);
 int mlxsw_sp_fid_vni(const struct mlxsw_sp_fid *fid, __be32 *vni);
 int mlxsw_sp_fid_nve_flood_index_set(struct mlxsw_sp_fid *fid,
 				     u32 nve_flood_index);
@@ -705,6 +707,8 @@ u16 mlxsw_sp_fid_8021q_vid(const struct mlxsw_sp_fid *f=
id);
 struct mlxsw_sp_fid *mlxsw_sp_fid_8021q_get(struct mlxsw_sp *mlxsw_sp, u16=
 vid);
 struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_get(struct mlxsw_sp *mlxsw_sp,
 					    int br_ifindex);
+struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_lookup(struct mlxsw_sp *mlxsw_sp,
+					       int br_ifindex);
 struct mlxsw_sp_fid *mlxsw_sp_fid_rfid_get(struct mlxsw_sp *mlxsw_sp,
 					   u16 rif_index);
 struct mlxsw_sp_fid *mlxsw_sp_fid_dummy_get(struct mlxsw_sp *mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index 7e07cf368e90..0ba3d90d4632 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -113,6 +113,19 @@ static const int *mlxsw_sp_packet_type_sfgc_types[] =
=3D {
 	[MLXSW_SP_FLOOD_TYPE_MC]	=3D mlxsw_sp_sfgc_mc_packet_types,
 };
=20
+struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
+						__be32 vni)
+{
+	struct mlxsw_sp_fid *fid;
+
+	fid =3D rhashtable_lookup_fast(&mlxsw_sp->fid_core->vni_ht, &vni,
+				     mlxsw_sp_fid_vni_ht_params);
+	if (fid)
+		fid->ref_count++;
+
+	return fid;
+}
+
 int mlxsw_sp_fid_vni(const struct mlxsw_sp_fid *fid, __be32 *vni)
 {
 	if (!fid->vni_valid)
@@ -879,14 +892,12 @@ static const struct mlxsw_sp_fid_family *mlxsw_sp_fid=
_family_arr[] =3D {
 	[MLXSW_SP_FID_TYPE_DUMMY]	=3D &mlxsw_sp_fid_dummy_family,
 };
=20
-static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct mlxsw_sp *mlxsw_sp,
-					     enum mlxsw_sp_fid_type type,
-					     const void *arg)
+static struct mlxsw_sp_fid *mlxsw_sp_fid_lookup(struct mlxsw_sp *mlxsw_sp,
+						enum mlxsw_sp_fid_type type,
+						const void *arg)
 {
 	struct mlxsw_sp_fid_family *fid_family;
 	struct mlxsw_sp_fid *fid;
-	u16 fid_index;
-	int err;
=20
 	fid_family =3D mlxsw_sp->fid_core->fid_family_arr[type];
 	list_for_each_entry(fid, &fid_family->fids_list, list) {
@@ -896,6 +907,23 @@ static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct ml=
xsw_sp *mlxsw_sp,
 		return fid;
 	}
=20
+	return NULL;
+}
+
+static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct mlxsw_sp *mlxsw_sp,
+					     enum mlxsw_sp_fid_type type,
+					     const void *arg)
+{
+	struct mlxsw_sp_fid_family *fid_family;
+	struct mlxsw_sp_fid *fid;
+	u16 fid_index;
+	int err;
+
+	fid =3D mlxsw_sp_fid_lookup(mlxsw_sp, type, arg);
+	if (fid)
+		return fid;
+
+	fid_family =3D mlxsw_sp->fid_core->fid_family_arr[type];
 	fid =3D kzalloc(fid_family->fid_size, GFP_KERNEL);
 	if (!fid)
 		return ERR_PTR(-ENOMEM);
@@ -955,6 +983,13 @@ struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_get(struct mlx=
sw_sp *mlxsw_sp,
 	return mlxsw_sp_fid_get(mlxsw_sp, MLXSW_SP_FID_TYPE_8021D, &br_ifindex);
 }
=20
+struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_lookup(struct mlxsw_sp *mlxsw_sp,
+					       int br_ifindex)
+{
+	return mlxsw_sp_fid_lookup(mlxsw_sp, MLXSW_SP_FID_TYPE_8021D,
+				   &br_ifindex);
+}
+
 struct mlxsw_sp_fid *mlxsw_sp_fid_rfid_get(struct mlxsw_sp *mlxsw_sp,
 					   u16 rif_index)
 {
--=20
2.17.2

