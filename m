Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qa2CnxrmfdpWhxwQfNcz/QRx0LAMcqvtJo3oWicVNSc=;
 b=zXXHq7R/yS26GFBFwlhLMCwY2QJ6QfAT6vp6c8h2+sA2NkO70FVxe2VxT/KvT2isvj
 xt5l/rUzNzrkKVk2HYgFBCuvJtQBc4LDSrClvDckfvV4yoYSctMTYDdIieyJFMOQT3Su
 4wK/6NQUapdz4d4tnn6aS7B5CdnJqIiDJzT4x4Y7Y7UDAabstt2pI4pNXF0/kqZOF6d4
 mpdFcAS6dIgX/twCCcqUX0jTQGMbJmQXQU1AbySYTjJGutXLgzffldqQLJffQiPYUIX1
 FK9CD5YMEJuZMIrBCtysDcHxhN5rGV4m1NRexk63viIvBj4OMVN9bh2lPl8vYzxyBbBP
 mE+g==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:52:00 +0200
Message-Id: <20210120145203.1109140-12-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 11/14] net: bridge: multicast: optimize
	TO_INCLUDE EHT timeouts
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

This is an optimization specifically for TO_INCLUDE which sends queries
for the older entries and thus lowers the S,G timers to LMQT. If we have
the following situation for a group in either include or exclude mode:
 - host A was interested in srcs X and Y, but is timing out
 - host B sends TO_INCLUDE src Z, the bridge lowers X and Y's timeouts
   to LMQT
 - host B sends BLOCK src Z after LMQT time has passed
 => since host B is the last host we can delete the group, but if we
    still have host A's EHT entries for X and Y (i.e. if they weren't
    lowered to LMQT previously) then we'll have to wait another LMQT
    time before deleting the group, with this optimization we can
    directly remove it regardless of the group mode as there are no more
    interested hosts

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast_eht.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index 861ae63f4a1c..fee3060d0495 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -656,6 +656,8 @@ static bool __eht_inc_exc(struct net_bridge_port_group *pg,
 	}
 	/* we can be missing sets only if we've deleted some entries */
 	if (flush_entries) {
+		struct net_bridge *br = pg->key.port->br;
+		struct net_bridge_group_eht_set *eht_set;
 		struct net_bridge_group_src *src_ent;
 		struct hlist_node *tmp;
 
@@ -667,6 +669,25 @@ static bool __eht_inc_exc(struct net_bridge_port_group *pg,
 				changed = true;
 				continue;
 			}
+			/* this is an optimization for TO_INCLUDE where we lower
+			 * the set's timeout to LMQT to catch timeout hosts:
+			 * - host A (timing out): set entries X, Y
+			 * - host B: set entry Z (new from current TO_INCLUDE)
+			 *           sends BLOCK Z after LMQT but host A's EHT
+			 *           entries still exist (unless lowered to LMQT
+			 *           so they can timeout with the S,Gs)
+			 * => we wait another LMQT, when we can just delete the
+			 *    group immediately
+			 */
+			if (!(src_ent->flags & BR_SGRP_F_SEND) ||
+			    filter_mode != MCAST_INCLUDE ||
+			    !to_report)
+				continue;
+			eht_set = br_multicast_eht_set_lookup(pg,
+							      &eht_src_addr);
+			if (!eht_set)
+				continue;
+			mod_timer(&eht_set->timer, jiffies + br_multicast_lmqt(br));
 		}
 	}
 
-- 
2.29.2

