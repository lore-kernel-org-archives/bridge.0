Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=B7O6yH/PBteyo+A5f96VEkj/XlXckAhH3H1CY/pyh6o=;
	b=Xj8HFpL08BU1nn/uf/teF+4Ys+ToBiLDF3sdaKwFFGo5MBYQ8czzG4t6A1skNhb4HsTDn6Jn2obMFnynoLDR+wot/sIvd4oMHbrgN+CUfNGQ6eVaxnkLErBNLfL/IRvNBih369Mcj98uYT8dk6hYasNA+nKPXY1Adzo2SfCCQlQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:48 +0000
Message-ID: <20181121080141.16676-14-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 13/16] mlxsw: spectrum_switchdev: Allow
 deletion of learned FDB entries
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

Allow users to delete learned FDB entries from the bridge's FDB before
enabling VxLAN learning.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index d3d1c1d00d98..b32a5ee57fb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2770,7 +2770,8 @@ mlxsw_sp_switchdev_bridge_nve_fdb_event(struct mlxsw_=
sp_switchdev_event_work *
 	    switchdev_work->event !=3D SWITCHDEV_FDB_DEL_TO_DEVICE)
 		return;
=20
-	if (!switchdev_work->fdb_info.added_by_user)
+	if (switchdev_work->event =3D=3D SWITCHDEV_FDB_ADD_TO_DEVICE &&
+	    !switchdev_work->fdb_info.added_by_user)
 		return;
=20
 	if (!netif_running(dev))
--=20
2.19.1

