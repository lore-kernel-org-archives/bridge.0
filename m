From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 17 Feb 2011 19:17:52 +0100
Message-Id: <1297966672-3457-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <20110215154128.2a28632c@nehalam>
References: <20110215154128.2a28632c@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH 2/2] bridge: Use IPv6 link-local address for
	multicast listener queries
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

Currently the bridge multicast snooping feature periodically issues
IPv6 general multicast listener queries to sense the absence of a
listener.

For this, it uses :: as its source address - however RFC 2710 requires:
"To be valid, the Query message MUST come from a link-local IPv6 Source
Address". Current Linux kernel versions seem to follow this requirement
and ignore our bogus MLD queries.

With this commit a link local address from the bridge interface is being
used to issue the MLD query, resulting in other Linux devices which are
multicast listeners in the network to respond with a MLD response (which
was not the case before).

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f904a2e..2d88861 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -446,7 +446,8 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge *br,
 	ip6h->payload_len = htons(8 + sizeof(*mldq));
 	ip6h->nexthdr = IPPROTO_HOPOPTS;
 	ip6h->hop_limit = 1;
-	ipv6_addr_set(&ip6h->saddr, 0, 0, 0, 0);
+	ipv6_dev_get_saddr(dev_net(br->dev), br->dev, &ip6h->daddr, 0,
+			   &ip6h->saddr);
 	ipv6_addr_set(&ip6h->daddr, htonl(0xff020000), 0, 0, htonl(1));
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
-- 
1.7.2.3

