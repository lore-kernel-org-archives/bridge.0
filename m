Date: Fri, 2 Mar 2007 14:14:18 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070302141418.1daa9047@freekitty>
In-Reply-To: <20070302140929.262e8460@freekitty>
References: <20070228171846.679d8733@dxpl.pdx.osdl.net>
	<20070302.132638.38710461.davem@davemloft.net>
	<20070302140929.262e8460@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [RFC 2/2] bridge: per device promiscious taps
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

Part of the next set of bridge patches includes this.

It allows packet capture by interface on a bridge:
	tcpdump -i eth0

will work as expected.

@@ -128,34 +125,45 @@ static inline int is_link_local(const un
 int br_handle_frame(struct net_bridge_port *p, struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
+	struct sk_buff *skb2 = NULL;
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
 
	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
		goto err;

 	if (unlikely(is_link_local(dest))) {
 		skb->pkt_type = PACKET_HOST;
 		return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
 			       NULL, br_handle_local_finish) != 0;
 	}
+
+	if (unlikely(p->dev->promiscuity > 1))
+		skb2 = skb_clone(skb, GFP_ATOMIC);
 
-	if (p->state == BR_STATE_FORWARDING || p->state == BR_STATE_LEARNING) {
+	switch (p->state) {
+	case BR_STATE_FORWARDING:
 		if (br_should_route_hook) {
-			if (br_should_route_hook(pskb))
+			if (br_should_route_hook(pskb)) {
+				kfree_skb(skb2);
 				return 0;
+			}
 			skb = *pskb;
 			dest = eth_hdr(skb)->h_dest;
 		}
 
 		if (!compare_ether_addr(p->br->dev->dev_addr, dest))
 			skb->pkt_type = PACKET_HOST;
+		/* fall thru */
 
+	case BR_STATE_LEARNING:
 		NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
 			br_handle_frame_finish);
-		return 1;
+		break;
+
+	default:
+		kfree_skb(skb);
 	}
 
-err:
-	kfree_skb(skb);
-	return 1;
+	if (likely(!skb2))
+		return 1;
+
+	*pskb = skb2;
+	return 0;
 }
