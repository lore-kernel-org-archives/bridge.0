Date: Thu, 29 Jul 2004 10:59:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040729105931.25815479@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040728191724.4afacdce.davem@redhat.com>
References: <20040728153725.7ace281c@dell_ss3.pdx.osdl.net>
	<20040728191724.4afacdce.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] (1/4) propgate bridge internal MTU changes
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org

Follow up to earlier RCU patch.  Since now using RCU, need to use
deferred free.  

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
--- a/net/bridge/br_fdb.c	2004-07-29 11:00:07 -07:00
+++ b/net/bridge/br_fdb.c	2004-07-29 11:00:07 -07:00
@@ -217,11 +217,18 @@
 	return fdb;
 }
 
+static void fdb_rcu_free(struct rcu_head *head)
+{
+	struct net_bridge_fdb_entry *ent
+		= container_of(head, struct net_bridge_fdb_entry, rcu);
+	kmem_cache_free(br_fdb_cache, ent);
+}
 
+/* Set entry up for deletion with RCU  */
 void br_fdb_put(struct net_bridge_fdb_entry *ent)
 {
 	if (atomic_dec_and_test(&ent->use_count))
-		kmem_cache_free(br_fdb_cache, ent);
+		call_rcu(&ent->rcu, fdb_rcu_free);
 }
 
 /*
diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
--- a/net/bridge/br_private.h	2004-07-29 11:00:07 -07:00
+++ b/net/bridge/br_private.h	2004-07-29 11:00:07 -07:00
@@ -46,7 +46,10 @@
 {
 	struct hlist_node		hlist;
 	struct net_bridge_port		*dst;
-	struct list_head		age_list;
+	union {
+		struct list_head	age_list;
+		struct rcu_head		rcu;
+	};
 	atomic_t			use_count;
 	unsigned long			ageing_timer;
 	mac_addr			addr;
