Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4QywxTMV8h/GX0t8L0hvnPKOnb81KIOt1o7mRDmjz4w=;
	b=YIxdHNl4eAgPye1F2G2cEvhXQk2PBPu52KEN4PPrD2J4ebyAWuOo75uQcSxAuU70sRxuGVnuwrqUvNFtY6b+D695SqRXW9WuD0V1gPSvGkaVoor5rDcM0zrPYPB0DPDwsmrwoQyVsD+JUrKIHEw4rTiCgf0H+s65KO5MeGK//iw=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:02:50 +0000
Message-ID: <48d25d9c3069c93bca89578257447b4332a4da3c.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 2/9] net: bridge: Propagate extack to
	switchdev
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

ndo_bridge_setlink has been updated in the previous patch to have extack
available, and changelink RTNL op has had this argument since the time
extack was added. Propagate both through the bridge driver to eventually
reach br_switchdev_port_vlan_add(), where it will be used by subsequent
patches.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Ivan Vecera <ivecera@redhat.com>
Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 net/bridge/br_if.c        |  2 +-
 net/bridge/br_netlink.c   | 27 +++++++++++++---------
 net/bridge/br_private.h   | 22 ++++++++++--------
 net/bridge/br_switchdev.c |  3 ++-
 net/bridge/br_vlan.c      | 59 ++++++++++++++++++++++++++-----------------=
----
 5 files changed, 65 insertions(+), 48 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d4863f5679ac..3b945d6369c4 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -650,7 +650,7 @@ int br_add_if(struct net_bridge *br, struct net_device =
*dev,
 	if (br_fdb_insert(br, p, dev->dev_addr, 0))
 		netdev_err(dev, "failed insert local address bridge forwarding table\n")=
;
=20
-	err =3D nbp_vlan_init(p);
+	err =3D nbp_vlan_init(p, extack);
 	if (err) {
 		netdev_err(dev, "failed to initialize vlan filtering on this port\n");
 		goto err7;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f9be70b26091..935495b93a99 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -525,7 +525,8 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 }
=20
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-			int cmd, struct bridge_vlan_info *vinfo, bool *changed)
+			int cmd, struct bridge_vlan_info *vinfo, bool *changed,
+			struct netlink_ext_ack *extack)
 {
 	bool curr_change;
 	int err =3D 0;
@@ -537,11 +538,11 @@ static int br_vlan_info(struct net_bridge *br, struct=
 net_bridge_port *p,
 			 * per-VLAN entry as well
 			 */
 			err =3D nbp_vlan_add(p, vinfo->vid, vinfo->flags,
-					   &curr_change);
+					   &curr_change, extack);
 		} else {
 			vinfo->flags |=3D BRIDGE_VLAN_INFO_BRENTRY;
 			err =3D br_vlan_add(br, vinfo->vid, vinfo->flags,
-					  &curr_change);
+					  &curr_change, extack);
 		}
 		if (curr_change)
 			*changed =3D true;
@@ -568,7 +569,8 @@ static int br_process_vlan_info(struct net_bridge *br,
 				struct net_bridge_port *p, int cmd,
 				struct bridge_vlan_info *vinfo_curr,
 				struct bridge_vlan_info **vinfo_last,
-				bool *changed)
+				bool *changed,
+				struct netlink_ext_ack *extack)
 {
 	if (!vinfo_curr->vid || vinfo_curr->vid >=3D VLAN_VID_MASK)
 		return -EINVAL;
@@ -598,7 +600,8 @@ static int br_process_vlan_info(struct net_bridge *br,
 		       sizeof(struct bridge_vlan_info));
 		for (v =3D (*vinfo_last)->vid; v <=3D vinfo_curr->vid; v++) {
 			tmp_vinfo.vid =3D v;
-			err =3D br_vlan_info(br, p, cmd, &tmp_vinfo, changed);
+			err =3D br_vlan_info(br, p, cmd, &tmp_vinfo, changed,
+					   extack);
 			if (err)
 				break;
 		}
@@ -607,13 +610,14 @@ static int br_process_vlan_info(struct net_bridge *br=
,
 		return err;
 	}
=20
-	return br_vlan_info(br, p, cmd, vinfo_curr, changed);
+	return br_vlan_info(br, p, cmd, vinfo_curr, changed, extack);
 }
