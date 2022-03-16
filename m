Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=qEjq+JluqrX19JTya9E5BaOdRZi0yTBXOGGVayL2yG8=;
 b=E2yBmQ0oQWbZj+OJQ/GtTbkTinQMJwVEMzGVWSNnH0Kb84FX+zg3/y8Xju8B2bQwyW
 tLeVYacb4MTPPNq2SZPOnk77IcFp0lehuuh2ho1A30bSnkG3im6TlA8jMt1zVAmxI0ZM
 0TQKLyrvWxv8duC0gRHF6O/tzSI4KRV1KXlWc8vOQGN5a3LEOWuMt2l3wqhizrCu5Dhg
 /JthNozYLxn6W/kwLW3JKwfLM1vM7AkJ7C0ebaXQV55TuqspiALUUQQ9FQkCAl/5EYpF
 DpknQeD8T/noWlT6QM5ZQsW239R6s5c8QWTKBTq/Tq36F4UUD8hCisgqt+k9IN3+6wEw
 VAwA==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Mar 2022 16:08:44 +0100
Message-Id: <20220316150857.2442916-3-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 02/15] net: bridge: mst: Allow changing
	a VLAN's MSTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Allow a VLAN to move out of the CST (MSTI 0), to an independent tree.

The user manages the VID to MSTI mappings via a global VLAN
setting. The proposed iproute2 interface would be:

    bridge vlan global set dev br0 vid <VID> msti <MSTI>

Changing the state in non-zero MSTIs is still not supported, but will
be addressed in upcoming changes.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_mst.c            | 42 ++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h        |  1 +
 net/bridge/br_vlan_options.c   | 15 ++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 30a242195ced..f60244b747ae 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -564,6 +564,7 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
 	BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS,
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE,
+	BRIDGE_VLANDB_GOPTS_MSTI,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 0f9f596f86bc..d7a7b5d7ddb3 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -46,6 +46,48 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	return 0;
 }
 
+static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
+{
+	struct net_bridge_vlan_group *vg = nbp_vlan_group(pv->port);
+	struct net_bridge_vlan *v;
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		/* If this port already has a defined state in this
+		 * MSTI (through some other VLAN membership), inherit
+		 * it.
+		 */
+		if (v != pv && v->brvlan->msti == msti) {
+			br_mst_vlan_set_state(pv->port, pv, v->state);
+			return;
+		}
+	}
+
+	/* Otherwise, start out in a new MSTI with all ports disabled. */
+	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
+}
+
+int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *pv;
+	struct net_bridge_port *p;
+
+	if (mv->msti == msti)
+		return 0;
+
+	mv->msti = msti;
+
+	list_for_each_entry(p, &mv->br->port_list, list) {
+		vg = nbp_vlan_group(p);
+
+		pv = br_vlan_find(vg, mv->vid);
+		if (pv)
+			br_mst_vlan_sync_state(pv, msti);
+	}
+
+	return 0;
+}
+
 void br_mst_vlan_init_state(struct net_bridge_vlan *v)
 {
 	/* VLANs always start out in MSTI 0 (CST) */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c2190c8841fb..3978e1d9ffb5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1780,6 +1780,7 @@ static inline bool br_mst_is_enabled(struct net_bridge *br)
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		     struct netlink_ext_ack *extack);
+int br_mst_vlan_set_msti(struct net_bridge_vlan *v, u16 msti);
 void br_mst_vlan_init_state(struct net_bridge_vlan *v);
 int br_mst_set_enabled(struct net_bridge *br, bool on,
 		       struct netlink_ext_ack *extack);
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 09112b56e79c..a2724d03278c 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -296,6 +296,7 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 					 const struct net_bridge_vlan *r_end)
 {
 	return v_curr->vid - r_end->vid == 1 &&
+		v_curr->msti == r_end->msti &&
 	       ((v_curr->priv_flags ^ r_end->priv_flags) &
 		BR_VLFLAG_GLOBAL_MCAST_ENABLED) == 0 &&
 		br_multicast_ctx_options_equal(&v_curr->br_mcast_ctx,
@@ -384,6 +385,9 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 #endif
 #endif
 
+	if (nla_put_u16(skb, BRIDGE_VLANDB_GOPTS_MSTI, v_opts->msti))
+		goto out_err;
+
 	nla_nest_end(skb, nest);
 
 	return true;
@@ -415,6 +419,7 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(const struct net_bridge_vlan *v)
 		+ nla_total_size(0) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS */
 		+ br_rports_size(&v->br_mcast_ctx) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS */
 #endif
+		+ nla_total_size(sizeof(u16)) /* BRIDGE_VLANDB_GOPTS_MSTI */
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
 
@@ -564,6 +569,15 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 	}
 #endif
 #endif
+	if (tb[BRIDGE_VLANDB_GOPTS_MSTI]) {
+		u16 msti;
+
+		msti = nla_get_u16(tb[BRIDGE_VLANDB_GOPTS_MSTI]);
+		err = br_mst_vlan_set_msti(v, msti);
+		if (err)
+			return err;
+		*changed = true;
+	}
 
 	return 0;
 }
@@ -583,6 +597,7 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_INTVL]	= { .type = NLA_U64 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL]	= { .type = NLA_U64 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL] = { .type = NLA_U64 },
+	[BRIDGE_VLANDB_GOPTS_MSTI] = NLA_POLICY_MAX(NLA_U16, VLAN_N_VID - 1),
 };
 
 int br_vlan_rtm_process_global_options(struct net_device *dev,
-- 
2.25.1

