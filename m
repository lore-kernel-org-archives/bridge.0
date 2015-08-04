Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  4 Aug 2015 19:06:33 +0200
Message-Id: <1438707993-14561-3-git-send-email-razor@blackwall.org>
In-Reply-To: <1438707993-14561-1-git-send-email-razor@blackwall.org>
References: <1438707993-14561-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net 2/2] bridge: netlink: account for the
	IFLA_BRPORT_PROXYARP_WIFI attribute size and policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, kyeyoonp@codeaurora.org, jouni@codeaurora.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

The attribute size wasn't accounted for in the get_slave_size() callback
(br_port_get_slave_size) when it was introduced, so fix it now. Also add
a policy entry for it in br_port_policy.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Fixes: 842a9ae08a25 ("bridge: Extend Proxy ARP design to allow optional rules for Wi-Fi")
---
 net/bridge/br_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5390536d500c..4d74a0639c4c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -113,6 +113,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_LEARNING */
 		+ nla_total_size(1)	/* IFLA_BRPORT_UNICAST_FLOOD */
 		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP */
+		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP_WIFI */
 		+ 0;
 }
 
@@ -508,6 +509,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_LEARNING]	= { .type = NLA_U8 },
 	[IFLA_BRPORT_UNICAST_FLOOD] = { .type = NLA_U8 },
 	[IFLA_BRPORT_PROXYARP]	= { .type = NLA_U8 },
+	[IFLA_BRPORT_PROXYARP_WIFI] = { .type = NLA_U8 },
 };
 
 /* Change the state of the port and notify spanning tree */
-- 
2.4.3

