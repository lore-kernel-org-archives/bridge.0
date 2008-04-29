Date: Tue, 29 Apr 2008 10:04:58 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080429100458.58249ba7@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [RFT 1/2] bridge: internal statistics
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org

I am too busy to setup a reasonable good test for this, but surely someone
else can validate it for me.  Patch against 2.6.25
--------------------------------------------------------------------------
Subject: bridge: network device statistics changes

Use internal network device stats structure.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

---
 net/bridge/br_device.c  |   11 ++---------
 net/bridge/br_forward.c |    2 +-
 net/bridge/br_input.c   |    9 +++++----
 net/bridge/br_private.h |    1 -
 4 files changed, 8 insertions(+), 15 deletions(-)

--- a/net/bridge/br_device.c	2008-04-29 09:07:44.000000000 -0700
+++ b/net/bridge/br_device.c	2008-04-29 09:09:01.000000000 -0700
@@ -21,12 +21,6 @@
 #include <asm/uaccess.h>
 #include "br_private.h"
 
-static struct net_device_stats *br_dev_get_stats(struct net_device *dev)
-{
-	struct net_bridge *br = netdev_priv(dev);
-	return &br->statistics;
-}
-
 /* net device transmit always called with no BH (preempt_disabled) */
 int br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
@@ -34,8 +28,8 @@ int br_dev_xmit(struct sk_buff *skb, str
 	const unsigned char *dest = skb->data;
 	struct net_bridge_fdb_entry *dst;
 
-	br->statistics.tx_packets++;
-	br->statistics.tx_bytes += skb->len;
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += skb->len;
 
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
@@ -161,7 +155,6 @@ void br_dev_setup(struct net_device *dev
 	ether_setup(dev);
 
 	dev->do_ioctl = br_dev_ioctl;
-	dev->get_stats = br_dev_get_stats;
 	dev->hard_start_xmit = br_dev_xmit;
 	dev->open = br_dev_open;
 	dev->set_multicast_list = br_dev_set_multicast_list;
--- a/net/bridge/br_forward.c	2008-04-29 09:07:44.000000000 -0700
+++ b/net/bridge/br_forward.c	2008-04-29 09:09:01.000000000 -0700
@@ -115,7 +115,7 @@ static void br_flood(struct net_bridge *
 				struct sk_buff *skb2;
 
 				if ((skb2 = skb_clone(skb, GFP_ATOMIC)) == NULL) {
-					br->statistics.tx_dropped++;
+					br->dev->stats.tx_dropped++;
 					kfree_skb(skb);
 					return;
 				}
--- a/net/bridge/br_input.c	2008-04-29 09:07:44.000000000 -0700
+++ b/net/bridge/br_input.c	2008-04-29 09:15:56.000000000 -0700
@@ -25,12 +25,13 @@ const u8 br_group_address[ETH_ALEN] = { 
 static void br_pass_frame_up(struct net_bridge *br, struct sk_buff *skb)
 {
 	struct net_device *indev;
+	struct net_device *brdev = br->dev;
 
-	br->statistics.rx_packets++;
-	br->statistics.rx_bytes += skb->len;
+	brdev->stats.rx_packets++;
+	brdev->stats.rx_bytes += skb->len;
 
 	indev = skb->dev;
-	skb->dev = br->dev;
+	skb->dev = brdev;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
 		netif_receive_skb);
@@ -64,7 +65,7 @@ int br_handle_frame_finish(struct sk_buf
 	dst = NULL;
 
 	if (is_multicast_ether_addr(dest)) {
-		br->statistics.multicast++;
+		br->dev->stats.multicast++;
 		skb2 = skb;
 	} else if ((dst = __br_fdb_get(br, dest)) && dst->is_local) {
 		skb2 = skb;
--- a/net/bridge/br_private.h	2008-04-29 09:07:44.000000000 -0700
+++ b/net/bridge/br_private.h	2008-04-29 09:09:01.000000000 -0700
@@ -90,7 +90,6 @@ struct net_bridge
 	spinlock_t			lock;
 	struct list_head		port_list;
 	struct net_device		*dev;
-	struct net_device_stats		statistics;
 	spinlock_t			hash_lock;
 	struct hlist_head		hash[BR_HASH_SIZE];
 	struct list_head		age_list;