=20
 static int br_afspec(struct net_bridge *br,
 		     struct net_bridge_port *p,
 		     struct nlattr *af_spec,
-		     int cmd, bool *changed)
+		     int cmd, bool *changed,
+		     struct netlink_ext_ack *extack)
 {
 	struct bridge_vlan_info *vinfo_curr =3D NULL;
 	struct bridge_vlan_info *vinfo_last =3D NULL;
@@ -643,7 +647,8 @@ static int br_afspec(struct net_bridge *br,
 				return -EINVAL;
 			vinfo_curr =3D nla_data(attr);
 			err =3D br_process_vlan_info(br, p, cmd, vinfo_curr,
-						   &vinfo_last, changed);
+						   &vinfo_last, changed,
+						   extack);
 			if (err)
 				return err;
 			break;
@@ -898,7 +903,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr =
*nlh, u16 flags,
 	}
=20
 	if (afspec)
-		err =3D br_afspec(br, p, afspec, RTM_SETLINK, &changed);
+		err =3D br_afspec(br, p, afspec, RTM_SETLINK, &changed, extack);
=20
 	if (changed)
 		br_ifinfo_notify(RTM_NEWLINK, br, p);
@@ -924,7 +929,7 @@ int br_dellink(struct net_device *dev, struct nlmsghdr =
*nlh, u16 flags)
 	if (!p && !(dev->priv_flags & IFF_EBRIDGE))
 		return -EINVAL;
