Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MNapdlZIFGwqMXz8JQUrCJGDqhLVy8LsxMj2F28gUnE=;
	b=UOFenIvAyCTQWX3hVJlmuDXZO5MfdkmxK8/8HAYBQWDkM1b8OyDOomABEpJ8flfx47Dd8S6jXFzF0iOsTZkTmY+06BvK9/YLVrxtenMdC6w2QenzqIKQYzGi7fBp+e++DbL8s6llXO30q+U3FCFKMRQy8hwHZxWjFxT7fjWGBsk=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527519997.git.petrm@mellanox.com>
References: <cover.1527519997.git.petrm@mellanox.com>
Message-Id: <85401f20b801fa1bae3025bf1df991a9d475fe85.1527519997.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 17:10:28 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 1/7] net: bridge: Extract boilerplate
 around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

A call to switchdev_port_obj_add() or switchdev_port_obj_del() involves
initializing a struct switchdev_obj_port_vlan, a piece of code that
repeats on each call site almost verbatim. While in the current codebase
there is just one duplicated add call, the follow-up patches add more of
both add and del calls.

Thus to remove the duplication, extract the repetition into named
functions and reuse.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br_private.h   | 13 +++++++++++++
 net/bridge/br_switchdev.c | 25 +++++++++++++++++++++++++
 net/bridge/br_vlan.c      | 31 ++++---------------------------
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 11520ed..5216a52 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1139,6 +1139,8 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long mask);
 void br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb,
 			     int type);
+int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags);
+int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
 
 static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
 {
@@ -1168,6 +1170,17 @@ static inline int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	return 0;
 }
 
+static inline int br_switchdev_port_vlan_add(struct net_device *dev,
+					     u16 vid, u16 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void
 br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 35474d4..d77f807 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -136,3 +136,28 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 		break;
 	}
 }
+
+int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags)
+{
+	struct switchdev_obj_port_vlan v = {
+		.obj.orig_dev = dev,
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.flags = flags,
+		.vid_begin = vid,
+		.vid_end = vid,
+	};
+
+	return switchdev_port_obj_add(dev, &v.obj);
+}
+
+int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
+{
+	struct switchdev_obj_port_vlan v = {
+		.obj.orig_dev = dev,
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.vid_begin = vid,
+		.vid_end = vid,
+	};
+
+	return switchdev_port_obj_del(dev, &v.obj);
+}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index dc832c09..8ad5756 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -82,19 +82,10 @@ static bool __vlan_add_flags(struct net_bridge_vlan *v, u16 flags)
 static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 			  u16 vid, u16 flags)
 {
-	struct switchdev_obj_port_vlan v = {
-		.obj.orig_dev = dev,
-		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
-		.flags = flags,
-		.vid_begin = vid,
-		.vid_end = vid,
-	};
-	int err;
-
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
-	err = switchdev_port_obj_add(dev, &v.obj);
+	int err = br_switchdev_port_vlan_add(dev, vid, flags);
 	if (err == -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, vid);
 	return err;
@@ -130,18 +121,11 @@ static void __vlan_del_list(struct net_bridge_vlan *v)
 static int __vlan_vid_del(struct net_device *dev, struct net_bridge *br,
 			  u16 vid)
 {
-	struct switchdev_obj_port_vlan v = {
-		.obj.orig_dev = dev,
-		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
-		.vid_begin = vid,
-		.vid_end = vid,
-	};
-	int err;
-
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q del.
 	 */
-	err = switchdev_port_obj_del(dev, &v.obj);
+	int err = br_switchdev_port_vlan_del(dev, vid);
+
 	if (err == -EOPNOTSUPP) {
 		vlan_vid_del(dev, br->vlan_proto, vid);
 		return 0;
@@ -1053,13 +1037,6 @@ int nbp_vlan_init(struct net_bridge_port *p)
 int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
 		 bool *changed)
 {
-	struct switchdev_obj_port_vlan v = {
-		.obj.orig_dev = port->dev,
-		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
-		.flags = flags,
-		.vid_begin = vid,
-		.vid_end = vid,
-	};
 	struct net_bridge_vlan *vlan;
 	int ret;
 
@@ -1069,7 +1046,7 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
 	vlan = br_vlan_find(nbp_vlan_group(port), vid);
 	if (vlan) {
 		/* Pass the flags to the hardware bridge */
-		ret = switchdev_port_obj_add(port->dev, &v.obj);
+		ret = br_switchdev_port_vlan_add(port->dev, vid, flags);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 		*changed = __vlan_add_flags(vlan, flags);
-- 
2.4.11

