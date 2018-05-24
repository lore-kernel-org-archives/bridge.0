Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xSMCu4jcGT7zgp33C1n06OEbbaSa4oJadG0tJ3euVPE=;
	b=fEsTMfRim+f1VgGjyyvi/LtrFPiTglggJaeE+wbV2rNGDVcK8XP6v0Y/KnRz0vP7/1AuAtt9HLxplS53vrRDI3mGkV7SEFZIs/ICg6sq3AD1FRw5s67ykG+zUedXpCzioRy1ouRF8oti0s4chcUDYcRykYj7v/PNwwI6eEBEnPk=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527173527.git.petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
Message-Id: <b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
Date: Thu, 24 May 2018 17:10:40 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 6/7] net: bridge: Notify about bridge VLANs
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

A driver might need to react to changes in settings of brentry VLANs.
Therefore send switchdev port notifications for these as well. Reuse
SWITCHDEV_OBJ_ID_PORT_VLAN for this purpose. Listeners should use
netif_is_bridge_master() on orig_dev to determine whether the
notification is about a bridge port or a bridge.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br_vlan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a75fe930..14c1b6c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -268,6 +268,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			goto out_filt;
 		v->brvlan = masterv;
 		v->stats = masterv->stats;
+	} else {
+		err = br_switchdev_port_obj_add(dev, v->vid, flags);
+		if (err && err != -EOPNOTSUPP)
+			goto out;
 	}
 
 	/* Add the dev mac and count the vlan only if it's usable */
@@ -303,6 +307,8 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			br_vlan_put_master(masterv);
 			v->brvlan = NULL;
 		}
+	} else {
+		br_switchdev_port_obj_del(dev, v->vid);
 	}
 
 	goto out;
@@ -328,6 +334,11 @@ static int __vlan_del(struct net_bridge_vlan *v)
 		err = __vlan_vid_del(p->dev, p->br, v->vid);
 		if (err)
 			goto out;
+	} else {
+		err = br_switchdev_port_obj_del(v->br->dev, v->vid);
+		if (err && err != -EOPNOTSUPP)
+			goto out;
+		err = 0;
 	}
 
 	if (br_vlan_should_use(v)) {
@@ -605,6 +616,9 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed)
 			vg->num_vlans++;
 			*changed = true;
 		}
+		ret = br_switchdev_port_obj_add(br->dev, vid, flags);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
 		if (__vlan_add_flags(vlan, flags))
 			*changed = true;
 
-- 
2.4.11

