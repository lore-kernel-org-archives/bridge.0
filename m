Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nDPaNY6uULGl6w+zVk/xRhftdiMNqXaciWDwCjq2kwk=;
 b=Gu53H7KUgfZBNNpa4067GYBOmGvciq/0MwHhdQww5zmdtIRjqRUV5GKBOMB4icFePH
 fQOO/dxkUznueovCd9bc4fTGkCK9wyLhJgKXozG5uosU7znnWMcHJ47IUkpNsd22CB8f
 J0JNlUMm04xwqlzfEGrmkl6Ci/2UlTvcjgkKw=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  2 Sep 2020 14:25:15 +0300
Message-Id: <20200902112529.1570040-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
References: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 01/15] net: bridge: mdb: arrange
	internal structs so fast-path fields are close
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Before this patch we'd need 2 cache lines for fast-path, now all used
fields are in the first cache line.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_private.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index baa1500f384f..357b6905ecef 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -217,23 +217,27 @@ struct net_bridge_fdb_entry {
 struct net_bridge_port_group {
 	struct net_bridge_port		*port;
 	struct net_bridge_port_group __rcu *next;
-	struct hlist_node		mglist;
-	struct rcu_head			rcu;
-	struct timer_list		timer;
 	struct br_ip			addr;
 	unsigned char			eth_addr[ETH_ALEN] __aligned(2);
 	unsigned char			flags;
+
+	struct timer_list		timer;
+	struct hlist_node		mglist;
+
+	struct rcu_head			rcu;
 };
 
 struct net_bridge_mdb_entry {
 	struct rhash_head		rhnode;
 	struct net_bridge		*br;
 	struct net_bridge_port_group __rcu *ports;
-	struct rcu_head			rcu;
-	struct timer_list		timer;
 	struct br_ip			addr;
 	bool				host_joined;
+
+	struct timer_list		timer;
 	struct hlist_node		mdb_node;
+
+	struct rcu_head			rcu;
 };
 
 struct net_bridge_port {
-- 
2.25.4

