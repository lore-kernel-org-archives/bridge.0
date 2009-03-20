From: Li Yang <leoli@freescale.com>
Date: Fri, 20 Mar 2009 17:04:29 +0800
Message-Id: <1237539869-30721-1-git-send-email-leoli@freescale.com>
Subject: [Bridge] [PATCH] net/bridge: use the maximum hard_header_len of
	ports for bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>

The bridging device used a constant hard_header_len.  This will cause
headroom shortage for ports with additional hardware header.  The patch
makes bridging device to use the maximum value of all ports.

Signed-off-by: Li Yang <leoli@freescale.com>
---
Fixes the following BUG when using bridging with gianfar driver:

skb_under_panic: text:c0224b84 len:122 put:8 head:dfb81800 data:dfb817fa tail:0xdfb81874 end:0xdfb818a0 dev:eth1
------------[ cut here ]------------
Kernel BUG at c02d9444 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
Call Trace:
[df2dbb20] [c02d9444] skb_under_panic+0x48/0x5c (unreliable)
[df2dbb30] [c0224b94] gfar_start_xmit+0x384/0x400
[df2dbb60] [c02e1c8c] dev_hard_start_xmit+0x258/0x2cc
[df2dbba0] [c02f264c] __qdisc_run+0x5c/0x1f8
[df2dbbd0] [c02e4bf4] dev_queue_xmit+0x264/0x2d0
[df2dbbf0] [c036fdc8] br_dev_queue_push_xmit+0x90/0xf8
[df2dbc00] [c036fcc8] br_flood+0xc8/0x120
[df2dbc30] [c036ebe0] br_dev_xmit+0xbc/0xc0
[df2dbc40] [c02e1c8c] dev_hard_start_xmit+0x258/0x2cc
[df2dbc80] [c02e4c04] dev_queue_xmit+0x274/0x2d0
[df2dbca0] [c02ebaa8] neigh_resolve_output+0xfc/0x25c
............

 net/bridge/br_if.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 727c5c5..d34303d 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -348,6 +348,7 @@ void br_features_recompute(struct net_bridge *br)
 {
 	struct net_bridge_port *p;
 	unsigned long features, mask;
+	unsigned short max_hard_header_len = ETH_HLEN;
 
 	features = mask = br->feature_mask;
 	if (list_empty(&br->port_list))
@@ -358,7 +359,10 @@ void br_features_recompute(struct net_bridge *br)
 	list_for_each_entry(p, &br->port_list, list) {
 		features = netdev_increment_features(features,
 						     p->dev->features, mask);
+		if (p->dev->hard_header_len > max_hard_header_len)
+			max_hard_header_len = p->dev->hard_header_len;
 	}
+	br->dev->hard_header_len = max_hard_header_len;
 
 done:
 	br->dev->features = netdev_fix_features(features, NULL);
-- 
1.5.5.1.248.g4b17

