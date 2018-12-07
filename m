Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ipNM8usYtPKPSrgFKUKVzxSVDOyt3wRmexas6crwHDw=;
	b=I11iNDE+kkJHx3hVpVf0MZ4a8Y/hhpoch3RpvYauEbKhbAjsIMa/ehkIJG3NfAYVUEPwdrOftMrNiM+rIhjR9GORQhGSuh9D3rUMu57LYY9X0eAvRHBuvHAjxJCD+1Ikc+FIieIf6/pt/da8tmobX+z8Ur0ZFBDLDQcohSh1zsI=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:12 +0000
Message-ID: <20181207195433.22540-8-idosch@mellanox.com>
References: <20181207195433.22540-1-idosch@mellanox.com>
In-Reply-To: <20181207195433.22540-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 07/12] mlxsw: spectrum_nve: Add
 mlxsw_sp_nve_ops.fdb_replay
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

A replay of FDB needs to be performed so that the FDB entries existing
at the NVE device are offloaded. How the replay is done depends on NVE
device type, and therefore add a per-NVE-type operation.

Implement the operation for the sole NVE device type currently supported
by mlxsw, VXLAN.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h     |  1 +
 .../net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.h
index 4cc3297e13d6..e2f945543433 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
@@ -41,6 +41,7 @@ struct mlxsw_sp_nve_ops {
 	int (*init)(struct mlxsw_sp_nve *nve,
 		    const struct mlxsw_sp_nve_config *config);
 	void (*fini)(struct mlxsw_sp_nve *nve);
+	int (*fdb_replay)(const struct net_device *nve_dev, __be32 vni);
 };
=20
 extern const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 4e9cc00a88fd..1651c912ef77 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -211,12 +211,21 @@ static void mlxsw_sp1_nve_vxlan_fini(struct mlxsw_sp_=
nve *nve)
 				 config->udp_dport);
 }
=20
+static int
+mlxsw_sp_nve_vxlan_fdb_replay(const struct net_device *nve_dev, __be32 vni=
)
+{
+	if (WARN_ON(!netif_is_vxlan(nve_dev)))
+		return -EINVAL;
+	return vxlan_fdb_replay(nve_dev, vni, &mlxsw_sp_switchdev_notifier);
+}
+
 const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops =3D {
 	.type		=3D MLXSW_SP_NVE_TYPE_VXLAN,
 	.can_offload	=3D mlxsw_sp1_nve_vxlan_can_offload,
 	.nve_config	=3D mlxsw_sp_nve_vxlan_config,
 	.init		=3D mlxsw_sp1_nve_vxlan_init,
 	.fini		=3D mlxsw_sp1_nve_vxlan_fini,
+	.fdb_replay	=3D mlxsw_sp_nve_vxlan_fdb_replay,
 };
=20
 static bool mlxsw_sp2_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve=
,
@@ -242,4 +251,5 @@ const struct mlxsw_sp_nve_ops mlxsw_sp2_nve_vxlan_ops =
=3D {
 	.nve_config	=3D mlxsw_sp_nve_vxlan_config,
 	.init		=3D mlxsw_sp2_nve_vxlan_init,
 	.fini		=3D mlxsw_sp2_nve_vxlan_fini,
+	.fdb_replay	=3D mlxsw_sp_nve_vxlan_fdb_replay,
 };
--=20
2.19.1

