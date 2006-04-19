Date: Wed, 19 Apr 2006 10:04:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] large packet size doesn't work
Message-ID: <20060419100437.3f079b98@localhost.localdomain>
In-Reply-To: <20060419073424.9133.qmail@webmaild.fe1.aruba.it>
References: <20060419073424.9133.qmail@webmaild.fe1.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: bridge@lists.osdl.org

Try the following if you are using vlan's

--- bridge.orig/net/bridge/br_forward.c	2006-04-10 16:17:51.000000000 -0700
+++ bridge/net/bridge/br_forward.c	2006-04-19 10:03:58.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/if_vlan.h>
 #include <linux/netfilter_bridge.h>
 #include "br_private.h"
 
@@ -29,11 +30,17 @@
 	return 1;
 }
 
+static inline unsigned eth_length(const struct sk_buff *skb)
+{
+	return skb->protocol == htons(ETH_P_8021Q)
+		? skb->len - VLAN_HLEN : skb->len;
+}
+
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
-	/* drop mtu oversized packets except tso */
-	if (skb->len > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
-		kfree_skb(skb);
+	/* drop mtu oversized packets except tso (local) and allow vlan's */
+	if (eth_length(skb) > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
+		dev_kfree_skb(skb);
 	else {
 #ifdef CONFIG_BRIDGE_NETFILTER
 		/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
