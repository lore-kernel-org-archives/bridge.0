Sender: Cyrill Gorcunov <gorcunov@gmail.com>
Message-Id: <20090704062321.034802084@openvz.org>
Date: Sat, 04 Jul 2009 10:11:58 +0400
From: Cyrill Gorcunov <gorcunov@openvz.org>
References: <20090704061156.658235360@openvz.org>
Content-Disposition: inline; filename=net-br-x-tables-ifconfig
Subject: [Bridge] [patch 2/2] net, netns_xt: shrink netns_xt members
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org, kaber@trash.net, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Cyrill Gorcunov <gorcunov@openvz.org>

In case if kernel was compiled without ebtables support
there is no need to keep ebt_table pointers in netns_xt
structure.

Make it config dependent.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
---

Probably GCC will authomatically shrink the structure
if the members are not in use. Please review.

 include/net/netns/x_tables.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.git/include/net/netns/x_tables.h
=====================================================================
--- linux-2.6.git.orig/include/net/netns/x_tables.h
+++ linux-2.6.git/include/net/netns/x_tables.h
@@ -8,8 +8,11 @@ struct ebt_table;
 
 struct netns_xt {
 	struct list_head tables[NFPROTO_NUMPROTO];
+#if defined(CONFIG_BRIDGE_NF_EBTABLES) || \
+    defined(CONFIG_BRIDGE_NF_EBTABLES_MODULE)
 	struct ebt_table *broute_table;
 	struct ebt_table *frame_filter;
 	struct ebt_table *frame_nat;
+#endif
 };
 #endif

