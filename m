Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TeTQaQd3z2Cccwv3G3CrgO+5zsooPcEUxakyuy0bm98=;
 b=MZMqAvEpQsRIuTQTQqsl2ETxt+vBn/2ApuEikXtbce+QH0nZ7vKoVA7RZ4s3Y4jJkx
 HW/rYOBzNNONe1OpQ46CSziTUi7pOZ6j5zlbWGdAggV5tXMjWtTnAsnLbPJbZBhP6feo
 cYRvdlV5kgtRxLc80WwsBljOfPVBoUGyxsnhp46BAOvXRSLPTvngdg5h3XGMzNKXUB8D
 5gjFnzzeGyTCoO8W4jdohcXT5mx32TRHUrrE62e4kdmVTZA68IlhdZAkviAfZcPdUiJo
 grGAZyC2fbBGbUbuNAOOrjY8vXoR+DMbA580HQ101OPXVJgGgqNY5Vjb/aOmuQVD7JDp
 v0lQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:19 +0300
Message-Id: <20210810152933.178325-2-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 01/15] net: bridge: vlan: add support for
	mcast igmp/mld version global options
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

Add support to change and retrieve global vlan IGMP/MLD versions.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  2 ++
 net/bridge/br_multicast.c      | 18 ++++++++-------
 net/bridge/br_netlink.c        |  6 +++--
 net/bridge/br_private.h        | 26 ++++++++++++++++++++--
 net/bridge/br_sysfs_br.c       |  4 ++--
 net/bridge/br_vlan_options.c   | 40 ++++++++++++++++++++++++++++++++--
 6 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f7997a3f7f82..07acfcc0466c 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -549,6 +549,8 @@ enum {
 	BRIDGE_VLANDB_GOPTS_ID,
 	BRIDGE_VLANDB_GOPTS_RANGE,
 	BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING,
+	BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
+	BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 470f1ec3b579..643b69d767f7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4327,7 +4327,8 @@ int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
 	return 0;
 }
 
-int br_multicast_set_igmp_version(struct net_bridge *br, unsigned long val)
+int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
+				  unsigned long val)
 {
 	/* Currently we support only version 2 and 3 */
 	switch (val) {
@@ -4338,15 +4339,16 @@ int br_multicast_set_igmp_version(struct net_bridge *br, unsigned long val)
 		return -EINVAL;
 	}
 
-	spin_lock_bh(&br->multicast_lock);
-	br->multicast_ctx.multicast_igmp_version = val;
-	spin_unlock_bh(&br->multicast_lock);
+	spin_lock_bh(&brmctx->br->multicast_lock);
+	brmctx->multicast_igmp_version = val;
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return 0;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-int br_multicast_set_mld_version(struct net_bridge *br, unsigned long val)
+int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
+				 unsigned long val)
 {
 	/* Currently we support version 1 and 2 */
 	switch (val) {
@@ -4357,9 +4359,9 @@ int br_multicast_set_mld_version(struct net_bridge *br, unsigned long val)
 		return -EINVAL;
 	}
 
-	spin_lock_bh(&br->multicast_lock);
-	br->multicast_ctx.multicast_mld_version = val;
-	spin_unlock_bh(&br->multicast_lock);
+	spin_lock_bh(&brmctx->br->multicast_lock);
+	brmctx->multicast_mld_version = val;
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return 0;
 }
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3d5860e41084..6cfb0b7cad82 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1443,7 +1443,8 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		__u8 igmp_version;
 
 		igmp_version = nla_get_u8(data[IFLA_BR_MCAST_IGMP_VERSION]);
-		err = br_multicast_set_igmp_version(br, igmp_version);
+		err = br_multicast_set_igmp_version(&br->multicast_ctx,
+						    igmp_version);
 		if (err)
 			return err;
 	}
@@ -1453,7 +1454,8 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		__u8 mld_version;
 
 		mld_version = nla_get_u8(data[IFLA_BR_MCAST_MLD_VERSION]);
-		err = br_multicast_set_mld_version(br, mld_version);
+		err = br_multicast_set_mld_version(&br->multicast_ctx,
+						   mld_version);
 		if (err)
 			return err;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 762e7220cc2d..1cc00d2f9156 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -896,9 +896,11 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack);
 int br_multicast_set_querier(struct net_bridge *br, unsigned long val);
 int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val);