=20
-	err =3D br_afspec(br, p, afspec, RTM_DELLINK, &changed);
+	err =3D br_afspec(br, p, afspec, RTM_DELLINK, &changed, NULL);
 	if (changed)
 		/* Send RTM_NEWLINK because userspace
 		 * expects RTM_NEWLINK for vlan dels
@@ -1106,7 +1111,7 @@ static int br_changelink(struct net_device *brdev, st=
ruct nlattr *tb[],
 	if (data[IFLA_BR_VLAN_DEFAULT_PVID]) {
 		__u16 defpvid =3D nla_get_u16(data[IFLA_BR_VLAN_DEFAULT_PVID]);
=20
-		err =3D __br_vlan_set_default_pvid(br, defpvid);
+		err =3D __br_vlan_set_default_pvid(br, defpvid, extack);
 		if (err)
 			return err;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 090dfacdc438..ff3dfb2a78b8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -868,7 +868,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 			       struct net_bridge_vlan_group *vg,
 			       struct sk_buff *skb);
 int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags,
-		bool *changed);
+		bool *changed, struct netlink_ext_ack *extack);
 int br_vlan_delete(struct net_bridge *br, u16 vid);
 void br_vlan_flush(struct net_bridge *br);
 struct net_bridge_vlan *br_vlan_find(struct net_bridge_vlan_group *vg, u16=
 vid);
@@ -881,12 +881,13 @@ int br_vlan_set_stats(struct net_bridge *br, unsigned=
 long val);
 int br_vlan_set_stats_per_port(struct net_bridge *br, unsigned long val);
 int br_vlan_init(struct net_bridge *br);
 int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val);
-int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid);
+int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
+			       struct netlink_ext_ack *extack);
 int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
-		 bool *changed);
+		 bool *changed, struct netlink_ext_ack *extack);
 int nbp_vlan_delete(struct net_bridge_port *port, u16 vid);
 void nbp_vlan_flush(struct net_bridge_port *port);
-int nbp_vlan_init(struct net_bridge_port *port);
+int nbp_vlan_init(struct net_bridge_port *port, struct netlink_ext_ack *ex=
tack);
 int nbp_get_num_vlan_infos(struct net_bridge_port *p, u32 filter_mask);
 void br_vlan_get_stats(const struct net_bridge_vlan *v,
 		       struct br_vlan_stats *stats);
@@ -971,7 +972,7 @@ static inline struct sk_buff *br_handle_vlan(struct net=
_bridge *br,
 }
=20
 static inline int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags,
-			      bool *changed)
+			      bool *changed, struct netlink_ext_ack *extack)
 {
 	*changed =3D false;
 	return -EOPNOTSUPP;
@@ -996,7 +997,7 @@ static inline int br_vlan_init(struct net_bridge *br)
 }
=20
 static inline int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 =
flags,
-			       bool *changed)
+			       bool *changed, struct netlink_ext_ack *extack)
 {
 	*changed =3D false;
 	return -EOPNOTSUPP;
@@ -1017,7 +1018,8 @@ static inline struct net_bridge_vlan *br_vlan_find(st=
ruct net_bridge_vlan_group
 	return NULL;
 }
=20
-static inline int nbp_vlan_init(struct net_bridge_port *port)
+static inline int nbp_vlan_init(struct net_bridge_port *port,
+				struct netlink_ext_ack *extack)
 {
 	return 0;
 }
@@ -1174,7 +1176,8 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
 			       unsigned long mask);
 void br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb,
 			     int type);
-int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags)=
;
+int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
+			       struct netlink_ext_ack *extack);
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
=20
 static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
@@ -1206,7 +1209,8 @@ static inline int br_switchdev_set_port_flag(struct n=
et_bridge_port *p,
 }
=20
 static inline int br_switchdev_port_vlan_add(struct net_device *dev,
-					     u16 vid, u16 flags)
+					     u16 vid, u16 flags,
+					     struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index b993df770675..99ba32177b31 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -140,7 +140,8 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_ent=
ry *fdb, int type)
 	}
 }
=20
-int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags)
+int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
+			       struct netlink_ext_ack *extack)
 {
 	struct switchdev_obj_port_vlan v =3D {
 		.obj.orig_dev =3D dev,
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 48f50d7ac624..4a2f31157ef5 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -80,14 +80,14 @@ static bool __vlan_add_flags(struct net_bridge_vlan *v,=
 u16 flags)
 }
=20
 static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
-			  u16 vid, u16 flags)
+			  u16 vid, u16 flags, struct netlink_ext_ack *extack)
 {
 	int err;
=20
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
-	err =3D br_switchdev_port_vlan_add(dev, vid, flags);
+	err =3D br_switchdev_port_vlan_add(dev, vid, flags, extack);
 	if (err =3D=3D -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, vid);
 	return err;
@@ -139,7 +139,9 @@ static int __vlan_vid_del(struct net_device *dev, struc=
t net_bridge *br,
 /* Returns a master vlan, if it didn't exist it gets created. In all cases=
 a
  * a reference is taken to the master vlan before returning.
  */
-static struct net_bridge_vlan *br_vlan_get_master(struct net_bridge *br, u=
16 vid)
+static struct net_bridge_vlan *
+br_vlan_get_master(struct net_bridge *br, u16 vid,
+		   struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *masterv;
@@ -150,7 +152,7 @@ static struct net_bridge_vlan *br_vlan_get_master(struc=
t net_bridge *br, u16 vid
 		bool changed;
=20
 		/* missing global ctx, create it now */
-		if (br_vlan_add(br, vid, 0, &changed))
+		if (br_vlan_add(br, vid, 0, &changed, extack))
 			return NULL;
 		masterv =3D br_vlan_find(vg, vid);
 		if (WARN_ON(!masterv))
@@ -214,7 +216,8 @@ static void nbp_vlan_rcu_free(struct rcu_head *rcu)
  * 4. same as 3 but with both master and brentry flags set so the entry
  *    will be used for filtering in both the port and the bridge
  */
-static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
+static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
+		      struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan *masterv =3D NULL;
 	struct net_bridge_port *p =3D NULL;
@@ -239,7 +242,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 fl=
ags)
 		 * This ensures tagged traffic enters the bridge when
 		 * promiscuous mode is disabled by br_manage_promisc().
 		 */
-		err =3D __vlan_vid_add(dev, br, v->vid, flags);
+		err =3D __vlan_vid_add(dev, br, v->vid, flags, extack);
 		if (err)
 			goto out;
=20
@@ -249,12 +252,12 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 =
flags)
=20
 			err =3D br_vlan_add(br, v->vid,
 					  flags | BRIDGE_VLAN_INFO_BRENTRY,
-					  &changed);
+					  &changed, extack);
 			if (err)
 				goto out_filt;
 		}
