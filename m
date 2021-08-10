Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nO5OawzfV9xH6SjxhEhhOLYCvCdIGW3fhHV+ketAsFg=;
 b=0N9+Pj5Ut+Y4+wTnZFkox6hGU82MINDqXP3Ng5lzrP7kH7m+zGr5he6W6NQtkYTGNj
 ccTd+0UElz5/gJTLcz5vtWA3dwhoCR07ZIrME3O8vieM+OQuW1gpQyAp38mO4u869sBp
 SIIOLc/EVfFTkc3uFamfJvWCoQ4ks+MzNKUoi988vAE7TaZJ8QlBU0MeFzvcKezhi/hP
 4jnx2/UgSmBAeiNtWDc5wScUmIiUGFRe5avveimAaxF8y2IWmyF7mehJvaRfioFZOgEl
 8ojcP0ZjGU7W/ZyMnlTLVYbGWUDD3othq7rNAGgu3k7WzI2+QkyfZVRywWZ/NohQ9BJP
 UGqw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:25 +0300
Message-Id: <20210810152933.178325-8-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 07/15] net: bridge: vlan: add support for
	mcast query interval global option
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

Add support to change and retrieve global vlan multicast query interval
option.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_private.h        |  2 ++
 net/bridge/br_vlan_options.c   | 13 +++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 517967b90e1a..371f4f93aaa1 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -557,6 +557,7 @@ enum {
 	BRIDGE_VLANDB_GOPTS_PAD,
 	BRIDGE_VLANDB_GOPTS_MCAST_MEMBERSHIP_INTVL,
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_INTVL,
+	BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index df60f8ecc11d..e72805d32458 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1197,6 +1197,8 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 	       brmctx2->multicast_membership_interval &&
 	       brmctx1->multicast_querier_interval ==
 	       brmctx2->multicast_querier_interval &&
+	       brmctx1->multicast_query_interval ==
+	       brmctx2->multicast_query_interval &&
 #if IS_ENABLED(CONFIG_IPV6)
 	       brmctx1->multicast_mld_version ==
 	       brmctx2->multicast_mld_version &&
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 58ed4277cd1b..10ed84336fd7 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -309,6 +309,10 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	if (nla_put_u64_64bit(skb, BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_INTVL,
 			      clockval, BRIDGE_VLANDB_GOPTS_PAD))
 		goto out_err;
+	clockval = jiffies_to_clock_t(v_opts->br_mcast_ctx.multicast_query_interval);
+	if (nla_put_u64_64bit(skb, BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL,
+			      clockval, BRIDGE_VLANDB_GOPTS_PAD))
+		goto out_err;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
@@ -340,6 +344,7 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_INTVL */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_MEMBERSHIP_INTVL */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_INTVL */
+		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
@@ -449,6 +454,13 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 		v->br_mcast_ctx.multicast_querier_interval = clock_t_to_jiffies(val);
 		*changed = true;
 	}
+	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]) {
+		u64 val;
+
+		val = nla_get_u64(tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]);
+		v->br_mcast_ctx.multicast_query_interval = clock_t_to_jiffies(val);
+		*changed = true;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]) {
 		u8 ver;
@@ -470,6 +482,7 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_RANGE]	= { .type = NLA_U16 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]	= { .type = NLA_U64 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]	= { .type = NLA_U32 },
-- 
2.31.1

