Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=76757SLn2m3kynx16q8kTjn2S8FyWnl1tPy4d5M2WAU=;
 b=fOo4unQQPl/kO4jXHli7n90QN01vhns0vLZqV98YC5kcPh3XSV4992TiZQhGEWLRkO
 4kQIWapNT6BhIwx1qJMnISKt1aVfLh+wmFCjRFNnyo87bfUqDdyQXxi4JyoyVi7jVrdY
 AS70kYTbecf/dmgzPTY/g6vBo8hAUwaLrQ71P4J6OIdGUmvi25LuDBqaP0i32eXebJh2
 XZ11KLYwSgtlweOgOO+6geRrcVtKd3XWEKWuFGTV9QaA1TAbExBR1NiZF8tk3narzKcH
 D6X2aS7K94orJvwQlXXN0/WKsgPPGoPEBS7nVyFdP86HCRk8hZFSU57Le42G3Y0afvAu
 H1cw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Mar 2022 16:08:50 +0100
Message-Id: <20220316150857.2442916-9-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 08/15] net: bridge: mst: Add helper to
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

This is useful for switchdev drivers that might want to refuse to join
a bridge where MST is enabled, if the hardware can't support it.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/linux/if_bridge.h | 6 ++++++
 net/bridge/br_mst.c       | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 1cf0cc46d90d..4efd5540279a 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+bool br_mst_enabled(const struct net_device *dev);
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
@@ -153,6 +154,11 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 	return -EINVAL;
 }
 
+static inline bool br_mst_enabled(const struct net_device *dev)
+{
+	return false;
+}
+
 static inline int br_mst_get_info(const struct net_device *dev, u16 msti,
 				  unsigned long *vids)
 {
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 00b36e629224..830a5746479f 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -13,6 +13,15 @@
 
 DEFINE_STATIC_KEY_FALSE(br_mst_used);
 
+bool br_mst_enabled(const struct net_device *dev)
+{
+	if (!netif_is_bridge_master(dev))
+		return false;
+
+	return br_opt_get(netdev_priv(dev), BROPT_MST_ENABLED);
+}
+EXPORT_SYMBOL_GPL(br_mst_enabled);
+
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
 {
 	const struct net_bridge_vlan_group *vg;
-- 
2.25.1

