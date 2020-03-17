Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GmTVCUwzP2sd2RegUgToB05hVf+yztMs1t67J5XMm00=;
 b=eKcVYTc9qQYhkE1Vi/Z417hbDiE3GtdPrKO4Cc7c/JdRPco1QtbXeyKIXljk94UweA
 LTetgFdKrdZOFkrN7hdUXTWpNrqcvY5Pz4QRsrPOcGKC9x8gSPMQrBTChuqmK/PLJHmh
 vBSF/AmONyIBLVQh/KL85aHRRSZ45u20es0rk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 17 Mar 2020 14:08:33 +0200
Message-Id: <20200317120836.1765164-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
References: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/4] net: bridge: vlan options: rename
	br_vlan_opts_eq to br_vlan_opts_eq_range
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

It is more appropriate name as it shows the intent of why we need to
check the options' state. It also allows us to give meaning to the two
arguments of the function: the first is the current vlan (v_curr) being
checked if it could enter the range ending in the second one (range_end).

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_private.h      | 4 ++--
 net/bridge/br_vlan.c         | 2 +-
 net/bridge/br_vlan_options.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5153ffe79a01..1f97703a52ff 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1199,8 +1199,8 @@ static inline void br_vlan_notify(const struct net_bridge *br,
 
 /* br_vlan_options.c */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
-bool br_vlan_opts_eq(const struct net_bridge_vlan *v1,
-		     const struct net_bridge_vlan *v2);
+bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
+			   const struct net_bridge_vlan *range_end);
 bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v);
 size_t br_vlan_opts_nl_size(void);
 int br_vlan_process_options(const struct net_bridge *br,
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 6b5deca08b89..09bfda47fbbf 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1694,7 +1694,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 {
 	return v_curr->vid - range_end->vid == 1 &&
 	       range_end->flags == v_curr->flags &&
-	       br_vlan_opts_eq(v_curr, range_end);
+	       br_vlan_opts_eq_range(v_curr, range_end);
 }
 
 static int br_vlan_dump_dev(const struct net_device *dev,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index cd2eb194eb98..24cf2a621df9 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -7,11 +7,11 @@
 
 #include "br_private.h"
 
-/* check if the options between two vlans are equal */
-bool br_vlan_opts_eq(const struct net_bridge_vlan *v1,
-		     const struct net_bridge_vlan *v2)
+/* check if the options' state of v_curr allow it to enter the range */
+bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
+			   const struct net_bridge_vlan *range_end)
 {
-	return v1->state == v2->state;
+	return v_curr->state == range_end->state;
 }
 
 bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v)
-- 
2.24.1

