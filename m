From: Ian Campbell <ian.campbell@citrix.com>
Date: Thu, 14 May 2009 12:01:44 +0100
Message-Id: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
Subject: [Bridge] [PATCH] BRIDGE: Do not suppress FDB learning after
	topology change when forward_delay is 0.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge@lists.linux-foundation.org, Ian Campbell <ian.campbell@citrix.com>

I recently noticed that my bridges were flooding traffic for a period of time
after a topology change. These bridges are part of a Xen host and therefore
have spanning tree disabled and forward_delay of zero. In this situation there
is no reason not to begin relearning immediately after a topology change.

The existing code uses hold_time == 0 to suppress learning in br_fdb_update.
hold_time() returns forward_delay if a topology change has recently occurred
and ageing_time if not. Setting each of those to zero has slightly different
semantics: Setting forward_delay to zero effectively means forward immediately
while setting ageing_time to zero effectively means do not learn.

The solution is to not learn after a topology change only if forward_delay is
non-zero but to retain the existing behaviour based on ageing_time if a
topology change has not occured.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org
---
 net/bridge/br_fdb.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a48f5ef..c4a38ed 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -57,6 +57,11 @@ static inline unsigned long hold_time(const struct net_bridge *br)
 	return br->topology_change ? br->forward_delay : br->ageing_time;
 }
 
+static inline int should_learn(const struct net_bridge *br)
+{
+	return br->topology_change ? !br->forward_delay : !!br->ageing_time;
+}
+
 static inline int has_expired(const struct net_bridge *br,
 				  const struct net_bridge_fdb_entry *fdb)
 {
@@ -384,7 +389,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 	struct net_bridge_fdb_entry *fdb;
 
 	/* some users want to always flood. */
-	if (hold_time(br) == 0)
+	if (!should_learn(br))
 		return;
 
 	/* ignore packets unless we are using this port */
-- 
1.5.6.5

