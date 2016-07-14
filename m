Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=av6iEXasn4p191FKuQpTxhNJxCzWBVX+TsfSgWgQL8Q=;
	b=Xi3U6SuJB0NNojGkFZpHWJZnHiaXPIvFKs71M3Eqyb43p9A+zCn63x3cS9VTbp1ubC
	NaTsb5gqbH2xQagqqD2RtOn/9luhN0uqMY0S2+tkufOm/XUilrw/sFjfCHga9Vf05me9
	gUV2vwyJ8ky8ay9V/E/qNrMsfhyBCW/teN+rI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 14 Jul 2016 06:09:59 +0300
Message-Id: <1468465802-4571-2-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1468465802-4571-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/4] net: bridge: minor style adjustments
	in br_handle_frame_finish
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Trivial style changes in br_handle_frame_finish.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_input.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index a7817e6f306f..0b6d32619468 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -131,11 +131,11 @@ static void br_do_proxy_arp(struct sk_buff *skb, struct net_bridge *br,
 /* note: already called with rcu_read_lock */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	const unsigned char *dest = eth_hdr(skb)->h_dest;
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
-	struct net_bridge *br;
-	struct net_bridge_fdb_entry *dst;
+	const unsigned char *dest = eth_hdr(skb)->h_dest;
+	struct net_bridge_fdb_entry *dst = NULL;
 	struct net_bridge_mdb_entry *mdst;
+	struct net_bridge *br;
 	struct sk_buff *skb2;
 	bool unicast = true;
 	u16 vid = 0;
@@ -166,8 +166,6 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (br->dev->flags & IFF_PROMISC)
 		skb2 = skb;
 
-	dst = NULL;
-
 	if (IS_ENABLED(CONFIG_INET) && skb->protocol == htons(ETH_P_ARP))
 		br_do_proxy_arp(skb, br, vid, p);
 
@@ -185,13 +183,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			skb = NULL;
 			if (!skb2)
 				goto out;
-		} else
+		} else {
 			skb2 = skb;
-
+		}
 		unicast = false;
 		br->dev->stats.multicast++;
-	} else if ((dst = __br_fdb_get(br, dest, vid)) &&
-			dst->is_local) {
+	} else if ((dst = __br_fdb_get(br, dest, vid)) && dst->is_local) {
 		skb2 = skb;
 		/* Do not forward the packet since it's local. */
 		skb = NULL;
@@ -201,8 +198,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		if (dst) {
 			dst->used = jiffies;
 			br_forward(dst->dst, skb, skb2);
-		} else
+		} else {
 			br_flood_forward(br, skb, skb2, unicast);
+		}
 	}
 
 	if (skb2)
-- 
2.4.3

