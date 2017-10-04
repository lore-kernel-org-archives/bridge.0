Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iZpV2fg+qJwxfxkZ8PVPKftA31uTWcgiEC7H6IkwWwo=;
	b=OEKKG1cW+Lw1VV2vcEuHv/gNUXdCUk5TqDy55eHW+bBV0pTQ7Ni4un/NfVO6ePOPEg
	WsBF30ixo9EiQNw7x483epb6sD+u40wN2ETniAmJgOZlU5kwNpfwu2ytPtM1Yh0D5CMB
	mq9zI9MYK3feG2yvhvK5ajiMTwMgIEUl4G2XC+9Ru7iZVMzQOSBG56V5S7m6BP2dqbXC
	vv2rG56405+F4eSf3rJnQ8QJA/ccGV5NdpMbewz9RCz9litHEehc1JD2RQtnlvtqypj0
	NfuD3fTuhpy3dJZDeHLpwL44uQNwON9cdwRQFDCgbTB7eAPKMbU7ex2kuTs5o18vqj6N
	aBDg==
From: David Ahern <dsahern@gmail.com>
Date: Tue,  3 Oct 2017 21:58:48 -0700
Message-Id: <1507093134-20406-2-git-send-email-dsahern@gmail.com>
In-Reply-To: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH net-next 1/7] net: Add extack to
	netdev_notifier_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: j.vosburgh@gmail.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, David Ahern <dsahern@gmail.com>, davem@davemloft.net

Add netlink_ext_ack to netdev_notifier_info to allow notifier
handlers to return errors to userspace.

Clean up the initialization in dev.c such that extack is easily
added in subsequent patches where relevant. Specifically, remove
the init call in call_netdevice_notifiers_info and have callers
initalize on stack when info is declared.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/linux/netdevice.h | 10 +++++-
 net/core/dev.c            | 79 ++++++++++++++++++++++++++++-------------------
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d04424cfffba..05fcaba4b0d9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2309,7 +2309,8 @@ int register_netdevice_notifier(struct notifier_block *nb);
 int unregister_netdevice_notifier(struct notifier_block *nb);
 
 struct netdev_notifier_info {
-	struct net_device *dev;
+	struct net_device	*dev;
+	struct netlink_ext_ack	*extack;
 };
 
 struct netdev_notifier_change_info {
@@ -2334,6 +2335,7 @@ static inline void netdev_notifier_info_init(struct netdev_notifier_info *info,
 					     struct net_device *dev)
 {
 	info->dev = dev;
+	info->extack = NULL;
 }
 
 static inline struct net_device *
@@ -2342,6 +2344,12 @@ netdev_notifier_info_to_dev(const struct netdev_notifier_info *info)
 	return info->dev;
 }
 
+static inline struct netlink_ext_ack *
+netdev_notifier_info_to_extack(const struct netdev_notifier_info *info)
+{
+	return info->extack;
+}
+
 int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
 
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 1770097cfd86..dbeeefebfbb7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -162,7 +162,6 @@ static struct list_head offload_base __read_mostly;
 
 static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_info(unsigned long val,
-					 struct net_device *dev,
 					 struct netdev_notifier_info *info);
 static struct napi_struct *napi_by_id(unsigned int napi_id);
 
