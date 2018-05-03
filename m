Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=UUGBEDh9PsVATyJn+vQh5ovPhgSVd7oYD+1ls84GZAQ=;
	b=PB+8auTAIonIWWs6Y6D92tMwMYf2mf0a95oSIufHSEF/qRw3v1aERgxIRzQkC+sRKo
	vhBzncC1+Z0brM5hkkV07i9Di1nbxART20jR0qQZjsmZ+SC4R0XzcguuYqXtiT7G0bvV
	VjQSriG4vFRZfgohbqLrFRTn75RvsqcGKmTHw=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu,  3 May 2018 13:47:24 +0300
Message-Id: <20180503104724.17799-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] net: bridge: avoid duplicate notification
	on up/down/change netdev events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

While handling netdevice events, br_device_event() sometimes uses
br_stp_(disable|enable)_port which unconditionally send a notification,
but then a second notification for the same event is sent at the end of
the br_device_event() function. To avoid sending duplicate notifications
in such cases, check if one has already been sent (i.e.
br_stp_enable/disable_port have been called).
The patch is based on a change by Satish Ashok.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
We've been running with a similar patch for over an year, it's been
thoroughly tested. Sending for net-next since it's an improvement and
not really a bug fix.

 net/bridge/br.c         | 12 ++++++++----
 net/bridge/br_if.c      | 11 ++++++++---
 net/bridge/br_private.h |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 671d13c10f6f..2ca035054664 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -34,6 +34,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net_bridge_port *p;
 	struct net_bridge *br;
+	bool notified = false;
 	bool changed_addr;
 	int err;
 
@@ -67,7 +68,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		break;
 
 	case NETDEV_CHANGE:
-		br_port_carrier_check(p);
+		br_port_carrier_check(p, &notified);
 		break;
 
 	case NETDEV_FEAT_CHANGE:
@@ -76,8 +77,10 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 
 	case NETDEV_DOWN:
 		spin_lock_bh(&br->lock);
-		if (br->dev->flags & IFF_UP)
+		if (br->dev->flags & IFF_UP) {
 			br_stp_disable_port(p);
+			notified = true;
+		}
 		spin_unlock_bh(&br->lock);
 		break;
 
@@ -85,6 +88,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		if (netif_running(br->dev) && netif_oper_up(dev)) {
 			spin_lock_bh(&br->lock);
 			br_stp_enable_port(p);
+			notified = true;
 			spin_unlock_bh(&br->lock);
 		}
 		break;
@@ -110,8 +114,8 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 	}
 
 	/* Events that may cause spanning tree to refresh */
-	if (event == NETDEV_CHANGEADDR || event == NETDEV_UP ||
-	    event == NETDEV_CHANGE || event == NETDEV_DOWN)
+	if (!notified && (event == NETDEV_CHANGEADDR || event == NETDEV_UP ||
+			  event == NETDEV_CHANGE || event == NETDEV_DOWN))
 		br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
 	return NOTIFY_DONE;
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 82c1a6f430b3..e3a8ea1bcbe2 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -64,7 +64,7 @@ static int port_cost(struct net_device *dev)
 
 
 /* Check for port carrier transitions. */
-void br_port_carrier_check(struct net_bridge_port *p)
+void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 {
 	struct net_device *dev = p->dev;
 	struct net_bridge *br = p->br;
@@ -73,16 +73,21 @@ void br_port_carrier_check(struct net_bridge_port *p)
 	    netif_running(dev) && netif_oper_up(dev))
 		p->path_cost = port_cost(dev);
 
+	*notified = false;
 	if (!netif_running(br->dev))
 		return;
 
 	spin_lock_bh(&br->lock);
 	if (netif_running(dev) && netif_oper_up(dev)) {
-		if (p->state == BR_STATE_DISABLED)
+		if (p->state == BR_STATE_DISABLED) {
 			br_stp_enable_port(p);
+			*notified = true;
+		}
 	} else {
-		if (p->state != BR_STATE_DISABLED)
+		if (p->state != BR_STATE_DISABLED) {
 			br_stp_disable_port(p);
+			*notified = true;
+		}
 	}
 	spin_unlock_bh(&br->lock);
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1a5093115534..0ddeeea2c6a7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -573,7 +573,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig);
 
 /* br_if.c */
-void br_port_carrier_check(struct net_bridge_port *p);
+void br_port_carrier_check(struct net_bridge_port *p, bool *notified);
 int br_add_bridge(struct net *net, const char *name);
 int br_del_bridge(struct net *net, const char *name);
 int br_add_if(struct net_bridge *br, struct net_device *dev,
-- 
2.11.0

