Date: Wed, 28 Jul 2004 15:38:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040728153857.70851b16@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] (2/4) bridge dev_xmit cleanup
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org

The br_dev_xmit function was broken in two pieces (needlessly).
Put it back together.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_device.c b/net/bridge/br_device.c
--- a/net/bridge/br_device.c	2004-07-28 15:31:58 -07:00
+++ b/net/bridge/br_device.c	2004-07-28 15:31:58 -07:00
@@ -28,43 +28,29 @@
 	return &br->statistics;
 }
 
-static int __br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+int br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct net_bridge *br;
-	unsigned char *dest;
+	struct net_bridge *br = netdev_priv(dev);
+	const unsigned char *dest = skb->data;
 	struct net_bridge_fdb_entry *dst;
 
-	br = dev->priv;
 	br->statistics.tx_packets++;
 	br->statistics.tx_bytes += skb->len;
 
-	dest = skb->mac.raw = skb->data;
+	skb->mac.raw = skb->data;
 	skb_pull(skb, ETH_HLEN);
 
-	if (dest[0] & 1) {
+	rcu_read_lock();
+	if (dest[0] & 1) 
 		br_flood_deliver(br, skb, 0);
-		return 0;
-	}
-
-	if ((dst = br_fdb_get(br, dest)) != NULL) {
+	else if ((dst = br_fdb_get(br, dest)) != NULL) {
 		br_deliver(dst->dst, skb);
 		br_fdb_put(dst);
-		return 0;
-	}
-
-	br_flood_deliver(br, skb, 0);
-	return 0;
-}
-
-int br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	int ret;
+	} else
+		br_flood_deliver(br, skb, 0);
 
-	rcu_read_lock();
-	ret = __br_dev_xmit(skb, dev);
 	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 static int br_dev_open(struct net_device *dev)
