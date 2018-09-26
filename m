Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=raljA9mu7GcsAyBYxUp5h7AO4Lca5O5aaA2PB5A8AvU=;
	b=KkSOCQSnzR6CC/8ulqai2iyhPbPi2Nk1l0kOQPHav1Q+Cvw3XmiObl1rg8mqPfNOqL
	7D34Hfexv2uss+qanef61CHYegGInTGhWPC2skKTaOsj+UqGOhbRlViEJoaivNXtBWMz
	OErlD6BNyN5SfJM/c3rBdqVXYd3dwfXancq5o=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 15:18:02 +0300
Message-Id: <20180926121802.27851-10-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 9/9] net: bridge: pack net_bridge better
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

Further reduce the size of net_bridge with 8 bytes and reduce the number of
holes in it:
 Before: holes: 5, sum holes: 15
 After: holes: 2, sum holes: 3

Also as a bonus we get offload_fwd_mark in the first cache line and remove
the need to pull the last cache line of net_bridge just for that member in
fast path (should_deliver -> nbp_switchdev_allowed_egress).

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_private.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 92d08f8c7dd4..e50506225666 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -329,6 +329,9 @@ struct net_bridge {
 	struct net_device		*dev;
 	struct pcpu_sw_netstats		__percpu *stats;
 	unsigned long			options;
+#ifdef CONFIG_NET_SWITCHDEV
+	int offload_fwd_mark;
+#endif
 	/* These fields are accessed on each packet */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	__be16				vlan_proto;
@@ -349,7 +352,6 @@ struct net_bridge {
 	/* STP */
 	bridge_id			designated_root;
 	bridge_id			bridge_id;
-	u32				root_path_cost;
 	unsigned char			topology_change;
 	unsigned char			topology_change_detected;
 	u16				root_port;
@@ -361,6 +363,7 @@ struct net_bridge {
 	unsigned long			bridge_hello_time;
 	unsigned long			bridge_forward_delay;
 	unsigned long			bridge_ageing_time;
+	u32				root_path_cost;
 
 	u8				group_addr[ETH_ALEN];
 
@@ -383,6 +386,7 @@ struct net_bridge {
 #if IS_ENABLED(CONFIG_IPV6)
 	u8				multicast_mld_version;
 #endif
+	spinlock_t			multicast_lock;
 	unsigned long			multicast_last_member_interval;
 	unsigned long			multicast_membership_interval;
 	unsigned long			multicast_querier_interval;
@@ -390,7 +394,6 @@ struct net_bridge {
 	unsigned long			multicast_query_response_interval;
 	unsigned long			multicast_startup_query_interval;
 
-	spinlock_t			multicast_lock;
 	struct net_bridge_mdb_htable __rcu *mdb;
 	struct hlist_head		router_list;
 
@@ -411,12 +414,9 @@ struct net_bridge {
 	struct timer_list		topology_change_timer;
 	struct delayed_work		gc_work;
 	struct kobject			*ifobj;
-	u32				auto_cnt;
 
-#ifdef CONFIG_NET_SWITCHDEV
-	int offload_fwd_mark;
-#endif
 	struct hlist_head		fdb_list;
+	u32				auto_cnt;
 };
 
 struct br_input_skb_cb {
-- 
2.11.0

