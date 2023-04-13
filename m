Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9DC441594
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8E71411A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OocpeD0UomI/FlyahJq/PTTUvQlSvlpAuA6QQ1oKXlo=;
 b=hjfE86leb4fR2D/5++bDZF7lP5Qc7zGgjOjjabEYmhOJ4/PziQTTLBF0uf0twhZubKpXevO2rNMBtxkn/1W8ASvOKIqtk0AZhhn3X+MzOng8VAirKkcY0Xpdvzed5YC8m/EQZMEttehRPrGrE3M4wgXo/qskBicn/Ku5YZY3Xm+1rGjxka8tg49TTYBOshaKTe/EL61OhooOiJbS/oWSCAeDXRe5CRqc+adKEFwBq5h+Z2ap67MUUeeBou85QUOpI5gdY8cXtwk1VLQcCfyf45abhUz66iNtXkuMtQP6RhfMjRXxSYUtViqfgffpFHGFV8tSJkNp9ttsYHXCDSytvg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Apr 2023 12:58:28 +0300
Message-Id: <20230413095830.2182382-8-idosch@nvidia.com>
In-Reply-To: <20230413095830.2182382-1-idosch@nvidia.com>
References: <20230413095830.2182382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 7/9] bridge: vlan: Allow setting VLAN
	neighbor suppression state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add a new VLAN attribute that allows user space to set the neighbor
suppression state of the port VLAN. Example:

 # bridge -d -j -p vlan show dev swp1 vid 10 | jq '.[]["vlans"][]["neigh_suppress"]'
 false
 # bridge vlan set vid 10 dev swp1 neigh_suppress on
 # bridge -d -j -p vlan show dev swp1 vid 10 | jq '.[]["vlans"][]["neigh_suppress"]'
 true
 # bridge vlan set vid 10 dev swp1 neigh_suppress off
 # bridge -d -j -p vlan show dev swp1 vid 10 | jq '.[]["vlans"][]["neigh_suppress"]'
 false

 # bridge vlan set vid 10 dev br0 neigh_suppress on
 Error: bridge: Can't set neigh_suppress for non-port vlans.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_vlan.c           |  1 +
 net/bridge/br_vlan_options.c   | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index c9d624f528c5..f95326fce6bb 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -525,6 +525,7 @@ enum {
 	BRIDGE_VLANDB_ENTRY_MCAST_ROUTER,
 	BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS,
 	BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS,
+	BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS,
 	__BRIDGE_VLANDB_ENTRY_MAX,
 };
 #define BRIDGE_VLANDB_ENTRY_MAX (__BRIDGE_VLANDB_ENTRY_MAX - 1)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8a3dbc09ba38..15f44d026e75 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2134,6 +2134,7 @@ static const struct nla_policy br_vlan_db_policy[BRIDGE_VLANDB_ENTRY_MAX + 1] =
 	[BRIDGE_VLANDB_ENTRY_MCAST_ROUTER]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS]	= { .type = NLA_REJECT },
 	[BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS]	= { .type = NLA_U32 },
+	[BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS]	= NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static int br_vlan_rtm_process_one(struct net_device *dev,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index e378c2f3a9e2..8fa89b04ee94 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -52,7 +52,9 @@ bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v,
 		       const struct net_bridge_port *p)
 {
 	if (nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_STATE, br_vlan_get_state(v)) ||
-	    !__vlan_tun_put(skb, v))
+	    !__vlan_tun_put(skb, v) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS,
+		       !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED)))
 		return false;
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -80,6 +82,7 @@ size_t br_vlan_opts_nl_size(void)
 	       + nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS */
 	       + nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS */
 #endif
+	       + nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS */
 	       + 0;
 }
 
@@ -239,6 +242,21 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 	}
 #endif
 
+	if (tb[BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS]) {
+		bool enabled = v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED;
+		bool val = nla_get_u8(tb[BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS]);
+
+		if (!p) {
+			NL_SET_ERR_MSG_MOD(extack, "Can't set neigh_suppress for non-port vlans");
+			return -EINVAL;
+		}
+
+		if (val != enabled) {
+			v->priv_flags ^= BR_VLFLAG_NEIGH_SUPPRESS_ENABLED;
+			*changed = true;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.37.3

