Message-ID: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 10 Jun 2009 15:32:06 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Even though some folks on this list thinks ebtables should be used
to deploy Private VLAN I find using ebtables a bit clumsy.

So here a first simple(RFC only) Private VLAN impl. for only Promiscuous and Isolated
mode for the linux bridge. Not tested yet.

 Jocke


diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d2c27c8..c10362c 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -18,11 +18,30 @@
 #include <linux/netfilter_bridge.h>
 #include "br_private.h"

-/* Don't forward packets to originating port or forwarding diasabled */
-static inline int should_deliver(const struct net_bridge_port *p,
+/* Don't forward packets to originating port or forwarding disabled.
+ * Don't froward packets between private VLAN's in ISOLATED mode.
+ */
+static inline int should_deliver(const struct net_bridge_port *to,
 				 const struct sk_buff *skb)
 {
-	return (skb->dev != p->dev && p->state == BR_STATE_FORWARDING);
+	struct net_bridge_port *from = rcu_dereference(skb->dev->br_port);
+
+	if (skb->dev == to->dev || to->state != BR_STATE_FORWARDING)
+		return 0;
+	if (to->priv_vlan == PVLAN_ISOLATED &&
+	    from->priv_vlan == PVLAN_ISOLATED)
+		return 0;
+	return 1;
+}
+
+int br_set_private_vlan(struct net_bridge_port *p,
+			unsigned long v)
+{
+	if (!(v == PVLAN_ISOLATED ||
+	      v == PVLAN_PROMISC))
+		return 1;
+	p->priv_vlan = v;
+	return 0;
 }

 static inline unsigned packet_length(const struct sk_buff *skb)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b6c3b71..6f63b7f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -30,6 +30,10 @@
 /* Path to usermode spanning tree program */
 #define BR_STP_PROG	"/sbin/bridge-stp"

+/* Private VLAN defs */
+#define PVLAN_PROMISC 0
+#define PVLAN_ISOLATED 1
+
 typedef struct bridge_id bridge_id;
 typedef struct mac_addr mac_addr;
 typedef __u16 port_id;
@@ -67,6 +71,7 @@ struct net_bridge_port
 	/* STP */
 	u8				priority;
 	u8				state;
+	u8				priv_vlan;
 	u16				port_no;
 	unsigned char			topology_change_ack;
 	unsigned char			config_pending;
@@ -175,6 +180,7 @@ extern void br_forward(const struct net_bridge_port *to,
 extern int br_forward_finish(struct sk_buff *skb);
 extern void br_flood_deliver(struct net_bridge *br, struct sk_buff *skb);
 extern void br_flood_forward(struct net_bridge *br, struct sk_buff *skb);
+extern int br_set_private_vlan(struct net_bridge_port *p, unsigned long v);

 /* br_if.c */
 extern void br_port_carrier_check(struct net_bridge_port *p);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 02b2d50..aaaa085 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -143,6 +143,18 @@ static ssize_t store_flush(struct net_bridge_port *p, unsigned long v)
 }
 static BRPORT_ATTR(flush, S_IWUSR, NULL, store_flush);

+static ssize_t show_private_vlan(struct net_bridge_port *p, char *buf)
+{
+	return sprintf(buf, "%d\n", p->priv_vlan);
+}
+static ssize_t store_private_vlan(struct net_bridge_port *p, unsigned long v)
+{
+	return br_set_private_vlan(p, v);
+}
+static BRPORT_ATTR(private_vlan, S_IRUGO | S_IWUSR,
+		   show_private_vlan, store_private_vlan);
+
+
 static struct brport_attribute *brport_attrs[] = {
 	&brport_attr_path_cost,
 	&brport_attr_priority,
@@ -159,6 +171,7 @@ static struct brport_attribute *brport_attrs[] = {
 	&brport_attr_forward_delay_timer,
 	&brport_attr_hold_timer,
 	&brport_attr_flush,
+	&brport_attr_private_vlan,
 	NULL
 };


