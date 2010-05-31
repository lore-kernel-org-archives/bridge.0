From: Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 23:23:13 +0200
Message-ID: <1275340993.2478.27.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next-2.6] br_netfilter: use skb_set_noref()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>, Patrick McHardy <kaber@trash.net>, David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

Avoid dirtying bridge_parent_rtable refcount, using new dst noref
infrastructure.

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
---
net/bridge/br_netfilter.c |    6 ++----
1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 4442099..cbea5af 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -244,8 +244,7 @@ static int br_nf_pre_routing_finish_ipv6(struct sk_buff *skb)
 		kfree_skb(skb);
 		return 0;
 	}
-	dst_hold(&rt->u.dst);
-	skb_dst_set(skb, &rt->u.dst);
+	skb_dst_set_noref(skb, &rt->u.dst);
 
 	skb->dev = nf_bridge->physindev;
 	nf_bridge_update_protocol(skb);
@@ -396,8 +395,7 @@ bridged_dnat:
 			kfree_skb(skb);
 			return 0;
 		}
-		dst_hold(&rt->u.dst);
-		skb_dst_set(skb, &rt->u.dst);
+		skb_dst_set_noref(skb, &rt->u.dst);
 	}
 
 	skb->dev = nf_bridge->physindev;



