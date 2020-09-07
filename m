Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O7XRJD3fu3d4+sci4GlpJ/2XFrLgoEqEaGnQ88muBlM=;
 b=fCjW8HszXba3964Ii5dy+2elUXq3NDR//C45sfI0J3HYWwImwD2Vp/Z7dlEArkrmFc
 KNWdbDQj3jHMAVe8RkJMX1ArjW0qWcc+oqNOmftnzDy5jiGm2DmXo0QWb+S6EreRpxec
 NgWA8OGnokDvYCZBMGTcwa3DJugi6KhKcUGNk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon,  7 Sep 2020 12:56:19 +0300
Message-Id: <20200907095619.11216-16-nikolay@cumulusnetworks.com>
In-Reply-To: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
References: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 15/15] net: bridge: mcast: destroy all
	entries via gc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Since each entry type has timers that can be running simultaneously we need
to make sure that entries are not freed before their timers have finished.
In order to do that generalize the src gc work to mcast gc work and use a
callback to free the entries (mdb, port group or src).

v3: add IPv6 support
v2: force mcast gc on port del to make sure all port group timers have
    finished before freeing the bridge port

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 118 +++++++++++++++++++++++++-------------
 net/bridge/br_private.h   |  13 ++++-
 2 files changed, 89 insertions(+), 42 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0bf791ed0f56..b83f11228948 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -140,6 +140,29 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 	return br_mdb_ip_get_rcu(br, &ip);
 }
 
+static void br_multicast_destroy_mdb_entry(struct net_bridge_mcast_gc *gc)
+{
+	struct net_bridge_mdb_entry *mp;
+
+	mp = container_of(gc, struct net_bridge_mdb_entry, mcast_gc);
+	WARN_ON(!hlist_unhashed(&mp->mdb_node));
+	WARN_ON(mp->ports);
+
+	del_timer_sync(&mp->timer);
+	kfree_rcu(mp, rcu);
+}
+
+static void br_multicast_del_mdb_entry(struct net_bridge_mdb_entry *mp)
+{
+	struct net_bridge *br = mp->br;
+
+	rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
+			       br_mdb_rht_params);
+	hlist_del_init_rcu(&mp->mdb_node);
+	hlist_add_head(&mp->mcast_gc.gc_node, &br->mcast_gc_list);
+	queue_work(system_long_wq, &br->mcast_gc_work);
+}
+
 static void br_multicast_group_expired(struct timer_list *t)
 {
 	struct net_bridge_mdb_entry *mp = from_timer(mp, t, timer);
@@ -153,15 +176,20 @@ static void br_multicast_group_expired(struct timer_list *t)
 
 	if (mp->ports)
 		goto out;
+	br_multicast_del_mdb_entry(mp);
+out:
+	spin_unlock(&br->multicast_lock);
+}
 
-	rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
-			       br_mdb_rht_params);
-	hlist_del_rcu(&mp->mdb_node);
+static void br_multicast_destroy_group_src(struct net_bridge_mcast_gc *gc)
+{
+	struct net_bridge_group_src *src;
 
-	kfree_rcu(mp, rcu);
+	src = container_of(gc, struct net_bridge_group_src, mcast_gc);
+	WARN_ON(!hlist_unhashed(&src->node));
 
-out:
-	spin_unlock(&br->multicast_lock);
+	del_timer_sync(&src->timer);
+	kfree_rcu(src, rcu);
 }
 
 static void br_multicast_del_group_src(struct net_bridge_group_src *src)
@@ -170,8 +198,21 @@ static void br_multicast_del_group_src(struct net_bridge_group_src *src)
 
 	hlist_del_init_rcu(&src->node);
 	src->pg->src_ents--;
