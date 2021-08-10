Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VZ4j9a98e0WJs436DgllC2xVf3eKi/fAJXZDQxBoJ/o=;
 b=RZRWfM+IcMidlckNyPcIcDqyBy9Jbscz3ilikrUbLBfAdF7TgX/NFmFPliJ099cK7i
 TUcOKL4JaiRFGspcLvBCgp9tDNvDfykQ+kDzdx5o+AsvimQKC/1IaCLWEmXNhmTj1CEO
 FHE2VRzmt2Bub0WKZa50odMeayr6ZzoODplsld01AxX9E2JKgt7URVSmPQOh6y6hjhuv
 Tcp4lrRtwZPf/7aTEzgX1kJxynTNdlQTC1J5Dq/0b2CZyLz87Zf5vMC0JixAo2ukHg9H
 LGD3sH9jSRquaiLIT5M5UYzMN03Qj6K3RepBRWbZy6X6aC/q9wg0LzWmGya5OjlT+OMo
 SXgA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:32 +0300
Message-Id: <20210810152933.178325-15-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 14/15] net: bridge: mcast: use the proper
	multicast context when dumping router ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When we are dumping the router ports of a vlan mcast context we need to
use the bridge/vlan and port/vlan's multicast contexts to check if
IPv4/IPv6 router port is present and later to dump the vlan id.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_mdb.c | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 73a8915b0148..7c16e2c76220 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -16,7 +16,7 @@
 
 #include "br_private.h"
 
-static bool br_rports_have_mc_router(struct net_bridge_mcast *brmctx)
+static bool br_rports_have_mc_router(const struct net_bridge_mcast *brmctx)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	return !hlist_empty(&brmctx->ip4_mc_router_list) ||
@@ -27,46 +27,58 @@ static bool br_rports_have_mc_router(struct net_bridge_mcast *brmctx)
 }
 
 static bool
-br_ip4_rports_get_timer(struct net_bridge_port *port, unsigned long *timer)
+br_ip4_rports_get_timer(struct net_bridge_mcast_port *pmctx,
+			unsigned long *timer)
 {
-	*timer = br_timer_value(&port->multicast_ctx.ip4_mc_router_timer);
-	return !hlist_unhashed(&port->multicast_ctx.ip4_rlist);
+	*timer = br_timer_value(&pmctx->ip4_mc_router_timer);
+	return !hlist_unhashed(&pmctx->ip4_rlist);
 }
 
 static bool
-br_ip6_rports_get_timer(struct net_bridge_port *port, unsigned long *timer)
+br_ip6_rports_get_timer(struct net_bridge_mcast_port *pmctx,
+			unsigned long *timer)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	*timer = br_timer_value(&port->multicast_ctx.ip6_mc_router_timer);
-	return !hlist_unhashed(&port->multicast_ctx.ip6_rlist);
+	*timer = br_timer_value(&pmctx->ip6_mc_router_timer);
+	return !hlist_unhashed(&pmctx->ip6_rlist);
 #else
 	*timer = 0;
 	return false;
 #endif
 }
 
-static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
-			       struct net_device *dev)
+static int br_rports_fill_info(struct sk_buff *skb,
+			       const struct net_bridge_mcast *brmctx)
 {
-	struct net_bridge *br = netdev_priv(dev);
+	u16 vid = brmctx->vlan ? brmctx->vlan->vid : 0;
 	bool have_ip4_mc_rtr, have_ip6_mc_rtr;
 	unsigned long ip4_timer, ip6_timer;
 	struct nlattr *nest, *port_nest;
 	struct net_bridge_port *p;
 
-	if (!br->multicast_ctx.multicast_router)
-		return 0;
-
-	if (!br_rports_have_mc_router(&br->multicast_ctx))
+	if (!brmctx->multicast_router || !br_rports_have_mc_router(brmctx))
 		return 0;
 
 	nest = nla_nest_start_noflag(skb, MDBA_ROUTER);
 	if (nest == NULL)
 		return -EMSGSIZE;
 
-	list_for_each_entry_rcu(p, &br->port_list, list) {
-		have_ip4_mc_rtr = br_ip4_rports_get_timer(p, &ip4_timer);
-		have_ip6_mc_rtr = br_ip6_rports_get_timer(p, &ip6_timer);
+	list_for_each_entry_rcu(p, &brmctx->br->port_list, list) {
+		struct net_bridge_mcast_port *pmctx;
+
+		if (vid) {
+			struct net_bridge_vlan *v;
+
+			v = br_vlan_find(nbp_vlan_group(p), vid);
+			if (!v)
+				continue;
+			pmctx = &v->port_mcast_ctx;
+		} else {
+			pmctx = &p->multicast_ctx;
+		}
+
+		have_ip4_mc_rtr = br_ip4_rports_get_timer(pmctx, &ip4_timer);
+		have_ip6_mc_rtr = br_ip6_rports_get_timer(pmctx, &ip6_timer);
 
 		if (!have_ip4_mc_rtr && !have_ip6_mc_rtr)
 			continue;
@@ -390,6 +402,7 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 	for_each_netdev_rcu(net, dev) {
 		if (dev->priv_flags & IFF_EBRIDGE) {
+			struct net_bridge *br = netdev_priv(dev);
 			struct br_port_msg *bpm;
 
 			if (idx < s_idx)
@@ -406,7 +419,7 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 			bpm->ifindex = dev->ifindex;
 			if (br_mdb_fill_info(skb, cb, dev) < 0)
 				goto out;
-			if (br_rports_fill_info(skb, cb, dev) < 0)
+			if (br_rports_fill_info(skb, &br->multicast_ctx) < 0)
 				goto out;
 
 			cb->args[1] = 0;
-- 
2.31.1

