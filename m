Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgxR7hFYSoTBWSHzj5ZUbxnFm+s0uIOxEOzE3rEZmOI=;
 b=WTrlWR3zS10EVS3swB3BcwzODRW1GdUzHXdroYIfxLI+DoLmhcRqGHEgCRKyGDPZFWhtkLseWAyVp8ppTbV5tM3QktgVfZXQ1UesGhRu1G2Wt9kHjkIsfU2Q+J1JF0LIoOFIljiQF3yxx9nTYhaf429xEA2GMejyIlnf4z4UkpM=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:56:59 +0300
Message-Id: <20210703115705.1034112-5-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 04/10] net: bridge: switchdev:
	allow the data plane forwarding to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Tobias Waldekranz <tobias@waldekranz.com>

Allow switchdevs to forward frames from the CPU in accordance with the
bridge configuration in the same way as is done between bridge
ports. This means that the bridge will only send a single skb towards
one of the ports under the switchdev's control, and expects the driver
to deliver the packet to all eligible ports in its domain.

Primarily this improves the performance of multicast flows with
multiple subscribers, as it allows the hardware to perform the frame
replication.

The basic flow between the driver and the bridge is as follows:

- The switchdev accepts the offload by returning a non-null pointer
  from .ndo_dfwd_add_station when the port is added to the bridge.

- The bridge sends offloadable skbs to one of the ports under the
  switchdev's control using dev_queue_xmit_accel.

- The switchdev notices the offload by checking for a non-NULL
  "sb_dev" in the core's call to .ndo_select_queue.

v1->v2:
- convert br_input_skb_cb::fwd_hwdoms to a plain unsigned long
- introduce a static key "br_switchdev_fwd_offload_used" to minimize the
  impact of the newly introduced feature on all the setups which don't
  have hardware that can make use of it
- introduce a check for nbp->flags & BR_FWD_OFFLOAD to optimize cache
  line access
- reorder nbp_switchdev_frame_mark_accel() and br_handle_vlan() in
  __br_forward()
- do not strip VLAN on egress if forwarding offload on VLAN-aware bridge
  is being used
- propagate errors from .ndo_dfwd_add_station() if not EOPNOTSUPP

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/if_bridge.h |  1 +
 net/bridge/br_forward.c   | 18 +++++++-
 net/bridge/br_private.h   | 24 +++++++++++
 net/bridge/br_switchdev.c | 87 +++++++++++++++++++++++++++++++++++++--
 net/bridge/br_vlan.c      | 10 ++++-
 5 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index b651c5e32a28..a47b86ab7f96 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -57,6 +57,7 @@ struct br_ip_list {
 #define BR_MRP_AWARE		BIT(17)
 #define BR_MRP_LOST_CONT	BIT(18)
 #define BR_MRP_LOST_IN_CONT	BIT(19)
+#define BR_FWD_OFFLOAD		BIT(20)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 07856362538f..919246a2c7eb 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -32,6 +32,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
 
 int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	struct net_device *sb_dev = NULL;
+
 	skb_push(skb, ETH_HLEN);
 	if (!is_skb_forwardable(skb->dev, skb))
 		goto drop;
@@ -48,7 +50,14 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 		skb_set_network_header(skb, depth);
 	}
 
-	dev_queue_xmit(skb);
+	if (br_switchdev_accels_skb(skb)) {
+		sb_dev = BR_INPUT_SKB_CB(skb)->brdev;
+
+		WARN_ON_ONCE(br_vlan_enabled(sb_dev) &&
+			     !skb_vlan_tag_present(skb));
+	}
+
+	dev_queue_xmit_accel(skb, sb_dev);
 
 	return 0;
 
