Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9vrvNq3e82oLunYDYY9nIsoNhP4+YR7sUGkgGUybR4E=;
	b=OcML003hKB14p9ttXeMBgJUE7Rv3YlsxSg3ZBZF3Q6lLMFcWmGq4LL2xCRP+wPFQWNokQpyQHYnhj+zTIAgINkj++u0/QhnIE/OrWI534CG+iDP4ZAUsudbrjH+tnMYw+OP1j4NKdGQIZ6W+hihcGkfCi1KM4q3eejIXarQJ6tQ=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527173527.git.petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
Message-Id: <af1bed5ce2b236544edd591b8cfb8425c2cb5ca0.1527173527.git.petrm@mellanox.com>
Date: Thu, 24 May 2018 17:10:07 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 1/7] net: bridge: Extract boilerplate
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
 net/bridge/br_vlan.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index dc832c09..a75fe930 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -79,8 +79,7 @@ static bool __vlan_add_flags(struct net_bridge_vlan *v, u16 flags)
 	return ret || !!(old_flags ^ v->flags);
 }
 
-static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
-			  u16 vid, u16 flags)
+static int br_switchdev_port_obj_add(struct net_device *dev, u16 vid, u16 flags)
 {
 	struct switchdev_obj_port_vlan v = {
 		.obj.orig_dev = dev,
@@ -89,12 +88,29 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 		.vid_begin = vid,
 		.vid_end = vid,
 	};
-	int err;
 
+	return switchdev_port_obj_add(dev, &v.obj);
+}
+
+static int br_switchdev_port_obj_del(struct net_device *dev, u16 vid)
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
+
+static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
+			  u16 vid, u16 flags)
+{
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
-	err = switchdev_port_obj_add(dev, &v.obj);
+	int err = br_switchdev_port_obj_add(dev, vid, flags);
 	if (err == -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, vid);
 	return err;
@@ -130,18 +146,11 @@ static void __vlan_del_list(struct net_bridge_vlan *v)
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
+	int err = br_switchdev_port_obj_del(dev, vid);
+
 	if (err == -EOPNOTSUPP) {
 		vlan_vid_del(dev, br->vlan_proto, vid);
 		return 0;
@@ -1053,13 +1062,6 @@ int nbp_vlan_init(struct net_bridge_port *p)
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
 
@@ -1069,7 +1071,7 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
 	vlan = br_vlan_find(nbp_vlan_group(port), vid);
 	if (vlan) {
 		/* Pass the flags to the hardware bridge */
-		ret = switchdev_port_obj_add(port->dev, &v.obj);
+		ret = br_switchdev_port_obj_add(port->dev, vid, flags);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 		*changed = __vlan_add_flags(vlan, flags);
-- 
2.4.11

