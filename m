Date: Wed, 11 Oct 2006 10:32:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061011103242.10d9a741@freekitty>
In-Reply-To: <cab05a880610110233u2d48c96ena9915cf2bb3cb682@mail.gmail.com>
References: <cab05a880610090952g2e94b7aka84ccb0ef8fd8013@mail.gmail.com>
	<452CB1E0.9020008@cambridgebroadband.com>
	<cab05a880610110233u2d48c96ena9915cf2bb3cb682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Link fail over - bridge slow learning !?!
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Cc: bridge@lists.osdl.org

Does this do what you want?

Flush the forwarding table when carrier is lost. This helps for
availability because new packets may come in on other links.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 net/bridge/br_fdb.c     |    9 ++++++++-
 net/bridge/br_if.c      |    4 ++--
 net/bridge/br_private.h |    2 +-
 net/bridge/br_stp_if.c  |    2 ++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 3a73b8c..557789b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -128,7 +128,10 @@ void br_fdb_cleanup(unsigned long _data)
 	mod_timer(&br->gc_timer, jiffies + HZ/10);
 }
 
-void br_fdb_delete_by_port(struct net_bridge *br, struct net_bridge_port *p)
+
+void br_fdb_delete_by_port(struct net_bridge *br, 
+			   const struct net_bridge_port *p,
+			   int do_all)
 {
 	int i;
 
@@ -142,6 +145,8 @@ void br_fdb_delete_by_port(struct net_br
 			if (f->dst != p) 
 				continue;
 
+			if (f->is_static & !do_all)
+				continue;
 			/*
 			 * if multiple ports all have the same device address
 			 * then when one port is deleted, assign
@@ -149,6 +154,7 @@ void br_fdb_delete_by_port(struct net_br
 			 */
 			if (f->is_local) {
 				struct net_bridge_port *op;
+
 				list_for_each_entry(op, &br->port_list, list) {
 					if (op != p && 
 					    !compare_ether_addr(op->dev->dev_addr,
@@ -166,6 +172,7 @@ void br_fdb_delete_by_port(struct net_br
 	spin_unlock_bh(&br->hash_lock);
 }
 
+
 /* No locking or refcounting, assumes caller has no preempt (rcu_read_lock) */
 struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
 					  const unsigned char *addr)
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index b1211d5..f753c40 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -163,7 +163,7 @@ static void del_nbp(struct net_bridge_po
 	br_stp_disable_port(p);
 	spin_unlock_bh(&br->lock);
 
-	br_fdb_delete_by_port(br, p);
+	br_fdb_delete_by_port(br, p, 1);
 
 	list_del_rcu(&p->list);
 
@@ -448,7 +448,7 @@ int br_add_if(struct net_bridge *br, str
 
 	return 0;
 err2:
-	br_fdb_delete_by_port(br, p);
+	br_fdb_delete_by_port(br, p, 1);
 err1:
 	kobject_del(&p->kobj);
 err0:
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c491fb2..74258d8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -143,7 +143,7 @@ extern void br_fdb_changeaddr(struct net
 			      const unsigned char *newaddr);
 extern void br_fdb_cleanup(unsigned long arg);
 extern void br_fdb_delete_by_port(struct net_bridge *br,
-			   struct net_bridge_port *p);
+				  const struct net_bridge_port *p, int do_all);
 extern struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
 						 const unsigned char *addr);
 extern struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 14cd025..d294224 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -113,6 +113,8 @@ void br_stp_disable_port(struct net_brid
 	del_timer(&p->forward_delay_timer);
 	del_timer(&p->hold_timer);
 
+	br_fdb_delete_by_port(br, p, 0);
+
 	br_configuration_update(br);
 
 	br_port_state_selection(br);
-- 
1.4.2.3

