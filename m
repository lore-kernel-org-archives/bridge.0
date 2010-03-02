From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20100301161658.5a61143b@nehalam>
References: <20100301161658.5a61143b@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 02 Mar 2010 10:02:59 +0100
Message-ID: <1267520579.2964.27.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH]  bridge: per-cpu packet statistics
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

From: Stephen Hemminger <shemminger@vyatta.com>

Le lundi 01 mars 2010 à 16:16 -0800, Stephen Hemminger a écrit :

> +	for_each_online_cpu(cpu) {
> +		const struct br_cpu_netstats *bstats
> +			= per_cpu_ptr(br->stats, cpu);
> +
> +		stats->rx_bytes   += bstats->rx_bytes;
> +		stats->rx_packets += bstats->rx_packets;
> +	}

And last point, we should use for_each_possible_cpu() here

Here is your patch with all my comments integrated :

1) Use txq->{tx_bytes|tx_packets} counter

2) alloc_percpu(struct ...) instead of alloc_percpu(sizeof(struct ...))

3) free_netdev() in destructor

4) for_each_possible_cpu() instead of for_each_online_cpu()

5) br_get_stats() use local variables for the sake of concurrent users

Next step would be to use multiqueue :)

Thanks

[PATCH] bridge: per-cpu packet statistics

The shared packet statistics are a potential source of slow down
on bridged traffic. Convert to per-cpu array for rx_packets/rx_bytes RX
accounting, and use txq tx_packets/tx_bytes for TX accounting

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
---
 net/bridge/br_device.c  |   39 +++++++++++++++++++++++++++++++++++---
 net/bridge/br_if.c      |    6 +++++
 net/bridge/br_input.c   |    6 +++--
 net/bridge/br_private.h |    6 +++++
 4 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index eb7062d..e73c42c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -22,6 +22,8 @@
 /* net device transmit always called with no BH (preempt_disabled) */
 netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	int qidx = skb_get_queue_mapping(skb);
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, qidx);
 	struct net_bridge *br = netdev_priv(dev);
 	const unsigned char *dest = skb->data;
 	struct net_bridge_fdb_entry *dst;
@@ -29,8 +31,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	BR_INPUT_SKB_CB(skb)->brdev = dev;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	txq->tx_packets++;
+	txq->tx_bytes += skb->len;
 
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
@@ -81,6 +83,28 @@ static int br_dev_stop(struct net_device *dev)
 	return 0;
 }
 
+static struct net_device_stats *br_get_stats(struct net_device *dev)
+{
+	struct net_bridge *br = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+	unsigned long rx_bytes = 0, rx_packets = 0;
+	unsigned int cpu;
+
+	dev_txq_stats_fold(dev, stats);
+
+	for_each_possible_cpu(cpu) {
+		const struct br_cpu_netstats *bstats
+			= per_cpu_ptr(br->stats, cpu);
+
+		rx_bytes   += bstats->rx_bytes;
+		rx_packets += bstats->rx_packets;
+	}
+	stats->rx_bytes   = rx_bytes;
+	stats->rx_packets = rx_packets;
+
+	return stats;
+}
+
 static int br_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct net_bridge *br = netdev_priv(dev);
@@ -180,19 +204,28 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_open		 = br_dev_open,
 	.ndo_stop		 = br_dev_stop,
 	.ndo_start_xmit		 = br_dev_xmit,
+	.ndo_get_stats		 = br_get_stats,
 	.ndo_set_mac_address	 = br_set_mac_address,
 	.ndo_set_multicast_list	 = br_dev_set_multicast_list,
 	.ndo_change_mtu		 = br_change_mtu,
 	.ndo_do_ioctl		 = br_dev_ioctl,
 };
 
+static void br_dev_free(struct net_device *dev)
+{
+	struct net_bridge *br = netdev_priv(dev);
+
+	free_percpu(br->stats);
+	free_netdev(dev);
+}
+
 void br_dev_setup(struct net_device *dev)
 {
 	random_ether_addr(dev->dev_addr);
 	ether_setup(dev);
 
 	dev->netdev_ops = &br_netdev_ops;
-	dev->destructor = free_netdev;
+	dev->destructor = br_dev_free;
 	SET_ETHTOOL_OPS(dev, &br_ethtool_ops);
 	dev->tx_queue_len = 0;
 	dev->priv_flags = IFF_EBRIDGE;
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index b6a3872..b7cdd2e 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -185,6 +185,12 @@ static struct net_device *new_bridge_dev(struct net *net, const char *name)
 	br = netdev_priv(dev);
 	br->dev = dev;
 
+	br->stats = alloc_percpu(struct br_cpu_netstats);
+	if (!br->stats) {
+		free_netdev(dev);
+		return NULL;
+	}
+
 	spin_lock_init(&br->lock);
 	INIT_LIST_HEAD(&br->port_list);
 	spin_lock_init(&br->hash_lock);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 53b3985..7a5a5b4 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -23,9 +23,11 @@ const u8 br_group_address[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
 static int br_pass_frame_up(struct sk_buff *skb)
 {
 	struct net_device *indev, *brdev = BR_INPUT_SKB_CB(skb)->brdev;
+	struct net_bridge *br = netdev_priv(brdev);
+	struct br_cpu_netstats *brstats = this_cpu_ptr(br->stats);
 
-	brdev->stats.rx_packets++;
-	brdev->stats.rx_bytes += skb->len;
+	brstats->rx_packets++;
+	brstats->rx_bytes += skb->len;
 
 	indev = skb->dev;
 	skb->dev = brdev;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9191198..06b30af 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -135,6 +135,12 @@ struct net_bridge
 	spinlock_t			lock;
 	struct list_head		port_list;
 	struct net_device		*dev;
+
+	struct br_cpu_netstats __percpu {
+		unsigned long	rx_bytes;
+		unsigned long	rx_packets;
+	} *stats;
+
 	spinlock_t			hash_lock;
 	struct hlist_head		hash[BR_HASH_SIZE];
 	unsigned long			feature_mask;


