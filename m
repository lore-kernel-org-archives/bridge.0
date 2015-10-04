Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun,  4 Oct 2015 14:23:33 +0200
Message-Id: <1443961427-15085-7-git-send-email-razor@blackwall.org>
In-Reply-To: <1443961427-15085-1-git-send-email-razor@blackwall.org>
References: <1443961427-15085-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 06/20] bridge: netlink: export
	topology_change and topology_change_detected
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

Add IFLA_BR_TOPOLOGY_CHANGE and IFLA_BR_TOPOLOGY_CHANGE_DETECTED and
export them via netlink.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h | 2 ++
 net/bridge/br_netlink.c      | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 7d7236d143fb..b00286ca1bfe 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -237,6 +237,8 @@ enum {
 	IFLA_BR_BRIDGE_ID,
 	IFLA_BR_ROOT_PORT,
 	IFLA_BR_ROOT_PATH_COST,
+	IFLA_BR_TOPOLOGY_CHANGE,
+	IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index cd0488b689d4..8bcaa5171f35 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -858,6 +858,8 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(struct ifla_bridge_id)) +   /* IFLA_BR_BRIDGE_ID */
 	       nla_total_size(sizeof(u16)) +    /* IFLA_BR_ROOT_PORT */
 	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_ROOT_PATH_COST */
+	       nla_total_size(sizeof(u8)) +    /* IFLA_BR_TOPOLOGY_CHANGE */
+	       nla_total_size(sizeof(u8)) +    /* IFLA_BR_TOPOLOGY_CHANGE_DETECTED */
 	       0;
 }
 
@@ -892,7 +894,10 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put(skb, IFLA_BR_ROOT_ID, sizeof(root_id), &root_id) ||
 	    nla_put(skb, IFLA_BR_BRIDGE_ID, sizeof(bridge_id), &bridge_id) ||
 	    nla_put_u16(skb, IFLA_BR_ROOT_PORT, br->root_port) ||
-	    nla_put_u32(skb, IFLA_BR_ROOT_PATH_COST, br->root_path_cost))
+	    nla_put_u32(skb, IFLA_BR_ROOT_PATH_COST, br->root_path_cost) ||
+	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE, br->topology_change) ||
+	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
+		       br->topology_change_detected))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
-- 
2.4.3

