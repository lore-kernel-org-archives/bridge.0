Return-Path: <WINTERA@de.ibm.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KNfCdZT6JTIzp69RQLFCxVKoQyQ1xvDgq5ZoDK67PcY=;
 b=Y/S7U/jfedtMy1vycU90huGYWiI/o07q5rJGhCU1juTgqZWma+2+L/1k8SA+rs2GwSpu
 R+jwNj/XCOfei8cL7jGxDlYR9z8CehIxvc1nMUZqYtTWwH3q5TuHIc73AHO++O0D0zmm
 6v5Vk/fnmtL1taICuJCZllcnZEsew60d/CRxD6L8tpCHi13jlxPxrAzRWvlInKU7D4tb
 daQQbTdI2hlVOyIwODfo3VLTpj37DCekD1U/pM9RqKv32u3THe7LmyyfQ9RgZnTS4Vjo
 0+j1GCwfIj/SsknoVpIaIbZitovtw6IOSyjMKh2VMdR5YmasA5TGRkcvrmWtQPaQnX7g 7A== 
From: Alexandra Winter <wintera@linux.ibm.com>
Date: Wed, 23 Jun 2021 15:34:25 +0200
Message-Id: <20210623133426.2613847-2-wintera@linux.ibm.com>
In-Reply-To: <20210623133426.2613847-1-wintera@linux.ibm.com>
References: <20210623133426.2613847-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/2] net/bridge: Support learning_sync on
	master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, jwi@linux.ibm.com
Cc: Alexandra Winter <wintera@linux.ibm.com>

Add support to set and get the 'learning_sync [master]' attribute of a
bridgeport. A following patch adds support to synchronize the software
bridge's fdb changes to the hardware fdb of this bridgeport.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 include/uapi/linux/if_link.h | 2 +-
 net/bridge/br_netlink.c      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index cd5b382a4138..4d8e4c9b803c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -499,7 +499,7 @@ enum {
 	IFLA_BRPORT_LEARNING,	/* mac learning */
 	IFLA_BRPORT_UNICAST_FLOOD, /* flood unicast traffic */
 	IFLA_BRPORT_PROXYARP,	/* proxy ARP */
-	IFLA_BRPORT_LEARNING_SYNC, /* mac learning sync from device */
+	IFLA_BRPORT_LEARNING_SYNC, /* mac learning sync from/to device */
 	IFLA_BRPORT_PROXYARP_WIFI, /* proxy ARP for Wi-Fi */
 	IFLA_BRPORT_ROOT_ID,	/* designated root */
 	IFLA_BRPORT_BRIDGE_ID,	/* designated bridge */
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e4e6e991313e..d91a5a319a4b 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -180,6 +180,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_MCAST_FLOOD */
 		+ nla_total_size(1)	/* IFLA_BRPORT_BCAST_FLOOD */
 		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP */
+		+ nla_total_size(1)	/* IFLA_BRPORT_LEARNING_SYNC */
 		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP_WIFI */
 		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
 		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
@@ -247,6 +248,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u8(skb, IFLA_BRPORT_BCAST_FLOOD,
 		       !!(p->flags & BR_BCAST_FLOOD)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_PROXYARP, !!(p->flags & BR_PROXYARP)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_LEARNING_SYNC,
+		       !!(p->flags & BR_LEARNING_SYNC)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_PROXYARP_WIFI,
 		       !!(p->flags & BR_PROXYARP_WIFI)) ||
 	    nla_put(skb, IFLA_BRPORT_ROOT_ID, sizeof(struct ifla_bridge_id),
@@ -818,6 +821,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_LEARNING]	= { .type = NLA_U8 },
 	[IFLA_BRPORT_UNICAST_FLOOD] = { .type = NLA_U8 },
 	[IFLA_BRPORT_PROXYARP]	= { .type = NLA_U8 },
+	[IFLA_BRPORT_LEARNING_SYNC] = { .type = NLA_U8 },
 	[IFLA_BRPORT_PROXYARP_WIFI] = { .type = NLA_U8 },
 	[IFLA_BRPORT_MULTICAST_ROUTER] = { .type = NLA_U8 },
 	[IFLA_BRPORT_MCAST_TO_UCAST] = { .type = NLA_U8 },
@@ -889,6 +893,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 			 BR_MULTICAST_TO_UNICAST);
 	br_set_port_flag(p, tb, IFLA_BRPORT_BCAST_FLOOD, BR_BCAST_FLOOD);
 	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
+	br_set_port_flag(p, tb, IFLA_BRPORT_LEARNING_SYNC, BR_LEARNING_SYNC);
 	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP_WIFI, BR_PROXYARP_WIFI);
 	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
 	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
-- 
2.25.1

