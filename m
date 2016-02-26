Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+jiLeO1te0YAdDaeSgl7Z1n704/yMEzvYXZT2Z9VWK4=;
	b=U9uiMY0FPe5j1wc6n60Z84qxM8h1H8/GC3aPMwRum1qdfqF8qzLWtHh5XexNVo2vU8
	3+1oF+mnQSpjKoq8L4Tdo8TJp+oo2gMc8fbLh4cMozHkIS3Q+DP4hGiCIvRr7Rr/3KH2
	6+cOHNssdiRaEFPpzSuGfhEP6/FXI5K/kJWPw=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 26 Feb 2016 21:20:03 +0100
Message-Id: <1456518004-25578-4-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 3/4] bridge: mcast: add support for
	temporary port router
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

Add support for a temporary router port which doesn't depend only on the
incoming query. It can be refreshed if set to the same value, which is
a no-op for the rest.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: split in two, this only adds the new temp router port type

 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_multicast.c      | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f2764b739f38..b281d02051cc 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -199,6 +199,7 @@ enum {
 	MDB_RTR_TYPE_DISABLED,
 	MDB_RTR_TYPE_TEMP_QUERY,
 	MDB_RTR_TYPE_PERM,
+	MDB_RTR_TYPE_TEMP
 };
 
 enum {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f1140cf5168d..a4c15df2b792 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -759,13 +759,17 @@ static void br_multicast_router_expired(unsigned long data)
 	struct net_bridge *br = port->br;
 
 	spin_lock(&br->multicast_lock);
-	if (port->multicast_router != MDB_RTR_TYPE_TEMP_QUERY ||
+	if (port->multicast_router == MDB_RTR_TYPE_DISABLED ||
+	    port->multicast_router == MDB_RTR_TYPE_PERM ||
 	    timer_pending(&port->multicast_router_timer) ||
 	    hlist_unhashed(&port->rlist))
 		goto out;
 
 	hlist_del_init_rcu(&port->rlist);
 	br_rtr_notify(br->dev, port, RTM_DELMDB);
+	/* Don't allow timer refresh if the router expired */
+	if (port->multicast_router == MDB_RTR_TYPE_TEMP)
+		port->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -981,6 +985,9 @@ void br_multicast_disable_port(struct net_bridge_port *port)
 	if (!hlist_unhashed(&port->rlist)) {
 		hlist_del_init_rcu(&port->rlist);
 		br_rtr_notify(br->dev, port, RTM_DELMDB);
+		/* Don't allow timer refresh if disabling */
+		if (port->multicast_router == MDB_RTR_TYPE_TEMP)
+			port->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
 	}
 	del_timer(&port->multicast_router_timer);
 	del_timer(&port->ip4_own_query.timer);
@@ -1234,7 +1241,8 @@ static void br_multicast_mark_router(struct net_bridge *br,
 		return;
 	}
 
-	if (port->multicast_router != MDB_RTR_TYPE_TEMP_QUERY)
+	if (port->multicast_router == MDB_RTR_TYPE_DISABLED ||
+	    port->multicast_router == MDB_RTR_TYPE_PERM)
 		return;
 
 	br_multicast_add_router(br, port);
@@ -1850,10 +1858,15 @@ static void __del_port_router(struct net_bridge_port *p)
 int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 {
 	struct net_bridge *br = p->br;
+	unsigned long now = jiffies;
 	int err = -EINVAL;
 
 	spin_lock(&br->multicast_lock);
 	if (p->multicast_router == val) {
+		/* Refresh the temp router port timer */
+		if (p->multicast_router == MDB_RTR_TYPE_TEMP)
+			mod_timer(&p->multicast_router_timer,
+				  now + br->multicast_querier_interval);
 		err = 0;
 		goto unlock;
 	}
@@ -1872,6 +1885,10 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 		del_timer(&p->multicast_router_timer);
 		br_multicast_add_router(br, p);
 		break;
+	case MDB_RTR_TYPE_TEMP:
+		p->multicast_router = MDB_RTR_TYPE_TEMP;
+		br_multicast_mark_router(br, p);
+		break;
 	default:
 		goto unlock;
 	}
-- 
2.4.3

