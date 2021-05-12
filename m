Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 13 May 2021 01:19:37 +0200
Message-Id: <20210512231941.19211-8-linus.luessing@c0d3.blue>
In-Reply-To: <20210512231941.19211-1-linus.luessing@c0d3.blue>
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [net-next v3 07/11] net: bridge: mcast: prepare add-router
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
access to an ip4 wrapper function.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 59 +++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 7815991..1d55709 100644
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
@@ -1689,7 +1689,7 @@ static void __br_multicast_enable_port(struct net_bridge_port *port)
 #endif
 	if (port->multicast_router == MDB_RTR_TYPE_PERM &&
 	    hlist_unhashed(&port->ip4_rlist))
-		br_multicast_add_router(br, port);
+		br_ip4_multicast_add_router(br, port);
 }
 
 void br_multicast_enable_port(struct net_bridge_port *port)
@@ -2659,28 +2659,51 @@ static void br_port_mc_router_state_change(struct net_bridge_port *p,
  *  and locked by br->multicast_lock and RCU
  */
 static void br_multicast_add_router(struct net_bridge *br,
-				    struct net_bridge_port *port)
+				    struct net_bridge_port *port,
+				    struct hlist_node *slot,
+				    struct hlist_node *rlist,
+				    struct hlist_head *mc_router_list)
 {
-	struct net_bridge_port *p;
-	struct hlist_node *slot = NULL;
-
-	if (!hlist_unhashed(&port->ip4_rlist))
+	if (!hlist_unhashed(rlist))
 		return;
 
-	hlist_for_each_entry(p, &br->ip4_mc_router_list, ip4_rlist) {
-		if ((unsigned long) port >= (unsigned long) p)
-			break;
-		slot = &p->ip4_rlist;
-	}
-
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
 
+static struct hlist_node *
+br_ip4_multicast_get_rport_slot(struct net_bridge *br, struct net_bridge_port *port)
+{
+	struct hlist_node *slot = NULL;
+	struct net_bridge_port *p;
+
+	hlist_for_each_entry(p, &br->ip4_mc_router_list, ip4_rlist) {
+		if ((unsigned long)port >= (unsigned long)p)
+			break;
+		slot = &p->ip4_rlist;
+	}
+
+	return slot;
+}
+
+/* Add port to router_list
+ *  list is maintained ordered by pointer value
+ *  and locked by br->multicast_lock and RCU
+ */
+static void br_ip4_multicast_add_router(struct net_bridge *br,
+					struct net_bridge_port *port)
+{
+	struct hlist_node *slot = br_ip4_multicast_get_rport_slot(br, port);
+
+	br_multicast_add_router(br, port, slot, &port->ip4_rlist,
+				&br->ip4_mc_router_list);
+}
+
 static void br_multicast_mark_router(struct net_bridge *br,
 				     struct net_bridge_port *port)
 {
@@ -2700,7 +2723,7 @@ static void br_multicast_mark_router(struct net_bridge *br,
 	    port->multicast_router == MDB_RTR_TYPE_PERM)
 		return;
 
-	br_multicast_add_router(br, port);
+	br_ip4_multicast_add_router(br, port);
 
 	mod_timer(&port->ip4_mc_router_timer,
 		  now + br->multicast_querier_interval);
@@ -3526,7 +3549,7 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 	case MDB_RTR_TYPE_PERM:
 		p->multicast_router = MDB_RTR_TYPE_PERM;
 		del_timer(&p->ip4_mc_router_timer);
-		br_multicast_add_router(br, p);
+		br_ip4_multicast_add_router(br, p);
 		break;
 	case MDB_RTR_TYPE_TEMP:
 		p->multicast_router = MDB_RTR_TYPE_TEMP;
-- 
2.31.0

