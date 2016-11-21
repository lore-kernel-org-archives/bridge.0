Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XMlKPfVKkxgDT8l4xRCQx16VoBPOxX/XGmeDLW9590U=;
	b=KDJ17dexVuA5ynSKO5ANI96oMV6kmfSXGX/exNgP+OS7OUqMMo+CFULP9jh6s5RFpx
	XIqXS9D5DbEB7he82tTwPIfNtk5nfgbss26a0ZmPlwkL8r7EphG9zUvEdqT06yXyQzhp
	+it65OFINK2+CqfMVmXLD6MS6JY1d2tXpoRouvm54iyCUsa7+VBU41s3SXnys/VMJ9Hx
	jSyxW2RL+BcPFi43losC6jMRQ2bBckRqWkC4m+8QOsgxXYz0LQi1+2ptRqlgZGfzHGZn
	ZqVvavj5oVdCZ2wqydGv0Ed1HElTw313h4CcvAFufhZdI09QyIROFGRhkyOps2JK2QTr
	hTtw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 21 Nov 2016 11:09:23 -0800
Message-Id: <20161121190925.14530-2-f.fainelli@gmail.com>
In-Reply-To: <20161121190925.14530-1-f.fainelli@gmail.com>
References: <20161121190925.14530-1-f.fainelli@gmail.com>
Subject: [Bridge] [RFC net-next 1/3] net: bridge: Allow bridge master device
	to configure switch CPU port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: idosch@mellanox.com, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@savoirfairelinux.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, davem@davemloft.net

An use case which is currently not possible with Linux bridges on top of
network switches is to configure the CPU port of the switch (inherently
presented to the user with a bridge master device) independently from
its downstream ports, with a different set of VLAN properties. The
reason as to why is that the switch driver will never get any call to
switchdev_port_obj_{add,del} with the obj->orig_dev set to the bridge
master device.

This allows CPU/management ports to e.g: receive all traffic as tagged,
whereas the downstream port may have different untagged VLAN settings.

The following happens now (assuming bridge master device is already
created):

bridge vlan add vid 2 dev port0 pvid untagged
	-> port0 (e.g: switch port 0) gets programmed
	-> CPU port gets programmed
bridge vlan add vid 2 dev br0 self
	-> CPU port gets programmed
bridge vlan add vid 2 dev port0
	-> port0 (switch port 0) gets programmed

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_vlan.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index b6de4f457161..b335d66d21db 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -228,7 +228,9 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 		err = __vlan_vid_add(dev, br, v->vid, flags);
 		if (err)
 			goto out;
+	}
 
+	if (p) {
 		/* need to work on the master vlan too */
 		if (flags & BRIDGE_VLAN_INFO_MASTER) {
 			err = br_vlan_add(br, v->vid, flags |
@@ -242,6 +244,14 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 			goto out_filt;
 		v->brvlan = masterv;
 		v->stats = masterv->stats;
+
+		/* Propagate the VLAN flags changes down to the underlying
+		 * hardware, which may have to reconfigure the physical port
+		 * associated with the bridge (e.g: CPU/management port)
+		 */
+		err = __vlan_vid_add(br->dev, br, v->vid, flags);
+		if (err)
+			goto out_filt;
 	}
 
 	/* Add the dev mac and count the vlan only if it's usable */
@@ -287,19 +297,25 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	struct net_bridge_vlan *masterv = v;
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
+	struct net_device *dev;
+	struct net_bridge *br;
 	int err = 0;
 
 	if (br_vlan_is_master(v)) {
-		vg = br_vlan_group(v->br);
+		br = v->br;
+		vg = br_vlan_group(br);
+		dev = v->br->dev;
 	} else {
 		p = v->port;
+		br = p->br;
+		dev = p->dev;
 		vg = nbp_vlan_group(v->port);
 		masterv = v->brvlan;
 	}
 
 	__vlan_delete_pvid(vg, v->vid);
-	if (p) {
-		err = __vlan_vid_del(p->dev, p->br, v->vid);
+	if (p || br_vlan_is_master(v)) {
+		err = __vlan_vid_del(dev, br, v->vid);
 		if (err)
 			goto out;
 	}
@@ -568,6 +584,12 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags)
 			vg->num_vlans++;
 		}
 		__vlan_add_flags(vlan, flags);
+
+		/* Propagate the VLAN flags changes down to the underlying
+		 * hardware, which may have to reconfigure the physical port
+		 * associated with the bridge (e.g: CPU/management port)
+		 */
+		__vlan_vid_add(br->dev, br, vlan->vid, flags);
 		return 0;
 	}
 
-- 
2.9.3

