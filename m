Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sA3i/DFYE/hSzQxbSQrUuqb132gH/yVBEXFVOQINxvo=;
	b=PlPQ5/TaKcNrbrbLUVvritrFQgVNnHuzvS3UWk6BNTwvdpM+K1nAp9AKdcNSi//hjJ
	GRpNxp5y4lBeol8WHeJAQmf4R0Tq0u2ZRI1TkKltMsEEN/LjP/9ABaxkTupl+PFvt8lt
	136cEtk/7DcpRbll3o7ZBROaNwC8Z8WwBOF50=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:01:00 +0300
Message-Id: <20180926140107.10218-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 2/9] net: bridge: add bitfield for
	options and convert vlan opts
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

Bridge options have usually been added as separate fields all over the
net_bridge struct taking up space and ending up in different cache lines.
Let's move them to a single bitfield to save up space and speedup lookups.
This patch adds a simple API for option modifying and retrieving using
bitops and converts the first user of the API - the bridge vlan options
(vlan_enabled and vlan_stats_enabled).

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/bridge/br.c          | 16 ++++++++++++++++
 net/bridge/br_netlink.c  |  3 ++-
 net/bridge/br_private.h  | 16 ++++++++++++++--
 net/bridge/br_sysfs_br.c |  4 ++--
 net/bridge/br_vlan.c     | 28 +++++++++++++++-------------
 5 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index b0a0b82e2d91..e411e40333e2 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -175,6 +175,22 @@ static struct notifier_block br_switchdev_notifier = {
 	.notifier_call = br_switchdev_event,
 };
 
+void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
+{
+	bool cur = !!br_opt_get(br, opt);
+
+	br_debug(br, "toggle option: %d state: %d -> %d\n",
+		 opt, cur, on);
+
+	if (cur == on)
+		return;
+
+	if (on)
+		set_bit(opt, &br->options);
+	else
+		clear_bit(opt, &br->options);
+}
+
 static void __net_exit br_net_exit(struct net *net)
 {
 	struct net_device *dev;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index ec2b58a09f76..6a53caff2d31 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1416,7 +1416,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	if (nla_put_be16(skb, IFLA_BR_VLAN_PROTOCOL, br->vlan_proto) ||
 	    nla_put_u16(skb, IFLA_BR_VLAN_DEFAULT_PVID, br->default_pvid) ||
-	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_ENABLED, br->vlan_stats_enabled))
+	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_ENABLED,
+		       br_opt_get(br, BROPT_VLAN_STATS_ENABLED)))
 		return -EMSGSIZE;
 #endif
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 522d707cc533..0abb632283ff 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,16 +306,20 @@ static inline struct net_bridge_port *br_port_get_rtnl_rcu(const struct net_devi
 		rcu_dereference_rtnl(dev->rx_handler_data) : NULL;
 }
 
+enum net_bridge_opts {
+	BROPT_VLAN_ENABLED,
+	BROPT_VLAN_STATS_ENABLED,
+};
+
 struct net_bridge {
 	spinlock_t			lock;
 	spinlock_t			hash_lock;
 	struct list_head		port_list;
 	struct net_device		*dev;
 	struct pcpu_sw_netstats		__percpu *stats;
+	unsigned long			options;
 	/* These fields are accessed on each packet */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
-	u8				vlan_enabled;
-	u8				vlan_stats_enabled;
 	__be16				vlan_proto;
 	u16				default_pvid;
 	struct net_bridge_vlan_group	__rcu *vlgrp;
@@ -489,6 +493,14 @@ static inline bool br_vlan_should_use(const struct net_bridge_vlan *v)
 	return true;
 }
 
+static inline int br_opt_get(const struct net_bridge *br,
+			     enum net_bridge_opts opt)
+{
+	return test_bit(opt, &br->options);
+}
+
+void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on);
+
 /* br_device.c */
 void br_dev_setup(struct net_device *dev);
 void br_dev_delete(struct net_device *dev, struct list_head *list);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 0318a69888d4..9f1f3866c833 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -743,7 +743,7 @@ static ssize_t vlan_filtering_show(struct device *d,
 				   char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", br->vlan_enabled);
+	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_VLAN_ENABLED));
 }
 
 static ssize_t vlan_filtering_store(struct device *d,
@@ -791,7 +791,7 @@ static ssize_t vlan_stats_enabled_show(struct device *d,
 				       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->vlan_stats_enabled);
+	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_ENABLED));
 }
 
 static ssize_t vlan_stats_enabled_store(struct device *d,
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index bb6ba794864f..61d698bfe2b7 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -386,7 +386,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 			return NULL;
 		}
 	}
