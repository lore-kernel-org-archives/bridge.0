Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3scyvaXo1PeteZ3JAkOm4OcQ3zDaSiYBQB8pGa2zk5c=;
	b=WaTmOMNxJkAyifE/2pXhrTGIwTsli3jEN27F0svxcw9Bw20D818MgCYeePEtyZ9+LPYb4lOW62K0IPpW8DMEI84Ea/wZM7akcpBqy7e+ysp5imBJ+KaJEEjOLsL6EJmxx0Rb74AhVCsxM9MLxn9nxaVLFl9jpY59juIyhfQU/kQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:30 +0000
Message-ID: <20181205154958.20262-7-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 06/12] mlxsw: spectrum_switchdev: Publish
 mlxsw_sp_switchdev_notifier
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

The notifier block will need to be passed to vxlan_fdb_replay() in a
follow-up patch.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h           | 1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 00d783136d11..6b0dc40fa213 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -387,6 +387,7 @@ int mlxsw_sp_bridge_vxlan_join(struct mlxsw_sp *mlxsw_s=
p,
 			       struct netlink_ext_ack *extack);
 void mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 				 const struct net_device *vxlan_dev);
+extern struct notifier_block mlxsw_sp_switchdev_notifier;
=20
 /* spectrum.c */
 int mlxsw_sp_port_ets_set(struct mlxsw_sp_port *mlxsw_sp_port,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 7c38231bbd89..402f652cbf1b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3186,7 +3186,7 @@ static int mlxsw_sp_switchdev_event(struct notifier_b=
lock *unused,
 	return NOTIFY_BAD;
 }
=20
-static struct notifier_block mlxsw_sp_switchdev_notifier =3D {
+struct notifier_block mlxsw_sp_switchdev_notifier =3D {
 	.notifier_call =3D mlxsw_sp_switchdev_event,
 };
=20
--=20
2.19.1

