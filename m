Return-Path: <leonardo@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Fri, 30 Aug 2019 15:13:53 -0300
Message-Id: <20190830181354.26279-2-leonardo@linux.ibm.com>
In-Reply-To: <20190830181354.26279-1-leonardo@linux.ibm.com>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 1/2] netfilter: Terminate rule eval if
	protocol=IPv6 and ipv6 module is disabled
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

If IPv6 is disabled on boot (ipv6.disable=1), but nft_fib_inet ends up
dealing with a IPv6 packet, it causes a kernel panic in
fib6_node_lookup_1(), crashing in bad_page_fault.

The panic is caused by trying to deference a very low address (0x38
in ppc64le), due to ipv6.fib6_main_tbl = NULL.
BUG: Kernel NULL pointer dereference at 0x00000038

The kernel panic was reproduced in a host that disabled IPv6 on boot and
have to process guest packets (coming from a bridge) using it's ip6tables.

Terminate rule evaluation when packet protocol is IPv6 but the ipv6 module
is not loaded.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 net/netfilter/nft_fib_netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_fib_netdev.c b/net/netfilter/nft_fib_netdev.c
index 2cf3f32fe6d2..a2e726ae7f07 100644
--- a/net/netfilter/nft_fib_netdev.c
+++ b/net/netfilter/nft_fib_netdev.c
@@ -14,6 +14,7 @@
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/ipv6.h>
 
 #include <net/netfilter/nft_fib.h>
 
@@ -34,6 +35,8 @@ static void nft_fib_netdev_eval(const struct nft_expr *expr,
 		}
 		break;
 	case ETH_P_IPV6:
+		if (!ipv6_mod_enabled())
+			break;
 		switch (priv->result) {
 		case NFT_FIB_RESULT_OIF:
 		case NFT_FIB_RESULT_OIFNAME:
-- 
2.20.1

