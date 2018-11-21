Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iul4VAdFcRuMceM/hm9LKPRvMB4jiS10cX2McjoN2v0=;
	b=X/CTsgmuY+5DmsfMXJgHfo8GahgJrda7wU4HkLLu8RSg0zF+BG/KRfPXwy3d1PXt1zgKkYDr2oX66/0PWDv92kRu0SG/wqgg90ranKydVyx1wnElTgrJYDAhR8An+u4ELtL0aBcSn/G77NP2QvvVHq7Lv/P4kt6N+SJyHkRlDzo=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:35 +0000
Message-ID: <20181121080141.16676-3-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 02/16] vxlan: vxlan_fdb_notify(): Make
 switchdev notification configurable
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

In a following patch, vxlan is extended to allow hardware FDB learning.
For FDB entries learned this way, switchdev notifications should not be
sent again, because the driver already knows about these entries.

To that end, add an argument vxlan_fdb_notify() to determine whether
the switchdev notifications should be sent. Propagate the argument to
all call sites transitively, eventually passing true in all root calls.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 71 ++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 99ab7844476f..441290464912 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -384,15 +384,19 @@ static void vxlan_fdb_switchdev_call_notifiers(struct=
 vxlan_dev *vxlan,
 }
=20
 static void vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fd=
b,
-			     struct vxlan_rdst *rd, int type)
+			     struct vxlan_rdst *rd, int type, bool swdev_notify)
 {
-	switch (type) {
-	case RTM_NEWNEIGH:
-		vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd, true);
-		break;
-	case RTM_DELNEIGH:
-		vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd, false);
-		break;
+	if (swdev_notify) {
+		switch (type) {
+		case RTM_NEWNEIGH:
+			vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
+							   true);
+			break;
+		case RTM_DELNEIGH:
+			vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
+							   false);
+			break;
+		}
 	}
=20
 	__vxlan_fdb_notify(vxlan, fdb, rd, type);
@@ -409,7 +413,7 @@ static void vxlan_ip_miss(struct net_device *dev, union=
 vxlan_addr *ipa)
 		.remote_vni =3D cpu_to_be32(VXLAN_N_VID),
 	};
=20
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH);
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true);
 }
=20
 static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_=
ALEN])
@@ -421,7 +425,7 @@ static void vxlan_fdb_miss(struct vxlan_dev *vxlan, con=
st u8 eth_addr[ETH_ALEN])
=20
 	memcpy(f.eth_addr, eth_addr, ETH_ALEN);
=20
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH);
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true);
 }
=20
 /* Hash Ethernet address */
@@ -756,7 +760,8 @@ static int vxlan_fdb_update(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
 			    __u16 state, __u16 flags,
 			    __be16 port, __be32 src_vni, __be32 vni,
-			    __u32 ifindex, __u8 ndm_flags)
+			    __u32 ifindex, __u8 ndm_flags,
+			    bool swdev_notify)
 {
 	__u8 fdb_flags =3D (ndm_flags & ~NTF_USE);
 	struct vxlan_rdst *rd =3D NULL;
@@ -822,7 +827,7 @@ static int vxlan_fdb_update(struct vxlan_dev *vxlan,
 	if (notify) {
 		if (rd =3D=3D NULL)
 			rd =3D first_remote_rtnl(f);
-		vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH);
+		vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH, swdev_notify);
 	}
=20
 	return 0;
@@ -841,7 +846,7 @@ static void vxlan_fdb_free(struct rcu_head *head)
 }
=20
 static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f=
,
-			      bool do_notify)
+			      bool do_notify, bool swdev_notify)
 {
 	struct vxlan_rdst *rd;
=20
@@ -851,7 +856,8 @@ static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, =
struct vxlan_fdb *f,
 	--vxlan->addrcnt;
 	if (do_notify)
 		list_for_each_entry(rd, &f->remotes, list)
-			vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH);
+			vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH,
+					 swdev_notify);
=20
 	hlist_del_rcu(&f->hlist);
 	call_rcu(&f->rcu, vxlan_fdb_free);
@@ -866,10 +872,10 @@ static void vxlan_dst_free(struct rcu_head *head)
 }
=20
 static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fd=
b *f,
-				  struct vxlan_rdst *rd)
+				  struct vxlan_rdst *rd, bool swdev_notify)
 {
 	list_del_rcu(&rd->list);
-	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH);
+	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, swdev_notify);
 	call_rcu(&rd->rcu, vxlan_dst_free);
 }
=20
@@ -968,7 +974,8 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlat=
tr *tb[],
=20
 	spin_lock_bh(&vxlan->hash_lock);
 	err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
