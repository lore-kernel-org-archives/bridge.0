Return-Path: <tipbot@zytor.com>
Date: Tue, 4 Dec 2018 14:50:35 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-1a56f7d53b5c8e82442e86eeac0b5d549088ee42@git.kernel.org>
Reply-To: tglx@linutronix.de, davem@davemloft.net, roopa@cumulusnetworks.com, 
	netdev@vger.kernel.org, nikolay@cumulusnetworks.com, mingo@kernel.org,
	hpa@zytor.com, bridge@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Subject: [Bridge] [tip:core/rcu] net/bridge: Replace call_rcu_bh() and
 rcu_barrier_bh()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-tip-commits@vger.kernel.org
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de, paulmck@linux.ibm.com, davem@davemloft.net

Commit-ID:  1a56f7d53b5c8e82442e86eeac0b5d549088ee42
Gitweb:     https://git.kernel.org/tip/1a56f7d53b5c8e82442e86eeac0b5d549088ee42
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Tue, 6 Nov 2018 19:45:50 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Sat, 1 Dec 2018 12:38:48 -0800

net/bridge: Replace call_rcu_bh() and rcu_barrier_bh()

Now that call_rcu()'s callback is not invoked until after all bh-disable
regions of code have completed (in addition to explicitly marked
RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_bh().  Similarly, rcu_barrier() can be used in place of
rcu_barrier_bh().  This commit therefore makes these changes.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <bridge@lists.linux-foundation.org>
Cc: <netdev@vger.kernel.org>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
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