=20
-		masterv =3D br_vlan_get_master(br, v->vid);
+		masterv =3D br_vlan_get_master(br, v->vid, extack);
 		if (!masterv)
 			goto out_filt;
 		v->brvlan =3D masterv;
@@ -269,7 +272,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 fl=
ags)
 			v->stats =3D masterv->stats;
 		}
 	} else {
-		err =3D br_switchdev_port_vlan_add(dev, v->vid, flags);
+		err =3D br_switchdev_port_vlan_add(dev, v->vid, flags, extack);
 		if (err && err !=3D -EOPNOTSUPP)
 			goto out;
 	}
@@ -591,11 +594,12 @@ bool br_should_learn(struct net_bridge_port *p, struc=
t sk_buff *skb, u16 *vid)
 static int br_vlan_add_existing(struct net_bridge *br,
 				struct net_bridge_vlan_group *vg,
 				struct net_bridge_vlan *vlan,
-				u16 flags, bool *changed)
+				u16 flags, bool *changed,
+				struct netlink_ext_ack *extack)
 {
 	int err;
=20
-	err =3D br_switchdev_port_vlan_add(br->dev, vlan->vid, flags);
+	err =3D br_switchdev_port_vlan_add(br->dev, vlan->vid, flags, extack);
 	if (err && err !=3D -EOPNOTSUPP)
 		return err;
=20
@@ -634,7 +638,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
  * Must be called with vid in range from 1 to 4094 inclusive.
  * changed must be true only if the vlan was created or updated
  */
-int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed)
+int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed,
+		struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *vlan;
@@ -646,7 +651,8 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 fla=
gs, bool *changed)
 	vg =3D br_vlan_group(br);
 	vlan =3D br_vlan_find(vg, vid);
 	if (vlan)
-		return br_vlan_add_existing(br, vg, vlan, flags, changed);
+		return br_vlan_add_existing(br, vg, vlan, flags, changed,
+					    extack);
=20
 	vlan =3D kzalloc(sizeof(*vlan), GFP_KERNEL);
 	if (!vlan)
@@ -663,7 +669,7 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 fla=
gs, bool *changed)
 	vlan->br =3D br;
 	if (flags & BRIDGE_VLAN_INFO_BRENTRY)
 		refcount_set(&vlan->refcnt, 1);
-	ret =3D __vlan_add(vlan, flags);
+	ret =3D __vlan_add(vlan, flags, extack);
 	if (ret) {
 		free_percpu(vlan->stats);
 		kfree(vlan);
@@ -914,7 +920,8 @@ static void br_vlan_disable_default_pvid(struct net_bri=
dge *br)
 	br->default_pvid =3D 0;
 }
=20
-int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid)
+int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
+			       struct netlink_ext_ack *extack)
 {
 	const struct net_bridge_vlan *pvent;
 	struct net_bridge_vlan_group *vg;
@@ -946,7 +953,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u=
16 pvid)
 				  BRIDGE_VLAN_INFO_PVID |
 				  BRIDGE_VLAN_INFO_UNTAGGED |
 				  BRIDGE_VLAN_INFO_BRENTRY,
-				  &vlchange);
+				  &vlchange, extack);
 		if (err)
 			goto out;
 		br_vlan_delete(br, old_pvid);
