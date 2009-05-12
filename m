From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 12 May 2009 19:34:32 +0200
Message-Id: <1242149672-14964-1-git-send-email-Joakim.Tjernlund@transmode.se>
Subject: [Bridge] [PATCH] bridge: Relay bridge multicast pkgs if !STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Currently the bridge drops all STP pkgs when
STP is off. This makes the bridge relay the Bridge Group
multicast address, 01:80:c2:00:00:00, when STP is off.
This allows for loop detection by other bridges doing STP.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
V2:
 - Use compare_ether_address()
 - Invert if logic, hopefully easier to read?
 net/bridge/br_input.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 30b8877..0bd175c 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -137,7 +137,9 @@ struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)
 		if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
 			    NULL, br_handle_local_finish))
 			return NULL;	/* frame consumed by filter */
-		else
+		/* Relay Bridge Group address if STP is off */
+		if (p->br->stp_enabled != BR_NO_STP ||
+		    compare_ether_addr(dest, br_group_address))
 			return skb;	/* continue processing */
 	}
 
-- 
1.6.2.3

