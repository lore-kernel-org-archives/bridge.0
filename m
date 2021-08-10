Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IZO6z66xLg3R8sWrzBKsMRKlDrBnbnQRa4M++exAkMo=;
 b=U3YhjEsyGh+3W1n7NDESfIfndxgRvy02BBNO91BdSVT4m3GoViD/inNT5so3wdY2Ha
 v+Nk2Xzdte5gbGxNzod489of6jsm+trOKm1iZknoev0889LOyq0PtreBqYKXuDfvJTRb
 7HiGitzf/yhQP3hgcQNivLVe59B1Kc9y6YLfnP0kvS8kmmnGnvPXAE1cxV/G6jlzBT/a
 IOyEKGWReMASxm6EzQ1LS5siGd6keBxcjvBWX3tY1kKhFaiCX846YViz+opD57g+/wkG
 OVYlW74GtSbrrTNNKRkqgN1xZl2BMuD+4AtnlshWrmEA3XUyTF/2hQHNI7YlmtESndQ9
 v0mA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:21 +0300
Message-Id: <20210810152933.178325-4-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 03/15] net: bridge: vlan: add support for
	mcast startup query count global option
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

Add support to change and retrieve global vlan multicast startup query
count option.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_private.h        |  2 ++
 net/bridge/br_vlan_options.c   | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 68099c6bc186..62d30153e343 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -552,6 +552,7 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 	BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
 	BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
+	BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ca88609c51b7..560c57dd33db 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1189,6 +1189,8 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 	       brmctx2->multicast_igmp_version &&
 	       brmctx1->multicast_last_member_count ==
 	       brmctx2->multicast_last_member_count &&
+	       brmctx1->multicast_startup_query_count ==
+	       brmctx2->multicast_startup_query_count &&
 #if IS_ENABLED(CONFIG_IPV6)
 	       brmctx1->multicast_mld_version ==
 	       brmctx2->multicast_mld_version &&
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 75733b5bc6f4..81a0988b97c1 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -291,7 +291,9 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 		       v_opts->br_mcast_ctx.multicast_igmp_version) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
-			v_opts->br_mcast_ctx.multicast_last_member_count))
+			v_opts->br_mcast_ctx.multicast_last_member_count) ||
+	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
+			v_opts->br_mcast_ctx.multicast_startup_query_count))
 		goto out_err;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -320,6 +322,7 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION */
 		+ nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT */
+		+ nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
@@ -401,6 +404,13 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 		v->br_mcast_ctx.multicast_last_member_count = cnt;
 		*changed = true;
 	}
+	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]) {
+		u32 cnt;
+
+		cnt = nla_get_u32(tb[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]);
+		v->br_mcast_ctx.multicast_startup_query_count = cnt;
+		*changed = true;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]) {
 		u8 ver;
@@ -424,6 +434,7 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT]	= { .type = NLA_U32 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]	= { .type = NLA_U32 },
 };
 
 int br_vlan_rtm_process_global_options(struct net_device *dev,
-- 
2.31.1

