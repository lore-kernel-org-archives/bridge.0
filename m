From: Bart De Schuymer <bdschuym@pandora.be>
Date: Wed, 4 Aug 2004 22:54:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408042254.41978.bdschuym@pandora.be>
Subject: [Bridge] Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: netfilter-devel <netfilter-devel@lists.netfilter.org>
Cc: bridge <bridge@osdl.org>

Hello,

Due to a recent change in the bridge code, we now need a way of knowing if
a packet has been defragmented. The bridge code now checks on the packet
size and drops packets that are too big for the output port. Defragmented
packets will get refragmented later, so they shouldn't be dropped.
I've been reading the defragmentation code and can't find an easy way of
knowing if a packet has been defragmented.
It's easy to check for a changed size of the skb of course, but a mangle
target could be responsible for a changed size too, probably.
So, my question: is there currently a fast way to know this?
If not, would the netfilter core team oppose to adding a
NFC_DEFRAGMENTED flag for the nf_cache field of the skb, which is set
by the defragmentation code?

To be more concrete, I've attached the proposed addition below.

cheers,
Bart

--- linux-2.6.8-rc2-bk9/include/linux/netfilter.h.old	2004-08-04 22:46:45.000000000 +0200
+++ linux-2.6.8-rc2-bk9/include/linux/netfilter.h	2004-08-04 22:47:49.000000000 +0200
@@ -24,6 +24,7 @@
    <= 0x2000 is used for protocol-flags. */
 #define NFC_UNKNOWN 0x4000
 #define NFC_ALTERED 0x8000
+#define NFC_DEFRAGMENTED 0x10000
 
 #ifdef __KERNEL__
 #include <linux/config.h>
--- linux-2.6.8-rc2-bk9/net/ipv4/netfilter/ip_conntrack_core.c.old	2004-08-04 22:46:32.000000000 +0200
+++ linux-2.6.8-rc2-bk9/net/ipv4/netfilter/ip_conntrack_core.c	2004-08-04 22:48:20.000000000 +0200
@@ -1212,7 +1212,7 @@ ip_ct_gather_frags(struct sk_buff *skb)
 	}
 
 	ip_send_check(skb->nh.iph);
-	skb->nfcache |= NFC_ALTERED;
+	skb->nfcache |= NFC_ALTERED | NFC_DEFRAGMENTED;
 #ifdef CONFIG_NETFILTER_DEBUG
 	/* Packet path as if nothing had happened. */
 	skb->nf_debug = olddebug;

