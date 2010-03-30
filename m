Message-ID: <OFC050A0FC.1BF55EDB-ONC12576F6.002669E3-C12576F6.00281EEA@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 30 Mar 2010 09:18:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] [RFC patch] allow IP address on enslaved interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org
Cc: Bart De Schuymer <bdschuym@pandora.be>


This quick hack lets me use an IP address on an enslaved interface:
 #eth1 has IP 192.168.1.16
 brctl addbr br0
 brctl setfd br0 0
 ifconfig br0 up
 brctl addif br0 eth1

After this I can use eth1 as if it was the br0 interface.
This obviously needs cleanup(skb->cb[42] = 99 needs to be fixed)
I probably broke something else too :(
Is this useful for someone else too?

          Jocke

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 1a99c4e..60d04eb 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -32,6 +32,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);

+	skb->cb[42] = 99;
 	if (dest[0] & 1)
 		br_flood_deliver(br, skb);
 	else if ((dst = __br_fdb_get(br, dest)) != NULL)
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5ee1a36..83806fd 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -28,8 +28,8 @@ static void br_pass_frame_up(struct net_bridge *br, struct sk_buff *skb)
 	brdev->stats.rx_bytes += skb->len;

 	indev = skb->dev;
-	skb->dev = brdev;
-
+	//skb->dev = brdev;
+	skb->cb[42] = 98;
 	NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
 		netif_receive_skb);
 }
@@ -124,6 +124,8 @@ struct sk_buff *br_handle_frame(struct net_bridge_port *p, struct sk_buff *skb)

 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
 		goto drop;
+	if (skb->cb[42] == 98)
+		return skb;

 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
diff --git a/net/core/dev.c b/net/core/dev.c
index ec87421..0ee9637 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -101,6 +101,7 @@
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/if_bridge.h>
+#include "../bridge/br_private.h"
 #include <linux/if_macvlan.h>
 #include <net/dst.h>
 #include <net/pkt_sched.h>
@@ -1808,7 +1809,13 @@ int dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	int rc = NETDEV_TX_OK;
+	struct net_bridge_port *port;

+	if (skb->cb[42] != 99 && (port = rcu_dereference(dev->br_port))) {
+		dev = port->br->dev;
+		skb->dev = port->br->dev;
+		ops = port->br->dev->netdev_ops;
+	}
 	if (likely(!skb->next)) {
 		if (!list_empty(&ptype_all))
 			dev_queue_xmit_nit(skb, dev);

