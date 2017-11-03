Return-Path: <allen.pais@oracle.com>
From: Allen Pais <allen.pais@oracle.com>
Date: Fri,  3 Nov 2017 11:51:10 +0530
Message-Id: <1509690071-12585-1-git-send-email-allen.pais@oracle.com>
Subject: [Bridge] [PATCH 1/2] [net-next] net: bridge: Convert timers to use
	timer_setup()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, Allen Pais <allen.pais@oracle.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, keescook@chromium.org

switch to using the new timer_setup() and from_timer() api's.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 net/bridge/br_multicast.c | 79 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 7947e04..5f7f0e9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -239,9 +239,9 @@ static void br_multicast_free_group(struct rcu_head *head)
 	kfree(mp);
 }
 
-static void br_multicast_group_expired(unsigned long data)
+static void br_multicast_group_expired(struct timer_list *t)
 {
-	struct net_bridge_mdb_entry *mp = (void *)data;
+	struct net_bridge_mdb_entry *mp = from_timer(mp, t, timer);
 	struct net_bridge *br = mp->br;
 	struct net_bridge_mdb_htable *mdb;
 
@@ -302,9 +302,9 @@ static void br_multicast_del_pg(struct net_bridge *br,
 	WARN_ON(1);
 }
 
-static void br_multicast_port_group_expired(unsigned long data)
+static void br_multicast_port_group_expired(struct timer_list *t)
 {
-	struct net_bridge_port_group *pg = (void *)data;
+	struct net_bridge_port_group *pg = from_timer(pg, t, timer);
 	struct net_bridge *br = pg->port->br;
 
 	spin_lock(&br->multicast_lock);
@@ -701,8 +701,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 
 	mp->br = br;
 	mp->addr = *group;
-	setup_timer(&mp->timer, br_multicast_group_expired,
-		    (unsigned long)mp);
+	timer_setup(&mp->timer, br_multicast_group_expired, 0);
 
 	hlist_add_head_rcu(&mp->hlist[mdb->ver], &mdb->mhash[hash]);
 	mdb->size++;
@@ -729,8 +728,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	p->flags = flags;
 	rcu_assign_pointer(p->next, next);
 	hlist_add_head(&p->mglist, &port->mglist);
-	setup_timer(&p->timer, br_multicast_port_group_expired,
-		    (unsigned long)p);
+	timer_setup(&p->timer, br_multicast_port_group_expired, 0);
 
 	if (src)
 		memcpy(p->eth_addr, src, ETH_ALEN);
@@ -843,9 +841,10 @@ static int br_ip6_multicast_add_group(struct net_bridge *br,
 }
 #endif
 
-static void br_multicast_router_expired(unsigned long data)
+static void br_multicast_router_expired(struct timer_list *t)
 {
-	struct net_bridge_port *port = (void *)data;
+	struct net_bridge_port *port =
+			from_timer(port, t, multicast_router_timer);
 	struct net_bridge *br = port->br;
 
 	spin_lock(&br->multicast_lock);
@@ -872,9 +871,9 @@ static void br_mc_router_state_change(struct net_bridge *p,
 	switchdev_port_attr_set(p->dev, &attr);
 }
 
-static void br_multicast_local_router_expired(unsigned long data)
+static void br_multicast_local_router_expired(struct timer_list *t)
 {
-	struct net_bridge *br = (struct net_bridge *)data;
+	struct net_bridge *br = from_timer(br, t, multicast_router_timer);
 
 	spin_lock(&br->multicast_lock);
 	if (br->multicast_router == MDB_RTR_TYPE_DISABLED ||
@@ -900,17 +899,17 @@ static void br_multicast_querier_expired(struct net_bridge *br,
 	spin_unlock(&br->multicast_lock);
 }
 
-static void br_ip4_multicast_querier_expired(unsigned long data)
+static void br_ip4_multicast_querier_expired(struct timer_list *t)
 {
-	struct net_bridge *br = (void *)data;
+	struct net_bridge *br = from_timer(br, t, ip4_other_query.timer);
 
 	br_multicast_querier_expired(br, &br->ip4_own_query);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static void br_ip6_multicast_querier_expired(unsigned long data)
+static void br_ip6_multicast_querier_expired(struct timer_list *t)
 {
-	struct net_bridge *br = (void *)data;
+	struct net_bridge *br = from_timer(br, t, ip6_other_query.timer);
 
 	br_multicast_querier_expired(br, &br->ip6_own_query);
 }
@@ -1011,17 +1010,17 @@ br_multicast_port_query_expired(struct net_bridge_port *port,
 	spin_unlock(&br->multicast_lock);
 }
 
-static void br_ip4_multicast_port_query_expired(unsigned long data)
+static void br_ip4_multicast_port_query_expired(struct timer_list *t)
 {
-	struct net_bridge_port *port = (void *)data;
+	struct net_bridge_port *port = from_timer(port, t, ip4_own_query.timer);
 
 	br_multicast_port_query_expired(port, &port->ip4_own_query);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static void br_ip6_multicast_port_query_expired(unsigned long data)
+static void br_ip6_multicast_port_query_expired(struct timer_list *t)
 {
-	struct net_bridge_port *port = (void *)data;
+	struct net_bridge_port *port = from_timer(port, t, ip6_own_query.timer);
 
 	br_multicast_port_query_expired(port, &port->ip6_own_query);
 }
@@ -1043,13 +1042,13 @@ int br_multicast_add_port(struct net_bridge_port *port)
 {
 	port->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
 
-	setup_timer(&port->multicast_router_timer, br_multicast_router_expired,
-		    (unsigned long)port);
-	setup_timer(&port->ip4_own_query.timer,
-		    br_ip4_multicast_port_query_expired, (unsigned long)port);
+	timer_setup(&port->multicast_router_timer,
+		    br_multicast_router_expired, 0);
+	timer_setup(&port->ip4_own_query.timer,
+		    br_ip4_multicast_port_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
-	setup_timer(&port->ip6_own_query.timer,
-		    br_ip6_multicast_port_query_expired, (unsigned long)port);
+	timer_setup(&port->ip6_own_query.timer,
+		    br_ip6_multicast_port_query_expired, 0);
 #endif
 	br_mc_disabled_update(port->dev, port->br->multicast_disabled);
 
@@ -1933,17 +1932,17 @@ static void br_multicast_query_expired(struct net_bridge *br,
 	spin_unlock(&br->multicast_lock);
 }
 
-static void br_ip4_multicast_query_expired(unsigned long data)
+static void br_ip4_multicast_query_expired(struct timer_list *t)
 {
-	struct net_bridge *br = (void *)data;
+	struct net_bridge *br = from_timer(br, t, ip4_own_query.timer);
 
 	br_multicast_query_expired(br, &br->ip4_own_query, &br->ip4_querier);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static void br_ip6_multicast_query_expired(unsigned long data)
+static void br_ip6_multicast_query_expired(struct timer_list *t)
 {
-	struct net_bridge *br = (void *)data;
+	struct net_bridge *br = from_timer(br, t, ip6_own_query.timer);
 
 	br_multicast_query_expired(br, &br->ip6_own_query, &br->ip6_querier);
 }
@@ -1978,17 +1977,17 @@ void br_multicast_init(struct net_bridge *br)
 	br->has_ipv6_addr = 1;
 
 	spin_lock_init(&br->multicast_lock);
-	setup_timer(&br->multicast_router_timer,
-		    br_multicast_local_router_expired, (unsigned long)br);
-	setup_timer(&br->ip4_other_query.timer,
-		    br_ip4_multicast_querier_expired, (unsigned long)br);
-	setup_timer(&br->ip4_own_query.timer, br_ip4_multicast_query_expired,
-		    (unsigned long)br);
+	timer_setup(&br->multicast_router_timer,
+		    br_multicast_local_router_expired, 0);
+	timer_setup(&br->ip4_other_query.timer,
+		    br_ip4_multicast_querier_expired, 0);
+	timer_setup(&br->ip4_own_query.timer,
+		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
-	setup_timer(&br->ip6_other_query.timer,
-		    br_ip6_multicast_querier_expired, (unsigned long)br);
-	setup_timer(&br->ip6_own_query.timer, br_ip6_multicast_query_expired,
-		    (unsigned long)br);
+	timer_setup(&br->ip6_other_query.timer,
+		    br_ip6_multicast_querier_expired, 0);
+	timer_setup(&br->ip6_own_query.timer,
+		    br_ip6_multicast_query_expired, 0);
 #endif
 }
 
-- 
2.7.4

