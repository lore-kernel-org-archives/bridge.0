Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=irBq6d+Vz3Sw+oCxjqZCdLasQkY69eFd2VGVc5REPGY=;
	b=GQ9Ds3m49U4VzLlPYDzXJGfnCuCWsSzsT/yzPaIMTpeJz/nrEyP7ME0aiZ2W8I7UyC4pmoPi0z5esNh5/FZMnQUbfLNtXDGzxJo+/jAaf3OaYjm0Entp0p7NZzw3MOxx2PQe9DEJuWZR9BnZFJsCy3YUSuL5renFXHecV+nqEIU=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 8 Jan 2019 16:48:11 +0000
Message-ID: <20190108164732.4024-9-idosch@mellanox.com>
References: <20190108164732.4024-1-idosch@mellanox.com>
In-Reply-To: <20190108164732.4024-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net 08/11] net: bridge: Fix VLANs memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: mlxsw <mlxsw@mellanox.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Nir Dotan <nird@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

When adding / deleting VLANs to / from a bridge port, the bridge driver
first tries to propagate the information via switchdev and falls back to
the 8021q driver in case the underlying driver does not support
switchdev. This can result in a memory leak [1] when VXLAN and mlxsw
ports are enslaved to the bridge:

$ ip link set dev vxlan0 master br0
# No mlxsw ports are enslaved to 'br0', so mlxsw ignores the switchdev
# notification and the bridge driver adds the VLAN on 'vxlan0' via the
# 8021q driver
$ bridge vlan add vid 10 dev vxlan0 pvid untagged
# mlxsw port is enslaved to the bridge
$ ip link set dev swp1 master br0
# mlxsw processes the switchdev notification and the 8021q driver is
# skipped
$ bridge vlan del vid 10 dev vxlan0

This results in 'struct vlan_info' and 'struct vlan_vid_info' being
leaked, as they were allocated by the 8021q driver during VLAN addition,
but never freed as the 8021q driver was skipped during deletion.

Fix this by introducing a new VLAN private flag that indicates whether
the VLAN was added on the port by switchdev or the 8021q driver. If the
VLAN was added by the 8021q driver, then we make sure to delete it via
the 8021q driver as well.

[1]
unreferenced object 0xffff88822d20b1e8 (size 256):
  comm "bridge", pid 2532, jiffies 4295216998 (age 1188.830s)
  hex dump (first 32 bytes):
    e0 42 97 ce 81 88 ff ff 00 00 00 00 00 00 00 00  .B..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f82d851d>] kmem_cache_alloc_trace+0x1be/0x330
    [<00000000e0178b02>] vlan_vid_add+0x661/0x920
    [<00000000218ebd5f>] __vlan_add+0x1be9/0x3a00
    [<000000006eafa1ca>] nbp_vlan_add+0x8b3/0xd90
    [<000000003535392c>] br_vlan_info+0x132/0x410
    [<00000000aedaa9dc>] br_afspec+0x75c/0x870
    [<00000000f5716133>] br_setlink+0x3dc/0x6d0
    [<00000000aceca5e2>] rtnl_bridge_setlink+0x615/0xb30
    [<00000000a2f2d23e>] rtnetlink_rcv_msg+0x3a3/0xa80
    [<0000000064097e69>] netlink_rcv_skb+0x152/0x3c0
    [<000000008be8d614>] rtnetlink_rcv+0x21/0x30
    [<000000009ab2ca25>] netlink_unicast+0x52f/0x740
    [<00000000e7d9ac96>] netlink_sendmsg+0x9c7/0xf50
    [<000000005d1e2050>] sock_sendmsg+0xbe/0x120
    [<00000000d51426bc>] ___sys_sendmsg+0x778/0x8f0
    [<00000000b9d7b2cc>] __sys_sendmsg+0x112/0x270
