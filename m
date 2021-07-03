Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm1suUrRTUxN1sONyMB0D5Ren6HKrOyLt+PgKB8cvag=;
 b=ciUe7vBXnBuXNX8XgFbFxdjeVRn5EwFa8aMZ/9nJP5+6PuMWIIreDUbjgB9kC3Rm/5StM0r/Eyb9y97v5uFbR9n9e/DvomSQvqBl9QmH/6KUB+rp0OSEQ34ZSheftnTchmS3DhRMqwN604bH8h41KXAedfDPhuMYh6w/qpMpOYE=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:57:01 +0300
Message-Id: <20210703115705.1034112-7-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 06/10] net: allow ndo_select_queue
	to go beyond dev->num_real_tx_queues
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

When using a bridge upper as a subordinate device, switchdev interfaces
must allocate a TX queue for it, in order to have the information needed
in .ndo_start_xmit() whether the skb comes from the bridge or not.

The dedicated TX queue has the ->sb_dev pointer pointing to the bridge
device, and the only assumption that can be made is that any skb on that
queue must be coming from the bridge. So no other skbs can be sent on
that.

The default netdev_pick_tx() -> skb_tx_hash() policy hashes between TX
queues of the same priority.

To make the scheme work, switchdev drivers offloading a bridge need to
implement their own .ndo_select_queue() which selects the dedicated TX
queue for packets coming from the sb_dev, and lets netdev_pick_tx()
choose from the rest of the TX queues for the rest.

The implication is that the dedicated TX queue for the sb_dev must be
outside of the dev->num_real_tx_queues range, because otherwise,
netdev_pick_tx() might choose that TX queue for packets which aren't
actually coming from our sb_dev and therefore the assumption made in the
driver's .ndo_start_xmit() would be wrong.

This patch lifts the restriction in netdev_core_pick_tx() which says
that the dedicated TX queue for the sb_dev cannot be larger than the
num_real_tx_queues. With this, netdev_pick_tx() can safely pick between
the non-dedicated TX queues.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/netdevice.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 16c88e416693..d43f6ddd12a1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3697,10 +3697,10 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
  */
 static inline u16 netdev_cap_txqueue(struct net_device *dev, u16 queue_index)
 {
-	if (unlikely(queue_index >= dev->real_num_tx_queues)) {
-		net_warn_ratelimited("%s selects TX queue %d, but real number of TX queues is %d\n",
+	if (unlikely(queue_index >= dev->num_tx_queues)) {
+		net_warn_ratelimited("%s selects TX queue %d, but number of TX queues is %d\n",
 				     dev->name, queue_index,
-				     dev->real_num_tx_queues);
+				     dev->num_tx_queues);
 		return 0;
 	}
 
-- 
2.25.1

