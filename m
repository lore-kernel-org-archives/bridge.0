From: Bill Pemberton <wfp5p@virginia.edu>
Date: Wed, 30 Mar 2011 14:45:20 -0400
Message-Id: <1301510720-28763-1-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] bridge: provide return value in
	br_stp_recalculate_bridge_id
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org

fix warning net/bridge/br_stp_if.c:216:3: warning: ‘return’ with no value, in function returning non-void

This warning was introduced when br_stp_recalculate_bridge_id was
changed to return true/false by commit
edf947f10074fea27fdb1730524dca59355a1c40

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 net/bridge/br_stp_if.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 5593f5a..9b61d09 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -213,7 +213,7 @@ bool br_stp_recalculate_bridge_id(struct net_bridge *br)
 
 	/* user has chosen a value so keep it */
 	if (br->flags & BR_SET_MAC_ADDR)
-		return;
+		return false;
 
 	list_for_each_entry(p, &br->port_list, list) {
 		if (addr == br_mac_zero ||
-- 
1.7.4

