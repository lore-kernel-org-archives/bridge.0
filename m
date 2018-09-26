Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Au6EMM/OdvvF10g59oIQBlCZPcBbpGhpqGD2xJP47Eo=;
	b=EMC0OJ+KkxJvfYsVkj9but+SfBDYtnMif/NjWVAzWa4doFcF9glEA7CWn490jn3Ivw
	xz/Gy80h4oWZ3CVpP8uRicz584bE0HCrU0LLEFu6oBmG/mwDvdFKYoKYLyLVORMdBhDz
	IB7/Pbb4lqMebyBcnMT4ZvIDxlJSVD4XLQ99Q=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 15:17:57 +0300
Message-Id: <20180926121802.27851-5-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 4/9] net: bridge: convert group_addr_set
	option to a bit
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

Convert group_addr_set internal bridge opt to a bit.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_private.h  | 2 +-
 net/bridge/br_sysfs_br.c | 2 +-
 net/bridge/br_vlan.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 521893df0c2a..b00ccf35c35d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1139,7 +1139,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		spin_lock_bh(&br->lock);
 		memcpy(br->group_addr, new_addr, sizeof(br->group_addr));
 		spin_unlock_bh(&br->lock);
-		br->group_addr_set = true;
+		br_opt_toggle(br, BROPT_GROUP_ADDR_SET, true);
 		br_recalculate_fwd_mask(br);
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d8eadab09d7d..dda117ce386e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -312,6 +312,7 @@ enum net_bridge_opts {
 	BROPT_NF_CALL_IPTABLES,
 	BROPT_NF_CALL_IP6TABLES,
 	BROPT_NF_CALL_ARPTABLES,
+	BROPT_GROUP_ADDR_SET,
 };
 
 struct net_bridge {
@@ -355,7 +356,6 @@ struct net_bridge {
 	unsigned long			bridge_ageing_time;
 
 	u8				group_addr[ETH_ALEN];
-	bool				group_addr_set;
 
 	enum {
 		BR_NO_STP, 		/* no spanning tree */
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 0f8545c94948..4c2d56354d89 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -303,7 +303,7 @@ static ssize_t group_addr_store(struct device *d,
 	ether_addr_copy(br->group_addr, new_addr);
 	spin_unlock_bh(&br->lock);
 
-	br->group_addr_set = true;
+	br_opt_toggle(br, BROPT_GROUP_ADDR_SET, true);
 	br_recalculate_fwd_mask(br);
 	netdev_state_change(br->dev);
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 61d698bfe2b7..5942e03dd845 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -695,7 +695,7 @@ struct net_bridge_vlan *br_vlan_find(struct net_bridge_vlan_group *vg, u16 vid)
 /* Must be protected by RTNL. */
 static void recalculate_group_addr(struct net_bridge *br)
 {
-	if (br->group_addr_set)
+	if (br_opt_get(br, BROPT_GROUP_ADDR_SET))
 		return;
 
 	spin_lock_bh(&br->lock);
-- 
2.11.0

