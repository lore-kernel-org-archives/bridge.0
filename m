From: Bart De Schuymer <bdschuym@pandora.be>
Date: Sun, 15 Aug 2004 11:58:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408151158.55190.bdschuym@pandora.be>
Subject: [Bridge] [PATCH] fix oops when mangling and brouting and tcpdumping
	packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge <bridge@osdl.org>

Hi Stephen,

The ebtables brouting chain, traversed through the call
br_should_route_hook(), can alter a packet. The redirect target
does this, f.e., to change the MAC destination.

This is what ebt_redirect does (among other things):
	if (skb_shared(*pskb) || skb_cloned(*pskb)) {
		struct sk_buff *nskb;

		nskb = skb_copy(*pskb, GFP_ATOMIC);
		if (!nskb)
			return NF_DROP;
		if ((*pskb)->sk)
			skb_set_owner_w(nskb, (*pskb)->sk);
		kfree_skb(*pskb);
		*pskb = nskb;
	}

So, if the packet is cloned or shared, we need to copy everything
to a private skb. If br_should_route_hook() returns a non-zero value,
the packet will be brouted and we must make sure the used skb remains
nskb, not the deleted skb. For this, we need the address of the skb used
in netif_receive_skb().
An oops (caused by netif_receive_skb() using a freed skb) is easilly
triggered by this:
ebtables -t broute -A BROUTING -j redirect --redirect-target DROP
along with tcpdump -i bridge_port (and traffic trying to go by)

cheers,
Bart


--- linux-2.6.8.1/net/core/dev.c.old	2004-08-14 22:50:04.000000000 +0200
+++ linux-2.6.8.1/net/core/dev.c	2004-08-14 22:51:39.000000000 +0200
@@ -1685,7 +1685,7 @@ static __inline__ int deliver_skb(struct
 
 
 #if defined(CONFIG_BRIDGE) || defined (CONFIG_BRIDGE_MODULE)
-int (*br_handle_frame_hook)(struct sk_buff *skb);
+int (*br_handle_frame_hook)(struct sk_buff **pskb);
 
 static __inline__ int handle_bridge(struct sk_buff *skb,
 				     struct packet_type *pt_prev)
@@ -1699,13 +1699,13 @@ static __inline__ int handle_bridge(stru
 
 #endif
 
-static inline int __handle_bridge(struct sk_buff *skb,
+static inline int __handle_bridge(struct sk_buff **pskb,
 			struct packet_type **pt_prev, int *ret)
 {
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-	if (skb->dev->br_port && skb->pkt_type != PACKET_LOOPBACK) {
-		*ret = handle_bridge(skb, *pt_prev);
-		if (br_handle_frame_hook(skb) == 0)
+	if ((*pskb)->dev->br_port && (*pskb)->pkt_type != PACKET_LOOPBACK) {
+		*ret = handle_bridge(*pskb, *pt_prev);
+		if (br_handle_frame_hook(pskb) == 0)
 			return 1;
 
 		*pt_prev = NULL;
@@ -1819,7 +1819,7 @@ ncls:
 
 	handle_diverter(skb);
 
-	if (__handle_bridge(skb, &pt_prev, &ret))
+	if (__handle_bridge(&skb, &pt_prev, &ret))
 		goto out;
 
 	type = skb->protocol;
--- linux-2.6.8.1/include/linux/if_bridge.h.old	2004-08-14 22:50:09.000000000 +0200
+++ linux-2.6.8.1/include/linux/if_bridge.h	2004-08-14 22:51:39.000000000 +0200
@@ -105,7 +105,7 @@ struct __fdb_entry
 #include <linux/netdevice.h>
 
 extern void brioctl_set(int (*ioctl_hook)(unsigned int, void __user *));
-extern int (*br_handle_frame_hook)(struct sk_buff *skb);
+extern int (*br_handle_frame_hook)(struct sk_buff **pskb);
 extern int (*br_should_route_hook)(struct sk_buff **pskb);
 
 #endif
--- linux-2.6.8.1/net/bridge/br_private.h.old	2004-08-14 22:50:15.000000000 +0200
+++ linux-2.6.8.1/net/bridge/br_private.h	2004-08-14 22:51:39.000000000 +0200
@@ -177,7 +177,7 @@ extern int br_min_mtu(const struct net_b
 
 /* br_input.c */
 extern int br_handle_frame_finish(struct sk_buff *skb);
-extern int br_handle_frame(struct sk_buff *skb);
+extern int br_handle_frame(struct sk_buff **pskb);
 
 /* br_ioctl.c */
 extern int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
--- linux-2.6.8.1/net/bridge/br_input.c.old	2004-08-14 22:50:21.000000000 +0200
+++ linux-2.6.8.1/net/bridge/br_input.c	2004-08-14 22:51:39.000000000 +0200
@@ -104,30 +104,30 @@ out:
 	return 0;
 }
 
-int br_handle_frame(struct sk_buff *skb)
+int br_handle_frame(struct sk_buff **pskb)
 {
 	unsigned char *dest;
 	struct net_bridge_port *p;
 
-	dest = skb->mac.ethernet->h_dest;
+	dest = (*pskb)->mac.ethernet->h_dest;
 
 	rcu_read_lock();
-	p = skb->dev->br_port;
+	p = (*pskb)->dev->br_port;
 	if (p == NULL || p->state == BR_STATE_DISABLED)
 		goto err;
 
-	if (skb->mac.ethernet->h_source[0] & 1)
+	if ((*pskb)->mac.ethernet->h_source[0] & 1)
 		goto err;
 
 	if (p->state == BR_STATE_LEARNING ||
 	    p->state == BR_STATE_FORWARDING)
-		br_fdb_insert(p->br, p, skb->mac.ethernet->h_source, 0);
+		br_fdb_insert(p->br, p, (*pskb)->mac.ethernet->h_source, 0);
 
 	if (p->br->stp_enabled &&
 	    !memcmp(dest, bridge_ula, 5) &&
 	    !(dest[5] & 0xF0)) {
 		if (!dest[5]) {
-			NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev, 
+			NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, *pskb, (*pskb)->dev, 
 				NULL, br_stp_handle_bpdu);
 			rcu_read_unlock();
 			return 0;
@@ -135,15 +135,15 @@ int br_handle_frame(struct sk_buff *skb)
 	}
 
 	else if (p->state == BR_STATE_FORWARDING) {
-		if (br_should_route_hook && br_should_route_hook(&skb)) {
+		if (br_should_route_hook && br_should_route_hook(pskb)) {
 			rcu_read_unlock();
 			return -1;
 		}
 
 		if (!memcmp(p->br->dev->dev_addr, dest, ETH_ALEN))
-			skb->pkt_type = PACKET_HOST;
+			(*pskb)->pkt_type = PACKET_HOST;
 
-		NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
+		NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, *pskb, (*pskb)->dev, NULL,
 			br_handle_frame_finish);
 		rcu_read_unlock();
 		return 0;
@@ -151,6 +151,6 @@ int br_handle_frame(struct sk_buff *skb)
 
 err:
 	rcu_read_unlock();
-	kfree_skb(skb);
+	kfree_skb(*pskb);
 	return 0;
 }

