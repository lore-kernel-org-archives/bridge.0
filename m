Date: Tue, 22 Jul 2008 14:59:20 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080722145920.4a8e0cbe@extreme>
In-Reply-To: <20080722193546.6b8b4567@polsl.pl>
References: <48861b90.378.7eff.1867149638@webmaildh6.aruba.it>
	<20080722193546.6b8b4567@polsl.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adam Osuchowski <Adam.Osuchowski@polsl.pl>
Cc: bridge@linuxfoundation.org

On Tue, 22 Jul 2008 21:35:46 +0200
Adam Osuchowski <Adam.Osuchowski@polsl.pl> wrote:

> Fulvio Ricciardi wrote:
> > Thanks for the patch
> 
> This patch has one shortcoming. Better version (with PPPoE support as well)
> is here:
> 
> https://lists.linux-foundation.org/pipermail/bridge/2007-May/005447.html
> 
> > that I hope developers will include it in the vanilla Kernel
> > as soon as possible.
> 
> Don't be under the illusion that it will be done quickly (if at all).
> I have been waiting for that since I reported bug.
> 

Problem has been fixed since 2.6.17 (over 2 yrs ago).
Look before you whine.
------------------------------------------------------

commit 85ca719e5756d79ea0f10c469e3762462ac45e22
Author: Stephen Hemminger <shemminger@osdl.org>
Date:   Wed Apr 26 02:39:19 2006 -0700

    [BRIDGE]: allow full size vlan packets
    
    Need to allow for VLAN header when bridging.
    
    Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 2d24fb4..56f3aa4 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/if_vlan.h>
 #include <linux/netfilter_bridge.h>
 #include "br_private.h"
 
@@ -29,10 +30,15 @@ static inline int should_deliver(const struct net_bridge_port *p,
 	return 1;
 }
 
+static inline unsigned packet_length(const struct sk_buff *skb)
+{
+	return skb->len - (skb->protocol == htons(ETH_P_8021Q) ? VLAN_HLEN : 0);
+}
+
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
 	/* drop mtu oversized packets except tso */
-	if (skb->len > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
+	if (packet_length(skb) > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
 		kfree_skb(skb);
 	else {
 #ifdef CONFIG_BRIDGE_NETFILTER

