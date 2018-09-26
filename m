Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jTGQZvEv8jF9ileMzpia+OiGB5i6bwN4n44DTWItOHQ=;
	b=Yq3gw51oFJXUFeg4Mc4kmkfgO2OraP56mBoOM26bPSMuZ1xnqBji66O8zWPPAzCobo
	b2OzeDD56u6Gtg7w9iLTcUdb5mrI8Iq/eAPcaNBzN/whCwqurO5VfutZGkK5h335IFKr
	w0x6F3sBmcRSIfWdR2/fmScJnIRI4F6fDfZg8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:01:07 +0300
Message-Id: <20180926140107.10218-10-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 9/9] net: bridge: pack net_bridge better
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@idosch.org, davem@davemloft.net

Further reduce the size of net_bridge with 8 bytes and reduce the number of
holes in it:
 Before: holes: 5, sum holes: 15
 After: holes: 3, sum holes: 7

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: Remove the comment about offload_fwd_mark in net_bridge and
    leave it, the change will be for net_bridge_port instead.
    Thanks to Ido for spotting it.

 net/bridge/br_private.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 92d08f8c7dd4..57229b9d800f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -349,7 +349,6 @@ struct net_bridge {
 	/* STP */
 	bridge_id			designated_root;
 	bridge_id			bridge_id;
-	u32				root_path_cost;
 	unsigned char			topology_change;
 	unsigned char			topology_change_detected;
 	u16				root_port;
@@ -361,6 +360,7 @@ struct net_bridge {
 	unsigned long			bridge_hello_time;
 	unsigned long			bridge_forward_delay;
 	unsigned long			bridge_ageing_time;
+	u32				root_path_cost;
 
 	u8				group_addr[ETH_ALEN];
 
@@ -383,6 +383,7 @@ struct net_bridge {
 #if IS_ENABLED(CONFIG_IPV6)
 	u8				multicast_mld_version;
 #endif
+	spinlock_t			multicast_lock;
 	unsigned long			multicast_last_member_interval;
 	unsigned long			multicast_membership_interval;
 	unsigned long			multicast_querier_interval;
@@ -390,7 +391,6 @@ struct net_bridge {
 	unsigned long			multicast_query_response_interval;
 	unsigned long			multicast_startup_query_interval;
 
-	spinlock_t			multicast_lock;
 	struct net_bridge_mdb_htable __rcu *mdb;
 	struct hlist_head		router_list;
 
-- 
2.11.0

