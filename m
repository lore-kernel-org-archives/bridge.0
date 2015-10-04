Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun,  4 Oct 2015 14:23:39 +0200
Message-Id: <1443961427-15085-13-git-send-email-razor@blackwall.org>
In-Reply-To: <1443961427-15085-1-git-send-email-razor@blackwall.org>
References: <1443961427-15085-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 12/20] bridge: netlink: add support for
	multicast_query_use_ifaddr
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

Add IFLA_BR_MCAST_QUERY_USE_IFADDR to allow setting/getting
br->multicast_query_use_ifaddr via netlink.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_netlink.c      | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 22cb395a713d..7090b3977eac 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -247,6 +247,7 @@ enum {
 	IFLA_BR_FDB_FLUSH,
 	IFLA_BR_MCAST_ROUTER,
 	IFLA_BR_MCAST_SNOOPING,
+	IFLA_BR_MCAST_QUERY_USE_IFADDR,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 25e1c66d70f1..12ef844273a7 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -769,6 +769,7 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 				 .len  = ETH_ALEN },
 	[IFLA_BR_MCAST_ROUTER] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_SNOOPING] = { .type = NLA_U8 },
+	[IFLA_BR_MCAST_QUERY_USE_IFADDR] = { .type = NLA_U8 },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -880,6 +881,13 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		if (err)
 			return err;
 	}
+
+	if (data[IFLA_BR_MCAST_QUERY_USE_IFADDR]) {
+		u8 val;
+
+		val = nla_get_u8(data[IFLA_BR_MCAST_QUERY_USE_IFADDR]);
+		br->multicast_query_use_ifaddr = !!val;
+	}
 #endif
 
 	return 0;
@@ -912,6 +920,7 @@ static size_t br_get_size(const struct net_device *brdev)
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ROUTER */
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_SNOOPING */
+	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_QUERY_USE_IFADDR */
 #endif
 	       0;
 }
@@ -971,7 +980,9 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	if (nla_put_u8(skb, IFLA_BR_MCAST_ROUTER, br->multicast_router) ||
-	    nla_put_u8(skb, IFLA_BR_MCAST_SNOOPING, !br->multicast_disabled))
+	    nla_put_u8(skb, IFLA_BR_MCAST_SNOOPING, !br->multicast_disabled) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_QUERY_USE_IFADDR,
+		       br->multicast_query_use_ifaddr))
 		return -EMSGSIZE;
 #endif
 
-- 
2.4.3

