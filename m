Return-Path: <abaci-bugfix@linux.alibaba.com>
From: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Date: Wed, 13 Jan 2021 17:44:19 +0800
Message-Id: <1610531059-56212-1-git-send-email-abaci-bugfix@linux.alibaba.com>
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

net/bridge/br_sysfs_if.c(162): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
net/bridge/br_sysfs_if.c(155): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
net/bridge/br_sysfs_if.c(148): warning: %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.

Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 net/bridge/br_sysfs_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 7a59cdd..16a7d41 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -145,21 +145,21 @@ static ssize_t show_port_state(struct net_bridge_port *p, char *buf)
 static ssize_t show_message_age_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->message_age_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&p->message_age_timer));
 }
 static BRPORT_ATTR(message_age_timer, 0444, show_message_age_timer, NULL);
 
 static ssize_t show_forward_delay_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&p->forward_delay_timer));
 }
 static BRPORT_ATTR(forward_delay_timer, 0444, show_forward_delay_timer, NULL);
 
 static ssize_t show_hold_timer(struct net_bridge_port *p,
 					    char *buf)
 {
-	return sprintf(buf, "%ld\n", br_timer_value(&p->hold_timer));
+	return sprintf(buf, "%lu\n", br_timer_value(&p->hold_timer));
 }
 static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
 
-- 
1.8.3.1

