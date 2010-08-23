From: Changli Gao <xiaosuo@gmail.com>
Date: Mon, 23 Aug 2010 13:03:26 +0800
Message-Id: <1282539806-25496-1-git-send-email-xiaosuo@gmail.com>
Subject: [Bridge] [PATCH v2] bridge: netfilter: fix a memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Changli Gao <xiaosuo@gmail.com>

nf_bridge_alloc() always reset the skb->nf_bridge, so we should always
put the old one.

Signed-off-by: Changli Gao <xiaosuo@gmail.com>
---
v2: Should init tmp->use again because memcpy() overwrite it.
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 2c911c0..5ed00bd 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -162,8 +162,8 @@ static inline struct nf_bridge_info *nf_bridge_unshare(struct sk_buff *skb)
 		if (tmp) {
 			memcpy(tmp, nf_bridge, sizeof(struct nf_bridge_info));
 			atomic_set(&tmp->use, 1);
-			nf_bridge_put(nf_bridge);
 		}
+		nf_bridge_put(nf_bridge);
 		nf_bridge = tmp;
 	}
 	return nf_bridge;
