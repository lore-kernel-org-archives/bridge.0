Date: Fri, 15 May 2009 09:10:13 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090515091013.44b624d7@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 1/2] bridge: relay bridge multicast pkgs if !STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, bridge@linux-foundation.org, netdev@vger.kernel.org

Currently the bridge catches all STP packets; even if STP is turned
off.  This prevents other systems (which do have STP turned on)
from being able to detect loops in the network.

With this patch, if STP is off, then any packet sent to the STP
multicast group address is forwarded to all ports.

Based on earlier patch by Joakim Tjernlund with changes
to go through forwarding (not local chain), and optimization
that only last octet needs to be checked.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

---
Please put in for 2.6.30 because it is a bug fix.

--- a/net/bridge/br_input.c	2009-05-14 14:50:29.288882708 -0700
+++ b/net/bridge/br_input.c	2009-05-15 09:01:31.799417662 -0700
@@ -134,6 +134,10 @@ struct sk_buff *br_handle_frame(struct n
 		if (skb->protocol == htons(ETH_P_PAUSE))
 			goto drop;
 
+		/* If STP is turned off, then forward */
+		if (p->br->stp_enabled == BR_NO_STP && dest[5] == 0)
+			goto forward;
+
 		if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
 			    NULL, br_handle_local_finish))
 			return NULL;	/* frame consumed by filter */
@@ -141,6 +145,7 @@ struct sk_buff *br_handle_frame(struct n
 			return skb;	/* continue processing */
 	}
 
+forward:
 	switch (p->state) {
 	case BR_STATE_FORWARDING:
 		rhook = rcu_dereference(br_should_route_hook);
