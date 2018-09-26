Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VvVwyeHFPsNJFg6V8qGKU698BAlOaSrJEv20zsO40Lk=;
	b=GrWS2Ho8knzL3/rlENzCestI8iWTE8esSGiJ9YNXgWbF3k+daO8ybx/W4FwwREC8YH
	RCMnz0v6v37w4b90arLtpXvQEQJYOp8KfOWv5PK3e06fYOIMnKKJoZI+LZuBpGZjRoaM
	zG8QWVqOqePRnV/51s8BlUjlL9EXS2GJbPN8E=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:01:04 +0300
Message-Id: <20180926140107.10218-7-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 6/9] net: bridge: convert mcast options
	to bits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@idosch.org, davem@davemloft.net

This patch converts the rest of the mcast options to bits. It also packs
the mcast options a little better by moving multicast_mld_version to an
existing hole, reducing the net_bridge size by 8 bytes.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/bridge/br_multicast.c | 22 ++++++++++------------
 net/bridge/br_netlink.c   | 11 ++++++-----
 net/bridge/br_private.h   | 20 ++++++++++----------
 net/bridge/br_sysfs_br.c  | 12 +++++++-----
 4 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ed6c33adc747..928024d8360d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -411,7 +411,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge *br,
 	iph->frag_off = htons(IP_DF);
 	iph->ttl = 1;
 	iph->protocol = IPPROTO_IGMP;
-	iph->saddr = br->multicast_query_use_ifaddr ?
+	iph->saddr = br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR) ?
 		     inet_select_addr(br->dev, 0, RT_SCOPE_LINK) : 0;
 	iph->daddr = htonl(INADDR_ALLHOSTS_GROUP);
 	((u8 *)&iph[1])[0] = IPOPT_RA;
