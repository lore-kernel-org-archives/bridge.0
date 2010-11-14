Message-Id: <20101114211515.553051479@vyatta.com>
Date: Sun, 14 Nov 2010 13:12:06 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
References: <20101114211201.678755903@vyatta.com>
Content-Disposition: inline; filename=bridgeX.patch
Subject: [Bridge] [PATCH 5/5] bridge: add RCU annotations to bridge port
	lookup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Eric Dumazet <eric.dumazet@gmail.com>

Add modern __rcu annotations to bridge code, to reduce sparse errors,
and self document code.
(CONFIG_SPARSE_RCU_POINTER=y)

br_port_get() split int br_port_get_rtnl()  and br_port_get_rcu()
to make clear RTNL is held.

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

---
 net/bridge/br_if.c      |    2 +-
 net/bridge/br_netlink.c |    4 ++--
 net/bridge/br_notify.c  |    4 ++--
 net/bridge/br_private.h |    9 +++++----
 4 files changed, 10 insertions(+), 9 deletions(-)

--- a/net/bridge/br_netlink.c	2010-11-14 12:24:35.000000000 -0800
+++ b/net/bridge/br_netlink.c	2010-11-14 12:26:47.859892139 -0800
@@ -119,7 +119,7 @@ static int br_dump_ifinfo(struct sk_buff
 
 	idx = 0;
 	for_each_netdev(net, dev) {
-		struct net_bridge_port *port = br_port_get(dev);
+		struct net_bridge_port *port = br_port_get_rtnl(dev);
 
 		/* not a bridge port */
 		if (!port || idx < cb->args[0])
@@ -171,7 +171,7 @@ static int br_rtm_setlink(struct sk_buff
 	if (!dev)
 		return -ENODEV;
 
-	p = br_port_get(dev);
+	p = br_port_get_rtnl(dev);
 	if (!p)
 		return -EINVAL;
 
--- a/net/bridge/br_private.h	2010-11-14 12:25:44.600853008 -0800
+++ b/net/bridge/br_private.h	2010-11-14 12:33:23.880986098 -0800
@@ -159,9 +159,10 @@ static inline struct net_bridge_port *br
 		rcu_dereference(dev->rx_handler_data) : NULL;
 }
 
-static inline struct net_bridge_port *br_port_get(struct net_device *dev)
+static inline struct net_bridge_port *br_port_get_rtnl(struct net_device *dev)
 {
-	return br_port_exists(dev) ? dev->rx_handler_data : NULL;
+	return br_port_exists(dev) ?
+		rtnl_dereference(dev->rx_handler_data) : NULL;
 }
 
 #define br_port_get(dev) ((struct net_bridge_port *) dev->rx_handler_data)
--- a/net/bridge/br_if.c	2010-11-14 12:23:34.000000000 -0800
+++ b/net/bridge/br_if.c	2010-11-14 12:27:24.267934764 -0800
@@ -475,7 +475,7 @@ int br_del_if(struct net_bridge *br, str
 {
 	struct net_bridge_port *p;
 
-	p = br_port_get(dev);
+	p = br_port_get_rtnl(dev);
 	if (!p || p->br != br)
 		return -EINVAL;
 
--- a/net/bridge/br_notify.c	2010-11-14 12:30:46.250267273 -0800
+++ b/net/bridge/br_notify.c	2010-11-14 12:31:11.749076964 -0800
@@ -37,10 +37,10 @@ static int br_device_event(struct notifi
 	int err;
 
 	/* not a port of a bridge */
-	if (!br_port_exists(dev))
+	p = br_port_get_rtnl(dev);
+	if (!p)
 		return NOTIFY_DONE;
 
-	p = br_port_get(dev);
 	br = p->br;
 
 	switch (event) {


