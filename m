Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  6 Oct 2015 14:11:58 +0200
Message-Id: <1444133522-16907-5-git-send-email-razor@blackwall.org>
In-Reply-To: <1444133522-16907-1-git-send-email-razor@blackwall.org>
References: <1444133522-16907-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 4/8] bridge: netlink: export port's id and
	number
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

Add IFLA_BRPORT_(ID|NO) to allow getting port's port_id and port_no
respectively via netlink.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h | 2 ++
 net/bridge/br_netlink.c      | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 837caf940135..6857563eb27c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -296,6 +296,8 @@ enum {
 	IFLA_BRPORT_BRIDGE_ID,	/* designated bridge */
 	IFLA_BRPORT_DESIGNATED_PORT,
 	IFLA_BRPORT_DESIGNATED_COST,
+	IFLA_BRPORT_ID,
+	IFLA_BRPORT_NO,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 678d22747044..e51332792c3c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -131,6 +131,8 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_COST */
+		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_ID */
+		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_NO */
 		+ 0;
 }
 
@@ -170,7 +172,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put(skb, IFLA_BRPORT_BRIDGE_ID, sizeof(struct ifla_bridge_id),
 		    &p->designated_bridge) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_PORT, p->designated_port) ||
-	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST, p->designated_cost))
+	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST, p->designated_cost) ||
+	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
+	    nla_put_u16(skb, IFLA_BRPORT_NO, p->port_no))
 		return -EMSGSIZE;
 
 	return 0;
-- 
2.4.3

