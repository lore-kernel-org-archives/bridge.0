Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HORlVdyGh2lGDd3y5BvuyOpIor1UFiV3pM2jOqAVHlI=;
 b=ksU1XqL/LKuIEER0eJhayiZ2Q5QVQXyH29qOAt3vJapvy+/IyFX78qljJI6SHRkeyC
 bihqJGu0JKIwYjsUH6RWnELkjmFJ7FBy7TBmLkrCiQ+WHlQmcjnOeYNDvi8AkCyHCVw7
 FhY0ofS9k+jRIQK7zhSRhEfsLci1xs8urECJS21oezGPUlknLrdBip0m7nLJnB5XgLu/
 2gBeH70jGu1orHF707eadV8E0omYKddbBY4vykZQ/mXGh3mBF4zy9gs88i/Ou5MoWLP0
 JRcIMDnbGmu6L0qlmbCWbdmrwsLjuPigA/giB1kW8WDnJv3dRMBCTNmbx+9VEDSEQFeg
 kX5A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 13 Aug 2021 17:59:59 +0300
Message-Id: <20210813150002.673579-4-razor@blackwall.org>
In-Reply-To: <20210813150002.673579-1-razor@blackwall.org>
References: <20210813150002.673579-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/6] net: bridge: mcast: consolidate
	querier selection for ipv4 and ipv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We can consolidate both functions as they share almost the same logic.
This is easier to maintain and we have a single querier update function.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 67 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 701cf46b89de..3705b7ace62d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2864,55 +2864,46 @@ static int br_ip6_multicast_mld2_report(struct net_bridge_mcast *brmctx,
 }
 #endif
 
-static bool br_ip4_multicast_select_querier(struct net_bridge_mcast *brmctx,
-					    struct net_bridge_mcast_port *pmctx,
-					    struct br_ip *saddr)
+static bool br_multicast_select_querier(struct net_bridge_mcast *brmctx,
+					struct net_bridge_mcast_port *pmctx,
+					struct br_ip *saddr)
 {
 	int port_ifidx = pmctx ? pmctx->port->dev->ifindex : 0;
+	struct timer_list *own_timer, *other_timer;
+	struct bridge_mcast_querier *querier;
 
-	if (!timer_pending(&brmctx->ip4_own_query.timer) &&
-	    !timer_pending(&brmctx->ip4_other_query.timer))
-		goto update;
-
-	if (!brmctx->ip4_querier.addr.src.ip4)
-		goto update;
-
-	if (ntohl(saddr->src.ip4) <= ntohl(brmctx->ip4_querier.addr.src.ip4))
-		goto update;
-
-	return false;
-
-update:
-	br_multicast_update_querier(brmctx, &brmctx->ip4_querier, port_ifidx,
-				    saddr);
-
-	return true;
-}
-
+	switch (saddr->proto) {
+	case htons(ETH_P_IP):
+		querier = &brmctx->ip4_querier;
+		own_timer = &brmctx->ip4_own_query.timer;
+		other_timer = &brmctx->ip4_other_query.timer;
+		if (!querier->addr.src.ip4 ||
+		    ntohl(saddr->src.ip4) <= ntohl(querier->addr.src.ip4))
+			goto update;
+		break;
 #if IS_ENABLED(CONFIG_IPV6)
-static bool br_ip6_multicast_select_querier(struct net_bridge_mcast *brmctx,
-					    struct net_bridge_mcast_port *pmctx,
-					    struct br_ip *saddr)
-{
-	int port_ifidx = pmctx ? pmctx->port->dev->ifindex : 0;
-
-	if (!timer_pending(&brmctx->ip6_own_query.timer) &&
-	    !timer_pending(&brmctx->ip6_other_query.timer))
-		goto update;
+	case htons(ETH_P_IPV6):
+		querier = &brmctx->ip6_querier;
+		own_timer = &brmctx->ip6_own_query.timer;
+		other_timer = &brmctx->ip6_other_query.timer;
+		if (ipv6_addr_cmp(&saddr->src.ip6, &querier->addr.src.ip6) <= 0)
+			goto update;
+		break;
+#endif
+	default:
+		return false;
+	}
 
-	if (ipv6_addr_cmp(&saddr->src.ip6,
-			  &brmctx->ip6_querier.addr.src.ip6) <= 0)
+	if (!timer_pending(own_timer) && !timer_pending(other_timer))
 		goto update;
 
 	return false;
 
 update:
-	br_multicast_update_querier(brmctx, &brmctx->ip6_querier, port_ifidx,
-				    saddr);
+	br_multicast_update_querier(brmctx, querier, port_ifidx, saddr);
 
 	return true;
 }
-#endif
 
 static void
 br_multicast_update_query_timer(struct net_bridge_mcast *brmctx,
@@ -3115,7 +3106,7 @@ br_ip4_multicast_query_received(struct net_bridge_mcast *brmctx,
 				struct br_ip *saddr,
 				unsigned long max_delay)
 {
-	if (!br_ip4_multicast_select_querier(brmctx, pmctx, saddr))
+	if (!br_multicast_select_querier(brmctx, pmctx, saddr))
 		return;
 
 	br_multicast_update_query_timer(brmctx, query, max_delay);
@@ -3130,7 +3121,7 @@ br_ip6_multicast_query_received(struct net_bridge_mcast *brmctx,
 				struct br_ip *saddr,
 				unsigned long max_delay)
 {
-	if (!br_ip6_multicast_select_querier(brmctx, pmctx, saddr))
+	if (!br_multicast_select_querier(brmctx, pmctx, saddr))
 		return;
 
 	br_multicast_update_query_timer(brmctx, query, max_delay);
-- 
2.31.1

