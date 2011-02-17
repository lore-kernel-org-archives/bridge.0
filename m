From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 17 Feb 2011 19:17:51 +0100
Message-Id: <1297966672-3457-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <20110215154128.2a28632c@nehalam>
References: <20110215154128.2a28632c@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH 1/2] bridge: Fix MLD queries' ethernet source
	address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>

Map the IPv6 header's destination multicast address to an ethernet
source address instead of the MLD queries multicast address.

For instance for a general MLD query (multicast address in the MLD query
set to ::), this would wrongly be mapped to 33:33:00:00:00:00, although
an MLD queries destination MAC should always be 33:33:00:00:00:01 which
matches the IPv6 header's multicast destination ff02::1.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b5eb28a..f904a2e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -435,7 +435,6 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge *br,
 	eth = eth_hdr(skb);
 
 	memcpy(eth->h_source, br->dev->dev_addr, 6);
-	ipv6_eth_mc_map(group, eth->h_dest);
 	eth->h_proto = htons(ETH_P_IPV6);
 	skb_put(skb, sizeof(*eth));
 
@@ -449,6 +448,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge *br,
 	ip6h->hop_limit = 1;
 	ipv6_addr_set(&ip6h->saddr, 0, 0, 0, 0);
 	ipv6_addr_set(&ip6h->daddr, htonl(0xff020000), 0, 0, htonl(1));
+	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
 	hopopt = (u8 *)(ip6h + 1);
 	hopopt[0] = IPPROTO_ICMPV6;		/* next hdr */
-- 
1.7.2.3

