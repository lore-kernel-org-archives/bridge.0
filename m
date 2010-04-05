Date: Mon, 5 Apr 2010 05:12:18 -0400
From: Amerigo Wang <amwang@redhat.com>
Message-Id: <20100405091605.4890.31181.sendpatchset@localhost.localdomain>
Subject: [Bridge] [v2 Patch 1/3] netpoll: add generic support for bridge and
	bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Jay Vosburgh <fubar@us.ibm.com>, Amerigo Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Matt Mackall <mpm@selenic.com>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

V2:
Fix some bugs of previous version.
Remove ->netpoll_setup and ->netpoll_xmit, they are not necessary.
Don't poll all underlying devices, poll ->real_dev in struct netpoll.
Thanks to David for suggesting above.

--------->

This whole patchset is for adding netpoll support to bridge and bonding
devices. I already tested it for bridge, bonding, bridge over bonding,
and bonding over bridge. It looks fine now.

Please comment.


To make bridge and bonding support netpoll, we need to adjust
some netpoll generic code. This patch does the following things:

1) introduce two new priv_flags for struct net_device:
   IFF_IN_NETPOLL which identifies we are processing a netpoll;
   IFF_DISABLE_NETPOLL is used to disable netpoll support for a device
   at run-time;

2) introduce one new method for netdev_ops:
   ->ndo_netpoll_cleanup() is used to clean up netpoll when a device is
     removed.

3) introduce netpoll_poll_dev() which takes a struct net_device * parameter;
   export netpoll_send_skb() and netpoll_poll_dev() which will be used later;

4) hide a pointer to struct netpoll in struct netpoll_info, ditto.

5) introduce ->real_dev for struct netpoll.

Cc: David Miller <davem@davemloft.net>
Cc: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: WANG Cong <amwang@redhat.com>

---

Index: linux-2.6/include/linux/if.h
===================================================================
--- linux-2.6.orig/include/linux/if.h
+++ linux-2.6/include/linux/if.h
@@ -71,6 +71,8 @@
 					 * release skb->dst
 					 */
 #define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
+#define IFF_IN_NETPOLL	0x1000		/* whether we are processing netpoll */
+#define IFF_DISABLE_NETPOLL	0x2000	/* disable netpoll at run-time */
 
 #define IF_GET_IFACE	0x0001		/* for querying only */
 #define IF_GET_PROTO	0x0002
Index: linux-2.6/include/linux/netdevice.h
===================================================================
--- linux-2.6.orig/include/linux/netdevice.h
+++ linux-2.6/include/linux/netdevice.h
@@ -667,6 +667,7 @@ struct net_device_ops {
 						        unsigned short vid);
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void                    (*ndo_poll_controller)(struct net_device *dev);
+	void			(*ndo_netpoll_cleanup)(struct net_device *dev);
 #endif
 	int			(*ndo_set_vf_mac)(struct net_device *dev,
 						  int queue, u8 *mac);
Index: linux-2.6/include/linux/netpoll.h
===================================================================
--- linux-2.6.orig/include/linux/netpoll.h
+++ linux-2.6/include/linux/netpoll.h
@@ -14,6 +14,7 @@
 
 struct netpoll {
 	struct net_device *dev;
+	struct net_device *real_dev;
 	char dev_name[IFNAMSIZ];
 	const char *name;
 	void (*rx_hook)(struct netpoll *, int, char *, int);
@@ -36,8 +37,11 @@ struct netpoll_info {
 	struct sk_buff_head txq;
 
 	struct delayed_work tx_work;
+
+	struct netpoll *netpoll;
 };
 
+void netpoll_poll_dev(struct net_device *dev);
 void netpoll_poll(struct netpoll *np);
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 void netpoll_print_options(struct netpoll *np);
@@ -47,6 +51,7 @@ int netpoll_trap(void);
 void netpoll_set_trap(int trap);
 void netpoll_cleanup(struct netpoll *np);
 int __netpoll_rx(struct sk_buff *skb);
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 
 
 #ifdef CONFIG_NETPOLL
Index: linux-2.6/net/core/netpoll.c
===================================================================
--- linux-2.6.orig/net/core/netpoll.c
+++ linux-2.6/net/core/netpoll.c
@@ -178,9 +178,8 @@ static void service_arp_queue(struct net
 	}
 }
 
