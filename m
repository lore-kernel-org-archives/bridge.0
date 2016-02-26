Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9jzzDYit6ULrH/yDNr8c3CKCxixcXNrosNfCi+Y4/d0=;
	b=YAsKSfVcLPOQT8XDt6WTuiXW59G723J/WGwbAjC3jQoTyT+KyWaG/e0NyHGcAsGjbL
	Q5sipVndwd398eLUuS4tjZ4TGewPnLUhKBvKA3SsMzjAs1xmSE7AP0N5agSlPcc00Iuj
	Qv0Mj7/2Dc38Co/oJ8XAMFcDLX5MOupeifMq0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 26 Feb 2016 19:59:26 +0100
Message-Id: <1456513166-20159-4-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1456513166-20159-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1456513166-20159-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 3/3] bridge: mcast: add support for
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

Add support for a temporary router port which doesn't depend on the
incoming query and allow for more port information to be dumped. For
that purpose we need to extend the MDBA_ROUTER_PORT attribute similar to
how it was done for the mdb entries recently. The new format is thus:
[MDBA_ROUTER_PORT] = { <- nested attribute
    u32 ifindex <- router port ifindex for user-space compatibility
    [MDBA_ROUTER_PATTR attributes]
}
This way it remains compatible with older users (they'll simply retrieve
the u32 in the beginning) and new users can parse the remaining
attributes.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h | 15 ++++++++++++++-
 net/bridge/br_mdb.c            | 16 ++++++++++++++--
 net/bridge/br_multicast.c      | 20 ++++++++++++++++++--
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f2764b739f38..af98f6855b7e 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -161,7 +161,10 @@ enum {
  *     }
  * }
  * [MDBA_ROUTER] = {
- *    [MDBA_ROUTER_PORT]
+ *    [MDBA_ROUTER_PORT] = {
+ *        u32 ifindex
+ *        [MDBA_ROUTER_PATTR attributes]
+ *    }
  * }
  */
 enum {
@@ -199,6 +202,7 @@ enum {
 	MDB_RTR_TYPE_DISABLED,
 	MDB_RTR_TYPE_TEMP_QUERY,
 	MDB_RTR_TYPE_PERM,
+	MDB_RTR_TYPE_TEMP
 };
 
 enum {
@@ -208,6 +212,15 @@ enum {
 };
 #define MDBA_ROUTER_MAX (__MDBA_ROUTER_MAX - 1)
 
+/* router port attributes */
+enum {
+	MDBA_ROUTER_PATTR_UNSPEC,
+	MDBA_ROUTER_PATTR_TIMER,
+	MDBA_ROUTER_PATTR_TYPE,
+	__MDBA_ROUTER_PATTR_MAX
+};
+#define MDBA_ROUTER_PATTR_MAX (__MDBA_ROUTER_PATTR_MAX - 1)
+
 struct br_port_msg {
 	__u8  family;
 	__u32 ifindex;
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 73786e2fe065..253bc77eda3b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -20,7 +20,7 @@ static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 {
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *p;
-	struct nlattr *nest;
+	struct nlattr *nest, *port_nest;
 
 	if (!br->multicast_router || hlist_empty(&br->router_list))
 		return 0;
@@ -30,8 +30,20 @@ static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 		return -EMSGSIZE;
 
 	hlist_for_each_entry_rcu(p, &br->router_list, rlist) {
-		if (p && nla_put_u32(skb, MDBA_ROUTER_PORT, p->dev->ifindex))
+		if (!p)
+			continue;
+		port_nest = nla_nest_start(skb, MDBA_ROUTER_PORT);
+		if (!port_nest)
 			goto fail;
+		if (nla_put_nohdr(skb, sizeof(u32), &p->dev->ifindex) ||
+		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
+				br_timer_value(&p->multicast_router_timer)) ||
+		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
+			       p->multicast_router)) {
+			nla_nest_cancel(skb, port_nest);
+			goto fail;
+		}
+		nla_nest_end(skb, port_nest);
 	}
 
 	nla_nest_end(skb, nest);
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 496f808f9aa1..0fb5061c2ad4 100644
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
@@ -1869,6 +1882,9 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 		del_timer(&p->multicast_router_timer);
 		br_multicast_add_router(br, p);
 		break;
+	case MDB_RTR_TYPE_TEMP:
+		br_multicast_mark_router(br, p);
+		break;
 	default:
 		goto unlock;
 	}
-- 
2.4.3

