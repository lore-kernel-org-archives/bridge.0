Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=w2Yad5Wb5XsIDQFbU/sVhhhPxXCpZ8NKCjOzcx9xLyQ=;
	b=Jd0n8VQOfTsMZXmuLNMGDfCTshDMC286sxzGYLkmXZwH+qwjfS8f7Tmx3yb2Hfwl9uE3oKKpqfjoashoHl6xh9XiLzShlh+ihj6rF1m5mIQoreWJo7Z5fyw2blt8xZqO4WBBFb3cCQP5asrjQitetYeTthybjq6wNfqOexd8AjM=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:44 +0000
Message-ID: <20181013171725.3261-15-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 14/18] vxlan: Support marking RDSTs as
	offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

Offloaded bridge FDB entries are marked with NTF_OFFLOADED. Implement a
similar mechanism for VXLAN, where a given remote destination can be
marked as offloaded.

To that end, introduce a new event, SWITCHDEV_VXLAN_FDB_OFFLOADED,
through which the marking is communicated to the vxlan driver. To
identify which RDST should be marked as offloaded, an
switchdev_notifier_vxlan_fdb_info is passed to the listeners. The
"offloaded" flag in that object determines whether the offloaded mark
should be set or cleared.

When sending offloaded FDB entries over netlink, mark them with
NTF_OFFLOADED.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c     | 59 ++++++++++++++++++++++++++++++++++++++++-
 include/net/switchdev.h |  1 +
 include/net/vxlan.h     |  2 ++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 97c2218569d9..0be9e285f265 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -272,6 +272,8 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct v=
xlan_dev *vxlan,
 	ndm->ndm_state =3D fdb->state;
 	ndm->ndm_ifindex =3D vxlan->dev->ifindex;
 	ndm->ndm_flags =3D fdb->flags;
+	if (rdst->offloaded)
+		ndm->ndm_flags |=3D NTF_OFFLOADED;
 	ndm->ndm_type =3D RTN_UNICAST;
=20
 	if (!net_eq(dev_net(vxlan->dev), vxlan->net) &&
@@ -373,6 +375,7 @@ static void vxlan_fdb_switchdev_call_notifiers(struct v=
xlan_dev *vxlan,
 		.remote_vni =3D rd->remote_vni,
 		.remote_ifindex =3D rd->remote_ifindex,
 		.vni =3D fdb->vni,
+		.offloaded =3D rd->offloaded,
 	};
 	memcpy(info.eth_addr, fdb->eth_addr, ETH_ALEN);
=20
@@ -536,6 +539,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 =
*mac, __be32 vni,
 	fdb_info->remote_vni =3D rdst->remote_vni;
 	fdb_info->remote_ifindex =3D rdst->remote_ifindex;
 	fdb_info->vni =3D vni;
+	fdb_info->offloaded =3D rdst->offloaded;
 	ether_addr_copy(fdb_info->eth_addr, mac);
=20
 out:
@@ -589,6 +593,7 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
=20
 	rd->remote_ip =3D *ip;
 	rd->remote_port =3D port;
+	rd->offloaded =3D false;
 	rd->remote_vni =3D vni;
 	rd->remote_ifindex =3D ifindex;
=20
@@ -3814,6 +3819,51 @@ static struct notifier_block vxlan_notifier_block __=
read_mostly =3D {
 	.notifier_call =3D vxlan_netdevice_event,
 };
=20
+static void
+vxlan_fdb_offloaded_set(struct net_device *dev,
+			struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+
+	spin_lock_bh(&vxlan->hash_lock);
+
+	f =3D vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	if (!f)
+		goto out;
+
+	rdst =3D vxlan_fdb_find_rdst(f, &fdb_info->remote_ip,
+				   fdb_info->remote_port,
+				   fdb_info->remote_vni,
+				   fdb_info->remote_ifindex);
+	if (!rdst)
+		goto out;
+
+	rdst->offloaded =3D fdb_info->offloaded;
+
+out:
+	spin_unlock_bh(&vxlan->hash_lock);
+}
+
+static int vxlan_switchdev_event(struct notifier_block *unused,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev =3D switchdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		vxlan_fdb_offloaded_set(dev, ptr);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block vxlan_switchdev_notifier_block __read_mostly =
=3D {
+	.notifier_call =3D vxlan_switchdev_event,
+};
+
 static __net_init int vxlan_init_net(struct net *net)
 {
 	struct vxlan_net *vn =3D net_generic(net, vxlan_net_id);
@@ -3887,11 +3937,17 @@ static int __init vxlan_init_module(void)
 	if (rc)
 		goto out2;
=20
-	rc =3D rtnl_link_register(&vxlan_link_ops);
+	rc =3D register_switchdev_notifier(&vxlan_switchdev_notifier_block);
 	if (rc)
 		goto out3;
=20
+	rc =3D rtnl_link_register(&vxlan_link_ops);
+	if (rc)
+		goto out4;
+
 	return 0;
+out4:
+	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
 out3:
 	unregister_netdevice_notifier(&vxlan_notifier_block);
 out2:
@@ -3904,6 +3960,7 @@ late_initcall(vxlan_init_module);
 static void __exit vxlan_cleanup_module(void)
 {
 	rtnl_link_unregister(&vxlan_link_ops);
+	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
 	unregister_netdevice_notifier(&vxlan_notifier_block);
 	unregister_pernet_subsys(&vxlan_net_ops);
 	/* rcu_barrier() is called by netns */
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 47199a11c586..b040f82351ba 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -148,6 +148,7 @@ enum switchdev_notifier_type {
=20
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
+	SWITCHDEV_VXLAN_FDB_OFFLOADED,
 };
=20
 struct switchdev_notifier_info {
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 798ba5019f4e..6457a82764cf 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -191,6 +191,7 @@ union vxlan_addr {
 struct vxlan_rdst {
 	union vxlan_addr	 remote_ip;
 	__be16			 remote_port;
+	u8			 offloaded:1;
 	__be32			 remote_vni;
 	u32			 remote_ifindex;
 	struct list_head	 list;
@@ -411,6 +412,7 @@ struct switchdev_notifier_vxlan_fdb_info {
 	u32 remote_ifindex;
 	u8 eth_addr[ETH_ALEN];
 	__be32 vni;
+	bool offloaded;
 };
=20
 #if IS_ENABLED(CONFIG_VXLAN)
--=20
2.17.2

