Return-Path: <joakim.tjernlund@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 28 Feb 2012 19:37:10 +0100
Message-Id: <1330454231-23852-1-git-send-email-Joakim.Tjernlund@transmode.se>
Subject: [Bridge] [PATCH 1/2] bridge: Adjust min age inc for HZ > 256
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

min age increment needs to round up its min age tick for all
HZ values to guarantee message age is increasing.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 net/bridge/br_stp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index a04eeb6..9a8aebd 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -17,9 +17,9 @@
 #include "br_private_stp.h"
 
 /* since time values in bpdu are in jiffies and then scaled (1/256)
- * before sending, make sure that is at least one.
+ * before sending, make sure that is at least one STP tick.
  */
-#define MESSAGE_AGE_INCR	((HZ < 256) ? 1 : (HZ/256))
+#define MESSAGE_AGE_INCR	((HZ / 256) + 1)
 
 static const char *const br_port_state_names[] = {
 	[BR_STATE_DISABLED] = "disabled",
-- 
1.7.3.4

