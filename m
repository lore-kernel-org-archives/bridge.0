Date: Mon, 23 Apr 2007 16:56:14 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] linux bridge does not bridge bpdu packets
Message-ID: <20070423165614.6eadfaae@localhost.localdomain>
In-Reply-To: <60386.193.196.136.17.1177336334.squirrel@sleon.dyndns.org>
References: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
	<462B9243.6070804@linux-foundation.org>
	<24321.193.196.136.17.1177322032.squirrel@sleon.dyndns.org>
	<60386.193.196.136.17.1177336334.squirrel@sleon.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: sleon@sleon.dyndns.org
Cc: bridge@lists.linux-foundation.org


> > this makes my "stealth" bridge not stealphy anymore!
> > because you can see in bptu packets its mac.
> >
> > That is what i want to prevent.
> > I want it to be completely transparent and not seen in the network
> > traffic.
> >
> > So should i patch the kernel for it ?

Hmm.. My first priority is to make sure that the bridge
code is stable for users, ie it doesn't cause network disasters.
Second, is following the standard, and third is making it
useful for all the wierd tricks (like being fully transparent)
that everyone seems to want the code to do.

But in this case, I think if STP is disabled, the bridge would
be more stable if it just forwarded the spanning tree packets.
The rationale is that if someone leaves STP off on one bridge,
but there are multiple paths from a bridge that is using spanning
tree; then the bridge that is doing STP will see and break the
potentially disastrous network loop.

Therefore, I suggest the following (probably not until 2.6.22)
change:

From 6188ced799c07054c64b0e15a645c674b0d256b8 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Mon, 23 Apr 2007 16:54:20 -0700
Subject: [PATCH] bridge: forward STP BPDU's if not doing spanning tree

If not doing spanning tree protocol than it is safer to just forward
any STP BPDU's received. This allows any device using STP to still
detect loops if there is a misconnected transparent bridge.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
---
 net/bridge/br_input.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 8a55276..85605bd 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -131,8 +131,9 @@ struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
 		goto drop;
 
-	if (unlikely(is_link_local(dest))) {
-		skb->pkt_type = PACKET_HOST;
+	/* Don't forward 802.1x packets */
+	if (p->br->stp_enabled != BR_NO_STP && is_link_local(dest)) {
+		skb->pkt_type = PACKET_MULTICAST;
 
 		return (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
 				NULL, br_handle_local_finish) == 0) ? skb : NULL;
-- 
1.5.0.6


