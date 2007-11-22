From: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 14:23:28 +0100
Message-Id: <1195737808.6323.102.camel@johannes.berg>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [RFC] bridging: don't forward EAPOL frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev <netdev@vger.kernel.org>, bridge <bridge@linux-foundation.org>

This patch makes the bridging code drop EAPOL frames as recommended by
802.1X-2004 in C.3.3.

Is this really the right place to put it?
---
 include/linux/if_ether.h |    1 +
 include/net/ieee80211.h  |    6 ------
 net/bridge/br_input.c    |    3 +++
 3 files changed, 4 insertions(+), 6 deletions(-)

--- everything.orig/include/linux/if_ether.h	2007-11-22 11:47:14.178686360 +0100
+++ everything/include/linux/if_ether.h	2007-11-22 11:48:21.438679036 +0100
@@ -74,6 +74,7 @@
 #define ETH_P_ATMFATE	0x8884		/* Frame-based ATM Transport
 					 * over Ethernet
 					 */
+#define ETH_P_PAE	0x888E		/* Port Access Entity (IEEE 802.1X) */
 #define ETH_P_AOE	0x88A2		/* ATA over Ethernet		*/
 #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
 
--- everything.orig/include/net/ieee80211.h	2007-11-22 11:46:29.908682888 +0100
+++ everything/include/net/ieee80211.h	2007-11-22 11:48:51.908679037 +0100
@@ -183,12 +183,6 @@ const char *escape_essid(const char *ess
 #endif
 #include <net/iw_handler.h>	/* new driver API */
 
-#ifndef ETH_P_PAE
-#define ETH_P_PAE 0x888E	/* Port Access Entity (IEEE 802.1X) */
-#endif				/* ETH_P_PAE */
-
-#define ETH_P_PREAUTH 0x88C7	/* IEEE 802.11i pre-authentication */
-
 #ifndef ETH_P_80211_RAW
 #define ETH_P_80211_RAW (ETH_P_ECONET + 1)
 #endif
--- everything.orig/net/bridge/br_input.c	2007-11-22 11:54:44.798683106 +0100
+++ everything/net/bridge/br_input.c	2007-11-22 11:57:23.248680285 +0100
@@ -145,6 +145,9 @@ struct sk_buff *br_handle_frame(struct n
 		}
 	}
 
+	if (unlikely(skb->protocol = htons(ETH_P_PAE)))
+		goto drop;
+
 	switch (p->state) {
 	case BR_STATE_FORWARDING:
 


