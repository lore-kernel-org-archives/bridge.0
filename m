Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GSx4QIELcR9xkyWBBehy9lJ5hvGJj8dGQFampul0IVo=;
	b=c07Tl1f1180GeriB7zwf34KMNMsCmC/35YWN2Xf7IiGiK2diGwyj2aLaRuQ5b1sDmD
	g/fu1pIACSjwIQd/ayCbGYfovi7AWeJm+ZOPyfiW1/RtwRVvY2pXOW0i+tY3uzayykT2
	EH6Tnx3B37L0IDhBlr2e1XLQgEH67keGETSCA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  2 Jul 2019 15:00:20 +0300
Message-Id: <20190702120021.13096-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 3/4] net: bridge: don't cache ether dest
	pointer on input
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: martin@linuxlounge.net, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, davem@davemloft.net

We would cache ether dst pointer on input in br_handle_frame_finish but
after the neigh suppress code that could lead to a stale pointer since
both ipv4 and ipv6 suppress code do pskb_may_pull. This means we have to
always reload it after the suppress code so there's no point in having
it cached just retrieve it directly.

Fixes: 057658cb33fbf ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_input.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 21b74e7a7b2f..52c712984cc7 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -74,7 +74,6 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_fdb_entry *dst = NULL;
 	struct net_bridge_mdb_entry *mdst;
 	bool local_rcv, mcast_hit = false;
-	const unsigned char *dest;
 	struct net_bridge *br;
 	u16 vid = 0;
 
@@ -92,10 +91,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, false);
 
 	local_rcv = !!(br->dev->flags & IFF_PROMISC);
-	dest = eth_hdr(skb)->h_dest;
-	if (is_multicast_ether_addr(dest)) {
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest)) {
 		/* by definition the broadcast is also a multicast address */
-		if (is_broadcast_ether_addr(dest)) {
+		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
 			pkt_type = BR_PKT_BROADCAST;
 			local_rcv = true;
 		} else {
@@ -145,7 +143,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		}
 		break;
 	case BR_PKT_UNICAST:
-		dst = br_fdb_find_rcu(br, dest, vid);
+		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
 	default:
 		break;
 	}
-- 
2.21.0

