From: Changli Gao <xiaosuo@gmail.com>
Date: Fri, 20 Aug 2010 13:03:16 +0800
Message-Id: <1282280596-18992-1-git-send-email-xiaosuo@gmail.com>
Subject: [Bridge] [PATCH] bridge: netfilter: fix a memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Changli Gao <xiaosuo@gmail.com>

nf_bridge_alloc() always reset the skb->nf_bridge, so we should always
put the old one. skb->nf_bridge->use is initialized in nf_bridge_alloc(),
so we don't need to initialize it again.

Signed-off-by: Changli Gao <xiaosuo@gmail.com>
---
 net/bridge/br_netfilter.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 2c911c0..7fde554 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -159,11 +159,9 @@ static inline struct nf_bridge_info *nf_bridge_unshare(struct sk_buff *skb)
 	if (atomic_read(&nf_bridge->use) > 1) {
 		struct nf_bridge_info *tmp = nf_bridge_alloc(skb);
 
-		if (tmp) {
+		if (tmp)
 			memcpy(tmp, nf_bridge, sizeof(struct nf_bridge_info));
-			atomic_set(&tmp->use, 1);
-			nf_bridge_put(nf_bridge);
-		}
+		nf_bridge_put(nf_bridge);
 		nf_bridge = tmp;
 	}
 	return nf_bridge;
