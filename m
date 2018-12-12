Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QaI2qc7pzMGtP8gTfj45NR+KqxgoKyJh0Tc9h7Vs8G8=;
	b=AiWdZe15aQOY1Cei7cKaTZ7rvr1J7aJjsNEg43kgpP3Zn/crnhk8Kd+0mEvU8Zgx31Wins0QlP2qh+7G7ql5XbK5PSf7uM4c7GkYxWECtGaKmVJZA5+c/gAuhVavSF/mS5z/9lpt3qERt7DwLLyrIkls4W9af8c+Xbv+7JSjc4c=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:02:56 +0000
Message-ID: <65de37ab45b93dbd911867c285139152912102c3.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 5/9] net: switchdev: Add extack to
 switchdev_handle_port_obj_add() callback
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "dsa@cumulusnetworks.com" <dsa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

Drivers use switchdev_handle_port_obj_add() to handle recursive descent
through lower devices. Change this function prototype to take add_cb
that itself takes an extack argument. Decode extack from
switchdev_notifier_port_obj_info and pass it to add_cb.

Update mlxsw and ocelot drivers which use this helper.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |  3 ++-
 drivers/net/ethernet/mscc/ocelot.c                       |  3 ++-
 include/net/switchdev.h                                  |  6 ++++--
 net/switchdev/switchdev.c                                | 12 +++++++++---
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 5ad1fcebf788..4b9292289256 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1777,7 +1777,8 @@ static void mlxsw_sp_span_respin_schedule(struct mlxs=
w_sp *mlxsw_sp)
=20
 static int mlxsw_sp_port_obj_add(struct net_device *dev,
 				 const struct switchdev_obj *obj,
-				 struct switchdev_trans *trans)
+				 struct switchdev_trans *trans,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port =3D netdev_priv(dev);
 	const struct switchdev_obj_port_vlan *vlan;
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc=
/ocelot.c
index 7f8da8873a96..ea3eec263875 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1293,7 +1293,8 @@ static int ocelot_port_obj_del_mdb(struct net_device =
*dev,
=20
 static int ocelot_port_obj_add(struct net_device *dev,
 			       const struct switchdev_obj *obj,
-			       struct switchdev_trans *trans)
+			       struct switchdev_trans *trans,
+			       struct netlink_ext_ack *extack)
 {
 	int ret =3D 0;
=20
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 4facfa6775e8..a7fdab5ee6c3 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -215,7 +215,8 @@ int switchdev_handle_port_obj_add(struct net_device *de=
v,
 			bool (*check_cb)(const struct net_device *dev),
 			int (*add_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj,
-				      struct switchdev_trans *trans));
+				      struct switchdev_trans *trans,
+				      struct netlink_ext_ack *extack));
 int switchdev_handle_port_obj_del(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
 			bool (*check_cb)(const struct net_device *dev),
@@ -304,7 +305,8 @@ switchdev_handle_port_obj_add(struct net_device *dev,
 			bool (*check_cb)(const struct net_device *dev),
 			int (*add_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj,
-				      struct switchdev_trans *trans))
+				      struct switchdev_trans *trans,
+				      struct netlink_ext_ack *extack))
 {
 	return 0;
 }
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index aa84acfb6632..5df9d1138ac9 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -616,16 +616,21 @@ static int __switchdev_handle_port_obj_add(struct net=
_device *dev,
 			bool (*check_cb)(const struct net_device *dev),
 			int (*add_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj,
-				      struct switchdev_trans *trans))
+				      struct switchdev_trans *trans,
+				      struct netlink_ext_ack *extack))
 {
+	struct netlink_ext_ack *extack;
 	struct net_device *lower_dev;
 	struct list_head *iter;
 	int err =3D -EOPNOTSUPP;
=20
+	extack =3D switchdev_notifier_info_to_extack(&port_obj_info->info);
+
 	if (check_cb(dev)) {
 		/* This flag is only checked if the return value is success. */
 		port_obj_info->handled =3D true;
-		return add_cb(dev, port_obj_info->obj, port_obj_info->trans);
+		return add_cb(dev, port_obj_info->obj, port_obj_info->trans,
+			      extack);
 	}
=20
 	/* Switch ports might be stacked under e.g. a LAG. Ignore the
@@ -650,7 +655,8 @@ int switchdev_handle_port_obj_add(struct net_device *de=
v,
 			bool (*check_cb)(const struct net_device *dev),
 			int (*add_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj,
-				      struct switchdev_trans *trans))
+				      struct switchdev_trans *trans,
+				      struct netlink_ext_ack *extack))
 {
 	int err;
=20
--=20
2.4.11

