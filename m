Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=U3nbgbA4OUEDsk3VprxnGRvFXLm2ahh45BfgG+2NRVQ=;
	b=eA5H2UalJ2Ruin/eD7fE9nrxri1Rp0Y9ks2zCy2z1qCjhjVlpkxwoJu0DTZNplWDKI77QikK0ov5HC5zD/uGLNPlpZCVSSY24jdicKy8hoiFqjoEk73RHBcxQHH6AUsGmybF9h7Tb++wJpsKrIbXNk1aTelXuEeyqyxNcXvLcGE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:36 +0000
Message-ID: <20181121080141.16676-4-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 03/16] vxlan: Mark user-added FDB entries
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

The VXLAN driver needs to differentiate between FDB entries learned by
the VXLAN driver, and those added by the user. The latter ones shouldn't
be taken over by external learning events. This is in accordance with
bridge behavior.

Therefore, extend the flags bitfield to 16 bits and add a new private
NTF flag to mark the user-added entries.

This seems preferable to adding a dedicated boolean, because passing the
flag, unlike passing e.g. a true, makes it clear what the meaning of the
bit is.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 17 +++++++++++------
 include/net/vxlan.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 441290464912..9171c1f42fe9 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -79,9 +79,11 @@ struct vxlan_fdb {
 	u8		  eth_addr[ETH_ALEN];
 	u16		  state;	/* see ndm_state */
 	__be32		  vni;
-	u8		  flags;	/* see ndm_flags */
+	u16		  flags;	/* see ndm_flags and below */
 };
=20
+#define NTF_VXLAN_ADDED_BY_USER 0x100
+
 /* salt for hash table */
 static u32 vxlan_salt __read_mostly;
=20
@@ -376,6 +378,7 @@ static void vxlan_fdb_switchdev_call_notifiers(struct v=
xlan_dev *vxlan,
 		.remote_ifindex =3D rd->remote_ifindex,
 		.vni =3D fdb->vni,
 		.offloaded =3D rd->offloaded,
+		.added_by_user =3D fdb->flags & NTF_VXLAN_ADDED_BY_USER,
 	};
 	memcpy(info.eth_addr, fdb->eth_addr, ETH_ALEN);
=20
@@ -544,6 +547,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 =
*mac, __be32 vni,
 	fdb_info->remote_ifindex =3D rdst->remote_ifindex;
 	fdb_info->vni =3D vni;
 	fdb_info->offloaded =3D rdst->offloaded;
+	fdb_info->added_by_user =3D f->flags & NTF_VXLAN_ADDED_BY_USER;
 	ether_addr_copy(fdb_info->eth_addr, mac);
=20
 out:
@@ -704,7 +708,7 @@ static int vxlan_gro_complete(struct sock *sk, struct s=
k_buff *skb, int nhoff)
=20
 static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan,
 					 const u8 *mac, __u16 state,
-					 __be32 src_vni, __u8 ndm_flags)
+					 __be32 src_vni, __u16 ndm_flags)
 {
 	struct vxlan_fdb *f;
=20
@@ -724,7 +728,7 @@ static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_d=
ev *vxlan,
 static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
 			    __u16 state, __be16 port, __be32 src_vni,
-			    __be32 vni, __u32 ifindex, __u8 ndm_flags,
+			    __be32 vni, __u32 ifindex, __u16 ndm_flags,
 			    struct vxlan_fdb **fdb)
 {
 	struct vxlan_rdst *rd =3D NULL;
@@ -760,10 +764,10 @@ static int vxlan_fdb_update(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
 			    __u16 state, __u16 flags,
 			    __be16 port, __be32 src_vni, __be32 vni,
-			    __u32 ifindex, __u8 ndm_flags,
+			    __u32 ifindex, __u16 ndm_flags,
 			    bool swdev_notify)
 {
-	__u8 fdb_flags =3D (ndm_flags & ~NTF_USE);
+	__u16 fdb_flags =3D (ndm_flags & ~NTF_USE);
 	struct vxlan_rdst *rd =3D NULL;
 	struct vxlan_fdb *f;
 	int notify =3D 0;
@@ -974,7 +978,8 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlat=
tr *tb[],
=20
 	spin_lock_bh(&vxlan->hash_lock);
 	err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
-			       port, src_vni, vni, ifindex, ndm->ndm_flags,
+			       port, src_vni, vni, ifindex,
+			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
 			       true);
 	spin_unlock_bh(&vxlan->hash_lock);
=20
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index ec999c49df1f..b73c670df184 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -421,6 +421,7 @@ struct switchdev_notifier_vxlan_fdb_info {
 	u8 eth_addr[ETH_ALEN];
 	__be32 vni;
 	bool offloaded;
+	bool added_by_user;
 };
=20
 #if IS_ENABLED(CONFIG_VXLAN)
--=20
2.19.1

