Date: Fri, 25 May 2007 10:17:50 +0200
From: Adam Osuchowski <adwol@zonk.pl>
Message-ID: <20070525081750.5ba4a411@zonk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [BUG] Dropping fragmented IP packets within VLAN frames on
	bridge
Reply-To: Adam Osuchowski <adwol@zonk.pl>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

There is a problem with fragmented IP packet sent within 802.1Q tagged
ethernet frame through bridge. Problem exists when conntrack is enabled
(i.e. nf_conntrack_ipv4 module is loaded). Then, such packets are not
fragmented again (after prior reassembling on bridge device) during
passing it to bridge enslaved NIC. It cause MTU exceeding and as a result
dropping packet.

Problem exists from kernel version 2.6.17 to 2.6.21.3 inclusive.

Below, there is a patch to fix it.

Regards.


--- linux-2.6.21.3.orig/net/bridge/br_netfilter.c	2007-05-25 09:56:15.000000000 +0200
+++ linux-2.6.21.3/net/bridge/br_netfilter.c	2007-05-25 10:11:42.000000000 +0200
@@ -731,7 +731,7 @@
 
 static int br_nf_dev_queue_xmit(struct sk_buff *skb)
 {
-	if (skb->protocol == htons(ETH_P_IP) &&
+	if ((skb->protocol == htons(ETH_P_IP) || IS_VLAN_IP(skb)) &&
 	    skb->len > skb->dev->mtu &&
 	    !skb_is_gso(skb))
 		return ip_fragment(skb, br_dev_queue_push_xmit);
