Return-Path: <paulmck@linux.vnet.ibm.com>
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Date: Sun, 11 Nov 2018 11:44:02 -0800
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
Message-Id: <20181111194410.6368-33-paulmck@linux.ibm.com>
Subject: [Bridge] [PATCH tip/core/rcu 33/41] net/bridge: Replace
	call_rcu_bh() and rcu_barrier_bh()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, peterz@infradead.org, fweisbec@gmail.com, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, oleg@redhat.com, dhowells@redhat.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, dipankar@in.ibm.com, joel@joelfernandes.org, akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, mingo@kernel.org

Now that call_rcu()'s callback is not invoked until after all bh-disable
regions of code have completed (in addition to explicitly marked
RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_bh().  Similarly, rcu_barrier() can be used in place of
rcu_barrier_bh().  This commit therefore makes these changes.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <bridge@lists.linux-foundation.org>
Cc: <netdev@vger.kernel.org>
---
 net/bridge/br_mdb.c       |  2 +-
 net/bridge/br_multicast.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a7ea2d431714..596ec6e7df11 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -728,7 +728,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 		rcu_assign_pointer(*pp, p->next);
 		hlist_del_init(&p->mglist);
 		del_timer(&p->timer);
-		call_rcu_bh(&p->rcu, br_multicast_free_pg);
+		call_rcu(&p->rcu, br_multicast_free_pg);
 		err = 0;
 
 		if (!mp->ports && !mp->host_joined &&
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6bac0d6b7b94..0255223f2001 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -260,7 +260,7 @@ static void br_multicast_group_expired(struct timer_list *t)
 	hlist_del_rcu(&mp->hlist[mdb->ver]);
 	mdb->size--;
 
-	call_rcu_bh(&mp->rcu, br_multicast_free_group);
+	call_rcu(&mp->rcu, br_multicast_free_group);
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -291,7 +291,7 @@ static void br_multicast_del_pg(struct net_bridge *br,
 		del_timer(&p->timer);
 		br_mdb_notify(br->dev, p->port, &pg->addr, RTM_DELMDB,
 			      p->flags);
-		call_rcu_bh(&p->rcu, br_multicast_free_pg);
+		call_rcu(&p->rcu, br_multicast_free_pg);
 
 		if (!mp->ports && !mp->host_joined &&
 		    netif_running(br->dev))
@@ -358,7 +358,7 @@ static int br_mdb_rehash(struct net_bridge_mdb_htable __rcu **mdbp, int max,
 	}
 
 	br_mdb_rehash_seq++;
-	call_rcu_bh(&mdb->rcu, br_mdb_free);
+	call_rcu(&mdb->rcu, br_mdb_free);
 
 out:
 	rcu_assign_pointer(*mdbp, mdb);
@@ -1629,7 +1629,7 @@ br_multicast_leave_group(struct net_bridge *br,
 			rcu_assign_pointer(*pp, p->next);
 			hlist_del_init(&p->mglist);
 			del_timer(&p->timer);
-			call_rcu_bh(&p->rcu, br_multicast_free_pg);
+			call_rcu(&p->rcu, br_multicast_free_pg);
 			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
 				      p->flags);
 
@@ -2051,19 +2051,19 @@ void br_multicast_dev_del(struct net_bridge *br)
 		hlist_for_each_entry_safe(mp, n, &mdb->mhash[i],
 					  hlist[ver]) {
 			del_timer(&mp->timer);
-			call_rcu_bh(&mp->rcu, br_multicast_free_group);
+			call_rcu(&mp->rcu, br_multicast_free_group);
 		}
 	}
 
 	if (mdb->old) {
 		spin_unlock_bh(&br->multicast_lock);
-		rcu_barrier_bh();
+		rcu_barrier();
 		spin_lock_bh(&br->multicast_lock);
 		WARN_ON(mdb->old);
 	}
 
 	mdb->old = mdb;
-	call_rcu_bh(&mdb->rcu, br_mdb_free);
+	call_rcu(&mdb->rcu, br_mdb_free);
 
 out:
 	spin_unlock_bh(&br->multicast_lock);
-- 
2.17.1

