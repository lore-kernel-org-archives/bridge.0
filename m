Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d1BgftJZxjdF2V+lZOAo+sZ8Xo9yAnh8LkQICn1DLDY=;
 b=KairQXsjNhNPPtzTVHrWafElX0IiPZSurbHirA9lJHSrdXjc3Q803HnjqkjxWEF9Z7
 GjZRwowCSdq1NqDbs+Tcrjvv84wc/yp56oerVVgYx6Onr+U7e4We37TJ0IDdGUxtHINz
 N0uVSnN+rgY7lfhrC0UD21tRaEc9sqq2Gn2ydJ7xdysMnp3QFXSGmsnqtQjVEuwHZqTK
 SqCtEZOIVwbTq9WbsNNzIRGu2xEL9ObZb13ZgJJvETGJdamix0Cttj4IQN8SxZD1mOU+
 dbQV1hGLAvWQZoVxwaNJymj1hy1O+VDXWTmgOvx9BhMuLiVnwtYrkGnVlAxxzEXopA2g
 jU/Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:28 +0300
Message-Id: <20210810152933.178325-11-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 10/15] net: bridge: mcast: move querier
	state to the multicast context
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

We need to have the querier state per multicast context in order to have
per-vlan control, so remove the internal option bit and move it to the
multicast context. Also annotate the lockless reads of the new variable.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 21 +++++++++++----------
 net/bridge/br_netlink.c   |  2 +-
 net/bridge/br_private.h   |  4 ++--
 net/bridge/br_sysfs_br.c  |  2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 643b69d767f7..fe1482efd59c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1668,7 +1668,7 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
 
 	if (!br_multicast_ctx_should_use(brmctx, pmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED) ||
-	    !br_opt_get(brmctx->br, BROPT_MULTICAST_QUERIER))
+	    !brmctx->multicast_querier)
 		return;
 
 	memset(&br_group.dst, 0, sizeof(br_group.dst));
@@ -1747,14 +1747,16 @@ static void br_multicast_port_group_rexmit(struct timer_list *t)
 
 	spin_lock(&br->multicast_lock);
 	if (!netif_running(br->dev) || hlist_unhashed(&pg->mglist) ||
-	    !br_opt_get(br, BROPT_MULTICAST_ENABLED) ||
-	    !br_opt_get(br, BROPT_MULTICAST_QUERIER))
+	    !br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		goto out;
 
 	pmctx = br_multicast_pg_to_port_ctx(pg);
 	if (!pmctx)
 		goto out;
 	brmctx = br_multicast_port_ctx_get_global(pmctx);
+	if (!brmctx->multicast_querier)
+		goto out;
+
 	if (pg->key.addr.proto == htons(ETH_P_IP))
 		other_query = &brmctx->ip4_other_query;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1974,8 +1976,7 @@ static void __grp_src_query_marked_and_rexmit(struct net_bridge_mcast *brmctx,
 		if (ent->flags & BR_SGRP_F_SEND) {
 			ent->flags &= ~BR_SGRP_F_SEND;
 			if (ent->timer.expires > lmqt) {
-				if (br_opt_get(brmctx->br,
-					       BROPT_MULTICAST_QUERIER) &&
+				if (brmctx->multicast_querier &&
 				    other_query &&
 				    !timer_pending(&other_query->timer))
 					ent->src_query_rexmit_cnt = lmqc;
@@ -1984,7 +1985,7 @@ static void __grp_src_query_marked_and_rexmit(struct net_bridge_mcast *brmctx,
 		}
 	}
 
-	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_QUERIER) ||
+	if (!brmctx->multicast_querier ||
 	    !other_query || timer_pending(&other_query->timer))
 		return;
 
@@ -2015,7 +2016,7 @@ static void __grp_send_query_and_rexmit(struct net_bridge_mcast *brmctx,
 		other_query = &brmctx->ip6_other_query;
 #endif
 
-	if (br_opt_get(brmctx->br, BROPT_MULTICAST_QUERIER) &&
+	if (brmctx->multicast_querier &&
 	    other_query && !timer_pending(&other_query->timer)) {
 		lmi = now + brmctx->multicast_last_member_interval;
 		pg->grp_query_rexmit_cnt = brmctx->multicast_last_member_count - 1;
@@ -3316,7 +3317,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 	if (timer_pending(&other_query->timer))
 		goto out;
 
-	if (br_opt_get(brmctx->br, BROPT_MULTICAST_QUERIER)) {
+	if (brmctx->multicast_querier) {
 		__br_multicast_send_query(brmctx, pmctx, NULL, NULL, &mp->addr,
 					  false, 0, NULL);
 
@@ -4300,10 +4301,10 @@ int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
 	val = !!val;
 
 	spin_lock_bh(&br->multicast_lock);
-	if (br_opt_get(br, BROPT_MULTICAST_QUERIER) == val)
+	if (brmctx->multicast_querier == val)
 		goto unlock;
 
-	br_opt_toggle(br, BROPT_MULTICAST_QUERIER, !!val);
+	WRITE_ONCE(brmctx->multicast_querier, val);
 	if (!val)
 		goto unlock;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6cfb0b7cad82..92c79eb16905 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1645,7 +1645,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERY_USE_IFADDR,
 		       br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERIER,
-		       br_opt_get(br, BROPT_MULTICAST_QUERIER)) ||
+		       READ_ONCE(br->multicast_ctx.multicast_querier)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_STATS_ENABLED,
 		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED)) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_ELASTICITY, RHT_ELASTICITY) ||
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4cdd71526145..50f38d6f586d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -118,6 +118,7 @@ struct net_bridge_mcast {
 	u32				multicast_last_member_count;
 	u32				multicast_startup_query_count;
 
+	u8				multicast_querier;
 	u8				multicast_igmp_version;
 	u8				multicast_router;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -439,7 +440,6 @@ enum net_bridge_opts {
 	BROPT_NF_CALL_ARPTABLES,
 	BROPT_GROUP_ADDR_SET,
 	BROPT_MULTICAST_ENABLED,
-	BROPT_MULTICAST_QUERIER,
 	BROPT_MULTICAST_QUERY_USE_IFADDR,
 	BROPT_MULTICAST_STATS_ENABLED,
 	BROPT_HAS_IPV6_ADDR,
@@ -1041,7 +1041,7 @@ __br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
 {
 	bool own_querier_enabled;
 
-	if (br_opt_get(brmctx->br, BROPT_MULTICAST_QUERIER)) {
+	if (READ_ONCE(brmctx->multicast_querier)) {
 		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
 			own_querier_enabled = false;
 		else
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 08e31debd6f2..570edfd391f4 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -447,7 +447,7 @@ static ssize_t multicast_querier_show(struct device *d,
 				      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_MULTICAST_QUERIER));
+	return sprintf(buf, "%d\n", READ_ONCE(br->multicast_ctx.multicast_querier));
 }
 
 static int set_multicast_querier(struct net_bridge *br, unsigned long val,
-- 
2.31.1

