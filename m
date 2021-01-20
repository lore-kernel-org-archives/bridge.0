Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+STi29hPfYbEluynEPrqxJhUnb3kYXkKj59XvyzIrkI=;
 b=gw9hqq9f8UYLKQ3/frZqRj4yGcT5JoTx8h+qZZcPdKSkwV7UG1blZ6v6s95U31wjMD
 D3nvR0HHMk10aDQU4O1uGCPPnraNsucZKBazqdIM0p/eIo102Qs/KB8BbrVyXLTZGXYS
 sl2H9hjhFRSD/qA1AZpsseHL70luzmKwG46sfASteXAx0jxfOgymGpBXJP45uTi1BOWr
 LkMxckcqkWAEB9+8dtbRoGN0q/v+/9oCG889oic+n3rtCaLXBVYkTN5b2Qyw1bQLU1vI
 e86r6ca6F8g6z3GV/yLX+pvF/sTMT0daUvY6Q/LDTcRLJXrZxemw0fiKYU9NbkRO64Zg
 BtQg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:52:02 +0200
Message-Id: <20210120145203.1109140-14-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 13/14] net: bridge: multicast: handle
	block pg delete for all cases
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

A block report can result in empty source and host sets for both include
and exclude groups so if there are no hosts left we can safely remove
the group. Pull the block group handling so it can cover both cases and
add a check if EHT requires the delete.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9cfc004312ab..47afb1e11daf 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2210,14 +2210,6 @@ static bool __grp_src_block_incl(struct net_bridge_port_group *pg, void *h_addr,
 	if (to_send)
 		__grp_src_query_marked_and_rexmit(pg);
 
-	if (pg->filter_mode == MCAST_INCLUDE && hlist_empty(&pg->src_list)) {
-		br_multicast_find_del_pg(pg->key.port->br, pg);
-		/* a notification has already been sent and we shouldn't access
-		 * pg after the delete thus we have to return false
-		 */
-		changed = false;
-	}
-
 	return changed;
 }
 
@@ -2279,6 +2271,15 @@ static bool br_multicast_block(struct net_bridge_port_group *pg, void *h_addr,
 		break;
 	}
 
+	if ((pg->filter_mode == MCAST_INCLUDE && hlist_empty(&pg->src_list)) ||
+	    br_multicast_eht_should_del_pg(pg)) {
+		br_multicast_find_del_pg(pg->key.port->br, pg);
+		/* a notification has already been sent and we shouldn't
+		 * access pg after the delete so we have to return false
+		 */
+		changed = false;
+	}
+
 	return changed;
 }
 
-- 
2.29.2

