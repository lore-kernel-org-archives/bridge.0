Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=bYcBMD0263VidrD3hBmBNToThm3cO5xgVyUXSYwtNSk=;
 b=T4omMjjTBYUygDUJqs2qeyJWoxrIZ8VgP6zJChmrH8GlXMT7A7uHI8RCaZb48a1vc8
 CriPE3c4iztC8LQlxpnwcAb1X8bRgeleRuZoFZ8V8FAWWbdsuSQPpwHBsflM0clmk1Va
 1dLozc8Up7stMYssey58mBkRz12AKi6XUxAObqucuoU3iBZeWk3qaTN1qZ9eKcQJMLwc
 687APJkB7FQg50eB+8SgHsH2RPEp4eOVo2Oa6y84pmpcwLTpNWgpS20BoMdFuUVMs7X6
 sGrTeCqobAjv5zjZeyPdCfpB7piQUWo7IdLuGLCN5/7W/Yd23WRp6n/YESNFpYEqeOgQ
 t7sQ==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Wed,  9 Feb 2022 14:05:33 +0100
Message-Id: <20220209130538.533699-2-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220209130538.533699-1-schultz.hans+netdev@gmail.com>
References: <20220209130538.533699-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 1/5] net: bridge: Add support for
	bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

In a 802.1X scenario, clients connected to a bridge port shall not
be allowed to have traffic forwarded until fully authenticated.
A static fdb entry of the clients MAC address for the bridge port
unlocks the client and allows bidirectional communication.

This scenario is facilitated with setting the bridge port in locked
mode, which is also supported by various switchcore chipsets.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 include/linux/if_bridge.h    |  1 +
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_input.c        | 10 +++++++++-
 net/bridge/br_netlink.c      |  6 +++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 509e18c7e740..3aae023a9353 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -58,6 +58,7 @@ struct br_ip_list {
 #define BR_MRP_LOST_CONT	BIT(18)
 #define BR_MRP_LOST_IN_CONT	BIT(19)
 #define BR_TX_FWD_OFFLOAD	BIT(20)
+#define BR_PORT_LOCKED		BIT(21)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 6218f93f5c1a..a45cc0a1f415 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -537,6 +537,7 @@ enum {
 	IFLA_BRPORT_MRP_IN_OPEN,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
+	IFLA_BRPORT_LOCKED,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index b50382f957c1..469e3adbce07 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -69,6 +69,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
 	enum br_pkt_type pkt_type = BR_PKT_UNICAST;
 	struct net_bridge_fdb_entry *dst = NULL;
+	struct net_bridge_fdb_entry *fdb_entry;
 	struct net_bridge_mcast_port *pmctx;
 	struct net_bridge_mdb_entry *mdst;
 	bool local_rcv, mcast_hit = false;
@@ -81,6 +82,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (!p || p->state == BR_STATE_DISABLED)
 		goto drop;
 
+	br = p->br;
+
 	brmctx = &p->br->multicast_ctx;
 	pmctx = &p->multicast_ctx;
 	state = p->state;
@@ -88,10 +91,15 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				&state, &vlan))
 		goto out;
 
+	if (p->flags & BR_PORT_LOCKED) {
+		fdb_entry = br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
+		if (!(fdb_entry && fdb_entry->dst == p))
+			goto drop;
+	}
+
 	nbp_switchdev_frame_mark(p, skb);
 
 	/* insert into forwarding database after filtering to avoid spoofing */
-	br = p->br;
 	if (p->flags & BR_LEARNING)
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 2ff83d84230d..7d4432ca9a20 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -184,6 +184,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
 		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
 		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
+		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
@@ -269,7 +270,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 							  BR_MRP_LOST_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
 		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
+	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
@@ -827,6 +829,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_GROUP_FWD_MASK] = { .type = NLA_U16 },
 	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
 	[IFLA_BRPORT_ISOLATED]	= { .type = NLA_U8 },
+	[IFLA_BRPORT_LOCKED] = { .type = NLA_U8 },
 	[IFLA_BRPORT_BACKUP_PORT] = { .type = NLA_U32 },
 	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] = { .type = NLA_U32 },
 };
@@ -893,6 +896,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
 	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
 	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
+	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
 
 	changed_mask = old_flags ^ p->flags;
 
-- 
2.30.2

