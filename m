Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=GnM2vWwSx2i5cE2iNl+NO2cDrpNSR+FaAqPVnKFkrgM=;
 b=uyhfrzP7w9DjuBUBI2RL71VgIXkwbG6IgUN2y0ZJe7zvgp8IWsL1bDwgVyCDnoTfZ9
 CHQA4UL9uMDbL2tZOAVJGcMjd3ekQIITSByP5SF129hYTSMLHsapZA8uro58+w3svgBx
 51EtxzdMy9jSYcZv3YxmR9oMMdHCWHVUXbJw7lXaeDdfO+VUJnkA3GUlXevzhv1TM593
 m9RFo1iNJo/OXZQxmkIvpd+zic1FlIbILxF5UVF06rgyMCg1ah8dZ3nBmQMsZM8cION6
 onopmBEBmOr45EaQ1P9TlgmsjTmQ2K6WVeufmzgSglCsjZ39R0Lr+/TS6pyzGMMCD4wQ
 N9Dw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Mar 2022 16:08:51 +0100
Message-Id: <20220316150857.2442916-10-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 09/15] net: bridge: mst: Add helper to
	query a port's MST state
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

This is useful for switchdev drivers who are offloading MST states
into hardware. As an example, a driver may wish to flush the FDB for a
port when it transitions from forwarding to blocking - which means
that the previous state must be discoverable.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/linux/if_bridge.h |  6 ++++++
 net/bridge/br_mst.c       | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 4efd5540279a..d62ef428e3aa 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -121,6 +121,7 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
 bool br_mst_enabled(const struct net_device *dev);
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
+int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -164,6 +165,11 @@ static inline int br_mst_get_info(const struct net_device *dev, u16 msti,
 {
 	return -EINVAL;
 }
+static inline int br_mst_get_state(const struct net_device *dev, u16 msti,
+				   u8 *state)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 830a5746479f..ee680adcee17 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -48,6 +48,31 @@ int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
 }
 EXPORT_SYMBOL_GPL(br_mst_get_info);
 
+int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
+{
+	const struct net_bridge_port *p = NULL;
+	const struct net_bridge_vlan_group *vg;
+	const struct net_bridge_vlan *v;
+
+	ASSERT_RTNL();
+
+	p = br_port_get_check_rtnl(dev);
+	if (!p || !br_opt_get(p->br, BROPT_MST_ENABLED))
+		return -EINVAL;
+
+	vg = nbp_vlan_group(p);
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		if (v->brvlan->msti == msti) {
+			*state = v->state;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(br_mst_get_state);
+
 static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
 				  u8 state)
 {
-- 
2.25.1