@@ -503,11 +503,11 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge *br,
 	if (ipv6_dev_get_saddr(dev_net(br->dev), br->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
 		kfree_skb(skb);
-		br->has_ipv6_addr = 0;
+		br_opt_toggle(br, BROPT_HAS_IPV6_ADDR, false);
 		return NULL;
 	}
 
-	br->has_ipv6_addr = 1;
+	br_opt_toggle(br, BROPT_HAS_IPV6_ADDR, true);
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
 	hopopt = (u8 *)(ip6h + 1);
@@ -967,7 +967,7 @@ static void br_multicast_send_query(struct net_bridge *br,
 
 	if (!netif_running(br->dev) ||
 	    !br_opt_get(br, BROPT_MULTICAST_ENABLED) ||
-	    !br->multicast_querier)
+	    !br_opt_get(br, BROPT_MULTICAST_QUERIER))
 		return;
 
 	memset(&br_group.u, 0, sizeof(br_group.u));
@@ -1636,7 +1636,7 @@ br_multicast_leave_group(struct net_bridge *br,
 	if (timer_pending(&other_query->timer))
 		goto out;
 
-	if (br->multicast_querier) {
+	if (br_opt_get(br, BROPT_MULTICAST_QUERIER)) {
 		__br_multicast_send_query(br, port, &mp->addr);
 
 		time = jiffies + br->multicast_last_member_count *
@@ -1748,7 +1748,7 @@ static void br_multicast_err_count(const struct net_bridge *br,
 	struct bridge_mcast_stats __percpu *stats;
 	struct bridge_mcast_stats *pstats;
 
-	if (!br->multicast_stats_enabled)
+	if (!br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED))
 		return;
 
 	if (p)
@@ -1958,8 +1958,6 @@ void br_multicast_init(struct net_bridge *br)
 	br->hash_max = 512;
 
 	br->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
-	br->multicast_querier = 0;
-	br->multicast_query_use_ifaddr = 0;
 	br->multicast_last_member_count = 2;
 	br->multicast_startup_query_count = 2;
 
@@ -1978,7 +1976,7 @@ void br_multicast_init(struct net_bridge *br)
 	br->ip6_other_query.delay_time = 0;
 	br->ip6_querier.port = NULL;
 #endif
-	br->has_ipv6_addr = 1;
+	br_opt_toggle(br, BROPT_HAS_IPV6_ADDR, true);
 
 	spin_lock_init(&br->multicast_lock);
 	timer_setup(&br->multicast_router_timer,
@@ -2238,10 +2236,10 @@ int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
 	val = !!val;
 
 	spin_lock_bh(&br->multicast_lock);
-	if (br->multicast_querier == val)
+	if (br_opt_get(br, BROPT_MULTICAST_QUERIER) == val)
 		goto unlock;
 
-	br->multicast_querier = val;
+	br_opt_toggle(br, BROPT_MULTICAST_QUERIER, !!val);
 	if (!val)
 		goto unlock;
 
@@ -2562,7 +2560,7 @@ void br_multicast_count(struct net_bridge *br, const struct net_bridge_port *p,
 	struct bridge_mcast_stats __percpu *stats;
 
 	/* if multicast_disabled is true then igmp type can't be set */
-	if (!type || !br->multicast_stats_enabled)
+	if (!type || !br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED))
 		return;
 
 	if (p)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1d276b7b27e0..e5a5bc5d5232 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1167,7 +1167,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		u8 val;
 
 		val = nla_get_u8(data[IFLA_BR_MCAST_QUERY_USE_IFADDR]);
-		br->multicast_query_use_ifaddr = !!val;
+		br_opt_toggle(br, BROPT_MULTICAST_QUERY_USE_IFADDR, !!val);
 	}
 
 	if (data[IFLA_BR_MCAST_QUERIER]) {
@@ -1244,7 +1244,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		__u8 mcast_stats;
 
 		mcast_stats = nla_get_u8(data[IFLA_BR_MCAST_STATS_ENABLED]);
-		br->multicast_stats_enabled = !!mcast_stats;
+		br_opt_toggle(br, BROPT_MULTICAST_STATS_ENABLED, !!mcast_stats);
 	}
 
 	if (data[IFLA_BR_MCAST_IGMP_VERSION]) {
@@ -1425,10 +1425,11 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_SNOOPING,
 		       br_opt_get(br, BROPT_MULTICAST_ENABLED)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERY_USE_IFADDR,
-		       br->multicast_query_use_ifaddr) ||
-	    nla_put_u8(skb, IFLA_BR_MCAST_QUERIER, br->multicast_querier) ||
+		       br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR)) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_QUERIER,
+		       br_opt_get(br, BROPT_MULTICAST_QUERIER)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_STATS_ENABLED,
-		       br->multicast_stats_enabled) ||
+		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED)) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_ELASTICITY,
 			br->hash_elasticity) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_MAX, br->hash_max) ||
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index fb1a266cdac8..e6bdb107fe04 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -314,6 +314,10 @@ enum net_bridge_opts {
 	BROPT_NF_CALL_ARPTABLES,
 	BROPT_GROUP_ADDR_SET,
 	BROPT_MULTICAST_ENABLED,
+	BROPT_MULTICAST_QUERIER,
+	BROPT_MULTICAST_QUERY_USE_IFADDR,
+	BROPT_MULTICAST_STATS_ENABLED,
+	BROPT_HAS_IPV6_ADDR,
 };
 
 struct net_bridge {
@@ -365,12 +369,6 @@ struct net_bridge {
 	} stp_enabled;
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
-	unsigned char			multicast_router;
-
-	u8				multicast_querier:1;
-	u8				multicast_query_use_ifaddr:1;
-	u8				has_ipv6_addr:1;
-	u8				multicast_stats_enabled:1;
 
 	u32				hash_elasticity;
 	u32				hash_max;
@@ -379,7 +377,10 @@ struct net_bridge {
 	u32				multicast_startup_query_count;
 
 	u8				multicast_igmp_version;
-
+	u8				multicast_router;
+#if IS_ENABLED(CONFIG_IPV6)
+	u8				multicast_mld_version;
+#endif
 	unsigned long			multicast_last_member_interval;
 	unsigned long			multicast_membership_interval;
 	unsigned long			multicast_querier_interval;
@@ -400,7 +401,6 @@ struct net_bridge {
 	struct bridge_mcast_other_query	ip6_other_query;
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
-	u8				multicast_mld_version;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 #endif
 
@@ -707,8 +707,8 @@ __br_multicast_querier_exists(struct net_bridge *br,
 {
 	bool own_querier_enabled;
 
-	if (br->multicast_querier) {
-		if (is_ipv6 && !br->has_ipv6_addr)
+	if (br_opt_get(br, BROPT_MULTICAST_QUERIER)) {
+		if (is_ipv6 && !br_opt_get(br, BROPT_HAS_IPV6_ADDR))
 			own_querier_enabled = false;
 		else
 			own_querier_enabled = true;
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index bf6f409a83e1..c93c5724609e 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -365,12 +365,13 @@ static ssize_t multicast_query_use_ifaddr_show(struct device *d,
 					       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->multicast_query_use_ifaddr);
+	return sprintf(buf, "%d\n",
+		       br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR));
 }
 
 static int set_query_use_ifaddr(struct net_bridge *br, unsigned long val)
 {
-	br->multicast_query_use_ifaddr = !!val;
+	br_opt_toggle(br, BROPT_MULTICAST_QUERY_USE_IFADDR, !!val);
 	return 0;
 }
 
@@ -388,7 +389,7 @@ static ssize_t multicast_querier_show(struct device *d,
 				      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->multicast_querier);
+	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_MULTICAST_QUERIER));
 }
 
 static ssize_t multicast_querier_store(struct device *d,
@@ -636,12 +637,13 @@ static ssize_t multicast_stats_enabled_show(struct device *d,
 {
 	struct net_bridge *br = to_bridge(d);
 
-	return sprintf(buf, "%u\n", br->multicast_stats_enabled);
+	return sprintf(buf, "%d\n",
+		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED));
 }
 
 static int set_stats_enabled(struct net_bridge *br, unsigned long val)
 {
-	br->multicast_stats_enabled = !!val;
+	br_opt_toggle(br, BROPT_MULTICAST_STATS_ENABLED, !!val);
 	return 0;
 }
 
-- 
2.11.0

