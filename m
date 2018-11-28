Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Dys+o+Jukl7R0enAJsYQRZu6+CddoiqutQvPmC9AK+U=;
	b=S6GadYGz4sChdQzx7f+85t0Ddp41sI8Uk4chRLGwwdTBqJikBUrUPPJo7zcdb8WS+pXPVPwe+MnjWwefNZSuM5GLM6Q2CzVZmwpv8SvdQJUcDzcIz703dhz12STWXsuPJNHXt9mNS/Ojpxt2eQrXQHHtJJFXB3PahI9CvcUoFkw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:06:59 +0000
Message-ID: <20181128200558.31343-3-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 2/8] mlxsw: spectrum_fid: Add API to
 lookup 802.1Q FIDs without creating them
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

In a similar fashion to commit 564c6d727aca ("mlxsw: spectrum_fid: Add
APIs to lookup FID without creating it"), add a corresponding API to
lookup 802.1Q FIDs.

This is a prerequisite to VxLAN support with VLAN-aware bridges and will
allow us to resolve a 802.1Q FID by its VLAN when an FDB entry is added
on the bridge port of the VxLAN device.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h           | 2 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c       | 6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 5 +++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 244972bf8b0a..55ed69038796 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -753,6 +753,8 @@ u16 mlxsw_sp_fid_8021q_vid(const struct mlxsw_sp_fid *f=
id);
 struct mlxsw_sp_fid *mlxsw_sp_fid_8021q_get(struct mlxsw_sp *mlxsw_sp, u16=
 vid);
 struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_get(struct mlxsw_sp *mlxsw_sp,
 					    int br_ifindex);
+struct mlxsw_sp_fid *mlxsw_sp_fid_8021q_lookup(struct mlxsw_sp *mlxsw_sp,
+					       u16 vid);
 struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_lookup(struct mlxsw_sp *mlxsw_sp,
 					       int br_ifindex);
 struct mlxsw_sp_fid *mlxsw_sp_fid_rfid_get(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index 6830e79aed93..f9af68230455 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1068,6 +1068,12 @@ struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_get(struct m=
lxsw_sp *mlxsw_sp,
 	return mlxsw_sp_fid_get(mlxsw_sp, MLXSW_SP_FID_TYPE_8021D, &br_ifindex);
 }
=20
+struct mlxsw_sp_fid *mlxsw_sp_fid_8021q_lookup(struct mlxsw_sp *mlxsw_sp,
+					       u16 vid)
+{
+	return mlxsw_sp_fid_lookup(mlxsw_sp, MLXSW_SP_FID_TYPE_8021Q, &vid);
+}
+
 struct mlxsw_sp_fid *mlxsw_sp_fid_8021d_lookup(struct mlxsw_sp *mlxsw_sp,
 					       int br_ifindex)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 3c2428404b2e..108dbb764c77 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2031,8 +2031,9 @@ static struct mlxsw_sp_fid *
 mlxsw_sp_bridge_8021q_fid_lookup(struct mlxsw_sp_bridge_device *bridge_dev=
ice,
 				 u16 vid)
 {
-	WARN_ON(1);
-	return NULL;
+	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_lower_get(bridge_device->dev);
+
+	return mlxsw_sp_fid_8021q_lookup(mlxsw_sp, vid);
 }
=20
 static u16
--=20
2.19.1

