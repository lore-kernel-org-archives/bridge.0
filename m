Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W+AoUXtDRqmvCnzMPgUsFve3ZW9qFjze1BaacgAckyQ=;
 b=rP7bBBZ1y4rd4WfGTlIm+GisET+CW5rLxqmHCokDkYwVzZePgFY5fSj9316v4KKNjm
 51gkDjnuaT5LGRN1GJvODnoLAKomScvIzrnLbLJx1EJE194d7fTqkcnJNXw8Y8z2LTwy
 no0BDxl/TyxRwRrijqB1yR1srEqxWMNc11ILC3jy0ZhIBSSlxCkZlA4pirKFaEpwio4f
 F9J3iwWXddGMsyBiudQkShN9NUn2aihtJcyaDuDNJBU6LdMf3+oBbN18enZqq8P14wDI
 PS5uwcBTI2iXYsw9bIeSNeqct/vK1Lc9czduDJs8WlignzTUGeMsFM+Dto8k7Ix4vMf3
 xMcg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 29 Jan 2021 13:51:41 +0200
Message-Id: <20210129115142.188455-2-razor@blackwall.org>
In-Reply-To: <20210129115142.188455-1-razor@blackwall.org>
References: <20210129115142.188455-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/2] net: bridge: mcast: drop hosts limit
	sysfs support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We decided to stop adding new sysfs bridge options and continue with
netlink only, so remove hosts limit sysfs support.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_sysfs_if.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index b66305fae26b..7a59cdddd3ce 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -16,7 +16,6 @@
 #include <linux/sched/signal.h>
 
 #include "br_private.h"
-#include "br_private_mcast_eht.h"
 
 struct brport_attribute {
 	struct attribute	attr;
@@ -246,29 +245,6 @@ static int store_multicast_router(struct net_bridge_port *p,
 static BRPORT_ATTR(multicast_router, 0644, show_multicast_router,
 		   store_multicast_router);
 
-static ssize_t show_multicast_eht_hosts_limit(struct net_bridge_port *p,
-					      char *buf)
-{
-	return sprintf(buf, "%u\n", p->multicast_eht_hosts_limit);
-}
-
-static int store_multicast_eht_hosts_limit(struct net_bridge_port *p,
-					   unsigned long v)
-{
-	return br_multicast_eht_set_hosts_limit(p, v);
-}
-static BRPORT_ATTR(multicast_eht_hosts_limit, 0644,
-		   show_multicast_eht_hosts_limit,
-		   store_multicast_eht_hosts_limit);
-
-static ssize_t show_multicast_eht_hosts_cnt(struct net_bridge_port *p,
-					    char *buf)
-{
-	return sprintf(buf, "%u\n", p->multicast_eht_hosts_cnt);
-}
-static BRPORT_ATTR(multicast_eht_hosts_cnt, 0444, show_multicast_eht_hosts_cnt,
-		   NULL);
-
 BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE);
 BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST);
 #endif
@@ -298,8 +274,6 @@ static const struct brport_attribute *brport_attrs[] = {
 	&brport_attr_multicast_router,
 	&brport_attr_multicast_fast_leave,
 	&brport_attr_multicast_to_unicast,
-	&brport_attr_multicast_eht_hosts_limit,
-	&brport_attr_multicast_eht_hosts_cnt,
 #endif
 	&brport_attr_proxyarp,
 	&brport_attr_proxyarp_wifi,
-- 
2.29.2

