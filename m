Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BRFb8W+EgtjBqbaULYGJfki6BdLlUMN6Y0g3p+CHuIo=;
	b=VoHJjQlARcWQg57lMyDsl+0er/EyOXUyNp9gWuG4OOVBiMRdX6NDGclh7oCNmzoouWiSyB08gbdw80UnlywC8r6hbDI7Zxp/eWABI4eLiIlUmWeoJezFJE6BwXWAvc/3mzgbTGIEB71AeDa+4ry0gTozQaIf8xvP/cQx/XgMH+k=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:26 +0000
Message-ID: <20181013171725.3261-5-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 04/18] mlxsw: spectrum_router: Allow
 querying VR ID based on table ID
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

In the device, different VRFs (routing tables) are represented using
different virtual routers (VRs) and thus the kernel's table IDs are
mapped to VR IDs.

Allow internal users of the IP router to query the VR ID based on a
kernel table ID.

This is needed - for example - when configuring the underlay VR where
VxLAN encapsulated packets will undergo an L3 lookup. In this case, the
kernel's table ID is derived from the VxLAN device's configuration.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h      |  2 ++
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 739a62d024c9..d0a73935e8bb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -438,6 +438,8 @@ int mlxsw_sp_router_nve_promote_decap(struct mlxsw_sp *=
mlxsw_sp, u32 ul_tb_id,
 void mlxsw_sp_router_nve_demote_decap(struct mlxsw_sp *mlxsw_sp, u32 ul_tb=
_id,
 				      enum mlxsw_sp_l3proto ul_proto,
 				      const union mlxsw_sp_l3addr *ul_sip);
+int mlxsw_sp_router_tb_id_vr_id(struct mlxsw_sp *mlxsw_sp, u32 tb_id,
+				u16 *vr_id);
=20
 /* spectrum_kvdl.c */
 enum mlxsw_sp_kvdl_entry_type {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/driver=
s/net/ethernet/mellanox/mlxsw/spectrum_router.c
index ca4289d15561..31b5491d6737 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -742,6 +742,19 @@ static struct mlxsw_sp_vr *mlxsw_sp_vr_find(struct mlx=
sw_sp *mlxsw_sp,
 	return NULL;
 }
=20
+int mlxsw_sp_router_tb_id_vr_id(struct mlxsw_sp *mlxsw_sp, u32 tb_id,
+				u16 *vr_id)
+{
+	struct mlxsw_sp_vr *vr;
+
+	vr =3D mlxsw_sp_vr_find(mlxsw_sp, tb_id);
+	if (!vr)
+		return -ESRCH;
+	*vr_id =3D vr->id;
+
+	return 0;
+}
+
 static struct mlxsw_sp_fib *mlxsw_sp_vr_fib(const struct mlxsw_sp_vr *vr,
 					    enum mlxsw_sp_l3proto proto)
 {
--=20
2.17.2