-	hlist_add_head(&src->del_node, &br->src_gc_list);
-	queue_work(system_long_wq, &br->src_gc_work);
+	hlist_add_head(&src->mcast_gc.gc_node, &br->mcast_gc_list);
+	queue_work(system_long_wq, &br->mcast_gc_work);
+}
+
+static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
+{
+	struct net_bridge_port_group *pg;
+
+	pg = container_of(gc, struct net_bridge_port_group, mcast_gc);
+	WARN_ON(!hlist_unhashed(&pg->mglist));
+	WARN_ON(!hlist_empty(&pg->src_list));
+
+	del_timer_sync(&pg->rexmit_timer);
+	del_timer_sync(&pg->timer);
+	kfree_rcu(pg, rcu);
 }
 
 void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
@@ -184,12 +225,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 
 	rcu_assign_pointer(*pp, pg->next);
 	hlist_del_init(&pg->mglist);
-	del_timer(&pg->timer);
-	del_timer(&pg->rexmit_timer);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent);
 	br_mdb_notify(br->dev, mp, pg, RTM_DELMDB);
-	kfree_rcu(pg, rcu);
+	hlist_add_head(&pg->mcast_gc.gc_node, &br->mcast_gc_list);
+	queue_work(system_long_wq, &br->mcast_gc_work);
 
 	if (!mp->ports && !mp->host_joined && netif_running(br->dev))
 		mod_timer(&mp->timer, jiffies);
@@ -254,6 +294,17 @@ static void br_multicast_port_group_expired(struct timer_list *t)
 	spin_unlock(&br->multicast_lock);
 }
 
+static void br_multicast_gc(struct hlist_head *head)
+{
+	struct net_bridge_mcast_gc *gcent;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(gcent, tmp, head, gc_node) {
+		hlist_del_init(&gcent->gc_node);
+		gcent->destroy(gcent);
+	}
+}
+
 static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge *br,
 						    struct net_bridge_port_group *pg,
 						    __be32 ip_dst, __be32 group,
@@ -622,6 +673,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 
 	mp->br = br;
 	mp->addr = *group;
+	mp->mcast_gc.destroy = br_multicast_destroy_mdb_entry;
 	timer_setup(&mp->timer, br_multicast_group_expired, 0);
 	err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
 					    br_mdb_rht_params);
@@ -710,6 +762,7 @@ br_multicast_new_group_src(struct net_bridge_port_group *pg, struct br_ip *src_i
 	grp_src->pg = pg;
 	grp_src->br = pg->port->br;
 	grp_src->addr = *src_ip;
+	grp_src->mcast_gc.destroy = br_multicast_destroy_group_src;
 	timer_setup(&grp_src->timer, br_multicast_group_src_expired, 0);
 
 	hlist_add_head_rcu(&grp_src->node, &pg->src_list);
@@ -736,6 +789,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	p->port = port;
 	p->flags = flags;
 	p->filter_mode = filter_mode;
+	p->mcast_gc.destroy = br_multicast_destroy_port_group;
 	INIT_HLIST_HEAD(&p->src_list);
 	rcu_assign_pointer(p->next, next);
 	timer_setup(&p->timer, br_multicast_port_group_expired, 0);
@@ -1163,13 +1217,16 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
+	HLIST_HEAD(deleted_head);
 	struct hlist_node *n;
 
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		br_multicast_find_del_pg(br, pg);
+	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
+	br_multicast_gc(&deleted_head);
 	del_timer_sync(&port->multicast_router_timer);
 	free_percpu(port->mcast_stats);
 }
@@ -2733,29 +2790,17 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 }
 #endif
 
-static void __grp_src_gc(struct hlist_head *head)
-{
-	struct net_bridge_group_src *ent;
-	struct hlist_node *tmp;
-
-	hlist_for_each_entry_safe(ent, tmp, head, del_node) {
-		hlist_del_init(&ent->del_node);
-		del_timer_sync(&ent->timer);
-		kfree_rcu(ent, rcu);
-	}
-}
-
-static void br_multicast_src_gc(struct work_struct *work)
+static void br_multicast_gc_work(struct work_struct *work)
 {
 	struct net_bridge *br = container_of(work, struct net_bridge,
-					     src_gc_work);
+					     mcast_gc_work);
 	HLIST_HEAD(deleted_head);
 
 	spin_lock_bh(&br->multicast_lock);
