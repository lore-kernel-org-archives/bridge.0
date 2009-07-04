Sender: Cyrill Gorcunov <gorcunov@gmail.com>
Message-Id: <20090704062320.774818680@openvz.org>
Date: Sat, 04 Jul 2009 10:11:57 +0400
From: Cyrill Gorcunov <gorcunov@openvz.org>
References: <20090704061156.658235360@openvz.org>
Content-Disposition: inline; filename=net-br-br_nf_ops-cleanup
Subject: [Bridge] [patch 1/2] net, bridge: align br_nf_ops assignment
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

No functional change -- just for easier reading.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
---
 net/bridge/br_netfilter.c |   96 ++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 40 deletions(-)

Index: linux-2.6.git/net/bridge/br_netfilter.c
=====================================================================
--- linux-2.6.git.orig/net/bridge/br_netfilter.c
+++ linux-2.6.git/net/bridge/br_netfilter.c
@@ -905,46 +905,62 @@ static unsigned int ip_sabotage_in(unsig
  * For br_nf_post_routing, we need (prio = NF_BR_PRI_LAST), because
  * ip_refrag() can return NF_STOLEN. */
 static struct nf_hook_ops br_nf_ops[] __read_mostly = {
-	{ .hook = br_nf_pre_routing,
-	  .owner = THIS_MODULE,
-	  .pf = PF_BRIDGE,
-	  .hooknum = NF_BR_PRE_ROUTING,
-	  .priority = NF_BR_PRI_BRNF, },
-	{ .hook = br_nf_local_in,
-	  .owner = THIS_MODULE,
-	  .pf = PF_BRIDGE,
-	  .hooknum = NF_BR_LOCAL_IN,
-	  .priority = NF_BR_PRI_BRNF, },
-	{ .hook = br_nf_forward_ip,
-	  .owner = THIS_MODULE,
-	  .pf = PF_BRIDGE,
-	  .hooknum = NF_BR_FORWARD,
-	  .priority = NF_BR_PRI_BRNF - 1, },
-	{ .hook = br_nf_forward_arp,
-	  .owner = THIS_MODULE,
-	  .pf = PF_BRIDGE,
-	  .hooknum = NF_BR_FORWARD,
-	  .priority = NF_BR_PRI_BRNF, },
-	{ .hook = br_nf_local_out,
-	  .owner = THIS_MODULE,
-	  .pf = PF_BRIDGE,
-	  .hooknum = NF_BR_LOCAL_OUT,
-	  .priority = NF_BR_PRI_FIRST, },
-	{ .hook = br_nf_post_routing,
-	  .owner = THIS_MODULE,
-	  .pf = PF_BRIDGE,
-	  .hooknum = NF_BR_POST_ROUTING,
-	  .priority = NF_BR_PRI_LAST, },
-	{ .hook = ip_sabotage_in,
-	  .owner = THIS_MODULE,
-	  .pf = PF_INET,
-	  .hooknum = NF_INET_PRE_ROUTING,
-	  .priority = NF_IP_PRI_FIRST, },
-	{ .hook = ip_sabotage_in,
-	  .owner = THIS_MODULE,
-	  .pf = PF_INET6,
-	  .hooknum = NF_INET_PRE_ROUTING,
-	  .priority = NF_IP6_PRI_FIRST, },
+	{
+		.hook = br_nf_pre_routing,
+		.owner = THIS_MODULE,
+		.pf = PF_BRIDGE,
+		.hooknum = NF_BR_PRE_ROUTING,
+		.priority = NF_BR_PRI_BRNF,
+	},
+	{
+		.hook = br_nf_local_in,
+		.owner = THIS_MODULE,
+		.pf = PF_BRIDGE,
+		.hooknum = NF_BR_LOCAL_IN,
+		.priority = NF_BR_PRI_BRNF,
+	},
+	{
+		.hook = br_nf_forward_ip,
+		.owner = THIS_MODULE,
+		.pf = PF_BRIDGE,
+		.hooknum = NF_BR_FORWARD,
+		.priority = NF_BR_PRI_BRNF - 1,
+	},
+	{
+		.hook = br_nf_forward_arp,
+		.owner = THIS_MODULE,
+		.pf = PF_BRIDGE,
+		.hooknum = NF_BR_FORWARD,
+		.priority = NF_BR_PRI_BRNF,
+	},
+	{
+		.hook = br_nf_local_out,
+		.owner = THIS_MODULE,
+		.pf = PF_BRIDGE,
+		.hooknum = NF_BR_LOCAL_OUT,
+		.priority = NF_BR_PRI_FIRST,
+	},
+	{
+		.hook = br_nf_post_routing,
+		.owner = THIS_MODULE,
+		.pf = PF_BRIDGE,
+		.hooknum = NF_BR_POST_ROUTING,
+		.priority = NF_BR_PRI_LAST,
+	},
+	{
+		.hook = ip_sabotage_in,
+		.owner = THIS_MODULE,
+		.pf = PF_INET,
+		.hooknum = NF_INET_PRE_ROUTING,
+		.priority = NF_IP_PRI_FIRST,
+	},
+	{
+		.hook = ip_sabotage_in,
+		.owner = THIS_MODULE,
+		.pf = PF_INET6,
+		.hooknum = NF_INET_PRE_ROUTING,
+		.priority = NF_IP6_PRI_FIRST,
+	},
 };
 
 #ifdef CONFIG_SYSCTL

