Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jpqLJoWOIcaOjv57b4ceGBMFodF6qwSYvdUhkkF1VfI=;
	b=fj7wBSbV8gHGhdXcXbGgvJkbwdI7yOkLYzS6DiaS6iQMQFgKoXuSsm1DeQbYHfd8bSZ25Uo7sAgpV4nNZIImGZZ0cIONfyDwCn2sd5dB12AukccObx4/F+sW49srEGHwepClMaZfCEmZ7OZmvQkn52sueBOYtxru6tB1wnFI8II=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:34 +0000
Message-ID: <20181121080141.16676-2-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 01/16] vxlan: __vxlan_fdb_delete(): Drop
 unused argument vid
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

This argument is necessary for vxlan_fdb_delete(), the API of which is
prescribed by ndo_fdb_del, but __vxlan_fdb_delete() doesn't need it.
Therefore drop it.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index c3e65e78f015..99ab7844476f 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -977,7 +977,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlat=
tr *tb[],
 static int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 			      const unsigned char *addr, union vxlan_addr ip,
 			      __be16 port, __be32 src_vni, __be32 vni,
-			      u32 ifindex, u16 vid)
+			      u32 ifindex)
 {
 	struct vxlan_fdb *f;
 	struct vxlan_rdst *rd =3D NULL;
@@ -1024,8 +1024,7 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct=
 nlattr *tb[],
 		return err;
=20
 	spin_lock_bh(&vxlan->hash_lock);
-	err =3D __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
-				 vid);
+	err =3D __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex);
 	spin_unlock_bh(&vxlan->hash_lock);
=20
 	return err;
@@ -3611,7 +3610,7 @@ static int vxlan_changelink(struct net_device *dev, s=
truct nlattr *tb[],
 					   vxlan->cfg.dst_port,
 					   old_dst.remote_vni,
 					   old_dst.remote_vni,
-					   old_dst.remote_ifindex, 0);
+					   old_dst.remote_ifindex);
=20
 		if (!vxlan_addr_any(&dst->remote_ip)) {
 			err =3D vxlan_fdb_create(vxlan, all_zeros_mac,
--=20
2.19.1

