From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110512160640.2A0B713A6B@rere.qmqm.pl>
References: <20110507114803.0D80A13A6B@rere.qmqm.pl>
	<20110512160640.2A0B713A6B@rere.qmqm.pl>
Message-Id: <20110512163702.0FE8A13A6A@rere.qmqm.pl>
Date: Thu, 12 May 2011 18:37:02 +0200 (CEST)
Subject: [Bridge] [RFC PATCH v3] net: fold dev_disable_lro() into
	netdev_fix_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Eric Dumazet <eric.dumazet@gmail.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Tom Herbert <therbert@google.com>

This implements checks for forwarding mode in netdev_fix_features() using
dev->priv_flags bits. As a side effect, after device is no longer
forwarding it gets LRO back. This also means that user is not allowed to
enable LRO after device is put to forwarding mode.

This patch depends on removal of discrete offload setting ethtool ops.

v2: remove protocol-specific checks from core code
v3: add comment and missing negation

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/if.h        |    5 +++++
 include/linux/netdevice.h |    1 -
 net/bridge/br_if.c        |    9 ++++++---
 net/core/dev.c            |   25 +++++--------------------
 net/ipv4/devinet.c        |   30 +++++++++++++++++++-----------
 net/ipv6/addrconf.c       |   17 +++++++++++++----
 6 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/include/linux/if.h b/include/linux/if.h
index 3bc63e6..1aef6a7 100644
--- a/include/linux/if.h
+++ b/include/linux/if.h
@@ -76,6 +76,11 @@
 #define IFF_BRIDGE_PORT	0x4000		/* device used as bridge port */
 #define IFF_OVS_DATAPATH	0x8000	/* device used as Open vSwitch
 					 * datapath port */
+#define IFF_FORWARDING_IPV4	0x10000	/* IPv4 router port */
+#define IFF_FORWARDING_IPV6	0x20000	/* IPv6 router port */
+
+#define IFF_LRO_FORBIDDEN (IFF_BRIDGE_PORT | \
+		IFF_FORWARDING_IPV4 | IFF_FORWARDING_IPV6)
 
 #define IF_GET_IFACE	0x0001		/* for querying only */
 #define IF_GET_PROTO	0x0002
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 41972b9..f698730 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1628,7 +1628,6 @@ extern struct net_device	*__dev_get_by_name(struct net *net, const char *name);
 extern int		dev_alloc_name(struct net_device *dev, const char *name);
 extern int		dev_open(struct net_device *dev);
 extern int		dev_close(struct net_device *dev);
-extern void		dev_disable_lro(struct net_device *dev);
 extern int		dev_queue_xmit(struct sk_buff *skb);
 extern int		register_netdevice(struct net_device *dev);
 extern void		unregister_netdevice_queue(struct net_device *dev,
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 5dbdfdf..31ba100 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -158,6 +158,8 @@ static void del_nbp(struct net_bridge_port *p)
 	br_netpoll_disable(p);
 
 	call_rcu(&p->rcu, destroy_nbp_rcu);
+
+	netdev_update_features(dev);
 }
 
 /* called with RTNL */
@@ -368,11 +370,12 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 
 	dev->priv_flags |= IFF_BRIDGE_PORT;
 
-	dev_disable_lro(dev);
-
 	list_add_rcu(&p->list, &br->port_list);
 
-	netdev_update_features(br->dev);
+	/* possibly disable LRO and force recalculation of bridge dev's
+	 * features through NETDEV_FEAT_CHANGE notifier call.
+	 */
+	netdev_change_features(dev);
 
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
diff --git a/net/core/dev.c b/net/core/dev.c
index 491b8eb..7c7df7c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1296,26 +1296,6 @@ int dev_close(struct net_device *dev)
 EXPORT_SYMBOL(dev_close);
 
 
