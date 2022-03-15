Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=tVCBhw08qNLsuFlkkOFuU98rHtIBmvXy+B80j+Mh3AE=;
 b=Ajad6Ng/K4St+Mej1wNaeU0DUSLAHoVfY9FQknmR5yYT0J2LcN3B5EM38Y2C3t3imY
 DbiPOzt1npZVsybU3zpIYM8hNYVIdjsYWnnbUqdYZ5vg9LWKRabomUcnwD6JbOG3TKe5
 mvT4PRWZ9xYkrofAinDjQUW0N+bGJmIPBmqwVIKminAXhqLaOwpdMJQL6f/b6I874Fgu
 v5ijsBCze+REVPVoAM3kDLD3VjRUm6vGDcXuSem9gkFP8igNTzYssJ9/JO2NrWrlju+1
 wLSY2JQ5qqwauprBlQWxdRuTLviVvn0kHAkywTUR2zefTfDQ0/FZyoHXO5jBG7dUVUxR
 RPbw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Tue, 15 Mar 2022 01:25:32 +0100
Message-Id: <20220315002543.190587-5-tobias@waldekranz.com>
In-Reply-To: <20220315002543.190587-1-tobias@waldekranz.com>
References: <20220315002543.190587-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 04/15] net: bridge: mst: Notify
	switchdev drivers of MST mode changes
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

Trigger a switchdev event whenever the bridge's MST mode is
enabled/disabled. This allows constituent ports to either perform any
required hardware config, or refuse the change if it not supported.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h |  2 ++
 net/bridge/br_mst.c     | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 3e424d40fae3..85dd004dc9ad 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -27,6 +27,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
+	SWITCHDEV_ATTR_ID_BRIDGE_MST,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
 };
 
@@ -48,6 +49,7 @@ struct switchdev_attr {
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
+		bool mst;				/* BRIDGE_MST */
 		bool mc_disabled;			/* MC_DISABLED */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
 	} u;
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 355ad102d6b1..051b9358946b 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -99,8 +99,14 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
 int br_mst_set_enabled(struct net_bridge *br, bool on,
 		       struct netlink_ext_ack *extack)
 {
+	struct switchdev_attr attr = {
+		.id = SWITCHDEV_ATTR_ID_BRIDGE_MST,
+		.orig_dev = br->dev,
+		.u.mst = on,
+	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p;
+	int err;
 
 	list_for_each_entry(p, &br->port_list, list) {
 		vg = nbp_vlan_group(p);
@@ -116,6 +122,10 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
 	if (br_opt_get(br, BROPT_MST_ENABLED) == on)
 		return 0;
 
+	err = switchdev_port_attr_set(br->dev, &attr, extack);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	if (on)
 		static_branch_enable(&br_mst_used);
 	else
-- 
2.25.1

