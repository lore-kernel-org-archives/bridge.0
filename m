Return-Path: <holger.brunck@keymile.com>
From: Holger Brunck <holger.brunck@keymile.com>
Message-Id: <1320941934-3534-1-git-send-email-holger.brunck@keymile.com>
Subject: [Bridge] [PATCH] net, bridge: print log message after state changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 10 Nov 2011 16:18:11 -0000
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <shemminger@linux-foundation.org>, bridge@lists.linux-foundation.org, Holger Brunck <holger.brunck@keymile.com>, Wolfgang Fritz <wolfgang.fritz@keymile.com>, "David S. Miller" <davem@davemloft.net>

From: Wolfgang Fritz <wolfgang.fritz@keymile.com>

Function br_log_state writes log message "... entering XXXX state" so it
should be called after the state has changed and not before.

Signed-off-by: Wolfgang Fritz <wolfgang.fritz@keymile.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Stephen Hemminger <shemminger@linux-foundation.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: bridge@lists.linux-foundation.org
---
 net/bridge/br_stp_if.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 19308e3..e91be40 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -98,8 +98,6 @@ void br_stp_disable_port(struct net_bridge_port *p)
 	struct net_bridge *br = p->br;
 	int wasroot;
 
-	br_log_state(p);
-
 	wasroot = br_is_root_bridge(br);
 	br_become_designated_port(p);
 	p->state = BR_STATE_DISABLED;
@@ -121,6 +119,8 @@ void br_stp_disable_port(struct net_bridge_port *p)
 
 	if (br_is_root_bridge(br) && !wasroot)
 		br_become_root_bridge(br);
+
+	br_log_state(p);
 }
 
 static void br_stp_start(struct net_bridge *br)
-- 
1.7.1

