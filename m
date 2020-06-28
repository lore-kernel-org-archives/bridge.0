Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593351940; x=1624887940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7RgpyIwXfH1tGTnb6OuRYjHUr8PyMUze0ylIcWVy050=;
 b=i+JaPpFGggPnUv1M3ON9wTRpEm/BHIabVb97cFMfP5VQT4XblHWWla1c
 5TK3LQgS/GrOyjz7DtKlbBVHfsJM66Nsp8KZWKq0oNdyzpcuYCi72Cj1r
 i9UwTgebe8gj2UxjxiKRvSkGyRdgYMOMTsdU4FJ3HNov+JECrgzEnRnBU
 jwJwKrCbpNhifqY6FITEaVvi95OK3Z/OdyyebE+FVhnd0rwjs9Un+NpZx
 03amz3YgdnP2sLT1ndI0ss0BmQYKy+lZU21HOSav6mTWZPJPWGEtzZ/qA
 v1DE03udjff3xedUSxVP4jF5eEE2l8+UmKS9FVD/sYncNaGPQKbnxTGIV A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sun, 28 Jun 2020 15:45:16 +0200
Message-ID: <20200628134516.3767607-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net] bridge: mrp: Fix endian conversion and some
	other warnings
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, kernel test robot <lkp@intel.com>

The following sparse warnings are fixed:
net/bridge/br_mrp.c:106:18: warning: incorrect type in assignment (different base types)
net/bridge/br_mrp.c:106:18:    expected unsigned short [usertype]
net/bridge/br_mrp.c:106:18:    got restricted __be16 [usertype]
net/bridge/br_mrp.c:281:23: warning: incorrect type in argument 1 (different modifiers)
net/bridge/br_mrp.c:281:23:    expected struct list_head *entry
net/bridge/br_mrp.c:281:23:    got struct list_head [noderef] *
net/bridge/br_mrp.c:332:28: warning: incorrect type in argument 1 (different modifiers)
net/bridge/br_mrp.c:332:28:    expected struct list_head *new
net/bridge/br_mrp.c:332:28:    got struct list_head [noderef] *
net/bridge/br_mrp.c:332:40: warning: incorrect type in argument 2 (different modifiers)
net/bridge/br_mrp.c:332:40:    expected struct list_head *head
net/bridge/br_mrp.c:332:40:    got struct list_head [noderef] *
net/bridge/br_mrp.c:682:29: warning: incorrect type in argument 1 (different modifiers)
net/bridge/br_mrp.c:682:29:    expected struct list_head const *head
net/bridge/br_mrp.c:682:29:    got struct list_head [noderef] *

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2f1a11ae11d222 ("bridge: mrp: Add MRP interface.")
Fixes: 4b8d7d4c599182 ("bridge: mrp: Extend bridge interface")
Fixes: 9a9f26e8f7ea30 ("bridge: mrp: Connect MRP API with the switchdev API")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c         | 2 +-
 net/bridge/br_private.h     | 2 +-
 net/bridge/br_private_mrp.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 779e1eb754430..90592af9db619 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -86,7 +86,7 @@ static struct sk_buff *br_mrp_skb_alloc(struct net_bridge_port *p,
 {
 	struct ethhdr *eth_hdr;
 	struct sk_buff *skb;
-	u16 *version;
+	__be16 *version;
 
 	skb = dev_alloc_skb(MRP_MAX_FRAME_LENGTH);
 	if (!skb)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2130fe0194e64..e0ea6dbbc97ed 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -430,7 +430,7 @@ struct net_bridge {
 	struct hlist_head		fdb_list;
 
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
-	struct list_head		__rcu mrp_list;
+	struct list_head		mrp_list;
 #endif
 };
 
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 33b255e38ffec..315eb37d89f0f 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -8,7 +8,7 @@
 
 struct br_mrp {
 	/* list of mrp instances */
-	struct list_head		__rcu list;
+	struct list_head		list;
 
 	struct net_bridge_port __rcu	*p_port;
 	struct net_bridge_port __rcu	*s_port;
-- 
2.26.2

