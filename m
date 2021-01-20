Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=grXUCar2XJM0EhIEo7HicVui+NQZU/ry4BRH3wt7hj0=;
 b=bwTiWJCkTV8X0YYr6p1yygOiDoXZVkQLuSTXyZFyBRL4YwR51pnNLQYKJQMP9xzaD+
 OkLelqhLxfctW7DqIWzgQlNZ1CWcv79oyUtC4FwNpcmsOrDoiilyYCId1LIYXQkymJMW
 DRmOwzmyKpb5guLdm7rF/JIwxH01M32RPzBOTCuFQg+sHcq5E8Usm7wRzgPRjBPEZxSg
 BwZ1wusFpwyZ8HUq5RPIRZ4Xtg1C4GLB6G10b0HxIXupkikwswLLzSIc+Utgz4bL11gt
 A2v/DYWZTQTS0SEZ4Jut0TYhKX0/TQMWuPr/3UCHhxvFCZin3XkYd0uELPAUp2lLzwGi
 TuNw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:51:52 +0200
Message-Id: <20210120145203.1109140-4-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 03/14] net: bridge: multicast:
	__grp_src_block_incl can modify pg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Prepare __grp_src_block_incl() for being able to cause a notification
due to changes. Currently it cannot happen, but EHT would change that
since we'll be deleting sources immediately. Make sure that if the pg is
deleted we don't return true as that would cause the caller to access
freed pg. This patch shouldn't cause any functional change.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 861545094d67..79569a398669 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2142,11 +2142,12 @@ static bool br_multicast_toex(struct net_bridge_port_group *pg, void *h_addr,
 /* State          Msg type      New state                Actions
  * INCLUDE (A)    BLOCK (B)     INCLUDE (A)              Send Q(G,A*B)
  */
-static void __grp_src_block_incl(struct net_bridge_port_group *pg, void *h_addr,
+static bool __grp_src_block_incl(struct net_bridge_port_group *pg, void *h_addr,
 				 void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge_group_src *ent;
 	u32 src_idx, to_send = 0;
+	bool changed = false;
 	struct br_ip src_ip;
 
 	hlist_for_each_entry(ent, &pg->src_list, node)
@@ -2167,8 +2168,15 @@ static void __grp_src_block_incl(struct net_bridge_port_group *pg, void *h_addr,
 	if (to_send)
 		__grp_src_query_marked_and_rexmit(pg);
 
-	if (pg->filter_mode == MCAST_INCLUDE && hlist_empty(&pg->src_list))
+	if (pg->filter_mode == MCAST_INCLUDE && hlist_empty(&pg->src_list)) {
 		br_multicast_find_del_pg(pg->key.port->br, pg);
+		/* a notification has already been sent and we shouldn't access
+		 * pg after the delete thus we have to return false
+		 */
+		changed = false;
+	}
+
+	return changed;
 }
 
 /* State          Msg type      New state                Actions
@@ -2218,7 +2226,7 @@ static bool br_multicast_block(struct net_bridge_port_group *pg, void *h_addr,
 
 	switch (pg->filter_mode) {
 	case MCAST_INCLUDE:
-		__grp_src_block_incl(pg, h_addr, srcs, nsrcs, addr_size);
+		changed = __grp_src_block_incl(pg, h_addr, srcs, nsrcs, addr_size);
 		break;
 	case MCAST_EXCLUDE:
 		changed = __grp_src_block_excl(pg, h_addr, srcs, nsrcs, addr_size);
-- 
2.29.2

