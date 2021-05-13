Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 13 May 2021 15:20:44 +0200
Message-Id: <20210513132053.23445-3-linus.luessing@c0d3.blue>
In-Reply-To: <20210513132053.23445-1-linus.luessing@c0d3.blue>
References: <20210513132053.23445-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [net-next v4 02/11] net: bridge: mcast: add wrappers for
	router node retrieval
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
their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
two wrapper functions for router node retrieval in the payload
forwarding code.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_forward.c |  5 +++--
 net/bridge/br_private.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index eb9847a..0785636 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -276,7 +276,8 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 	bool allow_mode_include = true;
 	struct hlist_node *rp;
 
-	rp = rcu_dereference(hlist_first_rcu(&br->ip4_mc_router_list));
+	rp = br_multicast_get_first_rport_node(br, skb);
+
 	if (mdst) {
 		p = rcu_dereference(mdst->ports);
 		if (br_multicast_should_handle_mode(br, mdst->addr.proto) &&
@@ -290,7 +291,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		struct net_bridge_port *port, *lport, *rport;
 
 		lport = p ? p->key.port : NULL;
-		rport = hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
+		rport = br_multicast_rport_from_node_skb(rp, skb);
 
 		if ((unsigned long)lport > (unsigned long)rport) {
 			port = lport;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 26e91d2..d970ef7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -864,6 +864,16 @@ static inline bool br_group_is_l2(const struct br_ip *group)
 #define mlock_dereference(X, br) \
 	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
 
+static inline struct hlist_node *
+br_multicast_get_first_rport_node(struct net_bridge *b, struct sk_buff *skb) {
+	return rcu_dereference(hlist_first_rcu(&b->ip4_mc_router_list));
+}
+
+static inline struct net_bridge_port *
+br_multicast_rport_from_node_skb(struct hlist_node *rp, struct sk_buff *skb) {
+	return hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
+}
+
 static inline bool br_multicast_is_router(struct net_bridge *br)
 {
 	return br->multicast_router == 2 ||
-- 
2.31.0