-/**
- *	dev_disable_lro - disable Large Receive Offload on a device
- *	@dev: device
- *
- *	Disable Large Receive Offload (LRO) on a net device.  Must be
- *	called under RTNL.  This is needed if received packets may be
- *	forwarded to another interface.
- */
-void dev_disable_lro(struct net_device *dev)
-{
-	dev->wanted_features &= ~NETIF_F_LRO;
-	netdev_update_features(dev);
-
-	if (unlikely(dev->features & NETIF_F_LRO))
-		netdev_WARN(dev, "failed to disable LRO!\n");
-
-}
-EXPORT_SYMBOL(dev_disable_lro);
-
-
 static int dev_boot_phase = 1;
 
 /**
@@ -5241,6 +5221,11 @@ u32 netdev_fix_features(struct net_device *dev, u32 features)
 		}
 	}
 
+	if (features & NETIF_F_LRO && dev->priv_flags & IFF_LRO_FORBIDDEN) {
+		netdev_info(dev, "Disabling LRO for forwarding interface.\n");
+		features &= ~NETIF_F_LRO;
+	}
+
 	return features;
 }
 EXPORT_SYMBOL(netdev_fix_features);
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 0d4a184..9552c68 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -221,6 +221,7 @@ void in_dev_finish_destroy(struct in_device *idev)
 	printk(KERN_DEBUG "in_dev_finish_destroy: %p=%s\n",
 	       idev, dev ? dev->name : "NIL");
 #endif
+	dev->priv_flags &= ~IFF_FORWARDING_IPV4;
 	dev_put(dev);
 	if (!idev->dead)
 		pr_err("Freeing alive in_device %p\n", idev);
@@ -229,6 +230,16 @@ void in_dev_finish_destroy(struct in_device *idev)
 }
 EXPORT_SYMBOL(in_dev_finish_destroy);
 
+static void mark_ipv4_forwarding(struct net_device *dev, bool on)
+{
+	if (on)
+		dev->priv_flags |= IFF_FORWARDING_IPV4;
+	else
+		dev->priv_flags &= ~IFF_FORWARDING_IPV4;
+
+	netdev_update_features(dev);
+}
+
 static struct in_device *inetdev_init(struct net_device *dev)
 {
 	struct in_device *in_dev;
@@ -245,8 +256,7 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	in_dev->arp_parms = neigh_parms_alloc(dev, &arp_tbl);
 	if (!in_dev->arp_parms)
 		goto out_kfree;
-	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
-		dev_disable_lro(dev);
+	mark_ipv4_forwarding(dev, IPV4_DEVCONF(in_dev->cnf, FORWARDING));
 	/* Reference in_dev->dev */
 	dev_hold(dev);
 	/* Account for reference dev->ip_ptr (below) */
@@ -1475,14 +1485,12 @@ static void inet_forward_change(struct net *net)
 	IPV4_DEVCONF_DFLT(net, FORWARDING) = on;
 
 	for_each_netdev(net, dev) {
-		struct in_device *in_dev;
-		if (on)
-			dev_disable_lro(dev);
-		rcu_read_lock();
-		in_dev = __in_dev_get_rcu(dev);
-		if (in_dev)
+		struct in_device *in_dev = __in_dev_get_rtnl(dev);
+
+		if (in_dev) {
 			IN_DEV_CONF_SET(in_dev, FORWARDING, on);
-		rcu_read_unlock();
+			mark_ipv4_forwarding(in_dev->dev, on);
+		}
 	}
 }
 
@@ -1527,11 +1535,11 @@ static int devinet_sysctl_forward(ctl_table *ctl, int write,
 			}
 			if (valp == &IPV4_DEVCONF_ALL(net, FORWARDING)) {
 				inet_forward_change(net);
-			} else if (*valp) {
+			} else {
 				struct ipv4_devconf *cnf = ctl->extra1;
 				struct in_device *idev =
 					container_of(cnf, struct in_device, cnf);
-				dev_disable_lro(idev->dev);
+				mark_ipv4_forwarding(idev->dev, *valp);
 			}
 			rtnl_unlock();
 			rt_cache_flush(net, 0);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f2f9b2e..7e0e8fa 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -333,6 +333,7 @@ void in6_dev_finish_destroy(struct inet6_dev *idev)
 #ifdef NET_REFCNT_DEBUG
 	printk(KERN_DEBUG "in6_dev_finish_destroy: %s\n", dev ? dev->name : "NIL");
 #endif
+	dev->priv_flags &= ~IFF_FORWARDING_IPV6;
 	dev_put(dev);
 	if (!idev->dead) {
 		pr_warning("Freeing alive inet6 device %p\n", idev);
@@ -344,6 +345,16 @@ void in6_dev_finish_destroy(struct inet6_dev *idev)
 
 EXPORT_SYMBOL(in6_dev_finish_destroy);
 
+static void mark_ipv6_forwarding(struct net_device *dev, bool on)
+{
+	if (on)
+		dev->priv_flags |= IFF_FORWARDING_IPV6;
+	else
+		dev->priv_flags &= ~IFF_FORWARDING_IPV6;
+
+	netdev_update_features(dev);
+}
+
 static struct inet6_dev * ipv6_add_dev(struct net_device *dev)
 {
 	struct inet6_dev *ndev;
@@ -370,8 +381,7 @@ static struct inet6_dev * ipv6_add_dev(struct net_device *dev)
 		kfree(ndev);
 		return NULL;
 	}
-	if (ndev->cnf.forwarding)
-		dev_disable_lro(dev);
+	mark_ipv6_forwarding(dev, ndev->cnf.forwarding);
 	/* We refer to the device */
 	dev_hold(dev);
 
@@ -469,8 +479,7 @@ static void dev_forward_change(struct inet6_dev *idev)
 	if (!idev)
 		return;
 	dev = idev->dev;
-	if (idev->cnf.forwarding)
-		dev_disable_lro(dev);
+	mark_ipv6_forwarding(dev, idev->cnf.forwarding);
 	if (dev && (dev->flags & IFF_MULTICAST)) {
 		if (idev->cnf.forwarding)
 			ipv6_dev_mc_inc(dev, &in6addr_linklocal_allrouters);
-- 
1.7.2.5

