Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7QgAKJYUvxoxYg9mJpeQeVQQ5R7yHrstaDnglDk7EvQ=;
 b=nI6qDDjVSKbywAXtOttTJ9/5E9FIKjKwR66PBvnyddknXQ/Tjfagl/aPVgKei1Upzh
 knv89ZAOgCHPc/xZqoVj62Qavl+bmQPFP0iETanAPaKXwtG/ImVNAeuhwoHxb4So+sH4
 rkWTK/t+tYqhq1I11pc25h6+1TNBxfdDt2e/++tOJUXd1IMdPiHnzZXNfurvXOyrS9N3
 DAp/JYzIl9ALqNMC02amVqZetrjmaRet/gkltIL1rOWIaLgtdeNdflD/766Kj7HOPmP8
 iObLHm5hD3pbuQY7FziYnTC8RH4Cktk8VJTiqaBxEmyn5FWUC4yGtxiLh8qXVmZ+Wo+l
 JytA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 13 Aug 2021 17:59:58 +0300
Message-Id: <20210813150002.673579-3-razor@blackwall.org>
In-Reply-To: <20210813150002.673579-1-razor@blackwall.org>
References: <20210813150002.673579-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/6] net: bridge: mcast: make sure querier
	port/address updates are consistent
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

Use a sequence counter to make sure port/address updates can be read
consistently without requiring the bridge multicast_lock. We need to
zero out the port and address when the other querier has expired and
we're about to select ourselves as querier. br_multicast_read_querier
will be used later when dumping querier state. Updates are done only
with the multicast spinlock and softirqs disabled, while reads are done
from process context and from softirqs (due to notifications).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 74 ++++++++++++++++++++++++++++-----------
 net/bridge/br_private.h   |  1 +
 2 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 853b947edf87..701cf46b89de 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1659,11 +1659,38 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	}
 }
 
