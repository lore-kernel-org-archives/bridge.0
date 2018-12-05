Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=stu69xwlUQeB+rBDDBzPrW0+gqEWHFvfU6eEO09qIf0=;
	b=JIutPuNZFI4EmwiNxbDMgjMFxfdNzmijRafpbLqQDjrhW+cftG9unpwGjzWiZPQv98i1uXsnBDqjJbiRJjP//HmWkpP3v63yhsc8pv9eBcLSq8XW0mABkvbVuXSqw5+uxgC5mJU9Fd8SR+xn609R5r/S63O/eR11neC40HEvTKU=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:37 +0000
Message-ID: <20181205154958.20262-11-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 10/12] mlxsw: spectrum_nve: Un/offload FDB
 on nve_fid_disable/enable
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

Any existing NVE FDB entries need to be offloaded when NVE is enabled
for a given FID. Recent patches have added fdb_replay op for this, so
just invoke it from mlxsw_sp_nve_fid_enable().

When NVE is disabled on a FID, any existing FDB offloaded marks need to
be cleared on NVE device as well as on its bridge master. An op to
handle this, fdb_clear_offload, has been added to FID ops and NVE ops in
previous patches. Add code to resolve the NVE device, NVE type, and
dispatch to both fdb_clear_offload ops.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.c
index e8e4cb6dfd38..9a86a7cde3b9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -789,6 +789,21 @@ static void mlxsw_sp_nve_fdb_flush_by_fid(struct mlxsw=
_sp *mlxsw_sp,
 	mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfdf), sfdf_pl);
 }
=20
+static void mlxsw_sp_nve_fdb_clear_offload(struct mlxsw_sp *mlxsw_sp,
+					   const struct mlxsw_sp_fid *fid,
+					   const struct net_device *nve_dev,
+					   __be32 vni)
+{
+	const struct mlxsw_sp_nve_ops *ops;
+	enum mlxsw_sp_nve_type type;
+
+	if (WARN_ON(mlxsw_sp_fid_nve_type(fid, &type)))
+		return;
+
+	ops =3D mlxsw_sp->nve->nve_ops_arr[type];
+	ops->fdb_clear_offload(nve_dev, vni);
+}
+
 int mlxsw_sp_nve_fid_enable(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_fid=
 *fid,
 			    struct mlxsw_sp_nve_params *params,
 			    struct netlink_ext_ack *extack)
@@ -826,8 +841,16 @@ int mlxsw_sp_nve_fid_enable(struct mlxsw_sp *mlxsw_sp,=
 struct mlxsw_sp_fid *fid,
=20
 	nve->config =3D config;
=20
+	err =3D ops->fdb_replay(params->dev, params->vni);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to offload the FDB");
+		goto err_fdb_replay;
+	}
+
 	return 0;
=20
+err_fdb_replay:
+	mlxsw_sp_fid_vni_clear(fid);
 err_fid_vni_set:
 	mlxsw_sp_nve_tunnel_fini(mlxsw_sp);
 	return err;
@@ -837,9 +860,27 @@ void mlxsw_sp_nve_fid_disable(struct mlxsw_sp *mlxsw_s=
p,
 			      struct mlxsw_sp_fid *fid)
 {
 	u16 fid_index =3D mlxsw_sp_fid_index(fid);
+	struct net_device *nve_dev;
+	int nve_ifindex;
+	__be32 vni;
=20
 	mlxsw_sp_nve_flood_ip_flush(mlxsw_sp, fid);
 	mlxsw_sp_nve_fdb_flush_by_fid(mlxsw_sp, fid_index);
+
+	if (WARN_ON(mlxsw_sp_fid_nve_ifindex(fid, &nve_ifindex) ||
+		    mlxsw_sp_fid_vni(fid, &vni)))
+		goto out;
+
+	nve_dev =3D dev_get_by_index(&init_net, nve_ifindex);
+	if (!nve_dev)
+		goto out;
+
+	mlxsw_sp_nve_fdb_clear_offload(mlxsw_sp, fid, nve_dev, vni);
+	mlxsw_sp_fid_fdb_clear_offload(fid, nve_dev);
+
+	dev_put(nve_dev);
+
+out:
 	mlxsw_sp_fid_vni_clear(fid);
 	mlxsw_sp_nve_tunnel_fini(mlxsw_sp);
 }
--=20
2.19.1