-			       port, src_vni, vni, ifindex, ndm->ndm_flags);
+			       port, src_vni, vni, ifindex, ndm->ndm_flags,
+			       true);
 	spin_unlock_bh(&vxlan->hash_lock);
=20
 	return err;
@@ -977,7 +984,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlat=
tr *tb[],
 static int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 			      const unsigned char *addr, union vxlan_addr ip,
 			      __be16 port, __be32 src_vni, __be32 vni,
-			      u32 ifindex)
+			      u32 ifindex, bool swdev_notify)
 {
 	struct vxlan_fdb *f;
 	struct vxlan_rdst *rd =3D NULL;
@@ -997,11 +1004,11 @@ static int __vxlan_fdb_delete(struct vxlan_dev *vxla=
n,
 	 * otherwise destroy the fdb entry
 	 */
 	if (rd && !list_is_singular(&f->remotes)) {
-		vxlan_fdb_dst_destroy(vxlan, f, rd);
+		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
 		goto out;
 	}
=20
-	vxlan_fdb_destroy(vxlan, f, true);
+	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
=20
 out:
 	return 0;
@@ -1024,7 +1031,8 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct=
 nlattr *tb[],
 		return err;
=20
 	spin_lock_bh(&vxlan->hash_lock);
-	err =3D __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex);
+	err =3D __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
+				 true);
 	spin_unlock_bh(&vxlan->hash_lock);
=20
 	return err;
@@ -1102,7 +1110,7 @@ static bool vxlan_snoop(struct net_device *dev,
=20
 		rdst->remote_ip =3D *src_ip;
 		f->updated =3D jiffies;
-		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH);
+		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true);
 	} else {
 		/* learned new entry */
 		spin_lock(&vxlan->hash_lock);
@@ -1115,7 +1123,7 @@ static bool vxlan_snoop(struct net_device *dev,
 					 vxlan->cfg.dst_port,
 					 vni,
 					 vxlan->default_dst.remote_vni,
-					 ifindex, NTF_SELF);
+					 ifindex, NTF_SELF, true);
 		spin_unlock(&vxlan->hash_lock);
 	}
=20
@@ -2499,7 +2507,7 @@ static void vxlan_cleanup(struct timer_list *t)
 					   "garbage collect %pM\n",
 					   f->eth_addr);
 				f->state =3D NUD_STALE;
-				vxlan_fdb_destroy(vxlan, f, true);
+				vxlan_fdb_destroy(vxlan, f, true, true);
 			} else if (time_before(timeout, next_timer))
 				next_timer =3D timeout;
 		}
@@ -2550,7 +2558,7 @@ static void vxlan_fdb_delete_default(struct vxlan_dev=
 *vxlan, __be32 vni)
 	spin_lock_bh(&vxlan->hash_lock);
 	f =3D __vxlan_find_mac(vxlan, all_zeros_mac, vni);
 	if (f)
-		vxlan_fdb_destroy(vxlan, f, true);
+		vxlan_fdb_destroy(vxlan, f, true, true);
 	spin_unlock_bh(&vxlan->hash_lock);
 }
=20
@@ -2604,7 +2612,7 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool=
 do_all)
 				continue;
 			/* the all_zeros_mac entry is deleted at vxlan_uninit */
 			if (!is_zero_ether_addr(f->eth_addr))
-				vxlan_fdb_destroy(vxlan, f, true);
+				vxlan_fdb_destroy(vxlan, f, true, true);
 		}
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
@@ -3342,13 +3350,14 @@ static int __vxlan_dev_create(struct net *net, stru=
ct net_device *dev,
=20
 	/* notify default fdb entry */
 	if (f)
-		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
+		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
+				 true);
=20
 	list_add(&vxlan->next, &vn->vxlan_list);
 	return 0;
 errout:
 	if (f)
-		vxlan_fdb_destroy(vxlan, f, false);
+		vxlan_fdb_destroy(vxlan, f, false, false);
 	return err;
 }
=20
@@ -3610,7 +3619,8 @@ static int vxlan_changelink(struct net_device *dev, s=
truct nlattr *tb[],
 					   vxlan->cfg.dst_port,
 					   old_dst.remote_vni,
 					   old_dst.remote_vni,
-					   old_dst.remote_ifindex);
+					   old_dst.remote_ifindex,
+					   true);
=20
 		if (!vxlan_addr_any(&dst->remote_ip)) {
 			err =3D vxlan_fdb_create(vxlan, all_zeros_mac,
@@ -3625,7 +3635,8 @@ static int vxlan_changelink(struct net_device *dev, s=
truct nlattr *tb[],
 				spin_unlock_bh(&vxlan->hash_lock);
 				return err;
 			}
-			vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
+			vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
+					 RTM_NEWNEIGH, true);
 		}
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
--=20
2.19.1

