From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 12 Jun 2009 23:26:50 +0200
Message-Id: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
Subject: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Currently the bridge does not impl. split horizon which will easily
cause loops when 2 or more VLANs are added from the same physical interface.
Impl. split horizon and add /sys/class/net/br0/bridge/split_horizon
to turn it off.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
Leaving for 1 week vacation next week, but feel free to
comment and/or test.

 Jocke

 net/bridge/br_forward.c  |   12 +++++++++++-
 net/bridge/br_if.c       |    2 +-
 net/bridge/br_private.h  |    1 +
 net/bridge/br_sysfs_br.c |   26 ++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d2c27c8..cfa1f7e 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -22,7 +22,17 @@
 static inline int should_deliver(const struct net_bridge_port *p,
 				 const struct sk_buff *skb)
 {
-	return (skb->dev != p->dev && p->state == BR_STATE_FORWARDING);
+	struct net_device *indev = skb->dev;
+	struct net_device *todev = p->dev;
+
+	if (p->br->flags & BR_SPLIT_HORIZON) {
+		if (indev->priv_flags & IFF_802_1Q_VLAN)
+			indev = vlan_dev_real_dev(indev);
+		if (todev->priv_flags & IFF_802_1Q_VLAN)
+			todev = vlan_dev_real_dev(todev);
+	}
+
+	return (indev != todev && p->state == BR_STATE_FORWARDING);
 }
 
 static inline unsigned packet_length(const struct sk_buff *skb)
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 727c5c5..f23e338 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -203,7 +203,7 @@ static struct net_device *new_bridge_dev(struct net *net, const char *name)
 	br->topology_change = 0;
 	br->topology_change_detected = 0;
 	br->ageing_time = 300 * HZ;
-
+	br->flags = BR_SPLIT_HORIZON;
 	br_netfilter_rtable_init(br);
 
 	INIT_LIST_HEAD(&br->age_list);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b6c3b71..2c99877 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -98,6 +98,7 @@ struct net_bridge
 #endif
 	unsigned long			flags;
 #define BR_SET_MAC_ADDR		0x00000001
+#define BR_SPLIT_HORIZON	0x00000002
 
 	/* STP */
 	bridge_id			designated_root;
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 603d892..d0eebc1 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -344,6 +344,31 @@ static ssize_t store_flush(struct device *d,
 }
 static DEVICE_ATTR(flush, S_IWUSR, NULL, store_flush);
 
+static ssize_t show_split_horizon(struct device *d,
+				  struct device_attribute *attr, char *buf)
+{
+	struct net_bridge *br = to_bridge(d);
+	int val = !!(br->flags & BR_SPLIT_HORIZON);
+
+	return sprintf(buf, "%d\n", val);
+}
+static int set_split_horizon(struct net_bridge *br, unsigned long val)
+{
+	if (val)
+		br->flags |= BR_SPLIT_HORIZON;
+	else
+		br->flags &= ~BR_SPLIT_HORIZON;
+	return 0;
+}
+
+static ssize_t store_split_horizon(struct device *d,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	return store_bridge_parm(d, buf, len, set_split_horizon);
+}
+static DEVICE_ATTR(split_horizon, S_IRUGO | S_IWUSR, show_split_horizon, store_split_horizon);
+
 static struct attribute *bridge_attrs[] = {
 	&dev_attr_forward_delay.attr,
 	&dev_attr_hello_time.attr,
@@ -363,6 +388,7 @@ static struct attribute *bridge_attrs[] = {
 	&dev_attr_gc_timer.attr,
 	&dev_attr_group_addr.attr,
 	&dev_attr_flush.attr,
+	&dev_attr_split_horizon.attr,
 	NULL
 };
 
-- 
1.6.2.3