-	hlist_move_list(&br->src_gc_list, &deleted_head);
+	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
 
-	__grp_src_gc(&deleted_head);
+	br_multicast_gc(&deleted_head);
 }
 
 void br_multicast_init(struct net_bridge *br)
@@ -2798,8 +2843,8 @@ void br_multicast_init(struct net_bridge *br)
 		    br_ip6_multicast_query_expired, 0);
 #endif
 	INIT_HLIST_HEAD(&br->mdb_list);
-	INIT_HLIST_HEAD(&br->src_gc_list);
-	INIT_WORK(&br->src_gc_work, br_multicast_src_gc);
+	INIT_HLIST_HEAD(&br->mcast_gc_list);
+	INIT_WORK(&br->mcast_gc_work, br_multicast_gc_work);
 }
 
 static void br_ip4_multicast_join_snoopers(struct net_bridge *br)
@@ -2907,18 +2952,13 @@ void br_multicast_dev_del(struct net_bridge *br)
 	struct hlist_node *tmp;
 
 	spin_lock_bh(&br->multicast_lock);
-	hlist_for_each_entry_safe(mp, tmp, &br->mdb_list, mdb_node) {
-		del_timer(&mp->timer);
-		rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
-				       br_mdb_rht_params);
-		hlist_del_rcu(&mp->mdb_node);
-		kfree_rcu(mp, rcu);
-	}
-	hlist_move_list(&br->src_gc_list, &deleted_head);
+	hlist_for_each_entry_safe(mp, tmp, &br->mdb_list, mdb_node)
+		br_multicast_del_mdb_entry(mp);
+	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
 
-	__grp_src_gc(&deleted_head);
-	cancel_work_sync(&br->src_gc_work);
+	br_multicast_gc(&deleted_head);
+	cancel_work_sync(&br->mcast_gc_work);
 
 	rcu_barrier();
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index fb35a73fc559..a23d2bae56e1 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -219,6 +219,11 @@ struct net_bridge_fdb_entry {
 #define BR_SGRP_F_DELETE	BIT(0)
 #define BR_SGRP_F_SEND		BIT(1)
 
+struct net_bridge_mcast_gc {
+	struct hlist_node		gc_node;
+	void				(*destroy)(struct net_bridge_mcast_gc *gc);
+};
+
 struct net_bridge_group_src {
 	struct hlist_node		node;
 
@@ -229,7 +234,7 @@ struct net_bridge_group_src {
 	struct timer_list		timer;
 
 	struct net_bridge		*br;
-	struct hlist_node		del_node;
+	struct net_bridge_mcast_gc	mcast_gc;
 	struct rcu_head			rcu;
 };
 
@@ -248,6 +253,7 @@ struct net_bridge_port_group {
 	struct timer_list		rexmit_timer;
 	struct hlist_node		mglist;
 
+	struct net_bridge_mcast_gc	mcast_gc;
 	struct rcu_head			rcu;
 };
 
@@ -261,6 +267,7 @@ struct net_bridge_mdb_entry {
 	struct timer_list		timer;
 	struct hlist_node		mdb_node;
 
+	struct net_bridge_mcast_gc	mcast_gc;
 	struct rcu_head			rcu;
 };
 
@@ -434,7 +441,7 @@ struct net_bridge {
 
 	struct rhashtable		mdb_hash_tbl;
 
-	struct hlist_head		src_gc_list;
+	struct hlist_head		mcast_gc_list;
 	struct hlist_head		mdb_list;
 	struct hlist_head		router_list;
 
@@ -448,7 +455,7 @@ struct net_bridge {
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
-	struct work_struct		src_gc_work;
+	struct work_struct		mcast_gc_work;
 #endif
 
 	struct timer_list		hello_timer;
-- 
2.25.4

