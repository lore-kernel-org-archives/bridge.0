Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=1LiXyXx71jdN39Tyg4LGzC6Dq0efiqfsghPtVFAEDPQ=;
	b=tZojQ9ubYIVjriLDATWEoS3CrOr9rFCpBXCxJayx9ON6lR5TplND1xLCM82cxxw3CfBOCUIshwRtYy5QtZrvTstrQahPB5YrLY997Z7GMTyL7Mp7DVeY2Rx8RhKyy2xBABYNDnAJhpQ3nayzc2Zslj4NA9lNzkFzVC+89xdaxi4=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri,  1 Sep 2017 12:22:25 +0300
Message-Id: <20170901092225.31597-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net] bridge: switchdev: Clear forward mark when
	transmitting packet
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, yotamg@mellanox.com, nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, davem@davemloft.net

Commit 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for
stacked devices") added the 'offload_fwd_mark' bit to the skb in order
to allow drivers to indicate to the bridge driver that they already
forwarded the packet in L2.

In case the bit is set, before transmitting the packet from each port,
the port's mark is compared with the mark stored in the skb's control
block. If both marks are equal, we know the packet arrived from a switch
device that already forwarded the packet and it's not re-transmitted.

However, if the packet is transmitted from the bridge device itself
(e.g., br0), we should clear the 'offload_fwd_mark' bit as the mark
stored in the skb's control block isn't valid.

This scenario can happen in rare cases where a packet was trapped during
L3 forwarding and forwarded by the kernel to a bridge device.

Fixes: 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for stacked devices")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Yotam Gigi <yotamg@mellanox.com>
Tested-by: Yotam Gigi <yotamg@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
---
 net/bridge/br_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 861ae2a165f4..5a7be3bddfa9 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -53,6 +53,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	brstats->tx_bytes += skb->len;
 	u64_stats_update_end(&brstats->syncp);
 
+#ifdef CONFIG_NET_SWITCHDEV
+	skb->offload_fwd_mark = 0;
+#endif
 	BR_INPUT_SKB_CB(skb)->brdev = dev;
 
 	skb_reset_mac_header(skb);
-- 
2.13.5

