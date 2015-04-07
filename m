Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue,  7 Apr 2015 21:57:29 +0200
Message-Id: <1428436652-4676-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1428436652-4676-1-git-send-email-linus.luessing@c0d3.blue>
References: <1428436652-4676-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFCv3 1/4] bridge: multicast: call
 skb_checksum_{simple_, }validate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

Let's use these new, neat helpers.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c |   28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index c465876..3c630c7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1609,16 +1609,8 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 	if (!pskb_may_pull(skb2, sizeof(*ih)))
 		goto out;
 
-	switch (skb2->ip_summed) {
-	case CHECKSUM_COMPLETE:
-		if (!csum_fold(skb2->csum))
-			break;
-		/* fall through */
-	case CHECKSUM_NONE:
-		skb2->csum = 0;
-		if (skb_checksum_complete(skb2))
-			goto out;
-	}
+	if (skb_checksum_simple_validate(skb2))
+		goto out;
 
 	err = 0;
 
@@ -1736,20 +1728,8 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 
 	ip6h = ipv6_hdr(skb2);
 
-	switch (skb2->ip_summed) {
-	case CHECKSUM_COMPLETE:
-		if (!csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr, skb2->len,
-					IPPROTO_ICMPV6, skb2->csum))
-			break;
-		/*FALLTHROUGH*/
-	case CHECKSUM_NONE:
-		skb2->csum = ~csum_unfold(csum_ipv6_magic(&ip6h->saddr,
-							&ip6h->daddr,
-							skb2->len,
-							IPPROTO_ICMPV6, 0));
-		if (__skb_checksum_complete(skb2))
-			goto out;
-	}
+	if (skb_checksum_validate(skb2, IPPROTO_ICMPV6, ip6_compute_pseudo))
+		goto out;
 
 	err = 0;
 
-- 
1.7.10.4

