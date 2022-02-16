Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=DYnfKqTSgC5uj+SzX4mt7uAq7sGgk7Wi7t60amasNV0=;
 b=oxgfrsXStgeuX6tCRI8Jrp2u3JdDVV8hMQYPzHmSvI8GOYa/IRYkpGoSbIKCUVYZZq
 pyHvHY1anxMNK9X3eJvqEjDG8+48vm6wLm0q79+bJQrnw6kKhbSZDh9v7OhufwQ+Q3xI
 oLCefAUu7MkS0wFIseqacZjsATPxgvlxhqk2bPdQy3tOYs/4/PNsx74hC8j6vPA2EwYt
 3A3BL4DVRusjAv56hhWzQ6BHib7nvN6z/HRpBkZ2Kf/OBYwIDQzKlAV3Oco5C881kPaY
 UlURxMwmPCiivCJYZPoiZh9ffuVp7p7wamxtLGKluisKrMujGYQOYudOCEHVFBU9YR7I
 SyvQ==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Feb 2022 14:29:28 +0100
Message-Id: <20220216132934.1775649-4-tobias@waldekranz.com>
In-Reply-To: <20220216132934.1775649-1-tobias@waldekranz.com>
References: <20220216132934.1775649-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 3/9] net: bridge: vlan: Notify switchdev
	drivers of VLAN MST migrations
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

Whenever a VLAN moves to a new MSTID, send a switchdev notification so
that switchdevs can track a bridge's VID to MSTID mapping.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h | 10 ++++++++++
 net/bridge/br_vlan.c    | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index d353793dfeb5..ee4a7bd1e540 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -28,6 +28,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
+	SWITCHDEV_ATTR_ID_VLAN_MSTID,
 };
 
 struct switchdev_brport_flags {
@@ -35,6 +36,14 @@ struct switchdev_brport_flags {
 	unsigned long mask;
 };
 
+struct switchdev_vlan_attr {
+	u16 vid;
+
+	union {
+		u16 mstid;
+	};
+};
+
 struct switchdev_attr {
 	struct net_device *orig_dev;
 	enum switchdev_attr_id id;
@@ -50,6 +59,7 @@ struct switchdev_attr {
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
 		bool mc_disabled;			/* MC_DISABLED */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
+		struct switchdev_vlan_attr vlan_attr;	/* VLAN_* */
 	} u;
 };
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 459e84a7354d..c45a34c14e10 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -173,6 +173,26 @@ static int br_vlan_mst_migrate(struct net_bridge_vlan *v, u16 mstid)
 	old_mst = rtnl_dereference(v->mst);
 	rcu_assign_pointer(v->mst, mst);
 
+	if (br_vlan_is_master(v)) {
+		struct switchdev_attr attr = {
+			.id = SWITCHDEV_ATTR_ID_VLAN_MSTID,
+			.flags = SWITCHDEV_F_DEFER,
+			.orig_dev = br->dev,
+			.u.vlan_attr = {
+				.vid = v->vid,
+				.mstid = mstid,
+			},
+		};
+		int err;
+
+		err = switchdev_port_attr_set(br->dev, &attr, NULL);
+		if (err && err != -EOPNOTSUPP) {
+			rcu_assign_pointer(v->mst, old_mst);
+			br_vlan_mst_put(mst);
+			return err;
+		}
+	}
+
 	if (old_mst)
 		br_vlan_mst_put(old_mst);
 
-- 
2.25.1

