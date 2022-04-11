Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=TFNOjZAXZon/4fuYvoXX/NbbTAf3VntOhKR6DBqpfYk=;
 b=kvB+hyM6e8RNZhoXuBQ/tSpmItfGCHtV/80UPZA2wcqsSJle472+AMQJQkqTSKG1zm
 9Ts/A1anN1MHNODDAuUPyykcEu1h3TncWzzTNf9nyt/TVZtmY+pPFG7NFuUeJhHrhKXa
 g9WqrFGvVVpE5OLbkZ64U+QIwjL7mx5bxxM82hWCDKNkDygEjR9jbQoxAPm6i/8W5kPR
 RzHZi9JYFT+8ZqGHUqK4lCk6QIv67edRLjOnrYh6wQB2mGbwq+hC0jyLJCtINGFhAInp
 U08yaJaXH9DmG3bSRD4IyKJK0gv0HkZDmsae+6ULbupzhH0+WDlM2Kp1QSlSlOP6Jn3H
 itWQ==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:32 +0200
Message-Id: <20220411133837.318876-9-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 08/13] net: bridge: avoid classifying
	unknown multicast as mrouters_only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Unknown multicast, MAC/IPv4/IPv6, should always be flooded according to
the per-port mcast_flood setting, as well as to detected and configured
mcast_router ports.

This patch drops the mrouters_only classifier of unknown IP multicast
and moves the flow handling from br_multicast_flood() to br_flood().
This in turn means br_flood() must know about multicast router ports.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 net/bridge/br_forward.c   | 11 +++++++++++
 net/bridge/br_multicast.c |  6 +-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 02bb620d3b8d..ab5b97a8c12e 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -199,9 +199,15 @@ static struct net_bridge_port *maybe_deliver(
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig)
 {
+	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
+	struct net_bridge_port *rport = NULL;
 	struct net_bridge_port *prev = NULL;
+	struct hlist_node *rp = NULL;
 	struct net_bridge_port *p;
 
+	if (pkt_type == BR_PKT_MULTICAST)
+		rp = br_multicast_get_first_rport_node(brmctx, skb);
+
 	list_for_each_entry_rcu(p, &br->port_list, list) {
 		/* Do not flood unicast traffic to ports that turn it off, nor
 		 * other traffic if flood off, except for traffic we originate
@@ -212,6 +218,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 				continue;
 			break;
 		case BR_PKT_MULTICAST:
+			rport = br_multicast_rport_from_node_skb(rp, skb);
+			if (rport == p) {
+				rp = rcu_dereference(hlist_next_rcu(rp));
+				break;
+			}
 			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev)
 				continue;
 			break;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index db4f2641d1cd..c57e3bbb00ad 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3643,9 +3643,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge_mcast *brmctx,
 	err = ip_mc_check_igmp(skb);
 
 	if (err == -ENOMSG) {
-		if (!ipv4_is_local_multicast(ip_hdr(skb)->daddr)) {
-			BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
-		} else if (pim_ipv4_all_pim_routers(ip_hdr(skb)->daddr)) {
+		if (pim_ipv4_all_pim_routers(ip_hdr(skb)->daddr)) {
 			if (ip_hdr(skb)->protocol == IPPROTO_PIM)
 				br_multicast_pim(brmctx, pmctx, skb);
 		} else if (ipv4_is_all_snoopers(ip_hdr(skb)->daddr)) {
@@ -3712,8 +3710,6 @@ static int br_multicast_ipv6_rcv(struct net_bridge_mcast *brmctx,
 	err = ipv6_mc_check_mld(skb);
 
 	if (err == -ENOMSG || err == -ENODATA) {
-		if (!ipv6_addr_is_ll_all_nodes(&ipv6_hdr(skb)->daddr))
-			BR_INPUT_SKB_CB(skb)->mrouters_only = 1;
 		if (err == -ENODATA &&
 		    ipv6_addr_is_all_snoopers(&ipv6_hdr(skb)->daddr))
 			br_ip6_multicast_mrd_rcv(brmctx, pmctx, skb);
-- 
2.25.1

