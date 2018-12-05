Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PtNhkKG6WCUAxU8wGMgAMzunatst6nYFbs+UOwG4lMs=;
	b=kbyKOoVc6QJyA6EOjbMDLnAT4+6Ex2kgnTM9l8pCdaPKR5uV2coIbNQNOFU1g655Fb+vTr3JUtGECkoEpxDRfMAZq6mO87/EAydmMS9nw9BXj5g8kibdIDBEjjgZ9P2L7bs3ySa1BUtTJt7KSV+W9h01vjeHa25mvOLwjLzoj2M=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:25 +0000
Message-ID: <20181205154958.20262-3-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 02/12] vxlan: Add vxlan_fdb_replay()
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

When a VXLAN device becomes relevant to a driver (such as when it is
attached to an offloaded bridge), the driver will generally need to walk
the existing FDB entries and offload them.

Add a function vxlan_fdb_replay() to call a given notifier block for
each FDB entry with a given VNI.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/vxlan.h |  9 +++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index fe5cd22e4b4d..3e44a358f7ea 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -556,6 +556,53 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8=
 *mac, __be32 vni,
 }
 EXPORT_SYMBOL_GPL(vxlan_fdb_find_uc);
=20
+static int vxlan_fdb_notify_one(struct notifier_block *nb,
+				const struct vxlan_dev *vxlan,
+				const struct vxlan_fdb *f,
+				const struct vxlan_rdst *rdst)
+{
+	struct switchdev_notifier_vxlan_fdb_info fdb_info;
+	int rc;
+
+	fdb_info =3D vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst);
+	rc =3D nb->notifier_call(nb, SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
+			       &fdb_info);
+	return notifier_to_errno(rc);
+}
+
+int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
+		     struct notifier_block *nb)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	unsigned int h;
+	int rc =3D 0;
+
+	if (!netif_is_vxlan(dev))
+		return -EINVAL;
+	vxlan =3D netdev_priv(dev);
+
+	spin_lock_bh(&vxlan->hash_lock);
+	for (h =3D 0; h < FDB_HASH_SIZE; ++h) {
+		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
+			if (f->vni =3D=3D vni) {
+				list_for_each_entry(rdst, &f->remotes, list) {
+					rc =3D vxlan_fdb_notify_one(nb, vxlan,
+								  f, rdst);
+					if (rc)
+						goto out;
+				}
+			}
+		}
+	}
+
+out:
+	spin_unlock_bh(&vxlan->hash_lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
+
 /* Replace destination of unicast mac */
 static int vxlan_fdb_replace(struct vxlan_fdb *f,
 			     union vxlan_addr *ip, __be16 port, __be32 vni,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index b73c670df184..f49aa9afe598 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -427,6 +427,9 @@ struct switchdev_notifier_vxlan_fdb_info {
 #if IS_ENABLED(CONFIG_VXLAN)
 int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 		      struct switchdev_notifier_vxlan_fdb_info *fdb_info);
+int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
+		     struct notifier_block *nb);
+
 #else
 static inline int
 vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
@@ -434,6 +437,12 @@ vxlan_fdb_find_uc(struct net_device *dev, const u8 *ma=
c, __be32 vni,
 {
 	return -ENOENT;
 }
+
+static inline int vxlan_fdb_replay(const struct net_device *dev, __be32 vn=
i,
+				   struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
 #endif
=20
 #endif
--=20
2.19.1

