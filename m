Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fkqGyTGSui2Q/O6XArwvpw1WDITLOibwbAJeueL3OzI=;
	b=cvvQlYcZnlMv3yYOFOD1xtiTT0NFhu3O7gdItg0awBxyo92ivOH4LSn5eofmRzgEc1RUCqXVIA+jUaPmLWKnZ6GZFB9RIW3VK3sJSKHN53V2fCjL7nfyqEY8sONjK3mQ1RB+Cb4drC62Yy8YVhutJJXMr414DvUPC2fHd8qsSW0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:29 +0000
Message-ID: <20181017085215.26607-17-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 16/18] bridge: switchdev: Allow
 clearing FDB entry offload indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Currently, an FDB entry only ceases being offloaded when it is deleted.
This changes with VxLAN encapsulation.

Devices capable of performing VxLAN encapsulation usually have only one
FDB table, unlike the software data path which has two - one in the
bridge driver and another in the VxLAN driver.

Therefore, bridge FDB entries pointing to a VxLAN device are only
offloaded if there is a corresponding entry in the VxLAN FDB.

Allow clearing the offload indication in case the corresponding entry
was deleted from the VxLAN FDB.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 9 +++++----
 drivers/net/ethernet/rocker/rocker_main.c                | 1 +
 include/net/switchdev.h                                  | 3 ++-
 net/bridge/br.c                                          | 4 ++--
 net/bridge/br_fdb.c                                      | 4 ++--
 net/bridge/br_private.h                                  | 2 +-
 net/bridge/br_switchdev.c                                | 9 ++++++---
 net/dsa/slave.c                                          | 1 +
 8 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index fa16ad2c6a50..a89075beef94 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2090,12 +2090,13 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_por=
t *mlxsw_sp_port,
 static void
 mlxsw_sp_fdb_call_notifiers(enum switchdev_notifier_type type,
 			    const char *mac, u16 vid,
-			    struct net_device *dev)
+			    struct net_device *dev, bool offloaded)
 {
 	struct switchdev_notifier_fdb_info info;
=20
 	info.addr =3D mac;
 	info.vid =3D vid;
+	info.offloaded =3D offloaded;
 	call_switchdev_notifiers(type, dev, &info.info);
 }
=20
@@ -2147,7 +2148,7 @@ static void mlxsw_sp_fdb_notify_mac_process(struct ml=
xsw_sp *mlxsw_sp,
 	if (!do_notification)
 		return;
 	type =3D adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRID=
GE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
=20
 	return;
=20
@@ -2207,7 +2208,7 @@ static void mlxsw_sp_fdb_notify_mac_lag_process(struc=
t mlxsw_sp *mlxsw_sp,
 	if (!do_notification)
 		return;
 	type =3D adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRID=
GE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
=20
 	return;
=20
@@ -2312,7 +2313,7 @@ static void mlxsw_sp_switchdev_bridge_fdb_event_work(=
struct work_struct *work)
 			break;
 		mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
 					    fdb_info->addr,
-					    fdb_info->vid, dev);
+					    fdb_info->vid, dev, true);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb_info =3D &switchdev_work->fdb_info;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethern=
et/rocker/rocker_main.c
index aeafdb9ac015..8721c0506af3 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2728,6 +2728,7 @@ rocker_fdb_offload_notify(struct rocker_port *rocker_=
port,
=20
 	info.addr =3D recv_info->addr;
 	info.vid =3D recv_info->vid;
+	info.offloaded =3D true;
 	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
 				 rocker_port->dev, &info.info);
 }
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index b040f82351ba..881ecb1555bf 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -159,7 +159,8 @@ struct switchdev_notifier_fdb_info {
 	struct switchdev_notifier_info info; /* must be first */
 	const unsigned char *addr;
 	u16 vid;
-	bool added_by_user;
+	u8 added_by_user:1,
+	   offloaded:1;
 };
