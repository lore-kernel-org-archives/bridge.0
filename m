Date: Tue, 3 Aug 2004 13:07:03 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040803130703.29a1c161@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.6] bridge -- rmmod device while bridge is down
	fails
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: bridge@osdl.org

The changes to bridge notifier to handle link state changes introduced
a bug. The case of device unregistering while bridge is down was no
longer being handled. Add comment so maintainer doesn't forget.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
 
diff -Nru a/net/bridge/br_notify.c b/net/bridge/br_notify.c
--- a/net/bridge/br_notify.c	2004-08-03 13:06:30 -07:00
+++ b/net/bridge/br_notify.c	2004-08-03 13:06:30 -07:00
@@ -23,32 +23,39 @@
 	.notifier_call = br_device_event
 };
 
+/*
+ * Handle changes in state of network devices enslaved to a bridge.
+ * 
+ * Note: don't care about up/down if bridge itself is down, because
+ *     port state is checked when bridge is brought up.
+ */
 static int br_device_event(struct notifier_block *unused, unsigned long event, void *ptr)
 {
 	struct net_device *dev = ptr;
 	struct net_bridge_port *p = dev->br_port;
 	struct net_bridge *br;
 
+	/* not a port of a bridge */
 	if (p == NULL)
 		return NOTIFY_DONE;
 
 	br = p->br;
-	if ( !(br->dev->flags & IFF_UP))
-		return NOTIFY_DONE;
-
-	if (event == NETDEV_CHANGEMTU) {
-		dev_set_mtu(br->dev, br_min_mtu(br));
-		return NOTIFY_DONE;
-	}
 
 	spin_lock_bh(&br->lock);
 	switch (event) {
+	case NETDEV_CHANGEMTU:
+		dev_set_mtu(br->dev, br_min_mtu(br));
+		break;
+
 	case NETDEV_CHANGEADDR:
 		br_fdb_changeaddr(p, dev->dev_addr);
 		br_stp_recalculate_bridge_id(br);
 		break;
 
 	case NETDEV_CHANGE:	/* device is up but carrier changed */
+		if (!(br->dev->flags & IFF_UP))
+			break;
+
 		if (netif_carrier_ok(dev)) {
 			if (p->state == BR_STATE_DISABLED)
 				br_stp_enable_port(p);
@@ -59,11 +66,12 @@
 		break;
 
 	case NETDEV_DOWN:
-		br_stp_disable_port(p);
+		if (br->dev->flags & IFF_UP)
+			br_stp_disable_port(p);
 		break;
 
 	case NETDEV_UP:
-		if (netif_carrier_ok(dev)) 
+		if (netif_carrier_ok(dev) && (br->dev->flags & IFF_UP)) 
 			br_stp_enable_port(p);
 		break;
 
