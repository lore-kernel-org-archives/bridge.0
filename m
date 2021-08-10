Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T8/4dj9gTvHCpwB5IlUq9PwSZ51kg1bcJ4gzNVJjnFg=;
 b=z0i3d+rdvfy/LfTsEd0Cx2oQl8SSKqWVKoIyyhERUZ9JRA8r+gqF5xTO1oYKwook92
 voqqtbNyq7m1UswCT3wLGgrAfUx2J2d/GUWXbLKrSiGZfGjnn8++YCvyBiYjHIjD4zo8
 qTvQqUG9NKtqneo9KxzUW+yOD+Bi+Ot9QNbcpn2fFO/JjzMo5O1Ux/+EtSkVWs/tUhyF
 zdn8mTDnCPqQjvgicGrMgIL+RgaOSqFDxBXBBAlkau8sfjP5gxcrLziwikWwXAzwqZ6t
 o9EBz9DXXDY+AAfPLBmksE8pxBXcYn6lo6GGXDo/uO2z2V7JOcdK82PkXM6jeLhx/ACZ
 UJ6Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:31 +0300
Message-Id: <20210810152933.178325-14-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 13/15] net: bridge: vlan: add support for
	mcast router global option
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

Add support to change and retrieve global vlan multicast router state
which is used for the bridge itself. We just need to pass multicast context
to br_multicast_set_router instead of bridge device and the rest of the
logic remains the same.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_multicast.c      | 11 +++++------
 net/bridge/br_netlink.c        |  3 ++-
 net/bridge/br_private.h        |  3 ++-
 net/bridge/br_sysfs_br.c       |  2 +-
 net/bridge/br_vlan_options.c   | 15 ++++++++++++++-
 6 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index ee691a0bc067..716ce30b3ca8 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -561,6 +561,7 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL,
 	BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL,
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
+	BRIDGE_VLANDB_GOPTS_MCAST_ROUTER,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a780ad8aca37..df6bf6a237aa 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4053,17 +4053,16 @@ void br_multicast_dev_del(struct net_bridge *br)
 	rcu_barrier();
 }
 
-int br_multicast_set_router(struct net_bridge *br, unsigned long val)
+int br_multicast_set_router(struct net_bridge_mcast *brmctx, unsigned long val)
 {
-	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
 	int err = -EINVAL;
 
-	spin_lock_bh(&br->multicast_lock);
+	spin_lock_bh(&brmctx->br->multicast_lock);
 
 	switch (val) {
 	case MDB_RTR_TYPE_DISABLED:
 	case MDB_RTR_TYPE_PERM:
-		br_mc_router_state_change(br, val == MDB_RTR_TYPE_PERM);
+		br_mc_router_state_change(brmctx->br, val == MDB_RTR_TYPE_PERM);
 		del_timer(&brmctx->ip4_mc_router_timer);
 #if IS_ENABLED(CONFIG_IPV6)
 		del_timer(&brmctx->ip6_mc_router_timer);
@@ -4073,13 +4072,13 @@ int br_multicast_set_router(struct net_bridge *br, unsigned long val)
 		break;
 	case MDB_RTR_TYPE_TEMP_QUERY:
 		if (brmctx->multicast_router != MDB_RTR_TYPE_TEMP_QUERY)
-			br_mc_router_state_change(br, false);
+			br_mc_router_state_change(brmctx->br, false);
 		brmctx->multicast_router = val;
 		err = 0;
 		break;
 	}
 
-	spin_unlock_bh(&br->multicast_lock);
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return err;
 }
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1d8ff9bbbd2f..93a517410671 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1349,7 +1349,8 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_MCAST_ROUTER]) {
 		u8 multicast_router = nla_get_u8(data[IFLA_BR_MCAST_ROUTER]);
 
-		err = br_multicast_set_router(br, multicast_router);
+		err = br_multicast_set_router(&br->multicast_ctx,
+					      multicast_router);
 		if (err)
 			return err;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 76adb729e58c..f5af6b56be8f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -890,7 +890,7 @@ void br_multicast_dev_del(struct net_bridge *br);
 void br_multicast_flood(struct net_bridge_mdb_entry *mdst, struct sk_buff *skb,
 			struct net_bridge_mcast *brmctx,
 			bool local_rcv, bool local_orig);
-int br_multicast_set_router(struct net_bridge *br, unsigned long val);
+int br_multicast_set_router(struct net_bridge_mcast *brmctx, unsigned long val);
 int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val);
 int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack);
@@ -1204,6 +1204,7 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 	       brmctx1->multicast_startup_query_interval ==
 	       brmctx2->multicast_startup_query_interval &&
 	       brmctx1->multicast_querier == brmctx2->multicast_querier &&
+	       brmctx1->multicast_router == brmctx2->multicast_router &&
 #if IS_ENABLED(CONFIG_IPV6)
 	       brmctx1->multicast_mld_version ==
 	       brmctx2->multicast_mld_version &&
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index e1234bd8d5a0..d9a89ddd0331 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -390,7 +390,7 @@ static ssize_t multicast_router_show(struct device *d,
 static int set_multicast_router(struct net_bridge *br, unsigned long val,
 				struct netlink_ext_ack *extack)
 {
-	return br_multicast_set_router(br, val);
+	return br_multicast_set_router(&br->multicast_ctx, val);
 }
 
 static ssize_t multicast_router_store(struct device *d,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 0d0db8ddae45..6ba45b73931f 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -296,7 +296,9 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
 			v_opts->br_mcast_ctx.multicast_startup_query_count) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
-		       v_opts->br_mcast_ctx.multicast_querier))
+		       v_opts->br_mcast_ctx.multicast_querier) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ROUTER,
+		       v_opts->br_mcast_ctx.multicast_router))
 		goto out_err;
 
 	clockval = jiffies_to_clock_t(v_opts->br_mcast_ctx.multicast_last_member_interval);
@@ -358,6 +360,7 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
@@ -497,6 +500,15 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 			return err;
 		*changed = true;
 	}
+	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER]) {
+		u8 val;
+
+		val = nla_get_u8(tb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER]);
+		err = br_multicast_set_router(&v->br_mcast_ctx, val);
+		if (err)
+			return err;
+		*changed = true;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]) {
 		u8 ver;
@@ -520,6 +532,7 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]	= { .type = NLA_U64 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]	= { .type = NLA_U32 },
-- 
2.31.1

