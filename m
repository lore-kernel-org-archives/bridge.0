From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 27 Mar 2011 08:27:23 +0200
Message-Id: <1301207244-10428-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1301207244-10428-1-git-send-email-linus.luessing@web.de>
References: <20110327034404.GC31916@Sellars>
	<1301207244-10428-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH] bridge: mcast snooping,
	fix IPv6 MLD checksum calculation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>, =?utf-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, David Miller <davem@davemloft.net>

In contrast to IGMP, the MLDv1/2 message checksum needs to include an
IPv6 "pseudo-header" in the calculations (see RFC2710, section 3.3;
RFC3810, section 5.1.2).

The multicast snooping feature of the bridge code however did not take
this "pseudo-header" into consideration for the checksum validation when
parsing a snooped IPv6 MLDv1/2 message of another host, leading to
possibly ignored, though valid MLDv1/2 messages. This commit shall fix
this issue.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f61eb2e..47fae4f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1525,7 +1525,10 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 			break;
 		/*FALLTHROUGH*/
 	case CHECKSUM_NONE:
-		skb2->csum = 0;
+		skb2->csum = ~csum_unfold(csum_ipv6_magic(&ip6h->saddr,
+							  &ip6h->daddr,
+							  skb2->len,
+							  nexthdr, 0));
 		if (skb_checksum_complete(skb2))
 			goto out;
 	}
-- 
1.5.6.5

