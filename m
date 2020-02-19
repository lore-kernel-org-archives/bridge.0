Return-Path: <madhuparnabhowmik10@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ukKkOw2CD1p6V3m08F/J1FLQ/Kv80Rkqm5DlFEyeEwo=;
 b=Ah7uoNUV021eb0uXbGTT4n8DSdPnmntOsRtdO0sIaVGmDz6Mx9DRCWkzlQUZdixw+q
 EWquftTkt68WCGlW/aA5nVyhgl+UHA3gsnBdG89IY8cpIjgmPUkSlbSABOsRoUQRQiP2
 tRiY/eEHI2tZExjQkFe8laVxjuRMHuzuVK45dlKZio/IG/07TcGQVIzIxWHJfXrtvd1a
 HtRVxwNVVRPt42qadehr7FMIyLth4UrIOnrhkVj5fNTULu6IlHaSMd/bRTPytPu9Y5vU
 PaRSz9bSbBntBZ+Ij+W79CdwpGDWwZ003hXlhvFCJlR5NffYtNcMGNj1KyqapsoM5/VY
 K/gA==
From: madhuparnabhowmik10@gmail.com
Date: Wed, 19 Feb 2020 20:47:46 +0530
Message-Id: <20200219151746.1050-1-madhuparnabhowmik10@gmail.com>
Subject: [Bridge] [PATCH] bridge: br_stp: Use built-in RCU list checking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net
Cc: paulmck@kernel.org, frextrite@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>, joel@joelfernandes.org, linux-kernel-mentees@lists.linuxfoundation.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

list_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 net/bridge/br_stp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 1f1410f8d312..8be12452071b 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -52,7 +52,8 @@ struct net_bridge_port *br_get_port(struct net_bridge *br, u16 port_no)
 {
 	struct net_bridge_port *p;
 
-	list_for_each_entry_rcu(p, &br->port_list, list) {
+	list_for_each_entry_rcu(p, &br->port_list, list,
+				lockdep_is_held(&br->lock)) {
 		if (p->port_no == port_no)
 			return p;
 	}
-- 
2.17.1

