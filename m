Return-Path: <tklauser@distanz.ch>
From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri,  5 May 2017 16:36:53 +0200
Message-Id: <20170505143653.8486-1-tklauser@distanz.ch>
Subject: [Bridge] [PATCH net] bridge: netlink: account for IFLA_BRPORT_{B,
	M}CAST_FLOOD size and policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Mike Manning <mmanning@brocade.com>

The attribute sizes for IFLA_BRPORT_MCAST_FLOOD and
IFLA_BRPORT_BCAST_FLOOD weren't accounted for in br_port_info_size()
when they were added. Do so now and also add the corresponding policy
entries:

Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Mike Manning <mmanning@brocade.com>
Fixes: b6cb5ac8331b ("net: bridge: add per-port multicast flood flag")
Fixes: 99f906e9ad7b ("bridge: add per-port broadcast flood flag")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/bridge/br_netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a572db710d4e..c5ce7745b230 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -133,6 +133,8 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_MCAST_TO_UCAST */
 		+ nla_total_size(1)	/* IFLA_BRPORT_LEARNING */
 		+ nla_total_size(1)	/* IFLA_BRPORT_UNICAST_FLOOD */
+		+ nla_total_size(1)	/* IFLA_BRPORT_MCAST_FLOOD */
+		+ nla_total_size(1)	/* IFLA_BRPORT_BCAST_FLOOD */
 		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP */
 		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP_WIFI */
 		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
@@ -633,6 +635,8 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_PROXYARP_WIFI] = { .type = NLA_U8 },
 	[IFLA_BRPORT_MULTICAST_ROUTER] = { .type = NLA_U8 },
 	[IFLA_BRPORT_MCAST_TO_UCAST] = { .type = NLA_U8 },
+	[IFLA_BRPORT_MCAST_FLOOD] = { .type = NLA_U8 },
+	[IFLA_BRPORT_BCAST_FLOOD] = { .type = NLA_U8 },
 };
 
 /* Change the state of the port and notify spanning tree */
-- 
2.12.2