+static void br_multicast_read_querier(const struct bridge_mcast_querier *querier,
+				      struct bridge_mcast_querier *dest)
+{
+	unsigned int seq;
+
+	memset(dest, 0, sizeof(*dest));
+	do {
+		seq = read_seqcount_begin(&querier->seq);
+		dest->port_ifidx = querier->port_ifidx;
+		memcpy(&dest->addr, &querier->addr, sizeof(struct br_ip));
+	} while (read_seqcount_retry(&querier->seq, seq));
+}
+
+static void br_multicast_update_querier(struct net_bridge_mcast *brmctx,
+					struct bridge_mcast_querier *querier,
+					int ifindex,
+					struct br_ip *saddr)
+{
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	write_seqcount_begin(&querier->seq);
+	querier->port_ifidx = ifindex;
+	memcpy(&querier->addr, saddr, sizeof(*saddr));
+	write_seqcount_end(&querier->seq);
+}
+
 static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
 				    struct net_bridge_mcast_port *pmctx,
 				    struct bridge_mcast_own_query *own_query)
 {
 	struct bridge_mcast_other_query *other_query = NULL;
+	struct bridge_mcast_querier *querier;
 	struct br_ip br_group;
 	unsigned long time;
 
@@ -1676,10 +1703,12 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
 
 	if (pmctx ? (own_query == &pmctx->ip4_own_query) :
 		    (own_query == &brmctx->ip4_own_query)) {
+		querier = &brmctx->ip4_querier;
 		other_query = &brmctx->ip4_other_query;
 		br_group.proto = htons(ETH_P_IP);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
+		querier = &brmctx->ip6_querier;
 		other_query = &brmctx->ip6_other_query;
 		br_group.proto = htons(ETH_P_IPV6);
 #endif
@@ -1688,6 +1717,13 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	if (!other_query || timer_pending(&other_query->timer))
 		return;
 
+	/* we're about to select ourselves as querier */
+	if (!pmctx && querier->port_ifidx) {
+		struct br_ip zeroip = {};
+
+		br_multicast_update_querier(brmctx, querier, 0, &zeroip);
+	}
+
 	__br_multicast_send_query(brmctx, pmctx, NULL, NULL, &br_group, false,
 				  0, NULL);
 
@@ -2830,9 +2866,9 @@ static int br_ip6_multicast_mld2_report(struct net_bridge_mcast *brmctx,
 
 static bool br_ip4_multicast_select_querier(struct net_bridge_mcast *brmctx,
 					    struct net_bridge_mcast_port *pmctx,
-					    __be32 saddr)
+					    struct br_ip *saddr)
 {
-	struct net_bridge_port *port = pmctx ? pmctx->port : NULL;
+	int port_ifidx = pmctx ? pmctx->port->dev->ifindex : 0;
 
 	if (!timer_pending(&brmctx->ip4_own_query.timer) &&
 	    !timer_pending(&brmctx->ip4_other_query.timer))
@@ -2841,17 +2877,14 @@ static bool br_ip4_multicast_select_querier(struct net_bridge_mcast *brmctx,
 	if (!brmctx->ip4_querier.addr.src.ip4)
 		goto update;
 
-	if (ntohl(saddr) <= ntohl(brmctx->ip4_querier.addr.src.ip4))
+	if (ntohl(saddr->src.ip4) <= ntohl(brmctx->ip4_querier.addr.src.ip4))
 		goto update;
 
 	return false;
 
 update:
-	brmctx->ip4_querier.addr.src.ip4 = saddr;
-
-	/* update protected by general multicast_lock by caller */
-	if (port)
-		brmctx->ip4_querier.port_ifidx = port->dev->ifindex;
+	br_multicast_update_querier(brmctx, &brmctx->ip4_querier, port_ifidx,
+				    saddr);
 
 	return true;
 }
@@ -2859,25 +2892,23 @@ static bool br_ip4_multicast_select_querier(struct net_bridge_mcast *brmctx,
 #if IS_ENABLED(CONFIG_IPV6)
 static bool br_ip6_multicast_select_querier(struct net_bridge_mcast *brmctx,
 					    struct net_bridge_mcast_port *pmctx,
-					    struct in6_addr *saddr)
+					    struct br_ip *saddr)
 {
-	struct net_bridge_port *port = pmctx ? pmctx->port : NULL;
+	int port_ifidx = pmctx ? pmctx->port->dev->ifindex : 0;
 
 	if (!timer_pending(&brmctx->ip6_own_query.timer) &&
 	    !timer_pending(&brmctx->ip6_other_query.timer))
 		goto update;
 
-	if (ipv6_addr_cmp(saddr, &brmctx->ip6_querier.addr.src.ip6) <= 0)
+	if (ipv6_addr_cmp(&saddr->src.ip6,
+			  &brmctx->ip6_querier.addr.src.ip6) <= 0)
 		goto update;
 
 	return false;
 
 update:
-	brmctx->ip6_querier.addr.src.ip6 = *saddr;
-
-	/* update protected by general multicast_lock by caller */
-	if (port)
-		brmctx->ip6_querier.port_ifidx = port->dev->ifindex;
+	br_multicast_update_querier(brmctx, &brmctx->ip6_querier, port_ifidx,
+				    saddr);
 
 	return true;
 }
@@ -3084,7 +3115,7 @@ br_ip4_multicast_query_received(struct net_bridge_mcast *brmctx,
 				struct br_ip *saddr,
 				unsigned long max_delay)
 {
-	if (!br_ip4_multicast_select_querier(brmctx, pmctx, saddr->src.ip4))
+	if (!br_ip4_multicast_select_querier(brmctx, pmctx, saddr))
 		return;
 
 	br_multicast_update_query_timer(brmctx, query, max_delay);
@@ -3099,7 +3130,7 @@ br_ip6_multicast_query_received(struct net_bridge_mcast *brmctx,
 				struct br_ip *saddr,
 				unsigned long max_delay)
 {
-	if (!br_ip6_multicast_select_querier(brmctx, pmctx, &saddr->src.ip6))
+	if (!br_ip6_multicast_select_querier(brmctx, pmctx, saddr))
 		return;
 
 	br_multicast_update_query_timer(brmctx, query, max_delay);
@@ -3119,7 +3150,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 	struct igmpv3_query *ih3;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
-	struct br_ip saddr;
+	struct br_ip saddr = {};
 	unsigned long max_delay;
 	unsigned long now = jiffies;
 	__be32 group;
@@ -3199,7 +3230,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 	struct mld2_query *mld2q;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
-	struct br_ip saddr;
+	struct br_ip saddr = {};
 	unsigned long max_delay;
 	unsigned long now = jiffies;
 	unsigned int offset = skb_transport_offset(skb);
@@ -3677,7 +3708,6 @@ static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
 	if (query->startup_sent < brmctx->multicast_startup_query_count)
 		query->startup_sent++;
 
-	querier->port_ifidx = 0;
 	br_multicast_send_query(brmctx, NULL, query);
 out:
 	spin_unlock(&brmctx->br->multicast_lock);
@@ -3735,11 +3765,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
 
 	brmctx->ip4_other_query.delay_time = 0;
 	brmctx->ip4_querier.port_ifidx = 0;
+	seqcount_init(&brmctx->ip4_querier.seq);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
 	brmctx->ip6_other_query.delay_time = 0;
 	brmctx->ip6_querier.port_ifidx = 0;
+	seqcount_init(&brmctx->ip6_querier.seq);
 #endif
 
 	timer_setup(&brmctx->ip4_mc_router_timer,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b92fab5ae0fb..6ca9519f18a3 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -82,6 +82,7 @@ struct bridge_mcast_other_query {
 struct bridge_mcast_querier {
 	struct br_ip addr;
 	int port_ifidx;
+	seqcount_t seq;
 };
 
 /* IGMP/MLD statistics */
-- 
2.31.1

