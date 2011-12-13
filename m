Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Tue, 13 Dec 2011 11:36:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201112131136.25919.vitas@nppfactor.kiev.ua>
Subject: [Bridge] [PATCH] bridge: push blocking slaves to forwarding when
	turning stp off
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

If there is a slave in blocking state when stp is turned off, that slave will 
remain in blocking state for indefinitely long time until interface state 
changed. We should push all blocking slaves into forwarding state after 
turning stp off.

Signed-off-by: Vitalii Demianets <vitas@nppfactor.kiev.ua>

---
 net/bridge/br_stp.c    |    5 ++++-
 net/bridge/br_stp_if.c |   10 +++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index dd147d7..aed7e21 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -415,7 +415,10 @@ void br_port_state_selection(struct net_bridge *br)
 			} else {
 				p->config_pending = 0;
 				p->topology_change_ack = 0;
-				br_make_blocking(p);
+				if(br->stp_enabled == BR_NO_STP)
+					br_make_forwarding(p);
+				else
+					br_make_blocking(p);
 			}
 		}
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 19308e3..38d8dd7 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -153,14 +153,14 @@ static void br_stp_stop(struct net_bridge *br)
 	if (br->stp_enabled == BR_USER_STP) {
 		r = call_usermodehelper(BR_STP_PROG, argv, envp, UMH_WAIT_PROC);
 		br_info(br, "userspace STP stopped, return code %d\n", r);
-
-		/* To start timers on any ports left in blocking */
-		spin_lock_bh(&br->lock);
-		br_port_state_selection(br);
-		spin_unlock_bh(&br->lock);
 	}
 
 	br->stp_enabled = BR_NO_STP;
+
+	/* To push in forwarding state any ports left in blocking */
+	spin_lock_bh(&br->lock);
+	br_port_state_selection(br);
+	spin_unlock_bh(&br->lock);
 }
 
 void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
-- 
1.7.3.4
