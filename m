Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IqT9S6zLkQjTG1ObzKtYPdpO4Iy091C9uepXtTwFLk0=;
	b=BZiPTxvBz90EeAkog/j/R/Yc7atPjlPPiUcUC0ZlrCokbSUNKQTO4nUfbfFToE+7hvhkoBTYFu6SXXTfCVhoXGdstKBLPHZa1dStPKsGk0m5KeBEx1/ljC1D/8geY0r3x8rwLkieaaEIOx1IXbjqOSrQJGSxfd+/tzjYzlnYrdo=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527641426.git.petrm@mellanox.com>
References: <cover.1527641426.git.petrm@mellanox.com>
Message-Id: <583d583ad158363411fde87dbf6709024714e498.1527641426.git.petrm@mellanox.com>
Date: Wed, 30 May 2018 03:00:45 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 7/8] net: bridge: Notify about bridge
	VLANs
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

A driver might need to react to changes in settings of brentry VLANs.
Therefore send switchdev port notifications for these as well. Reuse
SWITCHDEV_OBJ_ID_PORT_VLAN for this purpose. Listeners should use
netif_is_bridge_master() on orig_dev to determine whether the
notification is about a bridge port or a bridge.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br_vlan.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 602c869..7df2690 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -246,6 +246,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			goto out_filt;
 		v->brvlan = masterv;
 		v->stats = masterv->stats;
+	} else {
+		err = br_switchdev_port_vlan_add(dev, v->vid, flags);
+		if (err && err != -EOPNOTSUPP)
+			goto out;
 	}
 
 	/* Add the dev mac and count the vlan only if it's usable */
@@ -281,6 +285,8 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			br_vlan_put_master(masterv);
 			v->brvlan = NULL;
 		}
+	} else {
+		br_switchdev_port_vlan_del(dev, v->vid);
 	}
 
 	goto out;
@@ -306,6 +312,11 @@ static int __vlan_del(struct net_bridge_vlan *v)
 		err = __vlan_vid_del(p->dev, p->br, v->vid);
 		if (err)
 			goto out;
+	} else {
+		err = br_switchdev_port_vlan_del(v->br->dev, v->vid);
+		if (err && err != -EOPNOTSUPP)
+			goto out;
+		err = 0;
 	}
 
 	if (br_vlan_should_use(v)) {
@@ -558,16 +569,22 @@ static int br_vlan_add_existing(struct net_bridge *br,
 {
 	int err;
 
+	err = br_switchdev_port_vlan_add(br->dev, vlan->vid, flags);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	if (!br_vlan_is_brentry(vlan)) {
 		/* Trying to change flags of non-existent bridge vlan */
-		if (!(flags & BRIDGE_VLAN_INFO_BRENTRY))
-			return -EINVAL;
+		if (!(flags & BRIDGE_VLAN_INFO_BRENTRY)) {
+			err = -EINVAL;
+			goto err_flags;
+		}
 		/* It was only kept for port vlans, now make it real */
 		err = br_fdb_insert(br, NULL, br->dev->dev_addr,
 				    vlan->vid);
 		if (err) {
 			br_err(br, "failed to insert local address into bridge forwarding table\n");
-			return err;
+			goto err_fdb_insert;
 		}
 
 		refcount_inc(&vlan->refcnt);
@@ -580,6 +597,11 @@ static int br_vlan_add_existing(struct net_bridge *br,
 		*changed = true;
 
 	return 0;
+
+err_fdb_insert:
+err_flags:
+	br_switchdev_port_vlan_del(br->dev, vlan->vid);
+	return err;
 }
 
 /* Must be protected by RTNL.
-- 
2.4.11

