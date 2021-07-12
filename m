Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO5GO8v4tjOgZUiRtjtciq9L3Y+FWYdUxnxBxmGQESM=;
 b=j28MwkjWthzmhT7bf4y2E/LpNCLknuEItz5NpX3WH8EVM6pUioIJ8EqrBalxFmKYcgF6PtIEqyIa1/tgm6mYvSUjqr3KtoXdvnMBDdXMBtollZ/3pKua+nDJeNuUItz1L0vvQ4nG0DS47Je3kAW1FkTU9vapUN+P515VIMqtZPY=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:34 +0300
Message-Id: <20210712152142.800651-17-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 16/24] net: bridge: propagate ctx
	to br_switchdev_port_vlan_{add, del}
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Make br_switchdev_port_vlan_add() and br_switchdev_port_vlan_del()
callable by br_vlan_replay() too, by exposing a void *ctx argument.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_private.h   |  8 ++++++--
 net/bridge/br_switchdev.c |  8 +++++---
 net/bridge/br_vlan.c      | 19 +++++++++++--------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 46236302eed5..763de4a503d9 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1673,8 +1673,10 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 void br_switchdev_fdb_notify(struct net_bridge *br,
 			     const struct net_bridge_fdb_entry *fdb, int type);
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
+			       const void *ctx,
 			       struct netlink_ext_ack *extack);
-int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
+int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid,
+			       const void *ctx);
 void br_switchdev_init(struct net_bridge *br);
 
 static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
@@ -1703,12 +1705,14 @@ static inline int br_switchdev_set_port_flag(struct net_bridge_port *p,
 
 static inline int br_switchdev_port_vlan_add(struct net_device *dev,
 					     u16 vid, u16 flags,
+					     const void *ctx,
 					     struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
+static inline int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid,
+					     const void *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index c961d86bc323..90aad6a4c32c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -102,6 +102,7 @@ br_switchdev_fdb_notify(struct net_bridge *br,
 }
 
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
+			       const void *ctx,
 			       struct netlink_ext_ack *extack)
 {
 	struct switchdev_obj_port_vlan v = {
@@ -111,10 +112,11 @@ int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 		.vid = vid,
 	};
 
-	return switchdev_port_obj_add(dev, &v.obj, NULL, extack);
+	return switchdev_port_obj_add(dev, &v.obj, ctx, extack);
 }
 
-int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
+int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid,
+			       const void *ctx)
 {
 	struct switchdev_obj_port_vlan v = {
 		.obj.orig_dev = dev,
@@ -122,7 +124,7 @@ int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 		.vid = vid,
 	};
 
-	return switchdev_port_obj_del(dev, &v.obj, NULL);
+	return switchdev_port_obj_del(dev, &v.obj, ctx);
 }
 
 static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a08e9f193009..14f10203d121 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -92,7 +92,7 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
-	err = br_switchdev_port_vlan_add(dev, v->vid, flags, extack);
+	err = br_switchdev_port_vlan_add(dev, v->vid, flags, NULL, extack);
 	if (err == -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, v->vid);
 	v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV;
@@ -132,7 +132,7 @@ static int __vlan_vid_del(struct net_device *dev, struct net_bridge *br,
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q del.
 	 */
-	err = br_switchdev_port_vlan_del(dev, v->vid);
+	err = br_switchdev_port_vlan_del(dev, v->vid, NULL);
 	if (!(v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV))
 		vlan_vid_del(dev, br->vlan_proto, v->vid);
 	return err == -EOPNOTSUPP ? 0 : err;
@@ -281,7 +281,8 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 			v->stats = masterv->stats;
 		}
 	} else {
-		err = br_switchdev_port_vlan_add(dev, v->vid, flags, extack);
+		err = br_switchdev_port_vlan_add(dev, v->vid, flags, NULL,
+						 extack);
 		if (err && err != -EOPNOTSUPP)
 			goto out;
 	}
@@ -330,7 +331,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 			v->brvlan = NULL;
 		}
 	} else {
-		br_switchdev_port_vlan_del(dev, v->vid);
+		br_switchdev_port_vlan_del(dev, v->vid, NULL);
 	}
 
 	goto out;
@@ -357,7 +358,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 		if (err)
 			goto out;
 	} else {
-		err = br_switchdev_port_vlan_del(v->br->dev, v->vid);
+		err = br_switchdev_port_vlan_del(v->br->dev, v->vid, NULL);
 		if (err && err != -EOPNOTSUPP)
 			goto out;
 		err = 0;
@@ -650,7 +651,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 {
 	int err;
 
-	err = br_switchdev_port_vlan_add(br->dev, vlan->vid, flags, extack);
+	err = br_switchdev_port_vlan_add(br->dev, vlan->vid, flags, NULL,
+					 extack);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
@@ -681,7 +683,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 
 err_fdb_insert:
 err_flags:
-	br_switchdev_port_vlan_del(br->dev, vlan->vid);
+	br_switchdev_port_vlan_del(br->dev, vlan->vid, NULL);
 	return err;
 }
 
@@ -1219,7 +1221,8 @@ int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
 	vlan = br_vlan_find(nbp_vlan_group(port), vid);
 	if (vlan) {
 		/* Pass the flags to the hardware bridge */
-		ret = br_switchdev_port_vlan_add(port->dev, vid, flags, extack);
+		ret = br_switchdev_port_vlan_add(port->dev, vid, flags, NULL,
+						 extack);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 		*changed = __vlan_add_flags(vlan, flags);
-- 
2.25.1