unreferenced object 0xffff888227454308 (size 32):
  comm "bridge", pid 2532, jiffies 4295216998 (age 1188.882s)
  hex dump (first 32 bytes):
    88 b2 20 2d 82 88 ff ff 88 b2 20 2d 82 88 ff ff  .. -...... -....
    81 00 0a 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f82d851d>] kmem_cache_alloc_trace+0x1be/0x330
    [<0000000018050631>] vlan_vid_add+0x3e6/0x920
    [<00000000218ebd5f>] __vlan_add+0x1be9/0x3a00
    [<000000006eafa1ca>] nbp_vlan_add+0x8b3/0xd90
    [<000000003535392c>] br_vlan_info+0x132/0x410
    [<00000000aedaa9dc>] br_afspec+0x75c/0x870
    [<00000000f5716133>] br_setlink+0x3dc/0x6d0
    [<00000000aceca5e2>] rtnl_bridge_setlink+0x615/0xb30
    [<00000000a2f2d23e>] rtnetlink_rcv_msg+0x3a3/0xa80
    [<0000000064097e69>] netlink_rcv_skb+0x152/0x3c0
    [<000000008be8d614>] rtnetlink_rcv+0x21/0x30
    [<000000009ab2ca25>] netlink_unicast+0x52f/0x740
    [<00000000e7d9ac96>] netlink_sendmsg+0x9c7/0xf50
    [<000000005d1e2050>] sock_sendmsg+0xbe/0x120
    [<00000000d51426bc>] ___sys_sendmsg+0x778/0x8f0
    [<00000000b9d7b2cc>] __sys_sendmsg+0x112/0x270

Fixes: d70e42b22dd4 ("mlxsw: spectrum: Enable VxLAN enslavement to VLAN-awa=
re bridges")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org
---
 net/bridge/br_private.h |  1 +
 net/bridge/br_vlan.c    | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d240b3e7919f..eabf8bf28a3f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -107,6 +107,7 @@ struct br_tunnel_info {
 /* private vlan flags */
 enum {
 	BR_VLFLAG_PER_PORT_STATS =3D BIT(0),
+	BR_VLFLAG_ADDED_BY_SWITCHDEV =3D BIT(1),
 };
=20
 /**
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 4a2f31157ef5..96abf8feb9dc 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -80,16 +80,18 @@ static bool __vlan_add_flags(struct net_bridge_vlan *v,=
 u16 flags)
 }
=20
 static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
-			  u16 vid, u16 flags, struct netlink_ext_ack *extack)
+			  struct net_bridge_vlan *v, u16 flags,
+			  struct netlink_ext_ack *extack)
 {
 	int err;
=20
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
-	err =3D br_switchdev_port_vlan_add(dev, vid, flags, extack);
+	err =3D br_switchdev_port_vlan_add(dev, v->vid, flags, extack);
 	if (err =3D=3D -EOPNOTSUPP)
-		return vlan_vid_add(dev, br->vlan_proto, vid);
+		return vlan_vid_add(dev, br->vlan_proto, v->vid);
+	v->priv_flags |=3D BR_VLFLAG_ADDED_BY_SWITCHDEV;
 	return err;
 }
=20
@@ -121,19 +123,17 @@ static void __vlan_del_list(struct net_bridge_vlan *v=
)
 }
=20
 static int __vlan_vid_del(struct net_device *dev, struct net_bridge *br,
-			  u16 vid)
+			  const struct net_bridge_vlan *v)
 {
 	int err;
=20
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q del.
 	 */
-	err =3D br_switchdev_port_vlan_del(dev, vid);
-	if (err =3D=3D -EOPNOTSUPP) {
-		vlan_vid_del(dev, br->vlan_proto, vid);
-		return 0;
-	}
-	return err;
+	err =3D br_switchdev_port_vlan_del(dev, v->vid);
+	if (!(v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV))
+		vlan_vid_del(dev, br->vlan_proto, v->vid);
+	return err =3D=3D -EOPNOTSUPP ? 0 : err;
 }
=20
 /* Returns a master vlan, if it didn't exist it gets created. In all cases=
 a
@@ -242,7 +242,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 fl=
ags,
 		 * This ensures tagged traffic enters the bridge when
 		 * promiscuous mode is disabled by br_manage_promisc().
 		 */
-		err =3D __vlan_vid_add(dev, br, v->vid, flags, extack);
+		err =3D __vlan_vid_add(dev, br, v, flags, extack);
 		if (err)
 			goto out;
=20
@@ -305,7 +305,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 fl=
ags,
=20
 out_filt:
 	if (p) {
-		__vlan_vid_del(dev, br, v->vid);
+		__vlan_vid_del(dev, br, v);
 		if (masterv) {
 			if (v->stats && masterv->stats !=3D v->stats)
 				free_percpu(v->stats);
@@ -338,7 +338,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
=20
 	__vlan_delete_pvid(vg, v->vid);
 	if (p) {
-		err =3D __vlan_vid_del(p->dev, p->br, v->vid);
+		err =3D __vlan_vid_del(p->dev, p->br, v);
 		if (err)
 			goto out;
 	} else {
--=20
2.20.1

