Return-Path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
Date: Sat,  3 Nov 2012 23:02:30 +0100
Message-Id: <1351980150-24145-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
Subject: [Bridge] [PATCH 9/9] Avoid 'statement with no effect' compiler
	warnings
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>

Instead of issuing (0) statements when !CONFIG_SYSFS which will cause
'warning: ', we'll use inline statements instead. This will effectively
do the same thing, but suppress any unnecessary warnings.

Cc: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 net/bridge/br_private.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9b278c4..af5f584 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -566,10 +566,10 @@ extern void br_sysfs_delbr(struct net_device *dev);
 
 #else
 
-#define br_sysfs_addif(p)	(0)
-#define br_sysfs_renameif(p)	(0)
-#define br_sysfs_addbr(dev)	(0)
-#define br_sysfs_delbr(dev)	do { } while(0)
+static inline int br_sysfs_addif(struct net_bridge_port *p) { return 0; }
+static inline int br_sysfs_renameif(struct net_bridge_port *p) { return 0; }
+static inline int br_sysfs_addbr(struct net_device *dev) { return 0; }
+static inline void br_sysfs_delbr(struct net_device *dev) { return; }
 #endif /* CONFIG_SYSFS */
 
 #endif
-- 
1.7.9.5