-void netpoll_poll(struct netpoll *np)
+void netpoll_poll_dev(struct net_device *dev)
 {
-	struct net_device *dev = np->dev;
 	const struct net_device_ops *ops;
 
 	if (!dev || !netif_running(dev))
@@ -200,6 +199,11 @@ void netpoll_poll(struct netpoll *np)
 	zap_completion_queue();
 }
 
+void netpoll_poll(struct netpoll *np)
+{
+	netpoll_poll_dev(np->dev);
+}
+
 static void refill_skbs(void)
 {
 	struct sk_buff *skb;
@@ -281,7 +285,7 @@ static int netpoll_owner_active(struct n
 	return 0;
 }
 
-static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status = NETDEV_TX_BUSY;
 	unsigned long tries;
@@ -307,7 +311,9 @@ static void netpoll_send_skb(struct netp
 		     tries > 0; --tries) {
 			if (__netif_tx_trylock(txq)) {
 				if (!netif_tx_queue_stopped(txq)) {
+					dev->priv_flags |= IFF_IN_NETPOLL;
 					status = ops->ndo_start_xmit(skb, dev);
+					dev->priv_flags &= ~IFF_IN_NETPOLL;
 					if (status == NETDEV_TX_OK)
 						txq_trans_update(txq);
 				}
@@ -755,7 +761,10 @@ int netpoll_setup(struct netpoll *np)
 		atomic_inc(&npinfo->refcnt);
 	}
 
-	if (!ndev->netdev_ops->ndo_poll_controller) {
+	npinfo->netpoll = np;
+
+	if (ndev->priv_flags & IFF_DISABLE_NETPOLL
+			|| !ndev->netdev_ops->ndo_poll_controller) {
 		printk(KERN_ERR "%s: %s doesn't support polling, aborting.\n",
 		       np->name, np->dev_name);
 		err = -ENOTSUPP;
@@ -877,6 +886,7 @@ void netpoll_cleanup(struct netpoll *np)
 			}
 
 			if (atomic_dec_and_test(&npinfo->refcnt)) {
+				const struct net_device_ops *ops;
 				skb_queue_purge(&npinfo->arp_tx);
 				skb_queue_purge(&npinfo->txq);
 				cancel_rearming_delayed_work(&npinfo->tx_work);
@@ -884,7 +894,11 @@ void netpoll_cleanup(struct netpoll *np)
 				/* clean after last, unfinished work */
 				__skb_queue_purge(&npinfo->txq);
 				kfree(npinfo);
-				np->dev->npinfo = NULL;
+				ops = np->dev->netdev_ops;
+				if (ops->ndo_netpoll_cleanup)
+					ops->ndo_netpoll_cleanup(np->dev);
+				else
+					np->dev->npinfo = NULL;
 			}
 		}
 
@@ -907,6 +921,7 @@ void netpoll_set_trap(int trap)
 		atomic_dec(&trapped);
 }
 
+EXPORT_SYMBOL(netpoll_send_skb);
 EXPORT_SYMBOL(netpoll_set_trap);
 EXPORT_SYMBOL(netpoll_trap);
 EXPORT_SYMBOL(netpoll_print_options);
@@ -914,4 +929,5 @@ EXPORT_SYMBOL(netpoll_parse_options);
 EXPORT_SYMBOL(netpoll_setup);
 EXPORT_SYMBOL(netpoll_cleanup);
 EXPORT_SYMBOL(netpoll_send_udp);
+EXPORT_SYMBOL(netpoll_poll_dev);
 EXPORT_SYMBOL(netpoll_poll);
