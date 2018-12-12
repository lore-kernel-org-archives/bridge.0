Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QX1kCe5lcPgmAU+LWxj9uqEH/efBjeTdOIRaiRe/gpM=;
	b=AUpRzhotd/2D7RPCTxVqHxge6Jd/mmITXcLf7BZkN0h9SVDU+9OTCdTTEktIfx/X8EW4MhLvaZjKD7TUG8YHS9nomNP9T5ZfNBfjj73ikggLTLvTW3umyUqBZdX0n3J2kg5lhQqxqw9he/MK4Mef5RnjsDe3Srp8xZ4W0zR09MI=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:02:52 +0000
Message-ID: <eb670f6207ff419f7946c6fe4cdd09e704a9814b.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 3/9] net: switchdev: Add extack
 argument to switchdev_port_obj_add()
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

After the previous patch, bridge driver has extack argument available to
pass to switchdev. Therefore extend switchdev_port_obj_add() with this
argument, updating all callers, and passing the argument through to
switchdev_port_obj_notify().

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 include/net/switchdev.h   |  6 ++++--
 net/bridge/br_mdb.c       |  4 ++--
 net/bridge/br_switchdev.c |  2 +-
 net/switchdev/switchdev.c | 19 +++++++++++--------
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 866b6d148b77..69016305ad58 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -180,7 +180,8 @@ int switchdev_port_attr_get(struct net_device *dev,
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr);
 int switchdev_port_obj_add(struct net_device *dev,
-			   const struct switchdev_obj *obj);
+			   const struct switchdev_obj *obj,
+			   struct netlink_ext_ack *extack);
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
=20
@@ -233,7 +234,8 @@ static inline int switchdev_port_attr_set(struct net_de=
vice *dev,
 }
=20
 static inline int switchdev_port_obj_add(struct net_device *dev,
-					 const struct switchdev_obj *obj)
+					 const struct switchdev_obj *obj,
+					 struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 79d4c9d253e0..f69c8d91dc81 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -331,7 +331,7 @@ static void br_mdb_switchdev_host_port(struct net_devic=
e *dev,
 	mdb.obj.orig_dev =3D dev;
 	switch (type) {
 	case RTM_NEWMDB:
-		switchdev_port_obj_add(lower_dev, &mdb.obj);
+		switchdev_port_obj_add(lower_dev, &mdb.obj, NULL);
 		break;
 	case RTM_DELMDB:
 		switchdev_port_obj_del(lower_dev, &mdb.obj);
@@ -381,7 +381,7 @@ static void __br_mdb_notify(struct net_device *dev, str=
uct net_bridge_port *p,
 			__mdb_entry_to_br_ip(entry, &complete_info->ip);
 			mdb.obj.complete_priv =3D complete_info;
 			mdb.obj.complete =3D br_mdb_complete;
-			if (switchdev_port_obj_add(port_dev, &mdb.obj))
+			if (switchdev_port_obj_add(port_dev, &mdb.obj, NULL))
 				kfree(complete_info);
 		}
 	} else if (p && port_dev && type =3D=3D RTM_DELMDB) {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 99ba32177b31..035ff59d9cbd 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -151,7 +151,7 @@ int br_switchdev_port_vlan_add(struct net_device *dev, =
u16 vid, u16 flags,
 		.vid_end =3D vid,
 	};
=20
-	return switchdev_port_obj_add(dev, &v.obj);
+	return switchdev_port_obj_add(dev, &v.obj, extack);
 }
=20
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index fe23fac4dc4b..cb20669bf6ce 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -356,7 +356,8 @@ static size_t switchdev_obj_size(const struct switchdev=
_obj *obj)
 static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
 				     struct net_device *dev,
 				     const struct switchdev_obj *obj,
-				     struct switchdev_trans *trans)
+				     struct switchdev_trans *trans,
+				     struct netlink_ext_ack *extack)
 {
 	int rc;
 	int err;
@@ -379,7 +380,8 @@ static int switchdev_port_obj_notify(enum switchdev_not=
ifier_type nt,
 }
=20
 static int switchdev_port_obj_add_now(struct net_device *dev,
-				      const struct switchdev_obj *obj)
+				      const struct switchdev_obj *obj,
+				      struct netlink_ext_ack *extack)
 {
 	struct switchdev_trans trans;
 	int err;
@@ -397,7 +399,7 @@ static int switchdev_port_obj_add_now(struct net_device=
 *dev,
=20
 	trans.ph_prepare =3D true;
 	err =3D switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
-					dev, obj, &trans);
+					dev, obj, &trans, extack);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -417,7 +419,7 @@ static int switchdev_port_obj_add_now(struct net_device=
 *dev,
=20
 	trans.ph_prepare =3D false;
 	err =3D switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
-					dev, obj, &trans);
+					dev, obj, &trans, extack);
 	WARN(err, "%s: Commit of object (id=3D%d) failed.\n", dev->name, obj->id)=
;
 	switchdev_trans_items_warn_destroy(dev, &trans);
=20
@@ -430,7 +432,7 @@ static void switchdev_port_obj_add_deferred(struct net_=
device *dev,
 	const struct switchdev_obj *obj =3D data;
 	int err;
=20
-	err =3D switchdev_port_obj_add_now(dev, obj);
+	err =3D switchdev_port_obj_add_now(dev, obj, NULL);
 	if (err && err !=3D -EOPNOTSUPP)
 		netdev_err(dev, "failed (err=3D%d) to add object (id=3D%d)\n",
 			   err, obj->id);
@@ -460,12 +462,13 @@ static int switchdev_port_obj_add_defer(struct net_de=
vice *dev,
  *	in case SWITCHDEV_F_DEFER flag is not set.
  */
 int switchdev_port_obj_add(struct net_device *dev,
-			   const struct switchdev_obj *obj)
+			   const struct switchdev_obj *obj,
+			   struct netlink_ext_ack *extack)
 {
 	if (obj->flags & SWITCHDEV_F_DEFER)
 		return switchdev_port_obj_add_defer(dev, obj);
 	ASSERT_RTNL();
-	return switchdev_port_obj_add_now(dev, obj);
+	return switchdev_port_obj_add_now(dev, obj, extack);
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_add);
=20
@@ -473,7 +476,7 @@ static int switchdev_port_obj_del_now(struct net_device=
 *dev,
 				      const struct switchdev_obj *obj)
 {
 	return switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_DEL,
-					 dev, obj, NULL);
+					 dev, obj, NULL, NULL);
 }
=20
 static void switchdev_port_obj_del_deferred(struct net_device *dev,
--=20
2.4.11

