Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl7XzK3Eivke6MpoUHcV1M5dV+lmRkhJvQM3A0MzpJY=;
 b=QqLKKRsVZnyn6F4utnUErUlsZLrYSzJw85tqdFzeYy7aS0g7sgByKiFki3R0JnaRFDP37qUhicxmAuiPqXlh+E9Hs7Hg1wD/xVTZPQSe+Ed+srsGdlVgPYDsnbLu16hZdZZpwfqV5Lcpoc6FZ0LBJhAc763oeGHfW9g8rAbxQbA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun,  1 Nov 2020 02:08:45 +0200
Message-Id: <20201101000845.190009-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next] net: bridge: mcast: fix stub definition
	of br_multicast_querier_exists
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>

The commit cited below has changed only the functional prototype of
br_multicast_querier_exists, but forgot to do that for the stub
prototype (the one where CONFIG_BRIDGE_IGMP_SNOOPING is disabled).

Fixes: 955062b03fa6 ("net: bridge: mcast: add support for raw L2 multicast groups")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_private.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4c691c371884..891f3b05ffa4 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1013,7 +1013,8 @@ static inline bool br_multicast_is_router(struct net_bridge *br)
 }
 
 static inline bool br_multicast_querier_exists(struct net_bridge *br,
-					       struct ethhdr *eth)
+					       struct ethhdr *eth,
+					       const struct net_bridge_mdb_entry *mdb)
 {
 	return false;
 }
-- 
2.25.1

