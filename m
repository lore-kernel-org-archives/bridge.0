Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=i+b2UIYzIPR8HiB7lfNC7HnKeM/AsfglkAUtbevdP9c=;
 b=pKQumBJ+GJsRVp/9DOhiZG5nLwVHg3P0o8Mzd4OiMre2OVw7GwRWHQFDDOj6l1s/vA
 1w5nGNo0a8hV5fJ/UjSxv9IbAeQoH04ovDHkSWiJsu8KjaUjBh77oag+Hn7Eq4qixUVt
 6eQTY0sehEiq+KVOLjlm9AJ82yRyh6h5Zy+bEICcQBUHCmYnCsSs+FvWQsVpRKhnSJFp
 fzcz10VupTQQdkofQYGmIUbdEgaZ7hcDA/HtJcCsGUbtxVQtNTFsLfDx3KYyrrFESRJ7
 0BFwb9iICX8WGq/nTqHGi+B1rime6Vp8ivGp3nf6odxboZd80FFPzo4fl9NKqK1SwJmi
 gSIw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Mar 2022 16:08:48 +0100
Message-Id: <20220316150857.2442916-7-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 06/15] net: bridge: mst: Notify
	switchdev drivers of MST state changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Generate a switchdev notification whenever an MST state changes. This
notification is keyed by the VLANs MSTI rather than the VID, since
multiple VLANs may share the same MST instance.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h |  7 +++++++
 net/bridge/br_mst.c     | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 53dfa0f7cf5b..aa0171d5786d 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -19,6 +19,7 @@
 enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
+	SWITCHDEV_ATTR_ID_PORT_MST_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
@@ -32,6 +33,11 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_VLAN_MSTI,
 };
 
+struct switchdev_mst_state {
+	u16 msti;
+	u8 state;
+};
+
 struct switchdev_brport_flags {
 	unsigned long val;
 	unsigned long mask;
@@ -50,6 +56,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
+		struct switchdev_mst_state mst_state;	/* PORT_MST_STATE */
 		struct switchdev_brport_flags brport_flags; /* PORT_BRIDGE_FLAGS */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 29266174e6b4..00935a19afcc 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -30,13 +30,31 @@ static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_v
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		     struct netlink_ext_ack *extack)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_PORT_MST_STATE,
+		.orig_dev = p->dev,
+		.u.mst_state = {
+			.msti = msti,
+			.state = state,
+		},
+	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
+	int err;
 
 	vg = nbp_vlan_group(p);
 	if (!vg)
 		return 0;
 
+	/* MSTI 0 (CST) state changes are notified via the regular
+	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
+	 */
+	if (msti) {
+		err = switchdev_port_attr_set(p->dev, &attr, extack);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
-- 
2.25.1

