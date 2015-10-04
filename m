Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun,  4 Oct 2015 14:23:43 +0200
Message-Id: <1443961427-15085-17-git-send-email-razor@blackwall.org>
In-Reply-To: <1443961427-15085-1-git-send-email-razor@blackwall.org>
References: <1443961427-15085-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 16/20] bridge: netlink: add support for
	multicast_last_member_count
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Add IFLA_BR_MCAST_LAST_MEMBER_CNT to allow setting/getting
br->multicast_last_member_count via netlink.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_netlink.c      | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 10a44a735512..5409a461e47e 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -251,6 +251,7 @@ enum {
 	IFLA_BR_MCAST_QUERIER,
 	IFLA_BR_MCAST_HASH_ELASTICITY,
 	IFLA_BR_MCAST_HASH_MAX,
+	IFLA_BR_MCAST_LAST_MEMBER_CNT,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index d6b61b0eeada..cf6ccaea8180 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -773,6 +773,7 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_MCAST_QUERIER] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_HASH_ELASTICITY] = { .type = NLA_U32 },
 	[IFLA_BR_MCAST_HASH_MAX] = { .type = NLA_U32 },
+	[IFLA_BR_MCAST_LAST_MEMBER_CNT] = { .type = NLA_U32 },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -913,6 +914,12 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		if (err)
 			return err;
 	}
+
+	if (data[IFLA_BR_MCAST_LAST_MEMBER_CNT]) {
+		u32 val = nla_get_u32(data[IFLA_BR_MCAST_LAST_MEMBER_CNT]);
+
+		br->multicast_last_member_count = val;
+	}
 #endif
 
 	return 0;
@@ -949,6 +956,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_QUERIER */
 	       nla_total_size(sizeof(u32)) +     /* IFLA_BR_MCAST_HASH_ELASTICITY */
 	       nla_total_size(sizeof(u32)) +     /* IFLA_BR_MCAST_HASH_MAX */
+	       nla_total_size(sizeof(u32)) +     /* IFLA_BR_MCAST_LAST_MEMBER_CNT */
 #endif
 	       0;
 }
@@ -1014,7 +1022,9 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_QUERIER, br->multicast_querier) ||
 	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_ELASTICITY,
 			br->hash_elasticity) ||
-	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_MAX, br->hash_max))
+	    nla_put_u32(skb, IFLA_BR_MCAST_HASH_MAX, br->hash_max) ||
+	    nla_put_u32(skb, IFLA_BR_MCAST_LAST_MEMBER_CNT,
+			br->multicast_last_member_count))
 		return -EMSGSIZE;
 #endif
 
-- 
2.4.3

