Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun,  4 Oct 2015 14:23:35 +0200
Message-Id: <1443961427-15085-9-git-send-email-razor@blackwall.org>
In-Reply-To: <1443961427-15085-1-git-send-email-razor@blackwall.org>
References: <1443961427-15085-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 08/20] bridge: netlink: add group_addr
	support
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

Add IFLA_BR_GROUP_ADDR attribute to allow setting and retrieving the
group_addr via netlink.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_netlink.c      | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index a1e33282ab9d..eaeaac17dfdd 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -243,6 +243,7 @@ enum {
 	IFLA_BR_TCN_TIMER,
 	IFLA_BR_TOPOLOGY_CHANGE_TIMER,
 	IFLA_BR_GC_TIMER,
+	IFLA_BR_GROUP_ADDR,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 755bfe0ab404..a05a4306d42d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -765,6 +765,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_VLAN_FILTERING] = { .type = NLA_U8 },
 	[IFLA_BR_VLAN_PROTOCOL] = { .type = NLA_U16 },
 	[IFLA_BR_GROUP_FWD_MASK] = { .type = NLA_U16 },
+	[IFLA_BR_GROUP_ADDR] = { .type = NLA_BINARY,
+				 .len  = ETH_ALEN },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -838,6 +840,25 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		br->group_fwd_mask = fwd_mask;
 	}
 
+	if (data[IFLA_BR_GROUP_ADDR]) {
+		u8 new_addr[ETH_ALEN];
+
+		if (nla_len(data[IFLA_BR_GROUP_ADDR]) != ETH_ALEN)
+			return -EINVAL;
+		memcpy(new_addr, nla_data(data[IFLA_BR_GROUP_ADDR]), ETH_ALEN);
+		if (!is_link_local_ether_addr(new_addr))
+			return -EINVAL;
+		if (new_addr[5] == 1 ||		/* 802.3x Pause address */
+		    new_addr[5] == 2 ||		/* 802.3ad Slow protocols */
+		    new_addr[5] == 3)		/* 802.1X PAE address */
+			return -EINVAL;
+		spin_lock_bh(&br->lock);
+		memcpy(br->group_addr, new_addr, sizeof(br->group_addr));
+		spin_unlock_bh(&br->lock);
+		br->group_addr_set = true;
+		br_recalculate_fwd_mask(br);
+	}
+
 	return 0;
 }
 
@@ -864,6 +885,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u64)) +    /* IFLA_BR_TCN_TIMER */
 	       nla_total_size(sizeof(u64)) +    /* IFLA_BR_TOPOLOGY_CHANGE_TIMER */
 	       nla_total_size(sizeof(u64)) +    /* IFLA_BR_GC_TIMER */
+	       nla_total_size(ETH_ALEN) +       /* IFLA_BR_GROUP_ADDR */
 	       0;
 }
 
@@ -911,7 +933,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u64(skb, IFLA_BR_TCN_TIMER, tcn_timer) ||
 	    nla_put_u64(skb, IFLA_BR_TOPOLOGY_CHANGE_TIMER,
 			topology_change_timer) ||
-	    nla_put_u64(skb, IFLA_BR_GC_TIMER, gc_timer))
+	    nla_put_u64(skb, IFLA_BR_GC_TIMER, gc_timer) ||
+	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
-- 
2.4.3

