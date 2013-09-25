Return-Path: <paulmck@linux.vnet.ibm.com>
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 24 Sep 2013 18:35:14 -0700
Message-Id: <1380072916-31557-11-git-send-email-paulmck@linux.vnet.ibm.com>
In-Reply-To: <1380072916-31557-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20130925013451.GA31260@linux.vnet.ibm.com>
	<1380072916-31557-1-git-send-email-paulmck@linux.vnet.ibm.com>
Subject: [Bridge] [PATCH tip/core/rcu 11/13] bridge/br_mdb: Apply
	rcu_access_pointer() to avoid sparse false positive
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, tglx@linutronix.de, laijs@cn.fujitsu.com, edumazet@google.com, peterz@infradead.org, fweisbec@gmail.com, bridge@lists.linux-foundation.org, josh@joshtriplett.org, rostedt@goodmis.org, "David S. Miller" <davem@davemloft.net>, dhowells@redhat.com, sbw@mit.edu, niv@us.ibm.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, dipankar@in.ibm.com, darren@dvhart.com, akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, mingo@kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

The sparse checking for rcu_assign_pointer() was recently upgraded
to reject non-__kernel address spaces.  This also rejects __rcu,
which is almost always the right thing to do.  However, the use in
__br_mdb_del() is legitimate: They is assigning a pointer to an element
from an RCU-protected list, and all elements of this list are already
visible to caller.

This commit therefore silences these false positives by laundering the
pointers using rcu_access_pointer() as suggested by Josh Triplett.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 85a09bb..3184c88 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -447,7 +447,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 		if (p->port->state == BR_STATE_DISABLED)
 			goto unlock;
 
-		rcu_assign_pointer(*pp, p->next);
+		rcu_assign_pointer(*pp, rcu_access_pointer(p->next));
 		hlist_del_init(&p->mglist);
 		del_timer(&p->timer);
 		call_rcu_bh(&p->rcu, br_multicast_free_pg);
-- 
1.8.1.5