-	if (br->vlan_stats_enabled) {
+	if (br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) {
 		stats = this_cpu_ptr(v->stats);
 		u64_stats_update_begin(&stats->syncp);
 		stats->tx_bytes += skb->len;
@@ -475,14 +475,14 @@ static bool __allowed_ingress(const struct net_bridge *br,
 			skb->vlan_tci |= pvid;
 
 		/* if stats are disabled we can avoid the lookup */
-		if (!br->vlan_stats_enabled)
+		if (!br_opt_get(br, BROPT_VLAN_STATS_ENABLED))
 			return true;
 	}
 	v = br_vlan_find(vg, *vid);
 	if (!v || !br_vlan_should_use(v))
 		goto drop;
 
-	if (br->vlan_stats_enabled) {
+	if (br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) {
 		stats = this_cpu_ptr(v->stats);
 		u64_stats_update_begin(&stats->syncp);
 		stats->rx_bytes += skb->len;
@@ -504,7 +504,7 @@ bool br_allowed_ingress(const struct net_bridge *br,
 	/* If VLAN filtering is disabled on the bridge, all packets are
 	 * permitted.
 	 */
-	if (!br->vlan_enabled) {
+	if (!br_opt_get(br, BROPT_VLAN_ENABLED)) {
 		BR_INPUT_SKB_CB(skb)->vlan_filtered = false;
 		return true;
 	}
@@ -538,7 +538,7 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 	struct net_bridge *br = p->br;
 
 	/* If filtering was disabled at input, let it pass. */
-	if (!br->vlan_enabled)
+	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return true;
 
 	vg = nbp_vlan_group_rcu(p);
@@ -699,7 +699,8 @@ static void recalculate_group_addr(struct net_bridge *br)
 		return;
 
 	spin_lock_bh(&br->lock);
-	if (!br->vlan_enabled || br->vlan_proto == htons(ETH_P_8021Q)) {
+	if (!br_opt_get(br, BROPT_VLAN_ENABLED) ||
+	    br->vlan_proto == htons(ETH_P_8021Q)) {
 		/* Bridge Group Address */
 		br->group_addr[5] = 0x00;
 	} else { /* vlan_enabled && ETH_P_8021AD */
@@ -712,7 +713,8 @@ static void recalculate_group_addr(struct net_bridge *br)
 /* Must be protected by RTNL. */
 void br_recalculate_fwd_mask(struct net_bridge *br)
 {
-	if (!br->vlan_enabled || br->vlan_proto == htons(ETH_P_8021Q))
+	if (!br_opt_get(br, BROPT_VLAN_ENABLED) ||
+	    br->vlan_proto == htons(ETH_P_8021Q))
 		br->group_fwd_mask_required = BR_GROUPFWD_DEFAULT;
 	else /* vlan_enabled && ETH_P_8021AD */
 		br->group_fwd_mask_required = BR_GROUPFWD_8021AD &
@@ -729,14 +731,14 @@ int __br_vlan_filter_toggle(struct net_bridge *br, unsigned long val)
 	};
 	int err;
 
-	if (br->vlan_enabled == val)
+	if (br_opt_get(br, BROPT_VLAN_ENABLED) == !!val)
 		return 0;
 
 	err = switchdev_port_attr_set(br->dev, &attr);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	br->vlan_enabled = val;
+	br_opt_toggle(br, BROPT_VLAN_ENABLED, !!val);
 	br_manage_promisc(br);
 	recalculate_group_addr(br);
 	br_recalculate_fwd_mask(br);
@@ -753,7 +755,7 @@ bool br_vlan_enabled(const struct net_device *dev)
 {
 	struct net_bridge *br = netdev_priv(dev);
 
-	return !!br->vlan_enabled;
+	return br_opt_get(br, BROPT_VLAN_ENABLED);
 }
 EXPORT_SYMBOL_GPL(br_vlan_enabled);
 
@@ -819,7 +821,7 @@ int br_vlan_set_stats(struct net_bridge *br, unsigned long val)
 	switch (val) {
 	case 0:
 	case 1:
-		br->vlan_stats_enabled = val;
+		br_opt_toggle(br, BROPT_VLAN_STATS_ENABLED, !!val);
 		break;
 	default:
 		return -EINVAL;
@@ -964,7 +966,7 @@ int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val)
 		goto out;
 
 	/* Only allow default pvid change when filtering is disabled */
-	if (br->vlan_enabled) {
+	if (br_opt_get(br, BROPT_VLAN_ENABLED)) {
 		pr_info_once("Please disable vlan filtering to change default_pvid\n");
 		err = -EPERM;
 		goto out;
@@ -1018,7 +1020,7 @@ int nbp_vlan_init(struct net_bridge_port *p)
 		.orig_dev = p->br->dev,
 		.id = SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
 		.flags = SWITCHDEV_F_SKIP_EOPNOTSUPP,
-		.u.vlan_filtering = p->br->vlan_enabled,
+		.u.vlan_filtering = br_opt_get(p->br, BROPT_VLAN_ENABLED),
 	};
 	struct net_bridge_vlan_group *vg;
 	int ret = -ENOMEM;
-- 
2.11.0

