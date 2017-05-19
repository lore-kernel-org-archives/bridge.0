Return-Path: <cera@cera.cz>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com AF44B80468
From: Ivan Vecera <cera@cera.cz>
Date: Fri, 19 May 2017 18:25:43 +0200
Message-Id: <20170519162543.31670-1-cera@cera.cz>
Subject: [Bridge] [PATCH net] bridge: fix hello and hold timers
	starting/stopping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: lucien.xin@gmail.com, nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Current bridge code incorrectly handles starting/stopping of hello and
hold timers during STP enable/disable.

1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
   transition. This is not correct as the timers are stopped in NO_STP
   case.

2. Timers are started in br_stp_stop() during USER_STP->NO_STP transition.
   This is not also correct as the timers should be stopped in NO_STP
   state.

3. Timers are NOT stopped in br_stp_stop() during KERNEL_STP->NO_STP
   transition. They should be stopped as they are running in KERNEL_STP
   state and should not run in NO_STP case.

The patch is a follow-up for "bridge: start hello_timer when enabling
KERNEL_STP in br_stp_start" patch from Xin Long.

Cc: davem@davemloft.net
Cc: sashok@cumulusnetworks.com
Cc: stephen@networkplumber.org
Cc: bridge@lists.linux-foundation.org
Cc: lucien.xin@gmail.com
Cc: nikolay@cumulusnetworks.com
Signed-off-by: Ivan Vecera <cera@cera.cz>
---
 net/bridge/br_stp_if.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 0db8102995a5..f137ebf27755 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -150,7 +150,6 @@ static int br_stp_call_user(struct net_bridge *br, char *arg)
 
 static void br_stp_start(struct net_bridge *br)
 {
-	struct net_bridge_port *p;
 	int err = -ENOENT;
 
 	if (net_eq(dev_net(br->dev), &init_net))
@@ -169,11 +168,6 @@ static void br_stp_start(struct net_bridge *br)
 	if (!err) {
 		br->stp_enabled = BR_USER_STP;
 		br_debug(br, "userspace STP started\n");
-
-		/* Stop hello and hold timers */
-		del_timer(&br->hello_timer);
-		list_for_each_entry(p, &br->port_list, list)
-			del_timer(&p->hold_timer);
 	} else {
 		br->stp_enabled = BR_KERNEL_STP;
 		br_debug(br, "using kernel STP\n");
@@ -197,13 +191,14 @@ static void br_stp_stop(struct net_bridge *br)
 			br_err(br, "failed to stop userspace STP (%d)\n", err);
 
 		/* To start timers on any ports left in blocking */
-		mod_timer(&br->hello_timer, jiffies + br->hello_time);
-		list_for_each_entry(p, &br->port_list, list)
-			mod_timer(&p->hold_timer,
-				  round_jiffies(jiffies + BR_HOLD_TIME));
 		spin_lock_bh(&br->lock);
 		br_port_state_selection(br);
 		spin_unlock_bh(&br->lock);
+	} else {
+		/* BR_KERNEL_STP - stop hello and hold timers */
+		del_timer(&br->hello_timer);
+		list_for_each_entry(p, &br->port_list, list)
+			del_timer(&p->hold_timer);
 	}
 
 	br->stp_enabled = BR_NO_STP;
-- 
2.13.0

