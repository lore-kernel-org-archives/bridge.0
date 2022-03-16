Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=TJ/ysLEqmTIrEKAi22qClFzQAMPt3L4KxozAj/kLyzE=;
 b=hWyG+mS9Kxs+/LhY6K5HDdevwY5y0klEWciUDA/sqtLTCzp0tYUn6erX4d36ClkWSI
 VucLJnX+1P9Nj2S4aDw+ehQ4mk/jBhbbC+vjiX3HlzPHnnI685RXwraSVt+RmrsQP7yN
 37VfSi3BGd/kPpMqU6yBeTLtn5xl1ZITJmwrwQPGfqxykFdQr7GTjj6CjXhxKSY2jS6H
 TgWaGAMcQWl4D/+cEXhRkozGZuXibto8+xIsb3xSiHbjumN0Y71L3/DyI2kkog2Q6WCk
 EhBt6bWXm5DxArP+Bl+oqC07OOXg15f13k7yLkIbTlCsGOvh2b6uhgRuwPa+ly6fUYE2
 z16g==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Mar 2022 16:08:49 +0100
Message-Id: <20220316150857.2442916-8-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 07/15] net: bridge: mst: Add helper to
	map an MSTI to a VID set
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

br_mst_get_info answers the question: "On this bridge, which VIDs are
mapped to the given MSTI?"

This is useful in switchdev drivers, which might have to fan-out
operations, relating to an MSTI, per VLAN.

An example: When a port's MST state changes from forwarding to
blocking, a driver may choose to flush the dynamic FDB entries on that
port to get faster reconvergence of the network, but this should only
be done in the VLANs that are managed by the MSTI in question.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/linux/if_bridge.h |  7 +++++++
 net/bridge/br_mst.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 3aae023a9353..1cf0cc46d90d 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -151,6 +152,12 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+
+static inline int br_mst_get_info(const struct net_device *dev, u16 msti,
+				  unsigned long *vids)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 00935a19afcc..00b36e629224 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -13,6 +13,32 @@
 
 DEFINE_STATIC_KEY_FALSE(br_mst_used);
 
+int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
+{
+	const struct net_bridge_vlan_group *vg;
+	const struct net_bridge_vlan *v;
+	const struct net_bridge *br;
+
+	ASSERT_RTNL();
+
+	if (!netif_is_bridge_master(dev))
+		return -EINVAL;
+
+	br = netdev_priv(dev);
+	if (!br_opt_get(br, BROPT_MST_ENABLED))
+		return -EINVAL;
+
+	vg = br_vlan_group(br);
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		if (v->msti == msti)
+			__set_bit(v->vid, vids);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_mst_get_info);
+
 static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
 				  u8 state)
 {
-- 
2.25.1

