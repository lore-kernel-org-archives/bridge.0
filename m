Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x10urBDzl/1yXhZ8GCaxKLSPxTgXwMHg2Y0MjkjC5Qs=;
 b=eb6qJ9msfsxDPfqxmJe+ctSp7WX2cpWSq5V+Vim2tYDvkRtrfpibqTlwyk7YXW7KUF
 fxHPJ3UtznwDuY7xShHVE3BaqDw8yqWyrUoseoN7FqMXrglt12ruFKfvm/Pc9vrutITQ
 wN240TJGQZ6bBxGMPdxgkKICikQEieaqses2U=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sun,  2 Aug 2020 15:50:39 +0300
Message-Id: <20200802125039.648571-1-nikolay@cumulusnetworks.com>
In-Reply-To: <39736ed8-8565-ab64-5163-da6f2acba68a@cumulusnetworks.com>
References: <39736ed8-8565-ab64-5163-da6f2acba68a@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net v2] net: bridge: clear skb private space on
	bridge dev xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, dsahern@gmail.com

We need to clear all of the bridge private skb variables as they can be
stale due to the packet having skb->cb initialized earlier and then
transmitted through the bridge device. Similar memset is already done on
bridge's input. We've seen cases where proxyarp_replied was 1 on routed
multicast packets transmitted through the bridge to ports with neigh
suppress and were getting dropped. Same thing can in theory happen with the
port isolation bit as well. We clear only the struct part after the bridge
pointer (currently 8 bytes) since the pointer is always set later.
We can now remove the redundant zeroing of frag_max_size.
Also add a BUILD_BUG_ON to make sure we catch any movement of the bridge
dev pointer.

Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: clear only the second half of the struct which contains the
fields that are used in various bridge parts, this replaced the rep stos
instruction with a single movq on my x86 and in general reduces
the clear area to 8 bytes, and in addition we can remove the now
redundant zeroing of frag_max_size as it will be already cleared,
add a build_bug_on to make sure we catch any movement of the bridge
dev pointer

 net/bridge/br_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8c7b78f8bc23..4f7880c99d3c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -36,6 +36,12 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	/* clear all private fields after the bridge dev pointer */
+	BUILD_BUG_ON(offsetof(struct br_input_skb_cb, brdev) > 0);
+	memset(skb->cb + sizeof(struct net_device *),
+	       0,
+	       sizeof(struct br_input_skb_cb) - sizeof(struct net_device *));
+
 	rcu_read_lock();
 	nf_ops = rcu_dereference(nf_br_ops);
 	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
@@ -50,7 +56,6 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	br_switchdev_frame_unmark(skb);
 	BR_INPUT_SKB_CB(skb)->brdev = dev;
-	BR_INPUT_SKB_CB(skb)->frag_max_size = 0;
 
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
-- 
2.25.4

