Date: Sat, 20 Mar 2010 14:20:49 +0300
From: Dan Carpenter <error27@gmail.com>
Message-ID: <20100320112049.GU5331@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [patch] bridge: cleanup: remove unused assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, Michael Braun <michael-dev@fami-braun.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>

We never actually use iph again so this assignment can be removed.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6980625..9f0c4f0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1003,8 +1003,6 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 	if (!pskb_may_pull(skb2, sizeof(*ih)))
 		goto out;
 
-	iph = ip_hdr(skb2);
-
 	switch (skb2->ip_summed) {
 	case CHECKSUM_COMPLETE:
 		if (!csum_fold(skb2->csum))
