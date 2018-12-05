Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tYhlzCwf9c13WgNZpz2gRwDDCyn0drImwybYcga7vTw=;
	b=AzW8nPFsriO8ep37epez6YYProfQJ45JtHWS90hNM7y23GCoE+X8bFmaranMQsD92U
	F44GEFlUSAEojLsbGCOg43WoaU2KvLxO4utMh+r3f/G+Bdmw4D1wKdKIHQe/vw/8475X
	S5AxJHqoYcOz4e7zgHgzpAVs3z7FBx7CfV4AI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  5 Dec 2018 15:14:26 +0200
Message-Id: <20181205131427.4989-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
References: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 3/4] net: bridge: mark hash_elasticity
	as obsolete
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

Now that the bridge multicast uses the generic rhashtable interface we
can drop the hash_elasticity option as that is already done for us and
it's hardcoded to a maximum of RHT_ELASTICITY (16 currently). Add a
warning about the obsolete option when the hash_elasticity is set.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2, v3: no change

 net/bridge/br_multicast.c |  1 -
 net/bridge/br_netlink.c   | 11 ++++-------
 net/bridge/br_private.h   |  1 -
 net/bridge/br_sysfs_br.c  |  6 +++---
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5b8cfef8bc4d..804ee15c45c1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1741,7 +1741,6 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 
 void br_multicast_init(struct net_bridge *br)
 {
-	br->hash_elasticity = 4;
 	br->hash_max = 512;
 
 	br->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 063da636cb82..ff2c10d47529 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1189,11 +1189,9 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
-	if (data[IFLA_BR_MCAST_HASH_ELASTICITY]) {
-		u32 val = nla_get_u32(data[IFLA_BR_MCAST_HASH_ELASTICITY]);
-
-		br->hash_elasticity = val;
-	}
+	if (data[IFLA_BR_MCAST_HASH_ELASTICITY])
+		br_warn(br, "the hash_elasticity option has been deprecated and is always %u\n",
+			RHT_ELASTICITY);
 
 	if (data[IFLA_BR_MCAST_HASH_MAX])
 		br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]);
@@ -1452,8 +1450,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 		       br_opt_get(br, BROPT_MULTICAST_QUERIER)) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_STATS_ENABLED,
 		       br_opt_get(br, BROPT_MULTICAST_STATS_ENABLED)) ||
-	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_ELASTICITY,
-			br->hash_elasticity) ||
+	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_ELASTICITY, RHT_ELASTICITY) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_MAX, br->hash_max) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_LAST_MEMBER_CNT,
 			br->multicast_last_member_count) ||
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index cf1f7365deb3..ba50fa437a94 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -372,7 +372,6 @@ struct net_bridge {
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 
-	u32				hash_elasticity;
 	u32				hash_max;
 
 	u32				multicast_last_member_count;
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index f164cda30fe2..b05b94e9c595 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -424,13 +424,13 @@ static DEVICE_ATTR_RW(multicast_querier);
 static ssize_t hash_elasticity_show(struct device *d,
 				    struct device_attribute *attr, char *buf)
 {
-	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->hash_elasticity);
+	return sprintf(buf, "%u\n", RHT_ELASTICITY);
 }
 
 static int set_elasticity(struct net_bridge *br, unsigned long val)
 {
-	br->hash_elasticity = val;
+	br_warn(br, "the hash_elasticity option has been deprecated and is always %u\n",
+		RHT_ELASTICITY);
 	return 0;
 }
 
-- 
2.17.2

