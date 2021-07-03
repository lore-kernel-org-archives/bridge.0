Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdrmZRU0Q37EP78FtXBrjURVRoxh9R2XUtsYeAyE8XM=;
 b=UGHdQghISd2IvCvLLHDKUWCf3tq/Op8H+TK3twnw+TjCwHBEYlwa+Y835DSieZFT2m9dWJ5Cqdqhq5yY00/MXJ+ntU5dx5KJbEyfyxLJ0AjCGIOGmQeBOWK3WJfjb9GM034hBS8y3SUhCQkBjnw1S8jfpZ5Qt7spnTM137Dc6rk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:57:00 +0300
Message-Id: <20210703115705.1034112-6-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 05/10] net: extract helpers for
	binding a subordinate device to TX queues
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Currently, the acceleration scheme for offloading the data plane of
upper devices to hardware is geared towards a single topology: that of
macvlan interfaces, where there is a lower interface with many uppers.

We would like to use the same acceleration framework for the bridge data
plane, but there we have a single upper interface with many lowers.

This matters because commit ffcfe25bb50f ("net: Add support for
subordinate device traffic classes") has pulled some logic out of
ixgbe_select_queue() and moved it into net/core/dev.c as if it was
generic enough to do so. In particular, it created a scheme where:

- ixgbe calls netdev_set_sb_channel() on the macvlan interface, which
  changes the macvlan's dev->num_tc to a negative value (-channel).
  The value itself is not used anywhere in any relevant manner, it only
  matters that it's negative, because:
- when ixgbe calls netdev_bind_sb_channel_queue(), the macvlan is
  checked for being configured as a subordinate channel (its num_tc must
  be smaller than zero) and its tc_to_txq guts are being scavenged to
  hold what ixgbe puts in it (for each traffic class, a mapping is
  recorded towards an ixgbe TX ring dedicated to that macvlan). This is
  safe because "we can pretty much guarantee that the tc_to_txq mappings
  and XPS maps for the upper device are unused".
- when a packet is to be transmitted on the ixgbe interface on behalf of
  a macvlan upper and a TX queue is to be selected, netdev_pick_tx() ->
  skb_tx_hash() looks at the tc_to_txq array of the macvlan sb_dev,
  which was populated by ixgbe. The packet reaches the dedicated TX ring.

Fun, but netdev hierarchies with one upper and many lowers cannot do
this, because if multiple lowers tried to lay their eggs into the same
tc_to_txq array of the same upper, they would have to coordinate somehow.
So it doesn't quite work.

But nonetheless, to make sure of the subordinate device concept, we need
access to the sb_dev in the ndo_start_xmit() method, and the only place
we can retrieve it from is:

	netdev_get_tx_queue(dev, skb_get_queue_mapping(skb))->sb_dev

So we need that pointer populated and not much else.

Refactor the code which assigns the subordinate device pointer per lower
interface TX queue into a dedicated set of helpers and export it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/netdevice.h |  7 +++++++
 net/core/dev.c            | 31 +++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eaf5bb008aa9..16c88e416693 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2301,6 +2301,13 @@ static inline void net_prefetchw(void *p)
 #endif
 }
 
+void netdev_bind_tx_queues_to_sb_dev(struct net_device *dev,
+				     struct net_device *sb_dev,
+				     u16 count, u16 offset);
+
+void netdev_unbind_tx_queues_from_sb_dev(struct net_device *dev,
+					 struct net_device *sb_dev);
+
 void netdev_unbind_sb_channel(struct net_device *dev,
 			      struct net_device *sb_dev);
 int netdev_bind_sb_channel_queue(struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index c253c2aafe97..02e3a6941381 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2957,21 +2957,37 @@ int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
 }
 EXPORT_SYMBOL(netdev_set_num_tc);
 
-void netdev_unbind_sb_channel(struct net_device *dev,
-			      struct net_device *sb_dev)
+void netdev_bind_tx_queues_to_sb_dev(struct net_device *dev,
+				     struct net_device *sb_dev,
+				     u16 count, u16 offset)
+{
+	while (count--)
+		netdev_get_tx_queue(dev, count + offset)->sb_dev = sb_dev;
+}
+EXPORT_SYMBOL_GPL(netdev_bind_tx_queues_to_sb_dev);
+
+void netdev_unbind_tx_queues_from_sb_dev(struct net_device *dev,
+					 struct net_device *sb_dev)
 {
 	struct netdev_queue *txq = &dev->_tx[dev->num_tx_queues];
 
+	while (txq-- != &dev->_tx[0]) {
+		if (txq->sb_dev == sb_dev)
+			txq->sb_dev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(netdev_unbind_tx_queues_from_sb_dev);
+
+void netdev_unbind_sb_channel(struct net_device *dev,
+			      struct net_device *sb_dev)
+{
 #ifdef CONFIG_XPS
 	netif_reset_xps_queues_gt(sb_dev, 0);
 #endif
 	memset(sb_dev->tc_to_txq, 0, sizeof(sb_dev->tc_to_txq));
 	memset(sb_dev->prio_tc_map, 0, sizeof(sb_dev->prio_tc_map));
 
-	while (txq-- != &dev->_tx[0]) {
-		if (txq->sb_dev == sb_dev)
-			txq->sb_dev = NULL;
-	}
+	netdev_unbind_tx_queues_from_sb_dev(dev, sb_dev);
 }
 EXPORT_SYMBOL(netdev_unbind_sb_channel);
 
@@ -2994,8 +3010,7 @@ int netdev_bind_sb_channel_queue(struct net_device *dev,
 	/* Provide a way for Tx queue to find the tc_to_txq map or
 	 * XPS map for itself.
 	 */
-	while (count--)
-		netdev_get_tx_queue(dev, count + offset)->sb_dev = sb_dev;
+	netdev_bind_tx_queues_to_sb_dev(dev, sb_dev, count, offset);
 
 	return 0;
 }
-- 
2.25.1

