Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DeNavSBVgHmEUxUmBQUr68dzvVd/ZWitTRA5Beang5U=;
 b=CgpeVJyQwgLFfN6RQQaz70tZ7kfPjEB4FoC8dRJtuS32f756EWMg1TvodTK2W4FrhY
 kyx0qfJ3S+2LhRmYKQb5vBYZCqEllKzN+52WA3JITh0ZPRxLSkm/ITyePoA9qHCwg9U7
 Ce95w5ZQnxtxKpz+sR0CLXd6syVdh3ApIWWh8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  5 Sep 2020 11:24:00 +0300
Message-Id: <20200905082410.2230253-6-nikolay@cumulusnetworks.com>
In-Reply-To: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 05/15] net: bridge: mcast: factor out
	port group del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

In order to avoid future errors and reduce code duplication we should
factor out the port group del sequence. This allows us to have one
function which takes care of all details when removing a port group.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_mdb.c       | 15 +---------
 net/bridge/br_multicast.c | 59 +++++++++++++++++++--------------------
 net/bridge/br_private.h   |  3 ++
 3 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 76fce1dac4a5..9dc12ce61018 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -843,24 +843,11 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 		if (!p->port || p->port->dev->ifindex != entry->ifindex)
 			continue;
 
-		if (!hlist_empty(&p->src_list)) {
-			err = -EINVAL;
-			goto unlock;
-		}
-
 		if (p->port->state == BR_STATE_DISABLED)
 			goto unlock;
 
-		__mdb_entry_fill_flags(entry, p->flags);
-		rcu_assign_pointer(*pp, p->next);
-		hlist_del_init(&p->mglist);
-		del_timer(&p->timer);
-		kfree_rcu(p, rcu);
+		br_multicast_del_pg(mp, p, pp);
 		err = 0;
-
-		if (!mp->ports && !mp->host_joined &&
-		    netif_running(br->dev))
-			mod_timer(&mp->timer, jiffies);
 		break;
 	}
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4fdc1a7ba627..72b32398e279 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -173,14 +173,32 @@ static void br_multicast_del_group_src(struct net_bridge_group_src *src)
 	queue_work(system_long_wq, &br->src_gc_work);
 }
 
-static void br_multicast_del_pg(struct net_bridge *br,
-				struct net_bridge_port_group *pg)
+void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+			 struct net_bridge_port_group *pg,
+			 struct net_bridge_port_group __rcu **pp)
+{
+	struct net_bridge *br = pg->port->br;
+	struct net_bridge_group_src *ent;
+	struct hlist_node *tmp;
+
+	rcu_assign_pointer(*pp, pg->next);
+	hlist_del_init(&pg->mglist);
+	del_timer(&pg->timer);
+	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
+		br_multicast_del_group_src(ent);
+	br_mdb_notify(br->dev, pg->port, &pg->addr, RTM_DELMDB, pg->flags);
+	kfree_rcu(pg, rcu);
+
+	if (!mp->ports && !mp->host_joined && netif_running(br->dev))
+		mod_timer(&mp->timer, jiffies);
+}
+
+static void br_multicast_find_del_pg(struct net_bridge *br,
+				     struct net_bridge_port_group *pg)
 {
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
-	struct net_bridge_group_src *ent;
-	struct hlist_node *tmp;
 
 	mp = br_mdb_ip_get(br, &pg->addr);
 	if (WARN_ON(!mp))
@@ -192,19 +210,7 @@ static void br_multicast_del_pg(struct net_bridge *br,
 		if (p != pg)
 			continue;
 
-		rcu_assign_pointer(*pp, p->next);
-		hlist_del_init(&p->mglist);
-		del_timer(&p->timer);
-		hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
-			br_multicast_del_group_src(ent);
-		br_mdb_notify(br->dev, p->port, &pg->addr, RTM_DELMDB,
-			      p->flags);
-		kfree_rcu(p, rcu);
-
-		if (!mp->ports && !mp->host_joined &&
-		    netif_running(br->dev))
-			mod_timer(&mp->timer, jiffies);
-
+		br_multicast_del_pg(mp, pg, pp);
 		return;
 	}
 
@@ -221,7 +227,7 @@ static void br_multicast_port_group_expired(struct timer_list *t)
 	    hlist_unhashed(&pg->mglist) || pg->flags & MDB_PG_FLAGS_PERMANENT)
 		goto out;
 
-	br_multicast_del_pg(br, pg);
+	br_multicast_find_del_pg(br, pg);
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -615,7 +621,7 @@ static void br_multicast_group_src_expired(struct timer_list *t)
 		br_multicast_del_group_src(src);
 		if (!hlist_empty(&pg->src_list))
 			goto out;
-		br_multicast_del_pg(br, pg);
+		br_multicast_find_del_pg(br, pg);
 	}
 out:
 	spin_unlock(&br->multicast_lock);
@@ -1086,7 +1092,7 @@ void br_multicast_del_port(struct net_bridge_port *port)
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
-		br_multicast_del_pg(br, pg);
+		br_multicast_find_del_pg(br, pg);
 	spin_unlock_bh(&br->multicast_lock);
 	del_timer_sync(&port->multicast_router_timer);
 	free_percpu(port->mcast_stats);
@@ -1135,7 +1141,7 @@ void br_multicast_disable_port(struct net_bridge_port *port)
 	spin_lock(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT))
-			br_multicast_del_pg(br, pg);
+			br_multicast_find_del_pg(br, pg);
 
 	__del_port_router(port);
 
@@ -1641,16 +1647,7 @@ br_multicast_leave_group(struct net_bridge *br,
 			if (p->flags & MDB_PG_FLAGS_PERMANENT)
 				break;
 
-			rcu_assign_pointer(*pp, p->next);
-			hlist_del_init(&p->mglist);
-			del_timer(&p->timer);
-			kfree_rcu(p, rcu);
-			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
-				      p->flags | MDB_PG_FLAGS_FAST_LEAVE);
-
-			if (!mp->ports && !mp->host_joined &&
-			    netif_running(br->dev))
-				mod_timer(&mp->timer, jiffies);
+			br_multicast_del_pg(mp, p, pp);
 		}
 		goto out;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 45038b5c4ecd..e0632721b1ef 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -802,6 +802,9 @@ void br_mdb_notify(struct net_device *dev, struct net_bridge_port *port,
 		   struct br_ip *group, int type, u8 flags);
 void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
 		   int type);
+void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+			 struct net_bridge_port_group *pg,
+			 struct net_bridge_port_group __rcu **pp);
 void br_multicast_count(struct net_bridge *br, const struct net_bridge_port *p,
 			const struct sk_buff *skb, u8 type, u8 dir);
 int br_multicast_init_stats(struct net_bridge *br);
-- 
2.25.4

