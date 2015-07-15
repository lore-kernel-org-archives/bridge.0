Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ChDABX9dWzZI9Pk8DfY1gD1q23BpPfDo3nVFx8vLioM=;
	b=QIttmOXHvJyBGZLelIvWieir43nw+vxBeoSXmPq6l1vvNe6H+Dxwsqwgemjcr+eOea
	A/XpIQPV33NGcNuIRf8EABTK98HQAR7xnzCTPNu73bIImh0fYunekOn/IczcxD2CMU1o
	S5ThANlqIbpBHz0TIz3T/yqgvBnO1XSYRnwf4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 15 Jul 2015 07:16:51 -0700
Message-Id: <1436969811-13237-3-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/2] bridge: multicast: fix handling of
	temp and perm entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Satish Ashok <sashok@cumulusnetworks.com>

When the bridge (or port) is brought down/up flush only temp entries and
leave the perm ones. Flush perm entries only when deleting the bridge
device or the associated port.

Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_if.c        |  1 +
 net/bridge/br_multicast.c | 27 ++++++++++++++++++++-------
 net/bridge/br_private.h   |  1 +
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index a538cb1199a3..45e4757c6fd2 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -281,6 +281,7 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 	br_fdb_delete_by_port(br, NULL, 0, 1);
 
 	br_vlan_flush(br);
+	br_multicast_dev_del(br);
 	del_timer_sync(&br->gc_timer);
 
 	br_sysfs_delbr(br->dev);
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 55903d91d0a8..0dd3cd90962c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -916,6 +916,15 @@ void br_multicast_add_port(struct net_bridge_port *port)
 
 void br_multicast_del_port(struct net_bridge_port *port)
 {
+	struct net_bridge *br = port->br;
+	struct net_bridge_port_group *pg;
+	struct hlist_node *n;
+
+	/* Take care of the remaining groups, only perm ones should be left */
+	spin_lock_bh(&br->multicast_lock);
+	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
+		br_multicast_del_pg(br, pg);
+	spin_unlock_bh(&br->multicast_lock);
 	del_timer_sync(&port->multicast_router_timer);
 }
 
@@ -955,7 +964,8 @@ void br_multicast_disable_port(struct net_bridge_port *port)
 
 	spin_lock(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
-		br_multicast_del_pg(br, pg);
+		if (pg->state == MDB_TEMPORARY)
+			br_multicast_del_pg(br, pg);
 
 	if (!hlist_unhashed(&port->rlist))
 		hlist_del_init_rcu(&port->rlist);
@@ -1732,12 +1742,6 @@ void br_multicast_open(struct net_bridge *br)
 
 void br_multicast_stop(struct net_bridge *br)
 {
-	struct net_bridge_mdb_htable *mdb;
-	struct net_bridge_mdb_entry *mp;
-	struct hlist_node *n;
-	u32 ver;
-	int i;
-
 	del_timer_sync(&br->multicast_router_timer);
 	del_timer_sync(&br->ip4_other_query.timer);
 	del_timer_sync(&br->ip4_own_query.timer);
@@ -1745,6 +1749,15 @@ void br_multicast_stop(struct net_bridge *br)
 	del_timer_sync(&br->ip6_other_query.timer);
 	del_timer_sync(&br->ip6_own_query.timer);
 #endif
+}
+
+void br_multicast_dev_del(struct net_bridge *br)
+{
+	struct net_bridge_mdb_htable *mdb;
+	struct net_bridge_mdb_entry *mp;
+	struct hlist_node *n;
+	u32 ver;
+	int i;
 
 	spin_lock_bh(&br->multicast_lock);
 	mdb = mlock_dereference(br->mdb, br);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c73fd785654d..2bada2279721 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -466,6 +466,7 @@ void br_multicast_disable_port(struct net_bridge_port *port);
 void br_multicast_init(struct net_bridge *br);
 void br_multicast_open(struct net_bridge *br);
 void br_multicast_stop(struct net_bridge *br);
+void br_multicast_dev_del(struct net_bridge *br);
 void br_multicast_deliver(struct net_bridge_mdb_entry *mdst,
 			  struct sk_buff *skb);
 void br_multicast_forward(struct net_bridge_mdb_entry *mdst,
-- 
1.9.3

