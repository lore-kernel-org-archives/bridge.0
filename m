Date: Fri, 6 Aug 2004 09:13:05 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Fw: [Bridge] Re:  Any way of knowing a packet's been defragmented
Message-Id: <20040806091305.4d405664@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: bridge@osdl.org

Dave, this patch from Bart De Schuymer <bdschuym@pandora.be> fixes problems
when using filtering and defragmentation.  The bridge needs to enforce the
MTU restriction after going through the filtering chain not before, because
the incoming filter may have reassembled an IP packet, that then needs to
be fragmented on the output chain.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c	2004-08-06 09:12:41 -07:00
+++ b/net/bridge/br_forward.c	2004-08-06 09:12:41 -07:00
@@ -23,7 +23,6 @@
 				 const struct sk_buff *skb)
 {
 	if (skb->dev == p->dev ||
-	    skb->len > p->dev->mtu ||
 	    p->state != BR_STATE_FORWARDING)
 		return 0;
 
@@ -32,13 +31,17 @@
 
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
+	if (skb->len > skb->dev->mtu) 
+		kfree_skb(skb);
+	else {
 #ifdef CONFIG_BRIDGE_NETFILTER
-	/* ip_refrag calls ip_fragment, which doesn't copy the MAC header. */
-	nf_bridge_maybe_copy_header(skb);
+		/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
+		nf_bridge_maybe_copy_header(skb);
 #endif
-	skb_push(skb, ETH_HLEN);
+		skb_push(skb, ETH_HLEN);
 
-	dev_queue_xmit(skb);
+		dev_queue_xmit(skb);
+	}
 
 	return 0;
 }
