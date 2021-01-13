Return-Path: <abaci-bugfix@linux.alibaba.com>
From: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Date: Wed, 13 Jan 2021 17:36:24 +0800
Message-Id: <1610530584-48554-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Subject: [Bridge] [PATCH] net/bridge: Fix inconsistent format argument types
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>, nikolay@nvidia.com, kuba@kernel.org, davem@davemloft.net

Fix the following warnings:

net/bridge/br_sysfs_br.c(833): warning: %u in format string (no. 1)
requires 'unsigned int' but the argument type is 'signed int'.
net/bridge/br_sysfs_br.c(817): warning: %u in format string (no. 1)
requires 'unsigned int' but the argument type is 'signed int'.
net/bridge/br_sysfs_br.c(261): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
net/bridge/br_sysfs_br.c(253): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
net/bridge/br_sysfs_br.c(244): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
net/bridge/br_sysfs_br.c(236): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.

Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 net/bridge/br_sysfs_br.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 7db06e3..7512921 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -233,7 +233,7 @@ static ssize_t hello_timer_show(struct device *d,
 				struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->hello_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->hello_timer));
 }
 static DEVICE_ATTR_RO(hello_timer);
 
@@ -241,7 +241,7 @@ static ssize_t tcn_timer_show(struct device *d, struct device_attribute *attr,
 			      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->tcn_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->tcn_timer));
 }
 static DEVICE_ATTR_RO(tcn_timer);
 
@@ -250,7 +250,7 @@ static ssize_t topology_change_timer_show(struct device *d,
 					  char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->topology_change_timer));
 }
 static DEVICE_ATTR_RO(topology_change_timer);
 
@@ -258,7 +258,7 @@ static ssize_t gc_timer_show(struct device *d, struct device_attribute *attr,
 			     char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&br->gc_work.timer));
 }
 static DEVICE_ATTR_RO(gc_timer);
 
@@ -814,7 +814,7 @@ static ssize_t vlan_stats_enabled_show(struct device *d,
 				       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
+	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
 }
 
 static ssize_t vlan_stats_enabled_store(struct device *d,
@@ -830,7 +830,7 @@ static ssize_t vlan_stats_per_port_show(struct device *d,
 					char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
+	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
 }
 
 static ssize_t vlan_stats_per_port_store(struct device *d,
-- 
1.8.3.1

