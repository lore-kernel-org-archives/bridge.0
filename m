Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+kpoAPA2SgypkRiA4ECMXu1P8Eg0621HBkHYUDp7hME=;
	b=bYsb6X+mAU9jSeIFNCKpcZRSQasgHbeXUTcpON31dmhD3isIcvX/wAdCLimM0vbWhwymJgN2IRXTEu+U1bCrKatIDpoYL9flDELRycoQjVDoL5Vu1/hRYSq3Adn8jGpm6aPH0mfomq/WdhoZF+l3lP4XlPk2s7Nbc36RKT5Bsys=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:03 +0000
Message-ID: <20181207195433.22540-2-idosch@mellanox.com>
References: <20181207195433.22540-1-idosch@mellanox.com>
In-Reply-To: <20181207195433.22540-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 01/12] vxlan: Add a function to init
 switchdev_notifier_vxlan_fdb_info
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

There are currently two places that need to initialize the notifier info
structure, and one more is coming next when vxlan_fdb_replay() is
introduced. These three instances have / will have very similar code
that is easy to abstract away into a named function.

Add such function, vxlan_fdb_switchdev_notifier_info(), and call it from
vxlan_fdb_switchdev_call_notifiers() and vxlan_fdb_find_uc().

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 901eef428280..d3db0313c97e 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -358,6 +358,22 @@ static void __vxlan_fdb_notify(struct vxlan_dev *vxlan=
, struct vxlan_fdb *fdb,
 		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
 }
=20
+static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxla=
n,
+			    const struct vxlan_fdb *fdb,
+			    const struct vxlan_rdst *rd,
+			    struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	fdb_info->info.dev =3D vxlan->dev;
+	fdb_info->remote_ip =3D rd->remote_ip;
+	fdb_info->remote_port =3D rd->remote_port;
+	fdb_info->remote_vni =3D rd->remote_vni;
+	fdb_info->remote_ifindex =3D rd->remote_ifindex;
+	memcpy(fdb_info->eth_addr, fdb->eth_addr, ETH_ALEN);
+	fdb_info->vni =3D fdb->vni;
+	fdb_info->offloaded =3D rd->offloaded;
+	fdb_info->added_by_user =3D fdb->flags & NTF_VXLAN_ADDED_BY_USER;
+}
+
 static void vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
 					       struct vxlan_fdb *fdb,
 					       struct vxlan_rdst *rd,
@@ -371,18 +387,7 @@ static void vxlan_fdb_switchdev_call_notifiers(struct =
vxlan_dev *vxlan,
=20
 	notifier_type =3D adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE
 			       : SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE;
-
-	info =3D (struct switchdev_notifier_vxlan_fdb_info){
-		.remote_ip =3D rd->remote_ip,
-		.remote_port =3D rd->remote_port,
-		.remote_vni =3D rd->remote_vni,
-		.remote_ifindex =3D rd->remote_ifindex,
-		.vni =3D fdb->vni,
-		.offloaded =3D rd->offloaded,
-		.added_by_user =3D fdb->flags & NTF_VXLAN_ADDED_BY_USER,
-	};
-	memcpy(info.eth_addr, fdb->eth_addr, ETH_ALEN);
-
+	vxlan_fdb_switchdev_notifier_info(vxlan, fdb, rd, &info);
 	call_switchdev_notifiers(notifier_type, vxlan->dev,
 				 &info.info);
 }
@@ -539,17 +544,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8=
 *mac, __be32 vni,
 	}
=20
 	rdst =3D first_remote_rcu(f);
-
-	memset(fdb_info, 0, sizeof(*fdb_info));
-	fdb_info->info.dev =3D dev;
-	fdb_info->remote_ip =3D rdst->remote_ip;
-	fdb_info->remote_port =3D rdst->remote_port;
-	fdb_info->remote_vni =3D rdst->remote_vni;
-	fdb_info->remote_ifindex =3D rdst->remote_ifindex;
-	fdb_info->vni =3D vni;
-	fdb_info->offloaded =3D rdst->offloaded;
-	fdb_info->added_by_user =3D f->flags & NTF_VXLAN_ADDED_BY_USER;
-	ether_addr_copy(fdb_info->eth_addr, mac);
+	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, fdb_info);
=20
 out:
 	rcu_read_unlock();
--=20
2.19.1

