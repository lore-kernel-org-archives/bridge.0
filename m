Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed,  4 Sep 2013 02:13:38 +0200
Message-Id: <1378253619-23918-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1378253619-23918-1-git-send-email-linus.luessing@web.de>
References: <1378253619-23918-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/2] bridge: prevent flooding IPv6 packets
	that do not have a listener
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Adam Baker <linux@baker-net.org.uk>, Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, "David S. Miller" <davem@davemloft.net>, Cong Wang <amwang@redhat.com>

Currently if there is no listener for a certain group then IPv6 packets
for that group are flooded on all ports, even though there might be no
host and router interested in it on a port.

With this commit they are only forwarded to ports with a multicast
router.

Just like commit bd4265fe36 ("bridge: Only flood unregistered groups
to routers") did for IPv4, let's do the same for IPv6 with the same
reasoning.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index bbcb435..662ba7b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1547,8 +1547,14 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 	 *  - MLD has always Router Alert hop-by-hop option
 	 *  - But we do not support jumbrograms.
 	 */
-	if (ip6h->version != 6 ||
-	    ip6h->nexthdr != IPPROTO_HOPOPTS ||
+	if (ip6h->version != 6)
+		return 0;
+
+	/* Prevent flooding this packet if there is no listener present */
+	if (ipv6_is_transient_multicast(&ip6h->daddr))
+		BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
+
+	if (ip6h->nexthdr != IPPROTO_HOPOPTS ||
 	    ip6h->payload_len == 0)
 		return 0;
 
-- 
1.7.10.4

