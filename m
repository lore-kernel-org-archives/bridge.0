Sender: Cyrill Gorcunov <gorcunov@gmail.com>
Message-Id: <20090511125351.203354561@openvz.org>
Date: Mon, 11 May 2009 15:46:43 +0400
From: Cyrill Gorcunov <gorcunov@openvz.org>
References: <20090511114639.440944109@openvz.org>
Content-Disposition: inline; filename=net-br-hard-xmit-hook
Subject: [Bridge] [RFC 4/5] net: dev.c - introduce br_hard_xmit_hook
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

In a sake of ability to handle outgoing skb by
a bridge the br_hard_xmit_hook is added.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
---
 include/linux/if_bridge.h |    1 +
 net/core/dev.c            |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

Index: linux-2.6.git/include/linux/if_bridge.h
=====================================================================
--- linux-2.6.git.orig/include/linux/if_bridge.h
+++ linux-2.6.git/include/linux/if_bridge.h
@@ -109,6 +109,7 @@ struct __fdb_entry
 extern void brioctl_set(int (*ioctl_hook)(struct net *, unsigned int, void __user *));
 extern struct sk_buff *(*br_handle_frame_hook)(struct net_bridge_port *p,
 					       struct sk_buff *skb);
+extern int (*br_hard_xmit_hook)(struct sk_buff *skb, struct net_bridge_port *port);
 extern int (*br_should_route_hook)(struct sk_buff *skb);
 
 #endif
Index: linux-2.6.git/net/core/dev.c
=====================================================================
--- linux-2.6.git.orig/net/core/dev.c
+++ linux-2.6.git/net/core/dev.c
@@ -1671,6 +1671,24 @@ static int dev_gso_segment(struct sk_buf
 	return 0;
 }
 
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+int (*br_hard_xmit_hook)(struct sk_buff *skb, struct net_bridge_port *port);
+static inline int bridge_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct net_bridge_port *port;
+
+	port = rcu_dereference(dev->br_port);
+	if (!port || skb->br_seen)
+		return 0;
+
+	return br_hard_xmit_hook(skb, port);
+}
+#else
+static inline int bridge_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{ }
+#endif
+
+
 int dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 			struct netdev_queue *txq)
 {
@@ -1688,6 +1706,8 @@ int dev_hard_start_xmit(struct sk_buff *
 				goto gso;
 		}
 
+		bridge_hard_start_xmit(skb, dev);
+
 		rc = ops->ndo_start_xmit(skb, dev);
 		/*
 		 * TODO: if skb_orphan() was called by
@@ -1712,6 +1732,9 @@ gso:
 
 		skb->next = nskb->next;
 		nskb->next = NULL;
+
+		bridge_hard_start_xmit(skb, dev);
+
 		rc = ops->ndo_start_xmit(nskb, dev);
 		if (unlikely(rc)) {
 			nskb->next = skb->next;
@@ -5576,6 +5599,7 @@ EXPORT_SYMBOL(dev_get_flags);
 
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 EXPORT_SYMBOL(br_handle_frame_hook);
+EXPORT_SYMBOL(br_hard_xmit_hook);
 EXPORT_SYMBOL(br_fdb_get_hook);
 EXPORT_SYMBOL(br_fdb_put_hook);
 #endif

