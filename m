From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 27 Mar 2011 08:27:24 +0200
Message-Id: <1301207244-10428-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1301207244-10428-1-git-send-email-linus.luessing@web.de>
References: <20110327034404.GC31916@Sellars>
	<1301207244-10428-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH] bridge: mcast snooping,
	fix length check of snooped MLDv1/2
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

"len = ntohs(ip6h->payload_len)" does not include the length of the ipv6
header itself, which the rest of this function assumes, though.

This leads to a length check less restrictive as it should be in the
following line for one thing. For another, it very likely leads to an
integer underrun when substracting the offset and therefore to a very
high new value of 'len' due to its unsignedness. This will ultimately
lead to the pskb_trim_rcsum() practically never being called, even in
the cases where it should.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 47fae4f..3793264 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1475,7 +1475,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 	    ip6h->payload_len == 0)
 		return 0;
 
-	len = ntohs(ip6h->payload_len);
+	len = ntohs(ip6h->payload_len) + sizeof(*ip6h);
 	if (skb->len < len)
 		return -EINVAL;
 
-- 
1.5.6.5

