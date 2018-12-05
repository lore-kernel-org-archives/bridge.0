Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=eWeNud018QpYHK/HmG+3csCx1GPW4l5TBwbtZAoVrl4=;
	b=fVhtXY29wvsPGJS4YnwKSHTT0Zn1dICB82rT23m+9Nosd2y2F0F7eqKipza38355twooXa5Xg4gDJbMZxYvlS+KsCC3Y+fk7wK343XcWr8ZxopJbgyMD634uKpjVpsymg6Wdfz8AoHdcvrrKUlN+zg0G5nUnz2Y/Jgf5UZssl9M=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:36 +0000
Message-ID: <20181205154958.20262-10-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 09/12] mlxsw: spectrum: Add
 mlxsw_sp_fid_ops.fdb_clear_offload
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

If there are any offloaded FDB entries at bridge master of an NVE device
at the time that it's un-offloaded, their offloaded marks need to be
cleared. How that is done depends on whether the bridge in question is
vlan aware. Therefore add a per-FID-type operation.

Implement the operation for the 802.1q and 802.1d bridges.

Add and publish a function mlxsw_sp_fid_fdb_clear_offload() to dispatch
to the new operation according to FID type.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 ++
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 6b0dc40fa213..2d8f3692a949 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -763,6 +763,8 @@ int mlxsw_sp_fid_vni_set(struct mlxsw_sp_fid *fid, enum=
 mlxsw_sp_nve_type type,
 			 __be32 vni, int nve_ifindex);
 void mlxsw_sp_fid_vni_clear(struct mlxsw_sp_fid *fid);
 bool mlxsw_sp_fid_vni_is_set(const struct mlxsw_sp_fid *fid);
+void mlxsw_sp_fid_fdb_clear_offload(const struct mlxsw_sp_fid *fid,
+				    const struct net_device *nve_dev);
 int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
 			   enum mlxsw_sp_flood_type packet_type, u8 local_port,
 			   bool member);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index fe16e0be716e..7adb1494ebba 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -85,6 +85,8 @@ struct mlxsw_sp_fid_ops {
 	int (*nve_flood_index_set)(struct mlxsw_sp_fid *fid,
 				   u32 nve_flood_index);
 	void (*nve_flood_index_clear)(struct mlxsw_sp_fid *fid);
+	void (*fdb_clear_offload)(const struct mlxsw_sp_fid *fid,
+				  const struct net_device *nve_dev);
 };
=20
 struct mlxsw_sp_fid_family {
@@ -277,6 +279,16 @@ bool mlxsw_sp_fid_vni_is_set(const struct mlxsw_sp_fid=
 *fid)
 	return fid->vni_valid;
 }
=20
+void mlxsw_sp_fid_fdb_clear_offload(const struct mlxsw_sp_fid *fid,
+				    const struct net_device *nve_dev)
+{
+	struct mlxsw_sp_fid_family *fid_family =3D fid->fid_family;
+	const struct mlxsw_sp_fid_ops *ops =3D fid_family->ops;
+
+	if (ops->fdb_clear_offload)
+		ops->fdb_clear_offload(fid, nve_dev);
+}
+
 static const struct mlxsw_sp_flood_table *
 mlxsw_sp_fid_flood_table_lookup(const struct mlxsw_sp_fid *fid,
 				enum mlxsw_sp_flood_type packet_type)
@@ -766,6 +778,13 @@ static void mlxsw_sp_fid_8021d_nve_flood_index_clear(s=
truct mlxsw_sp_fid *fid)
 			    fid->vni_valid, 0, false);
 }
=20
+static void
+mlxsw_sp_fid_8021d_fdb_clear_offload(const struct mlxsw_sp_fid *fid,
+				     const struct net_device *nve_dev)
+{
+	br_fdb_clear_offload(nve_dev, 0);
+}
+
 static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops =3D {
 	.setup			=3D mlxsw_sp_fid_8021d_setup,
 	.configure		=3D mlxsw_sp_fid_8021d_configure,
@@ -779,6 +798,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d=
_ops =3D {
 	.vni_clear		=3D mlxsw_sp_fid_8021d_vni_clear,
 	.nve_flood_index_set	=3D mlxsw_sp_fid_8021d_nve_flood_index_set,
 	.nve_flood_index_clear	=3D mlxsw_sp_fid_8021d_nve_flood_index_clear,
+	.fdb_clear_offload	=3D mlxsw_sp_fid_8021d_fdb_clear_offload,
 };
=20
 static const struct mlxsw_sp_flood_table mlxsw_sp_fid_8021d_flood_tables[]=
 =3D {
@@ -815,6 +835,13 @@ static const struct mlxsw_sp_fid_family mlxsw_sp_fid_8=
021d_family =3D {
 	.lag_vid_valid		=3D 1,
 };
=20
+static void
+mlxsw_sp_fid_8021q_fdb_clear_offload(const struct mlxsw_sp_fid *fid,
+				     const struct net_device *nve_dev)
+{
+	br_fdb_clear_offload(nve_dev, mlxsw_sp_fid_8021q_vid(fid));
+}
+
 static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_emu_ops =3D {
 	.setup			=3D mlxsw_sp_fid_8021q_setup,
 	.configure		=3D mlxsw_sp_fid_8021d_configure,
@@ -828,6 +855,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q=
_emu_ops =3D {
 	.vni_clear		=3D mlxsw_sp_fid_8021d_vni_clear,
 	.nve_flood_index_set	=3D mlxsw_sp_fid_8021d_nve_flood_index_set,
 	.nve_flood_index_clear	=3D mlxsw_sp_fid_8021d_nve_flood_index_clear,
+	.fdb_clear_offload	=3D mlxsw_sp_fid_8021q_fdb_clear_offload,
 };
=20
 /* There are 4K-2 emulated 802.1Q FIDs, starting right after the 802.1D FI=
Ds */
--=20
2.19.1

