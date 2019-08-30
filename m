Return-Path: <leonardo@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Fri, 30 Aug 2019 15:13:54 -0300
Message-Id: <20190830181354.26279-3-leonardo@linux.ibm.com>
In-Reply-To: <20190830181354.26279-1-leonardo@linux.ibm.com>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 2/2] net: br_netfiler_hooks: Drops IPv6 packets
	if IPv6 module is not loaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Florian Westphal <fw@strlen.de>, Jozsef Kadlecsik <kadlec@netfilter.org>, Leonardo Bras <leonardo@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

A kernel panic can happen if a host has disabled IPv6 on boot and have to
process guest packets (coming from a bridge) using it's ip6tables.

IPv6 packets need to be dropped if the IPv6 module is not loaded.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 net/bridge/br_netfilter_hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index d3f9592f4ff8..5e8693730df1 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -493,6 +493,8 @@ static unsigned int br_nf_pre_routing(void *priv,
 	brnet = net_generic(state->net, brnf_net_id);
 	if (IS_IPV6(skb) || is_vlan_ipv6(skb, state->net) ||
 	    is_pppoe_ipv6(skb, state->net)) {
+		if (!ipv6_mod_enabled())
+			return NF_DROP;
 		if (!brnet->call_ip6tables &&
 		    !br_opt_get(br, BROPT_NF_CALL_IP6TABLES))
 			return NF_ACCEPT;
-- 
2.20.1