@@ -1338,10 +1337,11 @@ EXPORT_SYMBOL(netdev_features_change);
 void netdev_state_change(struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
-		struct netdev_notifier_change_info change_info;
+		struct netdev_notifier_change_info change_info = {
+			.info.dev = dev,
+		};
 
-		change_info.flags_changed = 0;
-		call_netdevice_notifiers_info(NETDEV_CHANGE, dev,
+		call_netdevice_notifiers_info(NETDEV_CHANGE,
 					      &change_info.info);
 		rtmsg_ifinfo(RTM_NEWLINK, dev, 0, GFP_KERNEL);
 	}
@@ -1562,9 +1562,10 @@ EXPORT_SYMBOL(dev_disable_lro);
 static int call_netdevice_notifier(struct notifier_block *nb, unsigned long val,
 				   struct net_device *dev)
 {
-	struct netdev_notifier_info info;
+	struct netdev_notifier_info info = {
+		.dev = dev,
+	};
 
-	netdev_notifier_info_init(&info, dev);
 	return nb->notifier_call(nb, val, &info);
 }
 
@@ -1689,11 +1690,9 @@ EXPORT_SYMBOL(unregister_netdevice_notifier);
  */
 
 static int call_netdevice_notifiers_info(unsigned long val,
-					 struct net_device *dev,
 					 struct netdev_notifier_info *info)
 {
 	ASSERT_RTNL();
-	netdev_notifier_info_init(info, dev);
 	return raw_notifier_call_chain(&netdev_chain, val, info);
 }
 
@@ -1708,9 +1707,11 @@ static int call_netdevice_notifiers_info(unsigned long val,
 
 int call_netdevice_notifiers(unsigned long val, struct net_device *dev)
 {
-	struct netdev_notifier_info info;
+	struct netdev_notifier_info info = {
+		.dev = dev,
+	};
 
-	return call_netdevice_notifiers_info(val, dev, &info);
+	return call_netdevice_notifiers_info(val, &info);
 }
 EXPORT_SYMBOL(call_netdevice_notifiers);
 
@@ -6277,7 +6278,15 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 				   struct net_device *upper_dev, bool master,
 				   void *upper_priv, void *upper_info)
 {
-	struct netdev_notifier_changeupper_info changeupper_info;
+	struct netdev_notifier_changeupper_info changeupper_info = {
+		.info = {
+			.dev = dev,
+		},
+		.upper_dev = upper_dev,
+		.master = master,
+		.linking = true,
+		.upper_info = upper_info,
+	};
 	int ret = 0;
 
 	ASSERT_RTNL();
@@ -6295,12 +6304,7 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	if (master && netdev_master_upper_dev_get(dev))
 		return -EBUSY;
 
-	changeupper_info.upper_dev = upper_dev;
-	changeupper_info.master = master;
-	changeupper_info.linking = true;
-	changeupper_info.upper_info = upper_info;
-
-	ret = call_netdevice_notifiers_info(NETDEV_PRECHANGEUPPER, dev,
+	ret = call_netdevice_notifiers_info(NETDEV_PRECHANGEUPPER,
 					    &changeupper_info.info);
 	ret = notifier_to_errno(ret);
 	if (ret)
@@ -6311,7 +6315,7 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	ret = call_netdevice_notifiers_info(NETDEV_CHANGEUPPER, dev,
+	ret = call_netdevice_notifiers_info(NETDEV_CHANGEUPPER,
 					    &changeupper_info.info);
 	ret = notifier_to_errno(ret);
 	if (ret)
@@ -6375,20 +6379,24 @@ EXPORT_SYMBOL(netdev_master_upper_dev_link);
 void netdev_upper_dev_unlink(struct net_device *dev,
 			     struct net_device *upper_dev)
 {
-	struct netdev_notifier_changeupper_info changeupper_info;
+	struct netdev_notifier_changeupper_info changeupper_info = {
+		.info = {
+			.dev = dev,
+		},
+		.upper_dev = upper_dev,
+		.linking = false,
+	};
 
 	ASSERT_RTNL();
 
-	changeupper_info.upper_dev = upper_dev;
 	changeupper_info.master = netdev_master_upper_dev_get(dev) == upper_dev;
-	changeupper_info.linking = false;
 
-	call_netdevice_notifiers_info(NETDEV_PRECHANGEUPPER, dev,
+	call_netdevice_notifiers_info(NETDEV_PRECHANGEUPPER,
 				      &changeupper_info.info);
 
 	__netdev_adjacent_dev_unlink_neighbour(dev, upper_dev);
 
-	call_netdevice_notifiers_info(NETDEV_CHANGEUPPER, dev,
+	call_netdevice_notifiers_info(NETDEV_CHANGEUPPER,
 				      &changeupper_info.info);
 }
 EXPORT_SYMBOL(netdev_upper_dev_unlink);
@@ -6404,11 +6412,13 @@ EXPORT_SYMBOL(netdev_upper_dev_unlink);
 void netdev_bonding_info_change(struct net_device *dev,
 				struct netdev_bonding_info *bonding_info)
 {
-	struct netdev_notifier_bonding_info	info;
+	struct netdev_notifier_bonding_info info = {
+		.info.dev = dev,
+	};
 
 	memcpy(&info.bonding_info, bonding_info,
 	       sizeof(struct netdev_bonding_info));
-	call_netdevice_notifiers_info(NETDEV_BONDING_INFO, dev,
+	call_netdevice_notifiers_info(NETDEV_BONDING_INFO,
 				      &info.info);
 }
 EXPORT_SYMBOL(netdev_bonding_info_change);
@@ -6534,11 +6544,13 @@ EXPORT_SYMBOL(dev_get_nest_level);
 void netdev_lower_state_changed(struct net_device *lower_dev,
 				void *lower_state_info)
 {
-	struct netdev_notifier_changelowerstate_info changelowerstate_info;
+	struct netdev_notifier_changelowerstate_info changelowerstate_info = {
+		.info.dev = lower_dev,
+	};
 
 	ASSERT_RTNL();
 	changelowerstate_info.lower_state_info = lower_state_info;
-	call_netdevice_notifiers_info(NETDEV_CHANGELOWERSTATE, lower_dev,
+	call_netdevice_notifiers_info(NETDEV_CHANGELOWERSTATE,
 				      &changelowerstate_info.info);
 }
 EXPORT_SYMBOL(netdev_lower_state_changed);
@@ -6829,11 +6841,14 @@ void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 
 	if (dev->flags & IFF_UP &&
 	    (changes & ~(IFF_UP | IFF_PROMISC | IFF_ALLMULTI | IFF_VOLATILE))) {
-		struct netdev_notifier_change_info change_info;
-
-		change_info.flags_changed = changes;
-		call_netdevice_notifiers_info(NETDEV_CHANGE, dev,
-					      &change_info.info);
+		struct netdev_notifier_change_info change_info = {
+			.info = {
+				.dev = dev,
+			},
+			.flags_changed = changes,
+		};
+
+		call_netdevice_notifiers_info(NETDEV_CHANGE, &change_info.info);
 	}
 }
 
-- 
2.1.4

