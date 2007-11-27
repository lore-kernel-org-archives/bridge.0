Message-ID: <474C43F4.5080704@openvz.org>
Date: Tue, 27 Nov 2007 19:21:08 +0300
From: Pavel Emelyanov <xemul@openvz.org>
MIME-Version: 1.0
Subject: [PATCH (resubmit)][BRIDGE] Properly dereference the
	br_should_route_hook
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>, Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.osdl.org, devel@openvz.org

This hook is protected with the RCU, so simple

	if (br_should_route_hook)
		br_should_route_hook(...)

is not enough on some architectures.

Use the rcu_dereference/rcu_assign_pointer in this case.

Fixed Stephen's comment concerning using the typeof().

Signed-off-by: Pavel Emelyanov <xemul@openvz.org>

---

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 3cedd4e..0ee79a7 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -122,6 +122,7 @@ static inline int is_link_local(const unsigned char *dest)
 struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)
 {
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
+	int (*rhook)(struct sk_buff *skb);
 
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
 		goto drop;
@@ -147,9 +148,9 @@ struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)
 
 	switch (p->state) {
 	case BR_STATE_FORWARDING:
-
-		if (br_should_route_hook) {
-			if (br_should_route_hook(skb))
+		rhook = rcu_dereference(br_should_route_hook);
+		if (rhook != NULL) {
+			if (rhook(skb))
 				return skb;
 			dest = eth_hdr(skb)->h_dest;
 		}
diff --git a/net/bridge/netfilter/ebtable_broute.c b/net/bridge/netfilter/ebtable_broute.c
index e44519e..be6f186 100644
--- a/net/bridge/netfilter/ebtable_broute.c
+++ b/net/bridge/netfilter/ebtable_broute.c
@@ -70,13 +70,13 @@ static int __init ebtable_broute_init(void)
 	if (ret < 0)
 		return ret;
 	/* see br_input.c */
-	br_should_route_hook = ebt_broute;
+	rcu_assign_pointer(br_should_route_hook, ebt_broute);
 	return ret;
 }
 
 static void __exit ebtable_broute_fini(void)
 {
-	br_should_route_hook = NULL;
+	rcu_assign_pointer(br_should_route_hook, NULL);
 	synchronize_net();
 	ebt_unregister_table(&broute_table);
 }
