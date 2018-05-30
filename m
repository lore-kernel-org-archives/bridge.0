Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5bI3dw3uI8xYMD39Yn7jX4l+ypVMEYb5TB7zQGSJZtk=;
	b=uJC8Cc/eJMNgPTwr/9HHuaDgdts5dRWLYSnRPfvGQvN9O2/WFXBvVSG1iDVIjw4Zf5jHNKZIMNDeJwkMgsBPuEqmk04KhSi8e8r1AqitiSCt3xS+HlhDHDxFl+MhhfoKHeWSg8hDuihSE5sgWDA+G5LRmTHj1ZBdgGLQIvdpRp4=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527641426.git.petrm@mellanox.com>
References: <cover.1527641426.git.petrm@mellanox.com>
Message-Id: <3f7f1f0580acedf385d993304d53d370a60410c2.1527641426.git.petrm@mellanox.com>
Date: Wed, 30 May 2018 02:56:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 2/8] net: bridge: Extract
	br_vlan_add_existing()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

Extract the code that deals with adding a preexisting VLAN to bridge CPU
port to a separate function. A follow-up patch introduces a need to roll
back operations in this block due to an error, and this split will make
the error-handling code clearer.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br_vlan.c | 55 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index e3b14c0..602c869 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -551,6 +551,37 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 	return false;
 }
 
+static int br_vlan_add_existing(struct net_bridge *br,
+				struct net_bridge_vlan_group *vg,
+				struct net_bridge_vlan *vlan,
+				u16 flags, bool *changed)
+{
+	int err;
+
+	if (!br_vlan_is_brentry(vlan)) {
+		/* Trying to change flags of non-existent bridge vlan */
+		if (!(flags & BRIDGE_VLAN_INFO_BRENTRY))
+			return -EINVAL;
+		/* It was only kept for port vlans, now make it real */
+		err = br_fdb_insert(br, NULL, br->dev->dev_addr,
+				    vlan->vid);
+		if (err) {
+			br_err(br, "failed to insert local address into bridge forwarding table\n");
+			return err;
+		}
+
+		refcount_inc(&vlan->refcnt);
+		vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
+		vg->num_vlans++;
+		*changed = true;
+	}
+
+	if (__vlan_add_flags(vlan, flags))
+		*changed = true;
+
+	return 0;
+}
+
 /* Must be protected by RTNL.
  * Must be called with vid in range from 1 to 4094 inclusive.
  * changed must be true only if the vlan was created or updated
@@ -566,28 +597,8 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed)
 	*changed = false;
 	vg = br_vlan_group(br);
 	vlan = br_vlan_find(vg, vid);
-	if (vlan) {
-		if (!br_vlan_is_brentry(vlan)) {
-			/* Trying to change flags of non-existent bridge vlan */
-			if (!(flags & BRIDGE_VLAN_INFO_BRENTRY))
-				return -EINVAL;
-			/* It was only kept for port vlans, now make it real */
-			ret = br_fdb_insert(br, NULL, br->dev->dev_addr,
-					    vlan->vid);
-			if (ret) {
-				br_err(br, "failed insert local address into bridge forwarding table\n");
-				return ret;
-			}
-			refcount_inc(&vlan->refcnt);
-			vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
-			vg->num_vlans++;
-			*changed = true;
-		}
-		if (__vlan_add_flags(vlan, flags))
-			*changed = true;
-
-		return 0;
-	}
+	if (vlan)
+		return br_vlan_add_existing(br, vg, vlan, flags, changed);
 
 	vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
 	if (!vlan)
-- 
2.4.11

