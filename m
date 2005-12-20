Message-Id: <20051220232154.858392000@localhost.localdomain>
References: <20051220231949.772360000@localhost.localdomain>
Date: Tue, 20 Dec 2005 15:19:52 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Content-Disposition: inline; filename=br-learn-fdb.patch
Subject: [Bridge] [PATCH 3/5] bridge: filter packets in learning state
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@osdl.org

While in the learning state, run filters but drop the result.
This prevents us from acquiring bad fdb entries in learning state.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- br-2.6.orig/net/bridge/br_input.c
+++ br-2.6/net/bridge/br_input.c
@@ -53,6 +53,11 @@ int br_handle_frame_finish(struct sk_buf
 	/* insert into forwarding database after filtering to avoid spoofing */
 	br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
 
+	if (p->state == BR_STATE_LEARNING) {
+		kfree_skb(skb);
+		goto out;
+	}
+
 	if (br->dev->flags & IFF_PROMISC) {
 		struct sk_buff *skb2;
 
@@ -107,9 +112,6 @@ int br_handle_frame(struct net_bridge_po
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
 		goto err;
 
-	if (p->state == BR_STATE_LEARNING)
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
-
 	if (p->br->stp_enabled &&
 	    !memcmp(dest, bridge_ula, 5) &&
 	    !(dest[5] & 0xF0)) {
@@ -118,9 +120,10 @@ int br_handle_frame(struct net_bridge_po
 				NULL, br_stp_handle_bpdu);
 			return 1;
 		}
+		goto err;
 	}
 
-	else if (p->state == BR_STATE_FORWARDING) {
+	if (p->state == BR_STATE_FORWARDING || p->state == BR_STATE_LEARNING) {
 		if (br_should_route_hook) {
 			if (br_should_route_hook(pskb)) 
 				return 0;

--
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger

