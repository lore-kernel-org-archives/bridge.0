From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20110331110135.1594713909@rere.qmqm.pl>
Date: Thu, 31 Mar 2011 13:01:35 +0200 (CEST)
Subject: [Bridge] [RFC PATCH] bridge: convert br_features_recompute() to
	ndo_fix_features
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>

This is a minimal change. br_features_recompute() might be just merged
to br_fix_features() since it should not be used explicitly anymore.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 net/bridge/br_device.c  |   57 +++++------------------------------------------
 net/bridge/br_if.c      |   16 +++++-------
 net/bridge/br_notify.c  |    2 +-
 net/bridge/br_private.h |    3 +-
 4 files changed, 15 insertions(+), 63 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 21e5901..d6ede61 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -79,8 +79,7 @@ static int br_dev_open(struct net_device *dev)
 	struct net_bridge *br = netdev_priv(dev);
 
 	netif_carrier_off(dev);
-
-	br_features_recompute(br);
+	netdev_update_features(dev);
 	netif_start_queue(dev);
 	br_stp_enable_bridge(br);
 	br_multicast_open(br);
@@ -177,48 +176,11 @@ static void br_getinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 	strcpy(info->bus_info, "N/A");
 }
 
-static int br_set_sg(struct net_device *dev, u32 data)
+static u32 br_fix_features(struct net_device *dev, u32 features)
 {
 	struct net_bridge *br = netdev_priv(dev);
 
-	if (data)
-		br->feature_mask |= NETIF_F_SG;
-	else
-		br->feature_mask &= ~NETIF_F_SG;
-
-	br_features_recompute(br);
-	return 0;
-}
-
-static int br_set_tso(struct net_device *dev, u32 data)
-{
-	struct net_bridge *br = netdev_priv(dev);
-
-	if (data)
-		br->feature_mask |= NETIF_F_TSO;
-	else
-		br->feature_mask &= ~NETIF_F_TSO;
-
-	br_features_recompute(br);
-	return 0;
-}
-
-static int br_set_tx_csum(struct net_device *dev, u32 data)
-{
-	struct net_bridge *br = netdev_priv(dev);
-
-	if (data)
-		br->feature_mask |= NETIF_F_NO_CSUM;
-	else
-		br->feature_mask &= ~NETIF_F_ALL_CSUM;
-
-	br_features_recompute(br);
-	return 0;
-}
-
-static int br_set_flags(struct net_device *netdev, u32 data)
-{
-	return ethtool_op_set_flags(netdev, data, ETH_FLAG_TXVLAN);
+	return br_features_recompute(br, features);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -319,16 +281,6 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
 static const struct ethtool_ops br_ethtool_ops = {
 	.get_drvinfo    = br_getinfo,
 	.get_link	= ethtool_op_get_link,
-	.get_tx_csum	= ethtool_op_get_tx_csum,
-	.set_tx_csum 	= br_set_tx_csum,
-	.get_sg		= ethtool_op_get_sg,
-	.set_sg		= br_set_sg,
-	.get_tso	= ethtool_op_get_tso,
-	.set_tso	= br_set_tso,
-	.get_ufo	= ethtool_op_get_ufo,
-	.set_ufo	= ethtool_op_set_ufo,
-	.get_flags	= ethtool_op_get_flags,
-	.set_flags	= br_set_flags,
 };
 
 static const struct net_device_ops br_netdev_ops = {
@@ -347,6 +299,7 @@ static const struct net_device_ops br_netdev_ops = {
 #endif
 	.ndo_add_slave		 = br_add_slave,
 	.ndo_del_slave		 = br_del_slave,
+	.ndo_fix_features        = br_fix_features,
 };
 
 static void br_dev_free(struct net_device *dev)
@@ -371,4 +324,6 @@ void br_dev_setup(struct net_device *dev)
 	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
 			NETIF_F_GSO_MASK | NETIF_F_NO_CSUM | NETIF_F_LLTX |
 			NETIF_F_NETNS_LOCAL | NETIF_F_GSO | NETIF_F_HW_VLAN_TX;
+	dev->hw_features = NETIF_F_NO_CSUM | NETIF_F_SG | NETIF_F_GSO_MASK |
+			   NETIF_F_HW_VLAN_TX;
 }
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 718b603..3622052 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -205,7 +205,6 @@ static struct net_device *new_bridge_dev(struct net *net, const char *name)
 
 	memcpy(br->group_addr, br_group_address, ETH_ALEN);
 
-	br->feature_mask = dev->features;
 	br->stp_enabled = BR_NO_STP;
 	br->designated_root = br->bridge_id;
 	br->root_path_cost = 0;
@@ -364,15 +363,15 @@ int br_min_mtu(const struct net_bridge *br)
 /*
  * Recomputes features using slave's features
  */
-void br_features_recompute(struct net_bridge *br)
+u32 br_features_recompute(struct net_bridge *br, u32 features)
 {
 	struct net_bridge_port *p;
-	u32 features, mask;
+	u32 mask;
 
-	features = mask = br->feature_mask;
 	if (list_empty(&br->port_list))
-		goto done;
+		return features;
 
+	mask = features;
 	features &= ~NETIF_F_ONE_FOR_ALL;
 
 	list_for_each_entry(p, &br->port_list, list) {
@@ -380,8 +379,7 @@ void br_features_recompute(struct net_bridge *br)
 						     p->dev->features, mask);
 	}
 
-done:
-	br->dev->features = netdev_fix_features(br->dev, features);
+	return features;
 }
 
 /* called with RTNL */
@@ -448,7 +446,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
-	br_features_recompute(br);
+	netdev_update_features(br->dev);
 
 	if ((dev->flags & IFF_UP) && netif_carrier_ok(dev) &&
 	    (br->dev->flags & IFF_UP))
@@ -496,7 +494,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 
 	spin_lock_bh(&br->lock);
 	br_stp_recalculate_bridge_id(br);
-	br_features_recompute(br);
+	netdev_update_features(br->dev);
 	spin_unlock_bh(&br->lock);
 
 	return 0;
diff --git a/net/bridge/br_notify.c b/net/bridge/br_notify.c
index 7d337c9..274ef4a 100644
--- a/net/bridge/br_notify.c
+++ b/net/bridge/br_notify.c
@@ -62,7 +62,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 	case NETDEV_FEAT_CHANGE:
 		spin_lock_bh(&br->lock);
 		if (netif_running(br->dev))
-			br_features_recompute(br);
+			netdev_update_features(br->dev);
 		spin_unlock_bh(&br->lock);
 		break;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 387013d..077c351 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -182,7 +182,6 @@ struct net_bridge
 	struct br_cpu_netstats __percpu *stats;
 	spinlock_t			hash_lock;
 	struct hlist_head		hash[BR_HASH_SIZE];
-	u32				feature_mask;
 #ifdef CONFIG_BRIDGE_NETFILTER
 	struct rtable 			fake_rtable;
 	bool				nf_call_iptables;
@@ -375,7 +374,7 @@ extern int br_add_if(struct net_bridge *br,
 extern int br_del_if(struct net_bridge *br,
 	      struct net_device *dev);
 extern int br_min_mtu(const struct net_bridge *br);
-extern void br_features_recompute(struct net_bridge *br);
+extern u32 br_features_recompute(struct net_bridge *br, u32 features);
 
 /* br_input.c */
 extern int br_handle_frame_finish(struct sk_buff *skb);
-- 
1.7.2.5

