Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=agAlWWZQYBVHrRvGB7Cz2qcqSgXZPBtTjYqG7FiBvqY=;
	b=tTWE9cLcWJD+1ny57xfQNb/D2DYOpAEE75CG4nOrdZoqktDKFjePWZgqfYrXftFZlhCOcdESshPiWexyIdMmvR68HB0sjyZ6VikhSpUmfoTQAW0gUj1xGDVP40TNHNENaZy6f92YXIQzX+hlNF5WaheXxF/v8i7kq++pOR5BW3M=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527503302.git.petrm@mellanox.com>
References: <cover.1527503302.git.petrm@mellanox.com>
Message-Id: <c52b1ce2a27aa2fd9095eb3a1804aff1011707c3.1527503302.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 12:50:31 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 6/7] net: bridge: Notify about bridge
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
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

A driver might need to react to changes in settings of brentry VLANs.
Therefore send switchdev port notifications for these as well. Reuse
SWITCHDEV_OBJ_ID_PORT_VLAN for this purpose. Listeners should use
netif_is_bridge_master() on orig_dev to determine whether the
notification is about a bridge port or a bridge.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_vlan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8ad5756..b15ef3f 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -243,6 +243,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			goto out_filt;
 		v->brvlan = masterv;
 		v->stats = masterv->stats;
+	} else {
+		err = br_switchdev_port_vlan_add(dev, v->vid, flags);
+		if (err && err != -EOPNOTSUPP)
+			goto out;
 	}
 
 	/* Add the dev mac and count the vlan only if it's usable */
@@ -278,6 +282,8 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			br_vlan_put_master(masterv);
 			v->brvlan = NULL;
 		}
+	} else {
+		br_switchdev_port_vlan_del(dev, v->vid);
 	}
 
 	goto out;
@@ -303,6 +309,11 @@ static int __vlan_del(struct net_bridge_vlan *v)
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
@@ -580,6 +591,9 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed)
 			vg->num_vlans++;
 			*changed = true;
 		}
+		ret = br_switchdev_port_vlan_add(br->dev, vid, flags);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
 		if (__vlan_add_flags(vlan, flags))
 			*changed = true;
 
-- 
2.4.11

