Return-Path: <wenxu@ucloud.cn>
From: wenxu@ucloud.cn
Date: Fri,  5 Jul 2019 21:16:36 +0800
Message-Id: <1562332598-17415-5-git-send-email-wenxu@ucloud.cn>
In-Reply-To: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
Subject: [Bridge] [PATCH 5/7 nf-next v2] bridge: add br_vlan_get_proto()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, pablo@netfilter.org
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This new function allows you to fetch bridge vlan proto.

Signed-off-by: wenxu <wenxu@ucloud.cn>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/linux/if_bridge.h |  6 ++++++
 net/bridge/br_vlan.c      | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 950db1d..9e57c44 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -89,6 +89,7 @@ static inline bool br_multicast_router(const struct net_device *dev)
 bool br_vlan_enabled(const struct net_device *dev);
 int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid);
 int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid);
+int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto);
 int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 #else
@@ -102,6 +103,11 @@ static inline int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid)
 	return -EINVAL;
 }
 
+static inline int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto)
+{
+	return -EINVAL;
+}
+
 static inline int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 {
 	return -EINVAL;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8d97b91..021cc9f66 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -797,6 +797,16 @@ bool br_vlan_enabled(const struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(br_vlan_enabled);
 
+int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto)
+{
+	struct net_bridge *br = netdev_priv(dev);
+
+	*p_proto = ntohs(br->vlan_proto);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_proto);
+
 int __br_vlan_set_proto(struct net_bridge *br, __be16 proto)
 {
 	int err = 0;
-- 
1.8.3.1