@@ -76,6 +85,11 @@ static void __br_forward(const struct net_bridge_port *to,
 	struct net *net;
 	int br_hook;
 
+	/* Mark the skb for forwarding offload early so that br_handle_vlan()
+	 * can know whether to pop the VLAN header on egress or keep it.
+	 */
+	nbp_switchdev_frame_mark_accel(to, skb);
+
 	vg = nbp_vlan_group_rcu(to);
 	skb = br_handle_vlan(to->br, to, vg, skb);
 	if (!skb)
@@ -174,6 +188,8 @@ static struct net_bridge_port *maybe_deliver(
 	if (!should_deliver(p, skb))
 		return prev;
 
+	nbp_switchdev_frame_mark_fwd(p, skb);
+
 	if (!prev)
 		goto out;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9ff09a32e3f8..655212df57f7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -332,6 +332,7 @@ struct net_bridge_port {
 #endif
 #ifdef CONFIG_NET_SWITCHDEV
 	int				hwdom;
+	void				*accel_priv;
 #endif
 	u16				group_fwd_mask;
 	u16				backup_redirected_cnt;
@@ -508,7 +509,9 @@ struct br_input_skb_cb {
 #endif
 
 #ifdef CONFIG_NET_SWITCHDEV
+	u8 fwd_accel:1;
 	int src_hwdom;
+	unsigned long fwd_hwdoms;
 #endif
 };
 
@@ -1647,6 +1650,12 @@ static inline void br_sysfs_delbr(struct net_device *dev) { return; }
 
 /* br_switchdev.c */
 #ifdef CONFIG_NET_SWITCHDEV
+bool br_switchdev_accels_skb(struct sk_buff *skb);
+
+void nbp_switchdev_frame_mark_accel(const struct net_bridge_port *p,
+				    struct sk_buff *skb);
+void nbp_switchdev_frame_mark_fwd(const struct net_bridge_port *p,
+				  struct sk_buff *skb);
 void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb);
 bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
@@ -1669,6 +1678,21 @@ static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
 	skb->offload_fwd_mark = 0;
 }
 #else
+static inline bool br_switchdev_accels_skb(struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline void nbp_switchdev_frame_mark_accel(const struct net_bridge_port *p,
+						  struct sk_buff *skb)
+{
+}
+
+static inline void nbp_switchdev_frame_mark_fwd(const struct net_bridge_port *p,
+						struct sk_buff *skb)
+{
+}
+
 static inline void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 					    struct sk_buff *skb)
 {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index f3120f13c293..8653d9a540a1 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -8,6 +8,40 @@
 
 #include "br_private.h"
 
+static struct static_key_false br_switchdev_fwd_offload_used;
+
+static bool nbp_switchdev_can_accel(const struct net_bridge_port *p,
+				    const struct sk_buff *skb)
+{
+	if (!static_branch_unlikely(&br_switchdev_fwd_offload_used))
+		return false;
+
+	return (p->flags & BR_FWD_OFFLOAD) &&
+	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
+}
+
+bool br_switchdev_accels_skb(struct sk_buff *skb)
+{
+	if (!static_branch_unlikely(&br_switchdev_fwd_offload_used))
+		return false;
+
+	return BR_INPUT_SKB_CB(skb)->fwd_accel;
+}
+
+void nbp_switchdev_frame_mark_accel(const struct net_bridge_port *p,
+				    struct sk_buff *skb)
+{
+	if (nbp_switchdev_can_accel(p, skb))
+		BR_INPUT_SKB_CB(skb)->fwd_accel = true;
+}
+
+void nbp_switchdev_frame_mark_fwd(const struct net_bridge_port *p,
+				  struct sk_buff *skb)
+{
+	if (nbp_switchdev_can_accel(p, skb))
+		set_bit(p->hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
+}
+
 void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb)
 {
@@ -18,8 +52,10 @@ void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 				  const struct sk_buff *skb)
 {
-	return !skb->offload_fwd_mark ||
-	       BR_INPUT_SKB_CB(skb)->src_hwdom != p->hwdom;
+	struct br_input_skb_cb *cb = BR_INPUT_SKB_CB(skb);
+
+	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
+		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);
 }
 
 /* Flags that can be offloaded to hardware */
@@ -125,6 +161,39 @@ int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 	return switchdev_port_obj_del(dev, &v.obj);
 }
 
+static int nbp_switchdev_fwd_offload_add(struct net_bridge_port *p)
+{
+	void *priv;
+
+	if (!(p->dev->features & NETIF_F_HW_L2FW_DOFFLOAD))
+		return 0;
+
+	priv = p->dev->netdev_ops->ndo_dfwd_add_station(p->dev, p->br->dev);
+	if (IS_ERR(priv)) {
+		int err = PTR_ERR(priv);
+
+		return err == -EOPNOTSUPP ? 0 : err;
+	}
+
+	p->accel_priv = priv;
+	p->flags |= BR_FWD_OFFLOAD;
+	static_branch_inc(&br_switchdev_fwd_offload_used);
+
+	return 0;
+}
+
+static void nbp_switchdev_fwd_offload_del(struct net_bridge_port *p)
+{
+	if (!p->accel_priv)
+		return;
+
+	p->dev->netdev_ops->ndo_dfwd_del_station(p->dev, p->accel_priv);
+
+	p->accel_priv = NULL;
+	p->flags &= ~BR_FWD_OFFLOAD;
+	static_branch_dec(&br_switchdev_fwd_offload_used);
+}
+
 static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
 {
 	struct net_bridge *br = joining->br;
@@ -176,13 +245,25 @@ int nbp_switchdev_add(struct net_bridge_port *p)
 		return err;
 	}
 
-	return nbp_switchdev_hwdom_set(p);
+	err = nbp_switchdev_hwdom_set(p);
+	if (err)
+		return err;
+
+	if (p->hwdom) {
+		err = nbp_switchdev_fwd_offload_add(p);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 void nbp_switchdev_del(struct net_bridge_port *p)
 {
 	ASSERT_RTNL();
 
+	nbp_switchdev_fwd_offload_del(p);
+
 	if (p->hwdom)
 		nbp_switchdev_hwdom_put(p);
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a08e9f193009..bf014efa5851 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -457,7 +457,15 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 		u64_stats_update_end(&stats->syncp);
 	}
 
-	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+	/* If the skb will be sent using forwarding offload, the assumption is
+	 * that the switchdev will inject the packet into hardware together
+	 * with the bridge VLAN, so that it can be forwarded according to that
+	 * VLAN. The switchdev should deal with popping the VLAN header in
+	 * hardware on each egress port as appropriate. So only strip the VLAN
+	 * header if forwarding offload is not being used.
+	 */
+	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED &&
+	    !br_switchdev_accels_skb(skb))
 		__vlan_hwaccel_clear_tag(skb);
 
 	if (p && (p->flags & BR_VLAN_TUNNEL) &&
-- 
2.25.1

