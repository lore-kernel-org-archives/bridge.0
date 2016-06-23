Return-Path: <daniel@dd-wrt.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com;
	s=mikd; 
	h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Cc:To:From;
	bh=OyzCFnKddYPmpcKftz5td+bnpj/cGd2DMfX2kODVs84=; 
	b=YHHl8O3JmnfKw9SPRVYFyGm4vjd+LzQzUOWKf4PyTg1v/D955FliFQtwa0lqW06CNYwedWeMYJjvnQR5nzNiODw/2IRy3tATLQJ6UvBXnag77kMzLJaZjPNpI/TzvnAkofRgMz76KJYEEr3JYvq0scl0/Vnxnv2o1wtNmvCTpwY=;
From: daniel <daniel@dd-wrt.com>
Message-ID: <4375d883-a95f-d032-c678-ed2fd665c36b@dd-wrt.com>
Date: Thu, 23 Jun 2016 11:28:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] Bridge: Fix ipv6 mc snooping if it has no ipv6
	address.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

The bridge is falsly dropping ipv6 mulitcast packets
if there is no ipv6 address assigned on the brigde and no
external mld querier is present.

When the bridge fails to build mld queries, because it has no
ipv6 address, it silently returns, but keeps the local querier enabled.
(br_multicast.c:832)

Ipv6 multicast snooping can only work if:
 a) an external querier is present
 b) the bridge has an ipv6 address an is capable of sending own queries

Otherwise it has to forward/flood the ipv6 multicast traffic,
because snooping cannot work.

This patch fixes the issue by adding a flag to the bridge struct that
indicates that there is currently no ipv6 address assinged to the bridge
and returns a false state for the local querier in
__br_multicast_querier_exists().

Special thanks to Linus Lüssing.

Signed-off-by: Daniel Danzberger <daniel@dd-wrt.com>
---
 net/bridge/br_multicast.c |  4 ++++
 net/bridge/br_private.h   | 23 +++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6852f3c..4384414 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -464,8 +464,11 @@ static struct sk_buff
*br_ip6_multicast_alloc_query(struct net_bridge *br,
 	if (ipv6_dev_get_saddr(dev_net(br->dev), br->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
 		kfree_skb(skb);
+		br->has_ipv6_addr = 0;
 		return NULL;
 	}
+
+	br->has_ipv6_addr = 1;
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);

 	hopopt = (u8 *)(ip6h + 1);
@@ -1745,6 +1748,7 @@ void br_multicast_init(struct net_bridge *br)
 	br->ip6_other_query.delay_time = 0;
 	br->ip6_querier.port = NULL;
 #endif
+	br->has_ipv6_addr = 1;

 	spin_lock_init(&br->multicast_lock);
 	setup_timer(&br->multicast_router_timer,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c7fb5d7..52edecf 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -314,6 +314,7 @@ struct net_bridge
 	u8				multicast_disabled:1;
 	u8				multicast_querier:1;
 	u8				multicast_query_use_ifaddr:1;
+	u8				has_ipv6_addr:1;

 	u32				hash_elasticity;
 	u32				hash_max;
@@ -588,10 +589,22 @@ static inline bool br_multicast_is_router(struct
net_bridge *br)

 static inline bool
 __br_multicast_querier_exists(struct net_bridge *br,
-			      struct bridge_mcast_other_query *querier)
+				struct bridge_mcast_other_query *querier,
+				const bool is_ipv6)
 {
+	bool own_querier_enabled;
+
+	if (br->multicast_querier) {
+		if (is_ipv6 && !br->has_ipv6_addr)
+			own_querier_enabled = false;
+		else
+			own_querier_enabled = true;
+	} else {
+		own_querier_enabled = false;
+	}
+
 	return time_is_before_jiffies(querier->delay_time) &&
-	       (br->multicast_querier || timer_pending(&querier->timer));
+	       (own_querier_enabled || timer_pending(&querier->timer));
 }

 static inline bool br_multicast_querier_exists(struct net_bridge *br,
@@ -599,10 +612,12 @@ static inline bool
br_multicast_querier_exists(struct net_bridge *br,
 {
 	switch (eth->h_proto) {
 	case (htons(ETH_P_IP)):
-		return __br_multicast_querier_exists(br, &br->ip4_other_query);
+		return __br_multicast_querier_exists(br,
+			&br->ip4_other_query, false);
 #if IS_ENABLED(CONFIG_IPV6)
 	case (htons(ETH_P_IPV6)):
-		return __br_multicast_querier_exists(br, &br->ip6_other_query);
+		return __br_multicast_querier_exists(br,
+			&br->ip6_other_query, true);
 #endif
 	default:
 		return false;
-- 
2.1.4