=20
 static inline struct net_device *
diff --git a/net/bridge/br.c b/net/bridge/br.c
index e411e40333e2..360ad66c21e9 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -151,7 +151,7 @@ static int br_switchdev_event(struct notifier_block *un=
used,
 			break;
 		}
 		br_fdb_offloaded_set(br, p, fdb_info->addr,
-				     fdb_info->vid);
+				     fdb_info->vid, true);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
 		fdb_info =3D ptr;
@@ -163,7 +163,7 @@ static int br_switchdev_event(struct notifier_block *un=
used,
 	case SWITCHDEV_FDB_OFFLOADED:
 		fdb_info =3D ptr;
 		br_fdb_offloaded_set(br, p, fdb_info->addr,
-				     fdb_info->vid);
+				     fdb_info->vid, fdb_info->offloaded);
 		break;
 	}
=20
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 74331690a390..e56ba3912a90 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1152,7 +1152,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, =
struct net_bridge_port *p,
 }
=20
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p=
,
-			  const unsigned char *addr, u16 vid)
+			  const unsigned char *addr, u16 vid, bool offloaded)
 {
 	struct net_bridge_fdb_entry *fdb;
=20
@@ -1160,7 +1160,7 @@ void br_fdb_offloaded_set(struct net_bridge *br, stru=
ct net_bridge_port *p,
=20
 	fdb =3D br_fdb_find(br, addr, vid);
 	if (fdb)
-		fdb->offloaded =3D 1;
+		fdb->offloaded =3D offloaded;
=20
 	spin_unlock_bh(&br->hash_lock);
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 10ee39fdca5c..2920e06a5403 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -574,7 +574,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, st=
ruct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p=
,
-			  const unsigned char *addr, u16 vid);
+			  const unsigned char *addr, u16 vid, bool offloaded);
=20
 /* br_forward.c */
 enum br_pkt_type {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index d77f807420c4..b993df770675 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -103,7 +103,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *=
p,
 static void
 br_switchdev_fdb_call_notifiers(bool adding, const unsigned char *mac,
 				u16 vid, struct net_device *dev,
-				bool added_by_user)
+				bool added_by_user, bool offloaded)
 {
 	struct switchdev_notifier_fdb_info info;
 	unsigned long notifier_type;
@@ -111,6 +111,7 @@ br_switchdev_fdb_call_notifiers(bool adding, const unsi=
gned char *mac,
 	info.addr =3D mac;
 	info.vid =3D vid;
 	info.added_by_user =3D added_by_user;
+	info.offloaded =3D offloaded;
 	notifier_type =3D adding ? SWITCHDEV_FDB_ADD_TO_DEVICE : SWITCHDEV_FDB_DE=
L_TO_DEVICE;
 	call_switchdev_notifiers(notifier_type, dev, &info.info);
 }
@@ -126,13 +127,15 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_e=
ntry *fdb, int type)
 		br_switchdev_fdb_call_notifiers(false, fdb->key.addr.addr,
 						fdb->key.vlan_id,
 						fdb->dst->dev,
-						fdb->added_by_user);
+						fdb->added_by_user,
+						fdb->offloaded);
 		break;
 	case RTM_NEWNEIGH:
 		br_switchdev_fdb_call_notifiers(true, fdb->key.addr.addr,
 						fdb->key.vlan_id,
 						fdb->dst->dev,
-						fdb->added_by_user);
+						fdb->added_by_user,
+						fdb->offloaded);
 		break;
 	}
 }
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 3f840b6eea69..5428ef529019 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1478,6 +1478,7 @@ static void dsa_slave_switchdev_event_work(struct wor=
k_struct *work)
 			netdev_dbg(dev, "fdb add failed err=3D%d\n", err);
 			break;
 		}
+		fdb_info->offloaded =3D true;
 		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
 					 &fdb_info->info);
 		break;
--=20
2.17.2

