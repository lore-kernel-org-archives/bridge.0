Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E6FA42A92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1708C42A90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGiHTPuD//V83hBeK/0kqBvdMWAAjILZAz+t5SR6Z5c=;
 b=FC8lcD1hudVaWVu1m6LzxtTcPiCGHJWji0wJfjtpJNe5xWSiGjXTlPkhe7oRHl9P9WSMVjzowpTd9Jx/pkW8FnuSlsr7uW3GBk9T1TY3BcuUZdqsGDS7bChNJnBI87sgRDIg1frwJ7fICeZUq85eIw4iyindRem6Leoj3IHo+SrAvk18U6GmUWhkQcXct+tGfJsGRx2mmQeWw9ykNcFpWwXA78+4qJ0YwGTyz90+OtcC2F/wJRHstCE2gjXTC+53Zj9Djjhmr45Vp1hXbXeRyjLsketnRUaJRV6kZx9cCK3Gd4ApIs90jcRaRnbWMqrI/KxY7u8jV8s68WHkpGgBAA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 19 Apr 2023 18:34:59 +0300
Message-Id: <20230419153500.2655036-9-idosch@nvidia.com>
In-Reply-To: <20230419153500.2655036-1-idosch@nvidia.com>
References: <20230419153500.2655036-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 8/9] bridge: Allow setting per-{Port,
	VLAN} neighbor suppression state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add a new bridge port attribute that allows user space to enable
per-{Port, VLAN} neighbor suppression. Example:

 # bridge -d -j -p link show dev swp1 | jq '.[]["neigh_vlan_suppress"]'
 false
 # bridge link set dev swp1 neigh_vlan_suppress on
 # bridge -d -j -p link show dev swp1 | jq '.[]["neigh_vlan_suppress"]'
 true
 # bridge link set dev swp1 neigh_vlan_suppress off
 # bridge -d -j -p link show dev swp1 | jq '.[]["neigh_vlan_suppress"]'
 false

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_link.h | 1 +
 net/bridge/br_netlink.c      | 8 +++++++-
 net/core/rtnetlink.c         | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 8d679688efe0..4ac1000b0ef2 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -569,6 +569,7 @@ enum {
 	IFLA_BRPORT_MAB,
 	IFLA_BRPORT_MCAST_N_GROUPS,
 	IFLA_BRPORT_MCAST_MAX_GROUPS,
+	IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index fefb1c0e248b..05c5863d2e20 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -189,6 +189,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
 		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
 		+ nla_total_size(1)	/* IFLA_BRPORT_MAB */
+		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_VLAN_SUPPRESS */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
@@ -278,7 +279,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)))
+	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
+		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
@@ -891,6 +894,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] = { .type = NLA_U32 },
 	[IFLA_BRPORT_MCAST_N_GROUPS] = { .type = NLA_REJECT },
 	[IFLA_BRPORT_MCAST_MAX_GROUPS] = { .type = NLA_U32 },
+	[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 /* Change the state of the port and notify spanning tree */
@@ -957,6 +961,8 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
 	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
 	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
+	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
+			 BR_NEIGH_VLAN_SUPPRESS);
 
 	if ((p->flags & BR_PORT_MAB) &&
 	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e844d75220fb..653901a1bf75 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -61,7 +61,7 @@
 #include "dev.h"
 
 #define RTNL_MAX_TYPE		50
-#define RTNL_SLAVE_MAX_TYPE	42
+#define RTNL_SLAVE_MAX_TYPE	43
 
 struct rtnl_link {
 	rtnl_doit_func		doit;
-- 
2.37.3

