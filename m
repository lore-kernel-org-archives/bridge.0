Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zzLB1cHJGbyLcBbbFOYb1kK/16n1MWFN+abWNlRC5Fc=;
	b=Ear3aaH08LBwUd872Ao1Rf+u3QoXpX34DQ8YgDBzV8cCdbmWBWsvSIPqE5ZUi1u/iG
	BdLyaJ8mMjKgFX35f1N+f8wXeQrsy/H3Nk15jDir3hIDqq2f4d853C49VOgMccNp88G1
	8pDNnp/LZhLOhPZ2pUFy6yfJKkxQK3CJzFPR4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:01:03 +0300
Message-Id: <20180926140107.10218-6-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 5/9] net: bridge: convert and rename
	mcast disabled
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

Convert mcast disabled to an option bit and while doing so convert the
logic to check if multicast is enabled instead. That is make the logic
follow the option value - if it's set then mcast is enabled and vice versa.
This avoids a few confusing places where we inverted the value that's being
set to follow the mcast_disabled logic.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/bridge/br_mdb.c       |  6 +++---
 net/bridge/br_multicast.c | 32 +++++++++++++++++---------------
 net/bridge/br_netlink.c   |  3 ++-
 net/bridge/br_private.h   |  2 +-
 net/bridge/br_sysfs_br.c  |  2 +-
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 6d9f48bd374a..a4a848bf827b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -84,7 +84,7 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 	int i, err = 0;
 	int idx = 0, s_idx = cb->args[1];
 
-	if (br->multicast_disabled)
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
 
 	mdb = rcu_dereference(br->mdb);
