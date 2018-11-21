Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nJdWEh8exCsBjSSRHhz+Hmi30cVT4QCrRJv7x3s9c74=;
	b=ZRmIhm4w19YiEyIVWLXHKtwDb4mDeP8zi4Kwqk2bFMGY8Q/SBz3TlKrwIQZ+6C030O4jyhJ80gc87UoiAG9FcO4/XRetD25k+QTrIdcmVcuWbUA7E/IaipuCfuFvs1g7GZxR/Loe+/Jmgp9oY/+Kl8elEXj/XW9OrQ+jLEFfbDQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:44 +0000
Message-ID: <20181121080141.16676-10-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 09/16] mlxsw: spectrum_fid: Store ifindex
 of NVE device in FID
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

The driver periodically polls for new FDB entries learned by the device.
In the case of an FDB entry learned from a VxLAN tunnel, the
notification includes the IP of the remote VTEP, the filtering
identifier (FID) and the source MAC address of the overlay packet.

Assuming learning is enabled in the VxLAN and bridge drivers, the driver
needs to generate a notification and update them about the new FDB
entry.

Store the ifindex of the NVE device in the FID so that the driver will
be able to update the VxLAN and bridge drivers using it.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  3 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 14 +++++++++++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 0875a79cbe7b..b8f00863a0c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -721,6 +721,7 @@ int mlxsw_sp_setup_tc_prio(struct mlxsw_sp_port *mlxsw_=
sp_port,
 			   struct tc_prio_qopt_offload *p);
=20
 /* spectrum_fid.c */
+int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid *fid, int *nve_ifin=
dex);
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
 						__be32 vni);
 int mlxsw_sp_fid_vni(const struct mlxsw_sp_fid *fid, __be32 *vni);
@@ -728,7 +729,7 @@ int mlxsw_sp_fid_nve_flood_index_set(struct mlxsw_sp_fi=
d *fid,
 				     u32 nve_flood_index);
 void mlxsw_sp_fid_nve_flood_index_clear(struct mlxsw_sp_fid *fid);
 bool mlxsw_sp_fid_nve_flood_index_is_set(const struct mlxsw_sp_fid *fid);
-int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni);
+int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni, int nve_ifi=
ndex);
 void mlxsw_sp_fid_vni_clear(struct mlxsw_sp_fid *fid);
 bool mlxsw_sp_fid_vni_is_set(const struct mlxsw_sp_fid *fid);
 int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index a3db033d7399..ad2bc8e3b2ed 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -30,6 +30,7 @@ struct mlxsw_sp_fid {
 	struct rhash_head vni_ht_node;
 	__be32 vni;
 	u32 nve_flood_index;
+	int nve_ifindex;
 	u8 vni_valid:1,
 	   nve_flood_index_valid:1;
 };
@@ -113,6 +114,16 @@ static const int *mlxsw_sp_packet_type_sfgc_types[] =
=3D {
 	[MLXSW_SP_FLOOD_TYPE_MC]	=3D mlxsw_sp_sfgc_mc_packet_types,
 };
=20
+int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid *fid, int *nve_ifin=
dex)
+{
+	if (!fid->vni_valid)
+		return -EINVAL;
+
+	*nve_ifindex =3D fid->nve_ifindex;
+
+	return 0;
+}
+
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_vni(struct mlxsw_sp *mlxsw_sp,
 						__be32 vni)
 {
@@ -173,7 +184,7 @@ bool mlxsw_sp_fid_nve_flood_index_is_set(const struct m=
lxsw_sp_fid *fid)
 	return fid->nve_flood_index_valid;
 }
=20
-int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni)
+int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be32 vni, int nve_ifi=
ndex)
 {
 	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
 	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
@@ -183,6 +194,7 @@ int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, __be=
32 vni)
 	if (WARN_ON(!ops->vni_set || fid->vni_valid))
 		return -EINVAL;
=20
+	fid->nve_ifindex =3D nve_ifindex;
 	fid->vni =3D vni;
 	err =3D rhashtable_lookup_insert_fast(&mlxsw_sp->fid_core->vni_ht,
 					    &fid->vni_ht_node,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.c
index ad06d9969bc1..4498e3b3c3f0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -803,7 +803,7 @@ int mlxsw_sp_nve_fid_enable(struct mlxsw_sp *mlxsw_sp, =
struct mlxsw_sp_fid *fid,
 		return err;
 	}
=20
-	err =3D mlxsw_sp_fid_vni_set(fid, params->vni);
+	err =3D mlxsw_sp_fid_vni_set(fid, params->vni, params->dev->ifindex);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to set VNI on FID");
 		goto err_fid_vni_set;
--=20
2.19.1

