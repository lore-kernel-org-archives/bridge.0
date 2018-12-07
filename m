Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BN9gDQYZtK+d+ppFPEArw2Z3EmgFDSjnrLgfyCytlLU=;
	b=bCTnUY3+TScY5jVHXvBBRflsIAFxtLRiYJofQOq7KLPSra+297UMX9vIKZizXtBBopy+U42zCjrInCTzSLLxg7r0oZpPyVANvkFMSNwLG+9mQHydJWhXZP9XwMCtp5hrdB9Ba90J0kxVDCkv0YJ6zz1ZfIwqfRYruSgStKHorWQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:06 +0000
Message-ID: <20181207195433.22540-4-idosch@mellanox.com>
References: <20181207195433.22540-1-idosch@mellanox.com>
In-Reply-To: <20181207195433.22540-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 03/12] vxlan: Add
	vxlan_fdb_clear_offload()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

When a driver unoffloads all FDB entries en bloc, it's inefficient to
send the switchdev notification one by one. Add a helper that walks the
FDB table, unsetting the offload flag on RDST with a given VNI.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 22 ++++++++++++++++++++++
 include/net/vxlan.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index d9cb0d903283..b56ef684ecac 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -599,6 +599,28 @@ int vxlan_fdb_replay(const struct net_device *dev, __b=
e32 vni,
 }
 EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
=20
+void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	unsigned int h;
+
+	if (!netif_is_vxlan(dev))
+		return;
+	vxlan =3D netdev_priv(dev);
+
+	spin_lock_bh(&vxlan->hash_lock);
+	for (h =3D 0; h < FDB_HASH_SIZE; ++h) {
+		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
+			if (f->vni =3D=3D vni)
+				list_for_each_entry(rdst, &f->remotes, list)
+					rdst->offloaded =3D false;
+	}
+	spin_unlock_bh(&vxlan->hash_lock);
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_clear_offload);
+
 /* Replace destination of unicast mac */
 static int vxlan_fdb_replace(struct vxlan_fdb *f,
 			     union vxlan_addr *ip, __be16 port, __be32 vni,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index f49aa9afe598..236403eb5ba6 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -429,6 +429,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 =
*mac, __be32 vni,
 		      struct switchdev_notifier_vxlan_fdb_info *fdb_info);
 int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
 		     struct notifier_block *nb);
+void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni);
=20
 #else
 static inline int
@@ -443,6 +444,11 @@ static inline int vxlan_fdb_replay(const struct net_de=
vice *dev, __be32 vni,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void
+vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
+{
+}
 #endif
=20
 #endif
--=20
2.19.1

