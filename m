Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 13 May 2021 15:20:49 +0200
Message-Id: <20210513132053.23445-8-linus.luessing@c0d3.blue>
In-Reply-To: <20210513132053.23445-1-linus.luessing@c0d3.blue>
References: <20210513132053.23445-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [net-next v4 07/11] net: bridge: mcast: prepare add-router
	function for mcast router split
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

In preparation for the upcoming split of multicast router state into
their IPv4 and IPv6 variants move the protocol specific router list
and timer access to ip4 wrapper functions.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 121 +++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 34 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 7815991..dc95464 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -51,8 +51,8 @@ static const struct rhashtable_params br_sg_port_rht_params = {
 
 static void br_multicast_start_querier(struct net_bridge *br,
 				       struct bridge_mcast_own_query *query);
-static void br_multicast_add_router(struct net_bridge *br,
-				    struct net_bridge_port *port);
+static void br_ip4_multicast_add_router(struct net_bridge *br,
+					struct net_bridge_port *port);
 static void br_ip4_multicast_leave_group(struct net_bridge *br,
 					 struct net_bridge_port *port,
 					 __be32 group,
@@ -1687,9 +1687,8 @@ static void __br_multicast_enable_port(struct net_bridge_port *port)
 #if IS_ENABLED(CONFIG_IPV6)
 	br_multicast_enable(&port->ip6_own_query);
 #endif
-	if (port->multicast_router == MDB_RTR_TYPE_PERM &&
-	    hlist_unhashed(&port->ip4_rlist))
-		br_multicast_add_router(br, port);
+	if (port->multicast_router == MDB_RTR_TYPE_PERM)
+		br_ip4_multicast_add_router(br, port);
 }
 
 void br_multicast_enable_port(struct net_bridge_port *port)
@@ -2653,45 +2652,86 @@ static void br_port_mc_router_state_change(struct net_bridge_port *p,
 	switchdev_port_attr_set(p->dev, &attr, NULL);
 }
 
-/*
- * Add port to router_list
- *  list is maintained ordered by pointer value
- *  and locked by br->multicast_lock and RCU
- */
-static void br_multicast_add_router(struct net_bridge *br,
-				    struct net_bridge_port *port)
+static struct net_bridge_port *
+br_multicast_rport_from_node(struct net_bridge *br,
+			     struct hlist_head *mc_router_list,
+			     struct hlist_node *rlist)
+{
+	return hlist_entry(rlist, struct net_bridge_port, ip4_rlist);
+}
+
+static struct hlist_node *
+br_multicast_get_rport_slot(struct net_bridge *br,
+			    struct net_bridge_port *port,
+			    struct hlist_head *mc_router_list)
+
 {
-	struct net_bridge_port *p;
 	struct hlist_node *slot = NULL;
+	struct net_bridge_port *p;
+	struct hlist_node *rlist;
 
-	if (!hlist_unhashed(&port->ip4_rlist))
-		return;
+	hlist_for_each(rlist, mc_router_list) {
+		p = br_multicast_rport_from_node(br, mc_router_list, rlist);
 
-	hlist_for_each_entry(p, &br->ip4_mc_router_list, ip4_rlist) {
-		if ((unsigned long) port >= (unsigned long) p)
+		if ((unsigned long)port >= (unsigned long)p)
 			break;
-		slot = &p->ip4_rlist;
+
+		slot = rlist;
 	}
 
+	return slot;
+}
+
+/* Add port to router_list
+ *  list is maintained ordered by pointer value
+ *  and locked by br->multicast_lock and RCU
+ */
+static void br_multicast_add_router(struct net_bridge *br,
+				    struct net_bridge_port *port,
+				    struct hlist_node *rlist,
+				    struct hlist_head *mc_router_list)
+{
+	struct hlist_node *slot;
+
+	if (!hlist_unhashed(rlist))
+		return;
+
+	slot = br_multicast_get_rport_slot(br, port, mc_router_list);
+
 	if (slot)
-		hlist_add_behind_rcu(&port->ip4_rlist, slot);
+		hlist_add_behind_rcu(rlist, slot);
 	else
-		hlist_add_head_rcu(&port->ip4_rlist, &br->ip4_mc_router_list);
+		hlist_add_head_rcu(rlist, mc_router_list);
+
 	br_rtr_notify(br->dev, port, RTM_NEWMDB);
 	br_port_mc_router_state_change(port, true);
 }
 
+/* Add port to router_list
+ *  list is maintained ordered by pointer value
+ *  and locked by br->multicast_lock and RCU
+ */
+static void br_ip4_multicast_add_router(struct net_bridge *br,
+					struct net_bridge_port *port)
+{
+	br_multicast_add_router(br, port, &port->ip4_rlist,
+				&br->ip4_mc_router_list);
+}
+
 static void br_multicast_mark_router(struct net_bridge *br,
-				     struct net_bridge_port *port)
+				     struct net_bridge_port *port,
+				     struct timer_list *timer,
+				     struct hlist_node *rlist,
+				     struct hlist_head *mc_router_list)
 {
 	unsigned long now = jiffies;
 
 	if (!port) {
 		if (br->multicast_router == MDB_RTR_TYPE_TEMP_QUERY) {
-			if (!timer_pending(&br->ip4_mc_router_timer))
+			if (!br_ip4_multicast_is_router(br) &&
+			    !br_ip6_multicast_is_router(br))
 				br_mc_router_state_change(br, true);
-			mod_timer(&br->ip4_mc_router_timer,
-				  now + br->multicast_querier_interval);
+			mod_timer(timer, now + br->multicast_querier_interval);
 		}
 		return;
 	}
@@ -2700,10 +2740,23 @@ static void br_multicast_mark_router(struct net_bridge *br,
 	    port->multicast_router == MDB_RTR_TYPE_PERM)
 		return;
 
-	br_multicast_add_router(br, port);
+	br_multicast_add_router(br, port, rlist, mc_router_list);
+	mod_timer(timer, now + br->multicast_querier_interval);
+}
 
-	mod_timer(&port->ip4_mc_router_timer,
-		  now + br->multicast_querier_interval);
+static void br_ip4_multicast_mark_router(struct net_bridge *br,
+					 struct net_bridge_port *port)
+{
+	struct timer_list *timer = &br->ip4_mc_router_timer;
+	struct hlist_node *rlist = NULL;
+
+	if (port) {
+		timer = &port->ip4_mc_router_timer;
+		rlist = &port->ip4_rlist;
+	}
+
+	br_multicast_mark_router(br, port, timer, rlist,
+				 &br->ip4_mc_router_list);
 }
 
 static void
@@ -2717,7 +2770,7 @@ br_ip4_multicast_query_received(struct net_bridge *br,
 		return;
 
 	br_multicast_update_query_timer(br, query, max_delay);
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2732,7 +2785,7 @@ br_ip6_multicast_query_received(struct net_bridge *br,
 		return;
 
 	br_multicast_update_query_timer(br, query, max_delay);
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 }
 #endif
 
@@ -3102,7 +3155,7 @@ static void br_multicast_pim(struct net_bridge *br,
 	    pim_hdr_type(pimhdr) != PIM_TYPE_HELLO)
 		return;
 
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 }
 
 static int br_ip4_multicast_mrd_rcv(struct net_bridge *br,
@@ -3113,7 +3166,7 @@ static int br_ip4_multicast_mrd_rcv(struct net_bridge *br,
 	    igmp_hdr(skb)->type != IGMP_MRDISC_ADV)
 		return -ENOMSG;
 
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 
 	return 0;
 }
@@ -3181,7 +3234,7 @@ static void br_ip6_multicast_mrd_rcv(struct net_bridge *br,
 	if (icmp6_hdr(skb)->icmp6_type != ICMPV6_MRDISC_ADV)
 		return;
 
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 }
 
 static int br_multicast_ipv6_rcv(struct net_bridge *br,
@@ -3526,11 +3579,11 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 	case MDB_RTR_TYPE_PERM:
 		p->multicast_router = MDB_RTR_TYPE_PERM;
 		del_timer(&p->ip4_mc_router_timer);
-		br_multicast_add_router(br, p);
+		br_ip4_multicast_add_router(br, p);
 		break;
 	case MDB_RTR_TYPE_TEMP:
 		p->multicast_router = MDB_RTR_TYPE_TEMP;
-		br_multicast_mark_router(br, p);
+		br_ip4_multicast_mark_router(br, p);
 		break;
 	default:
 		goto unlock;
-- 
2.31.0

