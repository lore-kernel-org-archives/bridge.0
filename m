Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=7lHeWPXEXWrCYgRFwcHwT0FA/DPhlUmoROl0FMGvSmk=;
 b=odLD55IR7r4dldGhulofhapMI5jrMDOi5q3CTbdcs8RDrs6wRN+BGPhnHaUKb6e22F
 5T/KPRXcIqll0h+XN7kOP7NTJ+FcAu2741kVFIUHFc/MI/XMqGo2HWPLlIzALElpDQ1F
 Mm02O7POmyISL2X167BSom71A92PoigsuxFKBoZbi/rGd6xnJHDeiZvSsFKufA2Is8Jd
 edmH4YijZ+M6MsQPcX/RJeW0yjJB1KUThuEF34pbsNfLHBPuo6NB+yBLgL9zri/CR5jz
 zwtw9yb0Sd56tBr9EtRjMM99jeKPUvlHsEpM0/k4NlpP8yJFCLmfsSPyOhRSBV0YIN/S
 Ieww==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Mon, 14 Mar 2022 10:52:25 +0100
Message-Id: <20220314095231.3486931-9-tobias@waldekranz.com>
In-Reply-To: <20220314095231.3486931-1-tobias@waldekranz.com>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 net-next 08/14] net: bridge: mst: Add helper to
	check if MST is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

This is useful for switchdev drivers that might want to refuse to join
a bridge where MST is enabled, if the hardware can't support it.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/linux/if_bridge.h | 5 +++++
 net/bridge/br_mst.c       | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 46e6327fef06..5dbab0a280a6 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+bool br_mst_enabled(struct net_device *dev);
 int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
@@ -152,6 +153,10 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+static inline bool br_mst_enabled(struct net_device *dev)
+{
+	return false;
+}
 static inline int br_mst_get_info(struct net_device *dev, u16 msti,
 				  unsigned long *vids)
 {
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index eb18dbd5838f..e5ab2ce451c2 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -13,6 +13,15 @@
 
 DEFINE_STATIC_KEY_FALSE(br_mst_used);
 
+bool br_mst_enabled(struct net_device *dev)
+{
+	if (!netif_is_bridge_master(dev))
+		return false;
+
+	return br_opt_get(netdev_priv(dev), BROPT_MST_ENABLED);
+}
+EXPORT_SYMBOL(br_mst_enabled);
+
 int br_mst_get_info(struct net_device *dev, u16 msti, unsigned long *vids)
 {
 	struct net_bridge_vlan_group *vg;
-- 
2.25.1

