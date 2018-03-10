Return-Path: <igor.mitsyanko.os@quantenna.com>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Date: Fri,  9 Mar 2018 19:03:06 -0800
Message-Id: <20180310030308.12947-4-igor.mitsyanko.os@quantenna.com>
In-Reply-To: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: [Bridge] [RFC PATCH net-next 3/5] bridge: allow switchdev port to
	handle flooding by itself
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ivecera@redhat.com, igor.mitsyanko.os@quantenna.com, jiri@resnulli.us, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

Introduce BR_FLOOD_OFFLOAD bridge port flag that can be used by
switchdev-capable hardware to advertize that it wants to handle all
flooding by itself.
In that case there is no need for a driver to set skb::offload_fwd_mark
on each offloaded packet as it is implied by BR_FLOOD_OFFLOAD bridge
port flag.

BR_FLOOD_OFFLOAD port flags helps in two scenarios:
  1. Mixed bridge configuration with SW ports and switchdev-capable ports.
In case a data frame that needs to be flooded is ingressed on a SW port,
it needs to be flooded to a single HW port of any given
switchdev-capable hardware only. Switchdev hardware will than take care
about flooding to the rest of the ports that it manages.
  2. Switch driver does not have to identify frames that were flooded by
hardware and explicitly mark them with skb::offload_fwd_mark. Assuming
it knows that hardware will always handle flooding by itself, it can
simply advertise BR_FLOOD_OFFLOAD port flag.

Note: current implementation can only handle a single switchdev-capable
device in a single port. Frame will be flooded as usual to all ports of
any additional switchdev present in a given bridge.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 include/linux/if_bridge.h |  1 +
 net/bridge/br_forward.c   |  2 ++
 net/bridge/br_private.h   |  8 ++++++++
 net/bridge/br_switchdev.c | 14 +++++++++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 02639eb..5d0e277 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -50,6 +50,7 @@ struct br_ip_list {
 #define BR_VLAN_TUNNEL		BIT(13)
 #define BR_BCAST_FLOOD		BIT(14)
 #define BR_NEIGH_SUPPRESS	BIT(15)
+#define BR_FLOOD_OFFLOAD	BIT(16)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index b4eed11..ac761a9 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -163,6 +163,8 @@ static struct net_bridge_port *maybe_deliver(
 	if (!should_deliver(p, skb))
 		return prev;
 
+	nbp_switchdev_offload_fwd_track(p, skb);
+
 	if (!prev)
 		goto out;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8e13a64..a6d2f2b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1111,6 +1111,8 @@ void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb);
 bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 				  const struct sk_buff *skb);
+void nbp_switchdev_offload_fwd_track(const struct net_bridge_port *p,
+				     struct sk_buff *skb);
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
 			       unsigned long mask);
@@ -1138,6 +1140,12 @@ static inline bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 	return true;
 }
 
+static inline void
+nbp_switchdev_offload_fwd_track(const struct net_bridge_port *p,
+				struct sk_buff *skb)
+{
+}
+
 static inline int br_switchdev_set_port_flag(struct net_bridge_port *p,
 					     unsigned long flags,
 					     unsigned long mask)
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee775f4..aee3c01 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -46,6 +46,9 @@ int nbp_switchdev_mark_set(struct net_bridge_port *p)
 void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb)
 {
+	if (p->flags & BR_FLOOD_OFFLOAD)
+		skb->offload_fwd_mark = 1;
+
 	if (skb->offload_fwd_mark && !WARN_ON_ONCE(!p->offload_fwd_mark))
 		BR_INPUT_SKB_CB(skb)->offload_fwd_mark = p->offload_fwd_mark;
 }
@@ -57,8 +60,17 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 	       BR_INPUT_SKB_CB(skb)->offload_fwd_mark != p->offload_fwd_mark;
 }
 
+void nbp_switchdev_offload_fwd_track(const struct net_bridge_port *p,
+				     struct sk_buff *skb)
+{
+	if (skb->offload_fwd_mark || !(p->flags & BR_FLOOD_OFFLOAD))
+		return;
+
+	nbp_switchdev_frame_mark(p, skb);
+}
+
 /* Flags that can be offloaded to hardware */
-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
+#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_FLOOD_OFFLOAD | \
 				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
-- 
2.9.5

