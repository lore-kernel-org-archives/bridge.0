Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jt17UTPtSWrRsfadafQrd7q0epdNjppf116mgZyUU/0=;
	b=tI3eRwiec1zcQ6kQT9gYr76gKqR8gJIHCbdZKSdm7f/bW5s7rh4beyl+KEnMbJwM3KuvUkaMe9TkL79lXv2eDtUXa15QMt21Pp6dYleWNUDgto8MBqiiAHvh9UyMXShOng60Ypa5OJIllapxsYEObqxtQqUbQZn7r5B9SLNK7S0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:39 +0000
Message-ID: <20181121080141.16676-6-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 05/16] vxlan: Add hardware FDB learning
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

From: Petr Machata <petrm@mellanox.com>

In order to allow devices to signal learning events to VXLAN, introduce
two new switchdev messages: SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE and
SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE.

Listen to these notifications in the vxlan driver. The FDB entries
learned this way have an NTF_EXT_LEARNED flag, and only entries marked
as such can be unlearned by the _DEL_ event. They are also immediately
marked as offloaded. This is the same behavior that the bridge driver
observes.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c     | 73 ++++++++++++++++++++++++++++++++++++++++-
 include/net/switchdev.h |  2 ++
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index b50705a50686..03ba1b56ba6d 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3923,18 +3923,89 @@ vxlan_fdb_offloaded_set(struct net_device *dev,
 	spin_unlock_bh(&vxlan->hash_lock);
 }
=20
+static int
+vxlan_fdb_external_learn_add(struct net_device *dev,
+			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	int err;
+
+	spin_lock_bh(&vxlan->hash_lock);
+	err =3D vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
+			       NUD_REACHABLE,
+			       NLM_F_CREATE | NLM_F_REPLACE,
+			       fdb_info->remote_port,
+			       fdb_info->vni,
+			       fdb_info->remote_vni,
+			       fdb_info->remote_ifindex,
+			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
+			       false);
+	spin_unlock_bh(&vxlan->hash_lock);
+
+	return err;
+}
+
+static int
+vxlan_fdb_external_learn_del(struct net_device *dev,
+			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	struct vxlan_fdb *f;
+	int err =3D 0;
+
+	spin_lock_bh(&vxlan->hash_lock);
+
+	f =3D vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	if (!f)
+		err =3D -ENOENT;
+	else if (f->flags & NTF_EXT_LEARNED)
+		err =3D __vxlan_fdb_delete(vxlan, fdb_info->eth_addr,
+					 fdb_info->remote_ip,
+					 fdb_info->remote_port,
+					 fdb_info->vni,
+					 fdb_info->remote_vni,
+					 fdb_info->remote_ifindex,
+					 false);
+
+	spin_unlock_bh(&vxlan->hash_lock);
+
+	return err;
+}
+
 static int vxlan_switchdev_event(struct notifier_block *unused,
 				 unsigned long event, void *ptr)
 {
 	struct net_device *dev =3D switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_vxlan_fdb_info *fdb_info;
+	int err =3D 0;
=20
 	switch (event) {
 	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
 		vxlan_fdb_offloaded_set(dev, ptr);
 		break;
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+		fdb_info =3D ptr;
+		err =3D vxlan_fdb_external_learn_add(dev, fdb_info);
+		if (err) {
+			err =3D notifier_from_errno(err);
+			break;
+		}
+		fdb_info->offloaded =3D true;
+		vxlan_fdb_offloaded_set(dev, fdb_info);
+		break;
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+		fdb_info =3D ptr;
+		err =3D vxlan_fdb_external_learn_del(dev, fdb_info);
+		if (err) {
+			err =3D notifier_from_errno(err);
+			break;
+		}
+		fdb_info->offloaded =3D false;
+		vxlan_fdb_offloaded_set(dev, fdb_info);
+		break;
 	}
=20
-	return 0;
+	return err;
 }
=20
 static struct notifier_block vxlan_switchdev_notifier_block __read_mostly =
=3D {
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 881ecb1555bf..7b371e7c4bc6 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -146,6 +146,8 @@ enum switchdev_notifier_type {
 	SWITCHDEV_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_FDB_OFFLOADED,
=20
+	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
+	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
--=20
2.19.1