-int br_multicast_set_igmp_version(struct net_bridge *br, unsigned long val);
+int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
+				  unsigned long val);
 #if IS_ENABLED(CONFIG_IPV6)
-int br_multicast_set_mld_version(struct net_bridge *br, unsigned long val);
+int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
+				 unsigned long val);
 #endif
 struct net_bridge_mdb_entry *
 br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
@@ -1178,6 +1180,19 @@ br_multicast_port_ctx_state_stopped(const struct net_bridge_mcast_port *pmctx)
 	       (br_multicast_port_ctx_is_vlan(pmctx) &&
 		pmctx->vlan->state == BR_STATE_BLOCKING);
 }
+
+static inline bool
+br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
+			       const struct net_bridge_mcast *brmctx2)
+{
+	return brmctx1->multicast_igmp_version ==
+	       brmctx2->multicast_igmp_version &&
+#if IS_ENABLED(CONFIG_IPV6)
+	       brmctx1->multicast_mld_version ==
+	       brmctx2->multicast_mld_version &&
+#endif
+	       true;
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
@@ -1343,6 +1358,13 @@ static inline int br_mdb_replay(struct net_device *br_dev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool
+br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
+			       const struct net_bridge_mcast *brmctx2)
+{
+	return true;
+}
 #endif
 
 /* br_vlan.c */
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 953d544663d5..08e31debd6f2 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -520,7 +520,7 @@ static ssize_t multicast_igmp_version_show(struct device *d,
 static int set_multicast_igmp_version(struct net_bridge *br, unsigned long val,
 				      struct netlink_ext_ack *extack)
 {
-	return br_multicast_set_igmp_version(br, val);
+	return br_multicast_set_igmp_version(&br->multicast_ctx, val);
 }
 
 static ssize_t multicast_igmp_version_store(struct device *d,
@@ -757,7 +757,7 @@ static ssize_t multicast_mld_version_show(struct device *d,
 static int set_multicast_mld_version(struct net_bridge *br, unsigned long val,
 				     struct netlink_ext_ack *extack)
 {
-	return br_multicast_set_mld_version(br, val);
+	return br_multicast_set_mld_version(&br->multicast_ctx, val);
 }
 
 static ssize_t multicast_mld_version_store(struct device *d,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 4ef975b20185..ac32fb40b7ba 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -264,7 +264,9 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 {
 	return v_curr->vid - r_end->vid == 1 &&
 	       ((v_curr->priv_flags ^ r_end->priv_flags) &
-		BR_VLFLAG_GLOBAL_MCAST_ENABLED) == 0;
+		BR_VLFLAG_GLOBAL_MCAST_ENABLED) == 0 &&
+		br_multicast_ctx_options_equal(&v_curr->br_mcast_ctx,
+					       &r_end->br_mcast_ctx);
 }
 
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
@@ -285,8 +287,16 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING,
-		       !!(v_opts->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED)))
+		       !!(v_opts->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED)) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
+		       v_opts->br_mcast_ctx.multicast_igmp_version))
+		goto out_err;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
+		       v_opts->br_mcast_ctx.multicast_mld_version))
 		goto out_err;
+#endif
 #endif
 
 	nla_nest_end(skb, nest);
@@ -305,6 +315,8 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u16)) /* BRIDGE_VLANDB_GOPTS_ID */
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
@@ -359,6 +371,8 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 					   bool *changed,
 					   struct netlink_ext_ack *extack)
 {
+	int err __maybe_unused;
+
 	*changed = false;
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]) {
@@ -368,6 +382,26 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 		if (br_multicast_toggle_global_vlan(v, !!mc_snooping))
 			*changed = true;
 	}
+	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
+		u8 ver;
+
+		ver = nla_get_u8(tb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]);
+		err = br_multicast_set_igmp_version(&v->br_mcast_ctx, ver);
+		if (err)
+			return err;
+		*changed = true;
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]) {
+		u8 ver;
+
+		ver = nla_get_u8(tb[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]);
+		err = br_multicast_set_mld_version(&v->br_mcast_ctx, ver);
+		if (err)
+			return err;
+		*changed = true;
+	}
+#endif
 #endif
 
 	return 0;
@@ -377,6 +411,8 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_ID]	= { .type = NLA_U16 },
 	[BRIDGE_VLANDB_GOPTS_RANGE]	= { .type = NLA_U16 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
 };
 
 int br_vlan_rtm_process_global_options(struct net_device *dev,
-- 
2.31.1

