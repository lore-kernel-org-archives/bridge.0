Return-Path: <yang.yang29@zte.com.cn>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D94ED8201C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 745AD81F67
Date: Thu, 6 Apr 2023 19:30:34 +0800 (CST)
Message-ID: <202304061930349843930@zte.com.cn>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Subject: [Bridge] =?utf-8?q?=5BPATCH_net-next=5D_net/bridge=3A_add_drop_re?=
	=?utf-8?q?asons_for_bridge_forwarding?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, zhang.yunkai@zte.com.cn, jiang.xuexin@zte.com.cn, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com

From: xu xin <xu.xin16@zte.com.cn>

This creates six drop reasons as follows, which will help users know the
specific reason why bridge drops the packets when forwarding.

1) SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
   port link when the destination port is down.

2) SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT: destination port is the same
   with originating port when forwarding by a bridge.

3) SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE: the bridge's state is
   not forwarding.

4) SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS: the packet is not allowed
   to go out through the port due to vlan filtering.

5) SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS: the packet is not
   allowed to go out through the port which is offloaded by a hardware
   switchdev, checked by nbp_switchdev_allowed_egress().

6) SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED: both source port and dest
   port are in BR_ISOLATED state when bridge forwarding.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang19@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
---
 include/net/dropreason.h | 33 ++++++++++++++++++++++++++++++++
 net/bridge/br_forward.c  | 49 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index c0a3ea806cd5..888039fd01c9 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -78,6 +78,12 @@
 	FN(IPV6_NDISC_BAD_CODE)		\
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
+	FN(BRIDGE_FWD_NO_BACKUP_PORT) \
+	FN(BRIDGE_FWD_SAME_PORT) \
+	FN(BRIDGE_NON_FORWARDING_STATE) \
+	FN(BRIDGE_NOT_ALLOWED_EGRESS) \
+	FN(BRIDGE_SWDEV_NOT_ALLOWED_EGRESS) \
+	FN(BRIDGE_BOTH_PORT_ISOLATED) \
 	FNe(MAX)

 /**
@@ -338,6 +344,33 @@ enum skb_drop_reason {
 	 * for another host.
 	 */
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
+	/** @SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
+	 * port link when the destination port is down.
+	 */
+	SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT,
+	/** @SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT: destination port is the same
+	 * with originating port when forwarding by a bridge.
+	 */
+	SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT,
+	/** @SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE: the bridge's state is
+	 * not forwarding.
+	 */
+	SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE,
+	/** @SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS: the packet is not allowed
+	 * to go out through the port due to vlan filtering.
+	 */
+	SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS,
+	/** @SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS: the packet is not
+	 * allowed to go out through the port which is offloaded by a hardware
+	 * switchdev, checked by nbp_switchdev_allowed_egress(). E.g, the source
+	 * switchdev is the same with the switchdev by which the dest port is
+	 * offloaded.
+	 */
+	SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS,
+	/** @SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED: both source port and dest
+	 * port are in BR_ISOLATED state when bridge forwarding.
+	 */
+	SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of drop reason, which shouldn't be
 	 * used as a real 'reason'
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 02bb620d3b8d..7ebdf9937125 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -18,16 +18,39 @@
 #include "br_private.h"

 /* Don't forward packets to originating port or forwarding disabled */
-static inline int should_deliver(const struct net_bridge_port *p,
-				 const struct sk_buff *skb)
+static inline bool should_deliver(const struct net_bridge_port *p, const struct sk_buff *skb,
+					 enum skb_drop_reason *need_reason)
 {
 	struct net_bridge_vlan_group *vg;
+	enum skb_drop_reason reason;

 	vg = nbp_vlan_group_rcu(p);
-	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
-		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
-		nbp_switchdev_allowed_egress(p, skb) &&
-		!br_skb_isolated(p, skb);
+	if (!(p->flags & BR_HAIRPIN_MODE) && skb->dev == p->dev) {
+		reason = SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT;
+		goto undeliverable;
+	}
+	if (p->state != BR_STATE_FORWARDING) {
+		reason = SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE;
+		goto undeliverable;
+	}
+	if (!br_allowed_egress(vg, skb)) {
+		reason = SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS;
+		goto undeliverable;
+	}
+	if (!nbp_switchdev_allowed_egress(p, skb)) {
+		reason = SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS;
+		goto undeliverable;
+	}
+	if (br_skb_isolated(p, skb)) {
+		reason = SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED;
+		goto undeliverable;
+	}
+	return true;
+
+undeliverable:
+	if (need_reason)
+		*need_reason = reason;
+	return false;
 }

 int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -144,6 +167,8 @@ static int deliver_clone(const struct net_bridge_port *prev,
 void br_forward(const struct net_bridge_port *to,
 		struct sk_buff *skb, bool local_rcv, bool local_orig)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
+
 	if (unlikely(!to))
 		goto out;

@@ -152,12 +177,14 @@ void br_forward(const struct net_bridge_port *to,
 		struct net_bridge_port *backup_port;

 		backup_port = rcu_dereference(to->backup_port);
-		if (unlikely(!backup_port))
+		if (unlikely(!backup_port)) {
+			reason = SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT;
 			goto out;
+		}
 		to = backup_port;
 	}

-	if (should_deliver(to, skb)) {
+	if (should_deliver(to, skb, &reason)) {
 		if (local_rcv)
 			deliver_clone(to, skb, local_orig);
 		else
@@ -167,7 +194,7 @@ void br_forward(const struct net_bridge_port *to,

 out:
 	if (!local_rcv)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 }
 EXPORT_SYMBOL_GPL(br_forward);

@@ -178,7 +205,7 @@ static struct net_bridge_port *maybe_deliver(
 	u8 igmp_type = br_multicast_igmp_type(skb);
 	int err;

-	if (!should_deliver(p, skb))
+	if (!should_deliver(p, skb, NULL))
 		return prev;

 	nbp_switchdev_frame_mark_tx_fwd_to_hwdom(p, skb);
@@ -254,7 +281,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
 	const unsigned char *src = eth_hdr(skb)->h_source;

-	if (!should_deliver(p, skb))
+	if (!should_deliver(p, skb, NULL))
 		return;

 	/* Even with hairpin, no soliloquies - prevent breaking IPv6 DAD */
-- 
2.15.2