@@ -598,7 +598,7 @@ static int __br_mdb_add(struct net *net, struct net_bridge *br,
 	struct net_bridge_port *p;
 	int ret;
 
-	if (!netif_running(br->dev) || br->multicast_disabled)
+	if (!netif_running(br->dev) || !br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return -EINVAL;
 
 	dev = __dev_get_by_index(net, entry->ifindex);
@@ -673,7 +673,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 	struct br_ip ip;
 	int err = -EINVAL;
 
-	if (!netif_running(br->dev) || br->multicast_disabled)
+	if (!netif_running(br->dev) || !br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return -EINVAL;
 
 	__mdb_entry_to_br_ip(entry, &ip);
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 20ed7adcf1cc..ed6c33adc747 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -158,7 +158,7 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 	struct net_bridge_mdb_htable *mdb = rcu_dereference(br->mdb);
 	struct br_ip ip;
 
-	if (br->multicast_disabled)
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return NULL;
 
 	if (BR_INPUT_SKB_CB(skb)->igmp)
@@ -628,7 +628,7 @@ static struct net_bridge_mdb_entry *br_multicast_get_group(
 				port ? port->dev->name : br->dev->name);
 			err = -E2BIG;
 disable:
-			br->multicast_disabled = 1;
+			br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
 			goto err;
 		}
 	}
@@ -894,7 +894,7 @@ static void br_multicast_querier_expired(struct net_bridge *br,
 					 struct bridge_mcast_own_query *query)
 {
 	spin_lock(&br->multicast_lock);
-	if (!netif_running(br->dev) || br->multicast_disabled)
+	if (!netif_running(br->dev) || !br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		goto out;
 
 	br_multicast_start_querier(br, query);
@@ -965,7 +965,8 @@ static void br_multicast_send_query(struct net_bridge *br,
 	struct br_ip br_group;
 	unsigned long time;
 
-	if (!netif_running(br->dev) || br->multicast_disabled ||
+	if (!netif_running(br->dev) ||
+	    !br_opt_get(br, BROPT_MULTICAST_ENABLED) ||
 	    !br->multicast_querier)
 		return;
 
@@ -1036,7 +1037,7 @@ static void br_mc_disabled_update(struct net_device *dev, bool value)
 		.orig_dev = dev,
 		.id = SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 		.flags = SWITCHDEV_F_DEFER,
-		.u.mc_disabled = value,
+		.u.mc_disabled = !value,
 	};
 
 	switchdev_port_attr_set(dev, &attr);
@@ -1054,7 +1055,8 @@ int br_multicast_add_port(struct net_bridge_port *port)
 	timer_setup(&port->ip6_own_query.timer,
 		    br_ip6_multicast_port_query_expired, 0);
 #endif
-	br_mc_disabled_update(port->dev, port->br->multicast_disabled);
+	br_mc_disabled_update(port->dev,
+			      br_opt_get(port->br, BROPT_MULTICAST_ENABLED));
 
 	port->mcast_stats = netdev_alloc_pcpu_stats(struct bridge_mcast_stats);
 	if (!port->mcast_stats)
@@ -1091,7 +1093,7 @@ static void __br_multicast_enable_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 
-	if (br->multicast_disabled || !netif_running(br->dev))
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED) || !netif_running(br->dev))
 		return;
 
 	br_multicast_enable(&port->ip4_own_query);
@@ -1904,7 +1906,7 @@ int br_multicast_rcv(struct net_bridge *br, struct net_bridge_port *port,
 	BR_INPUT_SKB_CB(skb)->igmp = 0;
 	BR_INPUT_SKB_CB(skb)->mrouters_only = 0;
 
-	if (br->multicast_disabled)
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
 
 	switch (skb->protocol) {
@@ -1998,7 +2000,7 @@ static void __br_multicast_open(struct net_bridge *br,
 {
 	query->startup_sent = 0;
 
-	if (br->multicast_disabled)
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return;
 
 	mod_timer(&query->timer, jiffies);
@@ -2173,12 +2175,12 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 	int err = 0;
 
 	spin_lock_bh(&br->multicast_lock);
-	if (br->multicast_disabled == !val)
+	if (!!br_opt_get(br, BROPT_MULTICAST_ENABLED) == !!val)
 		goto unlock;
 
-	br_mc_disabled_update(br->dev, !val);
-	br->multicast_disabled = !val;
-	if (br->multicast_disabled)
+	br_mc_disabled_update(br->dev, val);
+	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		goto unlock;
 
 	if (!netif_running(br->dev))
@@ -2189,7 +2191,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 		if (mdb->old) {
 			err = -EEXIST;
 rollback:
-			br->multicast_disabled = !!val;
+			br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
 			goto unlock;
 		}
 
@@ -2213,7 +2215,7 @@ bool br_multicast_enabled(const struct net_device *dev)
 {
 	struct net_bridge *br = netdev_priv(dev);
 
-	return !br->multicast_disabled;
+	return !!br_opt_get(br, BROPT_MULTICAST_ENABLED);
 }
 EXPORT_SYMBOL_GPL(br_multicast_enabled);
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b00ccf35c35d..1d276b7b27e0 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1422,7 +1422,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 #endif
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	if (nla_put_u8(skb, IFLA_BR_MCAST_ROUTER, br->multicast_router) ||
-	    nla_put_u8(skb, IFLA_BR_MCAST_SNOOPING, !br->multicast_disabled) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_SNOOPING,
+		       br_opt_get(br, BROPT_MULTICAST_ENABLED)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERY_USE_IFADDR,
 		       br->multicast_query_use_ifaddr) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERIER, br->multicast_querier) ||
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index dda117ce386e..fb1a266cdac8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -313,6 +313,7 @@ enum net_bridge_opts {
 	BROPT_NF_CALL_IP6TABLES,
 	BROPT_NF_CALL_ARPTABLES,
 	BROPT_GROUP_ADDR_SET,
+	BROPT_MULTICAST_ENABLED,
 };
 
 struct net_bridge {
@@ -366,7 +367,6 @@ struct net_bridge {
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	unsigned char			multicast_router;
 
-	u8				multicast_disabled:1;
 	u8				multicast_querier:1;
 	u8				multicast_query_use_ifaddr:1;
 	u8				has_ipv6_addr:1;
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 4c2d56354d89..bf6f409a83e1 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -349,7 +349,7 @@ static ssize_t multicast_snooping_show(struct device *d,
 				       char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%d\n", !br->multicast_disabled);
+	return sprintf(buf, "%d\n", br_opt_get(br, BROPT_MULTICAST_ENABLED));
 }
 
 static ssize_t multicast_snooping_store(struct device *d,
-- 
2.11.0

