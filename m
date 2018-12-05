Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Nv6c86JXxe2A4CeC9fmRNue/ay2D+SY3rTQJJZe//XA=;
	b=KmTuhVRAjHMHCD5UjMBoFS7X9fLPaeINbUXla6wHHdmWFJu8WbAKNY34dCY56i8g/WdZ4GNOtI620W6JcsOIGNUquju7NliXWaJM+Lj/2nsnwZoxuBhvi8yTQ2u73mg7XTFXjGnF+/PyD76rJTu0Js7sxnZ+iN9aTQvfx98V5ig=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:34 +0000
Message-ID: <20181205154958.20262-9-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 08/12] mlxsw: spectrum_nve: Add
 mlxsw_sp_nve_ops.fdb_clear_offload
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

If there are any offloaded FDB entries at an NVE device at the time that
it's un-offloaded, their offloaded marks need to be cleared. How that is
done depends on NVE device type, and therefore add a per-NVE-type
operation.

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
index e2f945543433..02937ea95bc3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
@@ -42,6 +42,7 @@ struct mlxsw_sp_nve_ops {
 		    const struct mlxsw_sp_nve_config *config);
 	void (*fini)(struct mlxsw_sp_nve *nve);
 	int (*fdb_replay)(const struct net_device *nve_dev, __be32 vni);
+	void (*fdb_clear_offload)(const struct net_device *nve_dev, __be32 vni);
 };
=20
 extern const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 1651c912ef77..74e564c4ac19 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -219,6 +219,14 @@ mlxsw_sp_nve_vxlan_fdb_replay(const struct net_device =
*nve_dev, __be32 vni)
 	return vxlan_fdb_replay(nve_dev, vni, &mlxsw_sp_switchdev_notifier);
 }
=20
+static void
+mlxsw_sp_nve_vxlan_clear_offload(const struct net_device *nve_dev, __be32 =
vni)
+{
+	if (WARN_ON(!netif_is_vxlan(nve_dev)))
+		return;
+	vxlan_fdb_clear_offload(nve_dev, vni);
+}
+
 const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops =3D {
 	.type		=3D MLXSW_SP_NVE_TYPE_VXLAN,
 	.can_offload	=3D mlxsw_sp1_nve_vxlan_can_offload,
@@ -226,6 +234,7 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops =
=3D {
 	.init		=3D mlxsw_sp1_nve_vxlan_init,
 	.fini		=3D mlxsw_sp1_nve_vxlan_fini,
 	.fdb_replay	=3D mlxsw_sp_nve_vxlan_fdb_replay,
+	.fdb_clear_offload =3D mlxsw_sp_nve_vxlan_clear_offload,
 };
=20
 static bool mlxsw_sp2_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve=
,
@@ -252,4 +261,5 @@ const struct mlxsw_sp_nve_ops mlxsw_sp2_nve_vxlan_ops =
=3D {
 	.init		=3D mlxsw_sp2_nve_vxlan_init,
 	.fini		=3D mlxsw_sp2_nve_vxlan_fini,
 	.fdb_replay	=3D mlxsw_sp_nve_vxlan_fdb_replay,
+	.fdb_clear_offload =3D mlxsw_sp_nve_vxlan_clear_offload,
 };
--=20
2.19.1

