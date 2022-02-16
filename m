Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=cB26irAVuZwgNbEFS2NIqDPkpe7vp7yzpsmTQMM5rLM=;
 b=uPIDQeX7oc2WSeCALfzmEetKxr7dbxXYjQ+wziKJoKb/BtdBPLPbLjZiTrubzjScbg
 ZGuhh0jF8MSrl2nsbmravglWDZ2yny96hMFByFSyLRXXr3GKCocOVtaM6RT/F2qSAabo
 2OSZaAb3m88zWumgY9rqUyk9zBkjVhOMNnBaxByHxj12hWiNwmzA26mLec+PBWB2Xk7x
 JjX/+rEMoiEdmf3QZtS9aF75KfkwdUsjLtglwt0C+P3sZZY8TleUYAE+VF8ChIQ04lL7
 XKw0rVTPBoSJ7JqH/S4uMMwSEvwjuaA9c4JolSs0B3I297r7yLFsfSfvPafx8mY71FUb
 sg2A==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Feb 2022 14:29:29 +0100
Message-Id: <20220216132934.1775649-5-tobias@waldekranz.com>
In-Reply-To: <20220216132934.1775649-1-tobias@waldekranz.com>
References: <20220216132934.1775649-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 4/9] net: bridge: vlan: Notify switchdev
	drivers of MST state changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Generate a switchdev notification whenever a per-VLAN STP state
changes. This notification is keyed by the VLANs MSTID rather than the
VID, since multiple VLANs may share the same MST instance.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h      |  7 +++++++
 net/bridge/br_vlan_options.c | 22 ++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ee4a7bd1e540..0a3e0e0bb10a 100644
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
@@ -31,6 +32,11 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_VLAN_MSTID,
 };
 
+struct switchdev_mst_state {
+	u16 mstid;
+	u8 state;
+};
+
 struct switchdev_brport_flags {
 	unsigned long val;
 	unsigned long mask;
@@ -52,6 +58,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
+		struct switchdev_mst_state mst_state;	/* PORT_MST_STATE */
 		struct switchdev_brport_flags brport_flags; /* PORT_BRIDGE_FLAGS */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 1c0fd55fe6c9..b8840294f98e 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -5,6 +5,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <net/ip_tunnels.h>
+#include <net/switchdev.h>
 
 #include "br_private.h"
 #include "br_private_tunnel.h"
@@ -80,7 +81,16 @@ static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
 				bool *changed,
 				struct netlink_ext_ack *extack)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_PORT_MST_STATE,
+		.flags = SWITCHDEV_F_DEFER,
+		.u.mst_state = {
+			.mstid = br_vlan_mstid_get(v),
+			.state = state,
+		},
+	};
 	struct net_bridge *br;
+	int err;
 
 	ASSERT_RTNL();
 
@@ -89,10 +99,12 @@ static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
 		return -EINVAL;
 	}
 
-	if (br_vlan_is_brentry(v))
+	if (br_vlan_is_brentry(v)) {
 		br = v->br;
-	else
+	} else {
 		br = v->port->br;
+		attr.orig_dev = v->port->dev;
+	}
 
 	if (br->stp_enabled == BR_KERNEL_STP) {
 		NL_SET_ERR_MSG_MOD(extack, "Can't modify vlan state when using kernel STP");
@@ -102,6 +114,12 @@ static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state_rtnl(v) == state)
 		return 0;
 
+	if (attr.orig_dev) {
+		err = switchdev_port_attr_set(attr.orig_dev, &attr, NULL);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
 	if (v->vid == br_get_pvid(vg))
 		br_vlan_set_pvid_state(vg, state);
 
-- 
2.25.1

