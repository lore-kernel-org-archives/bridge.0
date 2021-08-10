Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LAscvoBUzbxYWL/Sw9h/x/xIRZsYobJ3NT1ExxgA3/4=;
 b=MErF5S0FLDij7jscT7QSyChFZL/eAutFn8KvtXlWUw4Dl9Vpy4M9QoO4QsCI01Ivex
 LcvGqqLweumx0pde8PGo6ZdlGDgIgVVlxmuvV2SpmH+0Ysj+RcpaX63UQMJm+Buv9jVK
 T3AyGXDNxqOq4fo6WY1eAQ5IERVqa1aaebjzhwbiTeeC07IMnmF+ZizutIPpOYUs36vP
 gTosucaqv0ER7msfugwAbiYk0ktDkwqUZdGKo7AD2gWBkEjAwxyRES7jKvlw81mgBvAq
 dVwJIog2I+R+ANmKUNFzOVoC6vrA2wg4o36F+A7oMk9f62KmE6fEilsYXxXWkIalBIAa
 CsKQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:30 +0300
Message-Id: <20210810152933.178325-13-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 12/15] net: bridge: vlan: add support for
	mcast querier global option
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

Add support to change and retrieve global vlan multicast querier state.
We just need to pass multicast context to br_multicast_set_querier
instead of bridge device and the rest of the logic remains the same.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_multicast.c      |  7 +++----
 net/bridge/br_netlink.c        |  5 +++--
 net/bridge/br_private.h        |  5 +++--
 net/bridge/br_sysfs_br.c       |  4 ++--
 net/bridge/br_vlan_options.c   | 15 ++++++++++++++-
 6 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index ea8773cce9e9..ee691a0bc067 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -560,6 +560,7 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL,
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL,
 	BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL,
+	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f30c2e5d3142..a780ad8aca37 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4297,14 +4297,13 @@ bool br_multicast_router(const struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(br_multicast_router);
 
-int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
+int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 {
-	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
 	unsigned long max_delay;
 
 	val = !!val;
 
-	spin_lock_bh(&br->multicast_lock);
+	spin_lock_bh(&brmctx->br->multicast_lock);
 	if (brmctx->multicast_querier == val)
 		goto unlock;
 
@@ -4327,7 +4326,7 @@ int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
 #endif
 
 unlock:
-	spin_unlock_bh(&br->multicast_lock);
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return 0;
 }
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 92c79eb16905..1d8ff9bbbd2f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1372,7 +1372,8 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_MCAST_QUERIER]) {
 		u8 mcast_querier = nla_get_u8(data[IFLA_BR_MCAST_QUERIER]);
 
-		err = br_multicast_set_querier(br, mcast_querier);
+		err = br_multicast_set_querier(&br->multicast_ctx,
+					       mcast_querier);
 		if (err)
 			return err;
 	}
@@ -1645,7 +1646,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERY_USE_IFADDR,
 		       br_opt_get(br, BROPT_MULTICAST_QUERY_USE_IFADDR)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERIER,
-		       READ_ONCE(br->multicast_ctx.multicast_querier)) ||
+		       br->multicast_ctx.multicast_querier) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_STATS_ENABLED,
 		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED)) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_ELASTICITY, RHT_ELASTICITY) ||
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 25db6b02b042..76adb729e58c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -894,7 +894,7 @@ int br_multicast_set_router(struct net_bridge *br, unsigned long val);
 int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val);
 int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack);
-int br_multicast_set_querier(struct net_bridge *br, unsigned long val);
+int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val);
 int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val);
 int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
 				  unsigned long val);
@@ -1041,7 +1041,7 @@ __br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
 {
 	bool own_querier_enabled;
 
-	if (READ_ONCE(brmctx->multicast_querier)) {
+	if (brmctx->multicast_querier) {
 		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
 			own_querier_enabled = false;
 		else
@@ -1203,6 +1203,7 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 	       brmctx2->multicast_query_response_interval &&
 	       brmctx1->multicast_startup_query_interval ==
 	       brmctx2->multicast_startup_query_interval &&
+	       brmctx1->multicast_querier == brmctx2->multicast_querier &&
 #if IS_ENABLED(CONFIG_IPV6)
 	       brmctx1->multicast_mld_version ==
 	       brmctx2->multicast_mld_version &&
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 570edfd391f4..e1234bd8d5a0 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -447,13 +447,13 @@ static ssize_t multicast_querier_show(struct device *d,
 				      char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", READ_ONCE(br->multicast_ctx.multicast_querier));
+	return sprintf(buf, "%d\n", br->multicast_ctx.multicast_querier);
 }
 
 static int set_multicast_querier(struct net_bridge *br, unsigned long val,
 				 struct netlink_ext_ack *extack)
 {
-	return br_multicast_set_querier(br, val);
+	return br_multicast_set_querier(&br->multicast_ctx, val);
 }
 
 static ssize_t multicast_querier_store(struct device *d,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 7b8dfd138045..0d0db8ddae45 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -294,7 +294,9 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
 			v_opts->br_mcast_ctx.multicast_last_member_count) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
-			v_opts->br_mcast_ctx.multicast_startup_query_count))
+			v_opts->br_mcast_ctx.multicast_startup_query_count) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
+		       v_opts->br_mcast_ctx.multicast_querier))
 		goto out_err;
 
 	clockval = jiffies_to_clock_t(v_opts->br_mcast_ctx.multicast_last_member_interval);
@@ -355,6 +357,7 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
@@ -485,6 +488,15 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 		v->br_mcast_ctx.multicast_startup_query_interval = clock_t_to_jiffies(val);
 		*changed = true;
 	}
+	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER]) {
+		u8 val;
+
+		val = nla_get_u8(tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER]);
+		err = br_multicast_set_querier(&v->br_mcast_ctx, val);
+		if (err)
+			return err;
+		*changed = true;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]) {
 		u8 ver;
@@ -507,6 +519,7 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]	= { .type = NLA_U64 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]	= { .type = NLA_U32 },
-- 
2.31.1

