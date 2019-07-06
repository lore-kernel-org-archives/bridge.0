Return-Path: <wenxu@ucloud.cn>
From: wenxu@ucloud.cn
Date: Sat,  6 Jul 2019 22:15:50 +0800
Message-Id: <1562422552-26065-3-git-send-email-wenxu@ucloud.cn>
In-Reply-To: <1562422552-26065-1-git-send-email-wenxu@ucloud.cn>
References: <1562422552-26065-1-git-send-email-wenxu@ucloud.cn>
Subject: [Bridge] [PATCH 3/5 nf-next v4] bridge: add br_vlan_get_info_rcu()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, nikolay@cumulusnetworks.com, fw@strlen.de
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This new function allows you to fetch vlan info from packet path.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 include/linux/if_bridge.h |  7 +++++++
 net/bridge/br_vlan.c      | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 9e57c44..5c85608 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -92,6 +92,8 @@ static inline bool br_multicast_router(const struct net_device *dev)
 int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto);
 int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
+int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
+			 struct bridge_vlan_info *p_vinfo);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -118,6 +120,11 @@ static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
+				       struct bridge_vlan_info *p_vinfo)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 021cc9f66..8a9a26e 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1293,6 +1293,31 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 }
 EXPORT_SYMBOL_GPL(br_vlan_get_info);
 
+int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
+			 struct bridge_vlan_info *p_vinfo)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_bridge_port *p;
+
+	p = br_port_get_check_rcu(dev);
+	if (p)
+		vg = nbp_vlan_group_rcu(p);
+	else if (netif_is_bridge_master(dev))
+		vg = br_vlan_group_rcu(netdev_priv(dev));
+	else
+		return -EINVAL;
+
+	v = br_vlan_find(vg, vid);
+	if (!v)
+		return -ENOENT;
+
+	p_vinfo->vid = vid;
+	p_vinfo->flags = v->flags;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_info_rcu);
+
 static int br_vlan_is_bind_vlan_dev(const struct net_device *dev)
 {
 	return is_vlan_dev(dev) &&
-- 
1.8.3.1

