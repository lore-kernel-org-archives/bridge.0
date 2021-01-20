Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YT+SYFiw1dH0jJDDS//jhORRXswYAr3VsLQ6058Ln4M=;
 b=XTkqPPTp+PixnWplr7ie8/nV6iLYqPMstodVv4rNcV2HNQ2QCVA+IAoVenNeM7ZD83
 zXlvfsU5ijEPeIhs8zH4OJ3Mgb/HrzfXNCmWpQeRtDh9V45tkO3zfkcGz2cPlUAIKoxf
 gHU6zlyd/dZbQgWTQ0Q3lJSq/69YBpcllywqLELJp09O62SwbT6PUeMOhVjPFC+rEPWS
 gvqpI4OWp9pH+G5P125dqzK0LqXm67ILszXfmu939rXSVm55oWZ4ytGJ+RdcWGYHwdF+
 bmASzAtDnEQJfy20PjENjlV/E6Sa4EwqkMDOWVNZPMDQy9/6IyvaXzTQaPui1gwxrEYO
 B/Mw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:52:03 +0200
Message-Id: <20210120145203.1109140-15-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 14/14] net: bridge: multicast: mark
	IGMPv3/MLDv2 fast-leave deletes
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

Mark groups which were deleted due to fast leave/EHT.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c     | 21 ++++++++++++++-------
 net/bridge/br_multicast_eht.c |  8 ++++----
 net/bridge/br_private.h       |  3 ++-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 47afb1e11daf..df5db6a58e95 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -442,7 +442,8 @@ static void br_multicast_fwd_src_add(struct net_bridge_group_src *src)
 	br_multicast_sg_add_exclude_ports(star_mp, sg);
 }
 
-static void br_multicast_fwd_src_remove(struct net_bridge_group_src *src)
+static void br_multicast_fwd_src_remove(struct net_bridge_group_src *src,
+					bool fastleave)
 {
 	struct net_bridge_port_group *p, *pg = src->pg;
 	struct net_bridge_port_group __rcu **pp;
@@ -467,6 +468,8 @@ static void br_multicast_fwd_src_remove(struct net_bridge_group_src *src)
 		    (p->flags & MDB_PG_FLAGS_PERMANENT))
 			break;
 
+		if (fastleave)
+			p->flags |= MDB_PG_FLAGS_FAST_LEAVE;
 		br_multicast_del_pg(mp, p, pp);
 		break;
 	}
@@ -560,11 +563,12 @@ static void br_multicast_destroy_group_src(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(src, rcu);
 }
 
-void br_multicast_del_group_src(struct net_bridge_group_src *src)
+void br_multicast_del_group_src(struct net_bridge_group_src *src,
+				bool fastleave)
 {
 	struct net_bridge *br = src->pg->key.port->br;
 
-	br_multicast_fwd_src_remove(src);
+	br_multicast_fwd_src_remove(src, fastleave);
 	hlist_del_init_rcu(&src->node);
 	src->pg->src_ents--;
 	hlist_add_head(&src->mcast_gc.gc_node, &br->mcast_gc_list);
@@ -596,7 +600,7 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	hlist_del_init(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
-		br_multicast_del_group_src(ent);
+		br_multicast_del_group_src(ent, false);
 	br_mdb_notify(br->dev, mp, pg, RTM_DELMDB);
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
@@ -653,7 +657,7 @@ static void br_multicast_port_group_expired(struct timer_list *t)
 	pg->filter_mode = MCAST_INCLUDE;
 	hlist_for_each_entry_safe(src_ent, tmp, &pg->src_list, node) {
 		if (!timer_pending(&src_ent->timer)) {
-			br_multicast_del_group_src(src_ent);
+			br_multicast_del_group_src(src_ent, false);
 			changed = true;
 		}
 	}
@@ -1080,7 +1084,7 @@ static void br_multicast_group_src_expired(struct timer_list *t)
 
 	pg = src->pg;
 	if (pg->filter_mode == MCAST_INCLUDE) {
-		br_multicast_del_group_src(src);
+		br_multicast_del_group_src(src, false);
 		if (!hlist_empty(&pg->src_list))
 			goto out;
 		br_multicast_find_del_pg(br, pg);
@@ -1704,7 +1708,7 @@ static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
 
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		if (ent->flags & BR_SGRP_F_DELETE) {
-			br_multicast_del_group_src(ent);
+			br_multicast_del_group_src(ent, false);
 			deleted++;
 		}
 
@@ -2053,6 +2057,7 @@ static bool br_multicast_toin(struct net_bridge_port_group *pg, void *h_addr,
 	}
 
 	if (br_multicast_eht_should_del_pg(pg)) {
+		pg->flags |= MDB_PG_FLAGS_FAST_LEAVE;
 		br_multicast_find_del_pg(pg->key.port->br, pg);
 		/* a notification has already been sent and we shouldn't
 		 * access pg after the delete so we have to return false
@@ -2273,6 +2278,8 @@ static bool br_multicast_block(struct net_bridge_port_group *pg, void *h_addr,
 
 	if ((pg->filter_mode == MCAST_INCLUDE && hlist_empty(&pg->src_list)) ||
 	    br_multicast_eht_should_del_pg(pg)) {
+		if (br_multicast_eht_should_del_pg(pg))
+			pg->flags |= MDB_PG_FLAGS_FAST_LEAVE;
 		br_multicast_find_del_pg(pg->key.port->br, pg);
 		/* a notification has already been sent and we shouldn't
 		 * access pg after the delete so we have to return false
diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index 64ccbd4ae9d9..a4fa1760bc8a 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -537,7 +537,7 @@ static bool __eht_allow_excl(struct net_bridge_port_group *pg,
 			src_ent = br_multicast_find_group_src(pg, &src_ip);
 			if (!src_ent)
 				continue;
-			br_multicast_del_group_src(src_ent);
+			br_multicast_del_group_src(src_ent, true);
 			changed = true;
 		}
 	}
@@ -588,7 +588,7 @@ static bool __eht_block_incl(struct net_bridge_port_group *pg,
 		src_ent = br_multicast_find_group_src(pg, &src_ip);
 		if (!src_ent)
 			continue;
-		br_multicast_del_group_src(src_ent);
+		br_multicast_del_group_src(src_ent, true);
 		changed = true;
 	}
 
@@ -625,7 +625,7 @@ static bool __eht_block_excl(struct net_bridge_port_group *pg,
 			src_ent = br_multicast_find_group_src(pg, &src_ip);
 			if (!src_ent)
 				continue;
-			br_multicast_del_group_src(src_ent);
+			br_multicast_del_group_src(src_ent, true);
 			changed = true;
 		}
 	}
@@ -689,7 +689,7 @@ static bool __eht_inc_exc(struct net_bridge_port_group *pg,
 			br_multicast_ip_src_to_eht_addr(&src_ent->addr,
 							&eht_src_addr);
 			if (!br_multicast_eht_set_lookup(pg, &eht_src_addr)) {
-				br_multicast_del_group_src(src_ent);
+				br_multicast_del_group_src(src_ent, true);
 				changed = true;
 				continue;
 			}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index cad967690e9f..0e26ba623006 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -850,7 +850,8 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
 				       struct net_bridge_port_group *sg);
 struct net_bridge_group_src *
 br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip);
-void br_multicast_del_group_src(struct net_bridge_group_src *src);
+void br_multicast_del_group_src(struct net_bridge_group_src *src,
+				bool fastleave);
 
 static inline bool br_group_is_l2(const struct br_ip *group)
 {
-- 
2.29.2

