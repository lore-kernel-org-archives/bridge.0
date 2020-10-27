Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1603793058; x=1635329058;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AX5ILQYqJRWeHAR7oYK44Hjs5w5Q2DJ98accN2OCBmQ=;
 b=naxXQjKOvASvRoO/L7oyBgul0dpTnzw6sB+TtWd1ROTa9r9qR836GA2F
 ngsa20P6yOZPrF3hq7a7cUJZExujEISixLMMGPY75qYAI+mvz1nr0QE96
 TsvSkjxiNQPXqzdoi5eoeP+1n3xtpyHcT04QE+m+EzbEAJuVT/sfGJMWo
 6D7rhZGGyOrZVYKjfOzpycN6RLtpaA9OGpBWW4jdZ94KW6QG/bfb2YlHu
 +gnzulfIn8rzO3RfP2/zs+jd2g1gvQNbBQW08pdMbCUJOn3lnY0SwfUvT
 XG0sN2XwB9gRHnn4utXKlRDRaRuOlC3NxjjVx+I6JdsJCUOtCLtkpraoM g==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Tue, 27 Oct 2020 10:02:42 +0000
Message-ID: <20201027100251.3241719-2-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
References: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v7 01/10] net: bridge: extend the process
	of special frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@mellanox.com, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This patch extends the processing of frames in the bridge. Currently MRP
frames needs special processing and the current implementation doesn't
allow a nice way to process different frame types. Therefore try to
improve this by adding a list that contains frame types that need
special processing. This list is iterated for each input frame and if
there is a match based on frame type then these functions will be called
and decide what to do with the frame. It can process the frame then the
bridge doesn't need to do anything or don't process so then the bridge
will do normal forwarding.

Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_device.c  |  1 +
 net/bridge/br_input.c   | 33 ++++++++++++++++++++++++++++++++-
 net/bridge/br_mrp.c     | 19 +++++++++++++++----
 net/bridge/br_private.h | 19 ++++++++++++-------
 4 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 6f742fee874a..15c6445fa998 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -454,6 +454,7 @@ void br_dev_setup(struct net_device *dev)
 	spin_lock_init(&br->lock);
 	INIT_LIST_HEAD(&br->port_list);
 	INIT_HLIST_HEAD(&br->fdb_list);
+	INIT_HLIST_HEAD(&br->frame_type_list);
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	INIT_LIST_HEAD(&br->mrp_list);
 #endif
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 59a318b9f646..bece03bf83c4 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -254,6 +254,21 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	return RX_HANDLER_CONSUMED;
 }
 
+/* Return 0 if the frame was not processed otherwise 1
+ * note: already called with rcu_read_lock
+ */
+static int br_process_frame_type(struct net_bridge_port *p,
+				 struct sk_buff *skb)
+{
+	struct br_frame_type *tmp;
+
+	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
+		if (unlikely(tmp->type == skb->protocol))
+			return tmp->frame_handler(p, skb);
+
+	return 0;
+}
+
 /*
  * Return NULL if skb is handled
  * note: already called with rcu_read_lock
@@ -343,7 +358,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		}
 	}
 
-	if (unlikely(br_mrp_process(p, skb)))
+	if (unlikely(br_process_frame_type(p, skb)))
 		return RX_HANDLER_PASS;
 
 forward:
@@ -380,3 +395,19 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 
 	return br_handle_frame;
 }
+
+void br_add_frame(struct net_bridge *br, struct br_frame_type *ft)
+{
+	hlist_add_head_rcu(&ft->list, &br->frame_type_list);
+}
+
+void br_del_frame(struct net_bridge *br, struct br_frame_type *ft)
+{
+	struct br_frame_type *tmp;
+
+	hlist_for_each_entry(tmp, &br->frame_type_list, list)
+		if (ft == tmp) {
+			hlist_del_rcu(&ft->list);
+			return;
+		}
+}
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index b36689e6e7cb..f94d72bb7c32 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -6,6 +6,13 @@
 static const u8 mrp_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 };
 static const u8 mrp_in_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 };
 
+static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
+
+static struct br_frame_type mrp_frame_type __read_mostly = {
+	.type = cpu_to_be16(ETH_P_MRP),
+	.frame_handler = br_mrp_process,
+};
+
 static bool br_mrp_is_ring_port(struct net_bridge_port *p_port,
 				struct net_bridge_port *s_port,
 				struct net_bridge_port *port)
@@ -445,6 +452,9 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 
 	list_del_rcu(&mrp->list);
 	kfree_rcu(mrp, rcu);
+
+	if (list_empty(&br->mrp_list))
+		br_del_frame(br, &mrp_frame_type);
 }
 
 /* Adds a new MRP instance.
@@ -493,6 +503,9 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	spin_unlock_bh(&br->lock);
 	rcu_assign_pointer(mrp->s_port, p);
 
+	if (list_empty(&br->mrp_list))
+		br_add_frame(br, &mrp_frame_type);
+
 	INIT_DELAYED_WORK(&mrp->test_work, br_mrp_test_work_expired);
 	INIT_DELAYED_WORK(&mrp->in_test_work, br_mrp_in_test_work_expired);
 	list_add_tail_rcu(&mrp->list, &br->mrp_list);
@@ -1172,15 +1185,13 @@ static int br_mrp_rcv(struct net_bridge_port *p,
  * normal forwarding.
  * note: already called with rcu_read_lock
  */
-int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
 {
 	/* If there is no MRP instance do normal forwarding */
 	if (likely(!(p->flags & BR_MRP_AWARE)))
 		goto out;
 
-	if (unlikely(skb->protocol == htons(ETH_P_MRP)))
-		return br_mrp_rcv(p, skb, p->dev);
-
+	return br_mrp_rcv(p, skb, p->dev);
 out:
 	return 0;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 345118e35c42..2fe8b88d090e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -383,7 +383,7 @@ enum net_bridge_opts {
 struct net_bridge {
 	spinlock_t			lock;
 	spinlock_t			hash_lock;
-	struct list_head		port_list;
+	struct hlist_head		frame_type_list;
 	struct net_device		*dev;
 	struct pcpu_sw_netstats		__percpu *stats;
 	unsigned long			options;
@@ -395,6 +395,7 @@ struct net_bridge {
 #endif
 
 	struct rhashtable		fdb_hash_tbl;
+	struct list_head		port_list;
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	union {
 		struct rtable		fake_rtable;
@@ -755,6 +756,16 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
 rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
 
+struct br_frame_type {
+	__be16			type;
+	int			(*frame_handler)(struct net_bridge_port *port,
+						 struct sk_buff *skb);
+	struct hlist_node	list;
+};
+
+void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
+void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
+
 static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
 {
 	return rcu_dereference(dev->rx_handler) == br_get_rx_handler(dev);
@@ -1417,7 +1428,6 @@ extern int (*br_fdb_test_addr_hook)(struct net_device *dev, unsigned char *addr)
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
-int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
 bool br_mrp_enabled(struct net_bridge *br);
 void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
 int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
@@ -1429,11 +1439,6 @@ static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 	return -EOPNOTSUPP;
 }
 
-static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
-{
-	return 0;
-}
-
 static inline bool br_mrp_enabled(struct net_bridge *br)
 {
 	return false;
-- 
2.28.0

