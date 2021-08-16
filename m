Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gu3qPVqazrfPsLrdaA6zNjrUNMRsdA16rRPDc2bNkUw=;
 b=FuV+Ic3USr2PZi1PnKLkMugVAAt5b6+5NCSahnq3tBRmBe/bcNvT2wFZVSDo+FzS8D
 cM5uGmbJq7o1jfdbiMacajfbGNb1f5R+Smvdjtzrv5N0gitZG+KFycHfxnQWU3eQrLRB
 6dd6lfis26okjtBo811z5I8wcdLqoIVkrBaMuwHmp8CTl0GsaIy5JWFL8X5SxWM36hqG
 o2w6cQecfztfIUAS9pd0m0xmUPAzuu2HMUj1Uq1StplPP9WUozgBq7wwXYmgcA2PMVUc
 tcnvz1IL9FhSnI2v0GR3HBY3541g2J988f3/Cjq2nyQ8wXz4b1/FSZhSZGinCEHG+XQj
 Lyww==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 17:57:05 +0300
Message-Id: <20210816145707.671901-3-razor@blackwall.org>
In-Reply-To: <20210816145707.671901-1-razor@blackwall.org>
References: <20210816145707.671901-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/4] net: bridge: vlan: account for router
	port lists when notifying
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

When sending a global vlan notification we should account for the number
of router ports when allocating the skb, otherwise we might end up
losing notifications.

Fixes: dc002875c22b ("net: bridge: vlan: use br_rports_fill_info() to export mcast router ports")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_mdb.c          | 30 ++++++++++++++++++++++++++++++
 net/bridge/br_private.h      |  1 +
 net/bridge/br_vlan_options.c | 17 +++++++++--------
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 389ff3c1e9d9..0281453f7766 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -37,6 +37,36 @@ br_ip6_rports_get_timer(struct net_bridge_mcast_port *pmctx,
 #endif
 }
 
+static size_t __br_rports_one_size(void)
+{
+	return nla_total_size(sizeof(u32)) + /* MDBA_ROUTER_PORT */
+	       nla_total_size(sizeof(u32)) + /* MDBA_ROUTER_PATTR_TIMER */
+	       nla_total_size(sizeof(u8)) +  /* MDBA_ROUTER_PATTR_TYPE */
+	       nla_total_size(sizeof(u32)) + /* MDBA_ROUTER_PATTR_INET_TIMER */
+	       nla_total_size(sizeof(u32)) + /* MDBA_ROUTER_PATTR_INET6_TIMER */
+	       nla_total_size(sizeof(u32));  /* MDBA_ROUTER_PATTR_VID */
+}
+
+size_t br_rports_size(const struct net_bridge_mcast *brmctx)
+{
+	struct net_bridge_mcast_port *pmctx;
+	size_t size = nla_total_size(0); /* MDBA_ROUTER */
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(pmctx, &brmctx->ip4_mc_router_list,
+				 ip4_rlist)
+		size += __br_rports_one_size();
+
+#if IS_ENABLED(CONFIG_IPV6)
+	hlist_for_each_entry_rcu(pmctx, &brmctx->ip6_mc_router_list,
+				 ip6_rlist)
+		size += __br_rports_one_size();
+#endif
+	rcu_read_unlock();
+
+	return size;
+}
+
 int br_rports_fill_info(struct sk_buff *skb,
 			const struct net_bridge_mcast *brmctx)
 {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9b1bf98a2c5a..df0fa246c80c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -952,6 +952,7 @@ int br_multicast_dump_querier_state(struct sk_buff *skb,
 				    const struct net_bridge_mcast *brmctx,
 				    int nest_attr);
 size_t br_multicast_querier_state_size(void);
+size_t br_rports_size(const struct net_bridge_mcast *brmctx);
 
 static inline bool br_group_is_l2(const struct br_ip *group)
 {
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 49dec53a4a74..a3b8a086284b 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -362,7 +362,7 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	return false;
 }
 
-static size_t rtnl_vlan_global_opts_nlmsg_size(void)
+static size_t rtnl_vlan_global_opts_nlmsg_size(const struct net_bridge_vlan *v)
 {
 	return NLMSG_ALIGN(sizeof(struct br_vlan_msg))
 		+ nla_total_size(0) /* BRIDGE_VLANDB_GLOBAL_OPTIONS */
@@ -382,6 +382,8 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER */
 		+ br_multicast_querier_state_size() /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE */
+		+ nla_total_size(0) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS */
+		+ br_rports_size(&v->br_mcast_ctx) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
@@ -398,7 +400,12 @@ static void br_vlan_global_opts_notify(const struct net_bridge *br,
 	/* right now notifications are done only with rtnl held */
 	ASSERT_RTNL();
 
-	skb = nlmsg_new(rtnl_vlan_global_opts_nlmsg_size(), GFP_KERNEL);
+	/* need to find the vlan due to flags/options */
+	v = br_vlan_find(br_vlan_group(br), vid);
+	if (!v)
+		return;
+
+	skb = nlmsg_new(rtnl_vlan_global_opts_nlmsg_size(v), GFP_KERNEL);
 	if (!skb)
 		goto out_err;
 
@@ -411,11 +418,6 @@ static void br_vlan_global_opts_notify(const struct net_bridge *br,
 	bvm->family = AF_BRIDGE;
 	bvm->ifindex = br->dev->ifindex;
 
-	/* need to find the vlan due to flags/options */
-	v = br_vlan_find(br_vlan_group(br), vid);
-	if (!v)
-		goto out_kfree;
-
 	if (!br_vlan_global_opts_fill(skb, vid, vid_range, v))
 		goto out_err;
 
@@ -425,7 +427,6 @@ static void br_vlan_global_opts_notify(const struct net_bridge *br,
 
 out_err:
 	rtnl_set_sk_err(dev_net(br->dev), RTNLGRP_BRVLAN, err);
-out_kfree:
 	kfree_skb(skb);
 }
 
-- 
2.31.1

