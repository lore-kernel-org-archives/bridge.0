Return-Path: <pablo@netfilter.org>
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu,  4 Apr 2019 13:56:38 +0200
Message-Id: <20190404115638.28592-1-pablo@netfilter.org>
Subject: [Bridge] [PATCH net-next] net: bridge: update multicast stats from
	maybe_deliver()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, nbd@nbd.name

Simplify this code by updating bridge multicast stats from
maybe_deliver().

Note that commit 6db6f0eae605 ("bridge: multicast to unicast"), in case
the port flag BR_MULTICAST_TO_UNICAST is set, never updates the previous
port pointer, therefore it is always going to be different from the
existing port in this deduplicated list iteration.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/bridge/br_forward.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 48ddc60b4fbd..82225b8b54f5 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -173,6 +173,7 @@ static struct net_bridge_port *maybe_deliver(
 	struct net_bridge_port *prev, struct net_bridge_port *p,
 	struct sk_buff *skb, bool local_orig)
 {
+	u8 igmp_type = br_multicast_igmp_type(skb);
 	int err;
 
 	if (!should_deliver(p, skb))
@@ -184,8 +185,9 @@ static struct net_bridge_port *maybe_deliver(
 	err = deliver_clone(prev, skb, local_orig);
 	if (err)
 		return ERR_PTR(err);
-
 out:
+	br_multicast_count(p->br, p, skb, igmp_type, BR_MCAST_DIR_TX);
+
 	return p;
 }
 
@@ -193,7 +195,6 @@ static struct net_bridge_port *maybe_deliver(
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig)
 {
-	u8 igmp_type = br_multicast_igmp_type(skb);
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
 
@@ -226,9 +227,6 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		prev = maybe_deliver(prev, p, skb, local_orig);
 		if (IS_ERR(prev))
 			goto out;
-		if (prev == p)
-			br_multicast_count(p->br, p, skb, igmp_type,
-					   BR_MCAST_DIR_TX);
 	}
 
 	if (!prev)
@@ -277,7 +275,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			bool local_rcv, bool local_orig)
 {
 	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
-	u8 igmp_type = br_multicast_igmp_type(skb);
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
@@ -304,13 +301,9 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		}
 
 		prev = maybe_deliver(prev, port, skb, local_orig);
-delivered:
 		if (IS_ERR(prev))
 			goto out;
-		if (prev == port)
-			br_multicast_count(port->br, port, skb, igmp_type,
-					   BR_MCAST_DIR_TX);
-
+delivered:
 		if ((unsigned long)lport >= (unsigned long)port)
 			p = rcu_dereference(p->next);
 		if ((unsigned long)rport >= (unsigned long)port)
-- 
2.11.0

