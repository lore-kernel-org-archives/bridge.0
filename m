Date: Tue, 24 Aug 2004 11:38:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040824113837.2c3d037d@dell_ss3.pdx.osdl.net>
In-Reply-To: <200408151158.55190.bdschuym@pandora.be>
References: <200408151158.55190.bdschuym@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] fix oops when mangling and brouting and
 tcpdumping packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: bridge <bridge@osdl.org>

How about this, it is basically Bart's patch with:
	* some more cleanups to handle_bridge
	* removing extra rcu_read_lock (already done in netif_receive_skb)
	* pass bridge port to hook since already dereferenced in handle_bridge


diff -Nru a/include/linux/if_bridge.h b/include/linux/if_bridge.h
--- a/include/linux/if_bridge.h	2004-08-24 11:35:08 -07:00
+++ b/include/linux/if_bridge.h	2004-08-24 11:35:08 -07:00
@@ -105,7 +105,7 @@
 #include <linux/netdevice.h>
 
 extern void brioctl_set(int (*ioctl_hook)(unsigned int, void __user *));
-extern int (*br_handle_frame_hook)(struct sk_buff *skb);
+extern int (*br_handle_frame_hook)(struct net_bridge_port *p, struct sk_buff **pskb);
 extern int (*br_should_route_hook)(struct sk_buff **pskb);
 
 #endif
diff -Nru a/net/bridge/br_input.c b/net/bridge/br_input.c
--- a/net/bridge/br_input.c	2004-08-24 11:35:08 -07:00
+++ b/net/bridge/br_input.c	2004-08-24 11:35:08 -07:00
@@ -45,26 +45,15 @@
 			br_pass_frame_up_finish);
 }
 
+/* note: already called with rcu_read_lock (preempt_disabled) */
 int br_handle_frame_finish(struct sk_buff *skb)
 {
-	struct net_bridge *br;
-	unsigned char *dest;
+	const unsigned char *dest = skb->mac.ethernet->h_dest;
+	struct net_bridge_port *p = skb->dev->br_port;
+	struct net_bridge *br = p->br;
 	struct net_bridge_fdb_entry *dst;
-	struct net_bridge_port *p;
-	int passedup;
+	int passedup = 0;
 
-	dest = skb->mac.ethernet->h_dest;
-
-	rcu_read_lock();
-	p = rcu_dereference(skb->dev->br_port);
-
-	if (p == NULL || p->state == BR_STATE_DISABLED) {
-		kfree_skb(skb);
-		goto out;
-	}
-
-	br = p->br;
-	passedup = 0;
 	if (br->dev->flags & IFF_PROMISC) {
 		struct sk_buff *skb2;
 
@@ -99,20 +88,16 @@
 	br_flood_forward(br, skb, 0);
 
 out:
-	rcu_read_unlock();
 	return 0;
 }
 
-int br_handle_frame(struct sk_buff *skb)
+/* note: already called with rcu_read_lock (preempt_disabled) */
+int br_handle_frame(struct net_bridge_port *p, struct sk_buff **pskb)
 {
-	unsigned char *dest;
-	struct net_bridge_port *p;
-
-	dest = skb->mac.ethernet->h_dest;
+	struct sk_buff *skb = *pskb;
+	const unsigned char *dest = skb->mac.ethernet->h_dest;
 
-	rcu_read_lock();
-	p = skb->dev->br_port;
-	if (p == NULL || p->state == BR_STATE_DISABLED)
+	if (p->state == BR_STATE_DISABLED)
 		goto err;
 
 	if (skb->mac.ethernet->h_source[0] & 1)
@@ -128,28 +113,26 @@
 		if (!dest[5]) {
 			NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev, 
 				NULL, br_stp_handle_bpdu);
-			rcu_read_unlock();
 			return 0;
 		}
 	}
 
 	else if (p->state == BR_STATE_FORWARDING) {
-		if (br_should_route_hook && br_should_route_hook(&skb)) {
-			rcu_read_unlock();
+		if (br_should_route_hook && br_should_route_hook(pskb)) 
 			return -1;
-		}
+
+		skb = *pskb;
+		dest = skb->mac.ethernet->h_dest;
 
 		if (!memcmp(p->br->dev->dev_addr, dest, ETH_ALEN))
 			skb->pkt_type = PACKET_HOST;
 
 		NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
 			br_handle_frame_finish);
-		rcu_read_unlock();
 		return 0;
 	}
 
 err:
-	rcu_read_unlock();
 	kfree_skb(skb);
 	return 0;
 }
diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
--- a/net/bridge/br_private.h	2004-08-24 11:35:08 -07:00
+++ b/net/bridge/br_private.h	2004-08-24 11:35:08 -07:00
@@ -177,7 +177,7 @@
 
 /* br_input.c */
 extern int br_handle_frame_finish(struct sk_buff *skb);
-extern int br_handle_frame(struct sk_buff *skb);
+extern int br_handle_frame(struct net_bridge_port *p, struct sk_buff **pskb);
 
 /* br_ioctl.c */
 extern int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2004-08-24 11:35:08 -07:00
+++ b/net/core/dev.c	2004-08-24 11:35:08 -07:00
@@ -1684,35 +1684,26 @@
 
 
 #if defined(CONFIG_BRIDGE) || defined (CONFIG_BRIDGE_MODULE)
-int (*br_handle_frame_hook)(struct sk_buff *skb);
+int (*br_handle_frame_hook)(struct net_bridge_port *p, struct sk_buff **pskb);
 
-static __inline__ int handle_bridge(struct sk_buff *skb,
-				     struct packet_type *pt_prev)
+static __inline__ int handle_bridge(struct sk_buff **pskb,
+				    struct packet_type **pt_prev, int *ret)
 {
-	int ret = NET_RX_DROP;
-	if (pt_prev)
-		ret = deliver_skb(skb, pt_prev);
-
-	return ret;
-}
-
-#endif
+	struct net_bridge_port *port = rcu_dereference((*pskb)->dev->br_port);
 
-static inline int __handle_bridge(struct sk_buff *skb,
-			struct packet_type **pt_prev, int *ret)
-{
-#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-	if (skb->dev->br_port && skb->pkt_type != PACKET_LOOPBACK) {
-		*ret = handle_bridge(skb, *pt_prev);
-		if (br_handle_frame_hook(skb) == 0)
-			return 1;
+	if (port == NULL || (*pskb)->pkt_type == PACKET_LOOPBACK) 
+		return 0;
 
+	if (*pt_prev) {
+		*ret = deliver_skb(*pskb, *pt_prev);
 		*pt_prev = NULL;
-	}
-#endif
-	return 0;
+	} 
+	
+	return br_handle_frame_hook(port, pskb) == 0;
 }
-
+#else
+#define handle_bridge(skb, pt_prev, ret)	(0)
+#endif
 
 #ifdef CONFIG_NET_CLS_ACT
 /* TODO: Maybe we should just force sch_ingress to be compiled in
@@ -1818,7 +1809,7 @@
 
 	handle_diverter(skb);
 
-	if (__handle_bridge(skb, &pt_prev, &ret))
+	if (handle_bridge(&skb, &pt_prev, &ret))
 		goto out;
 
 	type = skb->protocol;
