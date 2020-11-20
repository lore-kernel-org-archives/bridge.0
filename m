Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=BL3VFQ6Rlyw6xKgutRurTH+pUFWUhjWT8248JWBktNA=;
 b=fDVVoSsXGVbcIdXpCWkS9TuBUgAABvWw7oIws1xua+ub1JY3mRe5TwOvwsKW1ekKbf
 eXdR76IdEnq2bS60Tf3NwVgfEU1sT8NYIvl5rvT5A1e5enND+LTkilCQ+PvGs6hUBajn
 RNglIsFMY0x1fRhTPJrAXB3zTV9Tx1HleTofWDAbQpit00XVVM7RnsUhdwEv6mvKVqiU
 q9iLT/oIhrINS62+G2xtfMvGUqpAWGPDMXZJPQcLV1VKDHB8RnUL4xadRjqmuAxc9GB2
 3haX1NNz1xpt6QPgxC9mjFTLodOWg4neLKTBDAKIbkHT/aUZjphDqASDjh2MkObZ9XKh
 ZEtQ==
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9bad2be2-fd84-7c6e-912f-cee433787018@gmail.com>
Date: Fri, 20 Nov 2020 12:22:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next] net: bridge: switch to net core
 statistics counters handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

Use netdev->tstats instead of a member of net_bridge for storing
a pointer to the per-cpu counters. This allows us to use core
functionality for statistics handling.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/bridge/br_device.c  | 31 +++++++++----------------------
 net/bridge/br_input.c   |  6 +-----
 net/bridge/br_private.h |  1 -
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 77bcc8487..adb674a86 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -30,7 +30,6 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_fdb_entry *dst;
 	struct net_bridge_mdb_entry *mdst;
-	struct pcpu_sw_netstats *brstats = this_cpu_ptr(br->stats);
 	const struct nf_br_ops *nf_ops;
 	u8 state = BR_STATE_FORWARDING;
 	const unsigned char *dest;
@@ -45,10 +44,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_OK;
 	}
 
-	u64_stats_update_begin(&brstats->syncp);
-	brstats->tx_packets++;
-	brstats->tx_bytes += skb->len;
-	u64_stats_update_end(&brstats->syncp);
+	dev_sw_netstats_tx_add(dev, 1, skb->len);
 
 	br_switchdev_frame_unmark(skb);
 	BR_INPUT_SKB_CB(skb)->brdev = dev;
@@ -119,26 +115,26 @@ static int br_dev_init(struct net_device *dev)
 	struct net_bridge *br = netdev_priv(dev);
 	int err;
 
-	br->stats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!br->stats)
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
 		return -ENOMEM;
 
 	err = br_fdb_hash_init(br);
 	if (err) {
-		free_percpu(br->stats);
+		free_percpu(dev->tstats);
 		return err;
 	}
 
 	err = br_mdb_hash_init(br);
 	if (err) {
-		free_percpu(br->stats);
+		free_percpu(dev->tstats);
 		br_fdb_hash_fini(br);
 		return err;
 	}
 
 	err = br_vlan_init(br);
 	if (err) {
-		free_percpu(br->stats);
+		free_percpu(dev->tstats);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
 		return err;
@@ -146,7 +142,7 @@ static int br_dev_init(struct net_device *dev)
 
 	err = br_multicast_init_stats(br);
 	if (err) {
-		free_percpu(br->stats);
+		free_percpu(dev->tstats);
 		br_vlan_flush(br);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
@@ -165,7 +161,7 @@ static void br_dev_uninit(struct net_device *dev)
 	br_vlan_flush(br);
 	br_mdb_hash_fini(br);
 	br_fdb_hash_fini(br);
-	free_percpu(br->stats);
+	free_percpu(dev->tstats);
 }
 
 static int br_dev_open(struct net_device *dev)
@@ -202,15 +198,6 @@ static int br_dev_stop(struct net_device *dev)
 	return 0;
 }
 
-static void br_get_stats64(struct net_device *dev,
-			   struct rtnl_link_stats64 *stats)
-{
-	struct net_bridge *br = netdev_priv(dev);
-
-	netdev_stats_to_stats64(stats, &dev->stats);
-	dev_fetch_sw_netstats(stats, br->stats);
-}
-
 static int br_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct net_bridge *br = netdev_priv(dev);
@@ -404,7 +391,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_init		 = br_dev_init,
 	.ndo_uninit		 = br_dev_uninit,
 	.ndo_start_xmit		 = br_dev_xmit,
-	.ndo_get_stats64	 = br_get_stats64,
+	.ndo_get_stats64	 = dev_get_tstats64,
 	.ndo_set_mac_address	 = br_set_mac_address,
 	.ndo_set_rx_mode	 = br_dev_set_multicast_list,
 	.ndo_change_rx_flags	 = br_dev_change_rx_flags,
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 21808985f..8ca1f1bc6 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -35,12 +35,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	struct net_device *indev, *brdev = BR_INPUT_SKB_CB(skb)->brdev;
 	struct net_bridge *br = netdev_priv(brdev);
 	struct net_bridge_vlan_group *vg;
-	struct pcpu_sw_netstats *brstats = this_cpu_ptr(br->stats);
 
-	u64_stats_update_begin(&brstats->syncp);
-	brstats->rx_packets++;
-	brstats->rx_bytes += skb->len;
-	u64_stats_update_end(&brstats->syncp);
+	dev_sw_netstats_rx_add(brdev, skb->len);
 
 	vg = br_vlan_group_rcu(br);
 	/* Bridge is just like any other port.  Make sure the
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6f2818cb2..9a99af59b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -385,7 +385,6 @@ struct net_bridge {
 	spinlock_t			hash_lock;
 	struct hlist_head		frame_type_list;
 	struct net_device		*dev;
-	struct pcpu_sw_netstats		__percpu *stats;
 	unsigned long			options;
 	/* These fields are accessed on each packet */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
-- 
2.29.2