@@ -966,7 +973,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u=
16 pvid)
 		err =3D nbp_vlan_add(p, pvid,
 				   BRIDGE_VLAN_INFO_PVID |
 				   BRIDGE_VLAN_INFO_UNTAGGED,
-				   &vlchange);
+				   &vlchange, extack);
 		if (err)
 			goto err_port;
 		nbp_vlan_delete(p, old_pvid);
@@ -988,7 +995,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u=
16 pvid)
 			nbp_vlan_add(p, old_pvid,
 				     BRIDGE_VLAN_INFO_PVID |
 				     BRIDGE_VLAN_INFO_UNTAGGED,
-				     &vlchange);
+				     &vlchange, NULL);
 		nbp_vlan_delete(p, pvid);
 	}
=20
@@ -998,7 +1005,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, =
u16 pvid)
 				    BRIDGE_VLAN_INFO_PVID |
 				    BRIDGE_VLAN_INFO_UNTAGGED |
 				    BRIDGE_VLAN_INFO_BRENTRY,
-				    &vlchange);
+				    &vlchange, NULL);
 		br_vlan_delete(br, pvid);
 	}
 	goto out;
@@ -1021,7 +1028,7 @@ int br_vlan_set_default_pvid(struct net_bridge *br, u=
nsigned long val)
 		err =3D -EPERM;
 		goto out;
 	}
-	err =3D __br_vlan_set_default_pvid(br, pvid);
+	err =3D __br_vlan_set_default_pvid(br, pvid, NULL);
 out:
 	return err;
 }
@@ -1047,7 +1054,7 @@ int br_vlan_init(struct net_bridge *br)
 	rcu_assign_pointer(br->vlgrp, vg);
 	ret =3D br_vlan_add(br, 1,
 			  BRIDGE_VLAN_INFO_PVID | BRIDGE_VLAN_INFO_UNTAGGED |
-			  BRIDGE_VLAN_INFO_BRENTRY, &changed);
+			  BRIDGE_VLAN_INFO_BRENTRY, &changed, NULL);
 	if (ret)
 		goto err_vlan_add;
=20
@@ -1064,7 +1071,7 @@ int br_vlan_init(struct net_bridge *br)
 	goto out;
 }
=20
-int nbp_vlan_init(struct net_bridge_port *p)
+int nbp_vlan_init(struct net_bridge_port *p, struct netlink_ext_ack *extac=
k)
 {
 	struct switchdev_attr attr =3D {
 		.orig_dev =3D p->br->dev,
@@ -1097,7 +1104,7 @@ int nbp_vlan_init(struct net_bridge_port *p)
 		ret =3D nbp_vlan_add(p, p->br->default_pvid,
 				   BRIDGE_VLAN_INFO_PVID |
 				   BRIDGE_VLAN_INFO_UNTAGGED,
-				   &changed);
+				   &changed, extack);
 		if (ret)
 			goto err_vlan_add;
 	}
@@ -1122,7 +1129,7 @@ int nbp_vlan_init(struct net_bridge_port *p)
  * changed must be true only if the vlan was created or updated
  */
 int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
-		 bool *changed)
+		 bool *changed, struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan *vlan;
 	int ret;
@@ -1133,7 +1140,7 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vi=
d, u16 flags,
 	vlan =3D br_vlan_find(nbp_vlan_group(port), vid);
 	if (vlan) {
 		/* Pass the flags to the hardware bridge */
-		ret =3D br_switchdev_port_vlan_add(port->dev, vid, flags);
+		ret =3D br_switchdev_port_vlan_add(port->dev, vid, flags, extack);
 		if (ret && ret !=3D -EOPNOTSUPP)
 			return ret;
 		*changed =3D __vlan_add_flags(vlan, flags);
@@ -1147,7 +1154,7 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vi=
d, u16 flags,
=20
 	vlan->vid =3D vid;
 	vlan->port =3D port;
-	ret =3D __vlan_add(vlan, flags);
+	ret =3D __vlan_add(vlan, flags, extack);
 	if (ret)
 		kfree(vlan);
 	else
--=20
2.4.11

