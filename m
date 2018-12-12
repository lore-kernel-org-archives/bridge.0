Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ech2ljaQYNDLuGnk3zXUmGP40fp2y8kfQLGW2hrFDXY=;
	b=tDa5YxImtyKYxQfMpdUOGEnMYz7dhjigPjwJqeQavP8dSiEp7PwNFDTzLyEsIdikc0wJAxQHfbPQfIaazcv1gOq9lE+gyuloVnCD4WbXPtf0M1fcSM8nffDHl8NnUsqdagnb6QBDGonv6OAJkViXggGgIUJoT0fK5FbPYlep+HU=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:02:54 +0000
Message-ID: <e3df8082c0b7f72f79884fcfe3407ee3e68ecc0f.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 4/9] net: switchdev: Add extack to
 struct switchdev_notifier_info
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

In order to pass extack to the drivers that need it, add an extack field
to struct switchdev_notifier_info, and an extack argument to the
function call_switchdev_blocking_notifiers(). Also add a helper function
switchdev_notifier_info_to_extack().

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c       |  1 +
 include/net/switchdev.h   | 13 +++++++++++--
 net/switchdev/switchdev.c |  7 +++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index b56ef684ecac..49d4b5854c62 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -364,6 +364,7 @@ static void vxlan_fdb_switchdev_notifier_info(const str=
uct vxlan_dev *vxlan,
 			    struct switchdev_notifier_vxlan_fdb_info *fdb_info)
 {
 	fdb_info->info.dev =3D vxlan->dev;
+	fdb_info->info.extack =3D NULL;
 	fdb_info->remote_ip =3D rd->remote_ip;
 	fdb_info->remote_port =3D rd->remote_port;
 	fdb_info->remote_vni =3D rd->remote_vni;
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 69016305ad58..4facfa6775e8 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -149,6 +149,7 @@ enum switchdev_notifier_type {
=20
 struct switchdev_notifier_info {
 	struct net_device *dev;
+	struct netlink_ext_ack *extack;
 };
=20
 struct switchdev_notifier_fdb_info {
@@ -172,6 +173,12 @@ switchdev_notifier_info_to_dev(const struct switchdev_=
notifier_info *info)
 	return info->dev;
 }
=20
+static inline struct netlink_ext_ack *
+switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *in=
fo)
+{
+	return info->extack;
+}
+
 #ifdef CONFIG_NET_SWITCHDEV
=20
 void switchdev_deferred_process(void);
@@ -193,7 +200,8 @@ int call_switchdev_notifiers(unsigned long val, struct =
net_device *dev,
 int register_switchdev_blocking_notifier(struct notifier_block *nb);
 int unregister_switchdev_blocking_notifier(struct notifier_block *nb);
 int call_switchdev_blocking_notifiers(unsigned long val, struct net_device=
 *dev,
-				      struct switchdev_notifier_info *info);
+				      struct switchdev_notifier_info *info,
+				      struct netlink_ext_ack *extack);
=20
 void switchdev_port_fwd_mark_set(struct net_device *dev,
 				 struct net_device *group_dev,
@@ -278,7 +286,8 @@ unregister_switchdev_blocking_notifier(struct notifier_=
block *nb)
 static inline int
 call_switchdev_blocking_notifiers(unsigned long val,
 				  struct net_device *dev,
-				  struct switchdev_notifier_info *info)
+				  struct switchdev_notifier_info *info,
+				  struct netlink_ext_ack *extack)
 {
 	return NOTIFY_DONE;
 }
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index cb20669bf6ce..aa84acfb6632 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -368,7 +368,7 @@ static int switchdev_port_obj_notify(enum switchdev_not=
ifier_type nt,
 		.handled =3D false,
 	};
=20
-	rc =3D call_switchdev_blocking_notifiers(nt, dev, &obj_info.info);
+	rc =3D call_switchdev_blocking_notifiers(nt, dev, &obj_info.info, extack)=
;
 	err =3D notifier_to_errno(rc);
 	if (err) {
 		WARN_ON(!obj_info.handled);
@@ -559,6 +559,7 @@ int call_switchdev_notifiers(unsigned long val, struct =
net_device *dev,
 			     struct switchdev_notifier_info *info)
 {
 	info->dev =3D dev;
+	info->extack =3D NULL;
 	return atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
 }
 EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
@@ -580,9 +581,11 @@ int unregister_switchdev_blocking_notifier(struct noti=
fier_block *nb)
 EXPORT_SYMBOL_GPL(unregister_switchdev_blocking_notifier);
=20
 int call_switchdev_blocking_notifiers(unsigned long val, struct net_device=
 *dev,
-				      struct switchdev_notifier_info *info)
+				      struct switchdev_notifier_info *info,
+				      struct netlink_ext_ack *extack)
 {
 	info->dev =3D dev;
+	info->extack =3D extack;
 	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
 					    val, info);
 }
--=20
2.4.11

