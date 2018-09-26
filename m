Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Cj9xt6OZfs4ZqqK1la4k/YVUriS7J8A7N/Dteny6QBs=;
	b=cEl/q5dDw8qI9ho6Dhq6fLCFRIvxa6dkuu1T2TqFhXHbDuwA7bolIKxay2CN5vF6If
	sRKQAcMgijmgQjJ6adYEb7xXC7KvO08fnr0tOIPkrbZGHv/ViPGSKjWDFoggSoNFEu3O
	LC/12A8fU8IgVjjHPG4nuuwD2/aN2NKIXymWo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:01:06 +0300
Message-Id: <20180926140107.10218-9-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 8/9] net: bridge: convert
	mtu_set_by_user to a bit
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

Convert the last remaining bool option to a bit thus reducing the overall
net_bridge size further by 8 bytes.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/bridge/br_device.c  | 2 +-
 net/bridge/br_if.c      | 4 ++--
 net/bridge/br_private.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a0afdca73d8f..e053a4e43758 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -228,7 +228,7 @@ static int br_change_mtu(struct net_device *dev, int new_mtu)
 	dev->mtu = new_mtu;
 
 	/* this flag will be cleared if the MTU was automatically adjusted */
-	br->mtu_set_by_user = true;
+	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, true);
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* remember the MTU in the rtable for PMTU */
 	dst_metric_set(&br->fake_rtable.dst, RTAX_MTU, new_mtu);
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 3bb66508f07d..9b46d2dc4c22 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -508,14 +508,14 @@ void br_mtu_auto_adjust(struct net_bridge *br)
 	ASSERT_RTNL();
 
 	/* if the bridge MTU was manually configured don't mess with it */
-	if (br->mtu_set_by_user)
+	if (br_opt_get(br, BROPT_MTU_SET_BY_USER))
 		return;
 
 	/* change to the minimum MTU and clear the flag which was set by
 	 * the bridge ndo_change_mtu callback
 	 */
 	dev_set_mtu(br->dev, br_mtu_min(br));
-	br->mtu_set_by_user = false;
+	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, false);
 }
 
 static void br_set_gso_limits(struct net_bridge *br)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6bdcc701bc71..92d08f8c7dd4 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -319,6 +319,7 @@ enum net_bridge_opts {
 	BROPT_MULTICAST_STATS_ENABLED,
 	BROPT_HAS_IPV6_ADDR,
 	BROPT_NEIGH_SUPPRESS_ENABLED,
+	BROPT_MTU_SET_BY_USER,
 };
 
 struct net_bridge {
@@ -415,7 +416,6 @@ struct net_bridge {
 #ifdef CONFIG_NET_SWITCHDEV
 	int offload_fwd_mark;
 #endif
-	bool				mtu_set_by_user;
 	struct hlist_head		fdb_list;
 };
 
-- 
2.11.0

