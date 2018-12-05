Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xpr7tHOBSYmsjPgJo6sa3kwB4WLbeAUtRQ+8akdgq90=;
	b=EvEURJTKCS90hylczLJUzprsWVZHM+u7HS2mLuXFBVhjUcHU5sHCoKMyDAwYVoOjHW
	YhzRmek80NSpH8b0lcL1FWGhTDELwB4QVCNToI58a1HJVNoWgOASJdb8xAjmFVnsfkXc
	BgZnXtbZC1Qdcy6HcMjG8EE5X4pbXbtRoi1us=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  5 Dec 2018 15:14:25 +0200
Message-Id: <20181205131427.4989-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
References: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 2/4] net: bridge: multicast: use non-bh
	rcu flavor
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

The bridge multicast code has been using a mix of RCU and RCU-bh flavors
sometimes in questionable way. Since we've moved to rhashtable just use
non-bh RCU everywhere. In addition this simplifies freeing of objects
and allows us to remove some unnecessary callback functions.

v3: new patch

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_mdb.c       |  2 +-
 net/bridge/br_multicast.c | 26 +++++---------------------
 net/bridge/br_private.h   |  1 -
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index ea8abdb56df3..79d4c9d253e0 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -710,7 +710,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 		rcu_assign_pointer(*pp, p->next);
 		hlist_del_init(&p->mglist);
 		del_timer(&p->timer);
-		call_rcu_bh(&p->rcu, br_multicast_free_pg);
+		kfree_rcu(p, rcu);
 		err = 0;
 
 		if (!mp->ports && !mp->host_joined &&
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 83a5931a7784..5b8cfef8bc4d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -160,22 +160,6 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 	return br_mdb_ip_get_rcu(br, &ip);
 }
 
-void br_multicast_free_pg(struct rcu_head *head)
-{
-	struct net_bridge_port_group *p =
-		container_of(head, struct net_bridge_port_group, rcu);
-
-	kfree(p);
-}
-
-static void br_multicast_free_group(struct rcu_head *head)
-{
-	struct net_bridge_mdb_entry *mp =
-		container_of(head, struct net_bridge_mdb_entry, rcu);
-
-	kfree(mp);
-}
-
 static void br_multicast_group_expired(struct timer_list *t)
 {
 	struct net_bridge_mdb_entry *mp = from_timer(mp, t, timer);
@@ -195,7 +179,7 @@ static void br_multicast_group_expired(struct timer_list *t)
 			       br_mdb_rht_params);
 	hlist_del_rcu(&mp->mdb_node);
 
-	call_rcu_bh(&mp->rcu, br_multicast_free_group);
+	kfree_rcu(mp, rcu);
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -223,7 +207,7 @@ static void br_multicast_del_pg(struct net_bridge *br,
 		del_timer(&p->timer);
 		br_mdb_notify(br->dev, p->port, &pg->addr, RTM_DELMDB,
 			      p->flags);
-		call_rcu_bh(&p->rcu, br_multicast_free_pg);
+		kfree_rcu(p, rcu);
 
 		if (!mp->ports && !mp->host_joined &&
 		    netif_running(br->dev))
@@ -1425,7 +1409,7 @@ br_multicast_leave_group(struct net_bridge *br,
 			rcu_assign_pointer(*pp, p->next);
 			hlist_del_init(&p->mglist);
 			del_timer(&p->timer);
-			call_rcu_bh(&p->rcu, br_multicast_free_pg);
+			kfree_rcu(p, rcu);
 			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
 				      p->flags);
 
@@ -1839,11 +1823,11 @@ void br_multicast_dev_del(struct net_bridge *br)
 		rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
 				       br_mdb_rht_params);
 		hlist_del_rcu(&mp->mdb_node);
-		call_rcu_bh(&mp->rcu, br_multicast_free_group);
+		kfree_rcu(mp, rcu);
 	}
 	spin_unlock_bh(&br->multicast_lock);
 
-	rcu_barrier_bh();
+	rcu_barrier();
 }
 
 int br_multicast_set_router(struct net_bridge *br, unsigned long val)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a0ce0822921c..cf1f7365deb3 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -679,7 +679,6 @@ struct net_bridge_mdb_entry *
 br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
 struct net_bridge_mdb_entry *
 br_multicast_new_group(struct net_bridge *br, struct br_ip *group);
-void br_multicast_free_pg(struct rcu_head *head);
 struct net_bridge_port_group *
 br_multicast_new_port_group(struct net_bridge_port *port, struct br_ip *group,
 			    struct net_bridge_port_group __rcu *next,
-- 
2.17.2

