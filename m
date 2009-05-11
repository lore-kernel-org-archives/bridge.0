Sender: Cyrill Gorcunov <gorcunov@gmail.com>
Message-Id: <20090511125350.996551330@openvz.org>
Date: Mon, 11 May 2009 15:46:42 +0400
From: Cyrill Gorcunov <gorcunov@openvz.org>
References: <20090511114639.440944109@openvz.org>
Content-Disposition: inline; filename=net-br-introduce-skb-brmark
Subject: [Bridge] [RFC 3/5] net: sk_buff - introduce br_seen field to mark
	skb issued by a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

To distinguish skb's that was issued by a bridge (to not
loop forever) special skb mark is needed - br_seen.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
---
 include/linux/skbuff.h |    3 +++
 net/core/skbuff.c      |    3 +++
 2 files changed, 6 insertions(+)

Index: linux-2.6.git/include/linux/skbuff.h
=====================================================================
--- linux-2.6.git.orig/include/linux/skbuff.h
+++ linux-2.6.git/include/linux/skbuff.h
@@ -382,6 +382,9 @@ struct sk_buff {
 	__u8			do_not_encrypt:1;
 	__u8			requeue:1;
 #endif
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	__u8			br_seen:1;
+#endif
 	/* 0/13/14 bit hole */
 
 #ifdef CONFIG_NET_DMA
Index: linux-2.6.git/net/core/skbuff.c
=====================================================================
--- linux-2.6.git.orig/net/core/skbuff.c
+++ linux-2.6.git/net/core/skbuff.c
@@ -549,6 +549,9 @@ static void __copy_skb_header(struct sk_
 	new->tc_verd		= old->tc_verd;
 #endif
 #endif
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	new->br_seen		= old->br_seen;
+#endif
 	new->vlan_tci		= old->vlan_tci;
 
 	skb_copy_secmark(new, old);

