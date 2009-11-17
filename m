From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Nov 2009 22:39:09 +0000
Message-Id: <1258497551-25959-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1258497551-25959-1-git-send-email-arnd@arndb.de>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
Subject: [Bridge] [PATCH 2/3] macvlan: implement VEPA and private mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>

This allows each macvlan slave device to be in one
of three modes, depending on the use case:

MACVLAN_MODE_PRIVATE:
  The device never communicates with any other device
  on the same upper_dev. This even includes frames
  coming back from a reflective relay, where supported
  by the adjacent bridge.

MACVLAN_MODE_VEPA:
  The new Virtual Ethernet Port Aggregator (VEPA) mode,
  we assume that the adjacent bridge returns all frames
  where both source and destination are local to the
  macvlan port, i.e. the bridge is set up as a reflective
  relay.
  Broadcast frames coming in from the upper_dev get
  flooded to all macvlan interfaces in VEPA mode.
  We never deliver any frames locally.

MACVLAN_MODE_BRIDGE:
  We provide the behavior of a simple bridge between
  different macvlan interfaces on the same port. Frames
  from one interface to another one get delivered directly
  and are not sent out externally. Broadcast frames get
  flooded to all other bridge ports and to the external
  interface, but when they come back from a reflective
  relay, we don't deliver them again.
  Since we know all the MAC addresses, the macvlan bridge
  mode does not require learning or STP like the bridge
  module does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/macvlan.c |   46 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 406b8b5..fa8b568 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -33,6 +33,12 @@
 
 #define MACVLAN_HASH_SIZE	(1 << BITS_PER_BYTE)
 
+enum macvlan_type {
+	MACVLAN_PRIVATE		= 1,
+	MACVLAN_VEPA		= 2,
+	MACVLAN_BRIDGE		= 4,
+};
+
 struct macvlan_port {
 	struct net_device	*dev;
 	struct hlist_head	vlan_hash[MACVLAN_HASH_SIZE];
@@ -45,6 +51,7 @@ struct macvlan_dev {
 	struct hlist_node	hlist;
 	struct macvlan_port	*port;
 	struct net_device	*lowerdev;
+	enum macvlan_mode	mode;
 };
 
 
@@ -104,7 +111,8 @@ static int macvlan_addr_busy(const struct macvlan_port *port,
 
 static void macvlan_broadcast(struct sk_buff *skb,
 			      const struct macvlan_port *port,
-			      struct net_device *src)
+			      struct net_device *src,
+			      enum macvlan_mode mode)
 {
 	const struct ethhdr *eth = eth_hdr(skb);
 	const struct macvlan_dev *vlan;
@@ -123,6 +131,9 @@ static void macvlan_broadcast(struct sk_buff *skb,
 			if (dev == src)
 				continue;
 
+			if (!(vlan->mode & mode))
+				continue;
+
 			nskb = skb_clone(skb, GFP_ATOMIC);
 			if (nskb == NULL) {
 				dev->stats.rx_errors++;
@@ -177,13 +188,27 @@ static struct sk_buff *macvlan_handle_frame(struct sk_buff *skb)
 	const struct ethhdr *eth = eth_hdr(skb);
 	const struct macvlan_port *port;
 	const struct macvlan_dev *vlan;
+	const struct macvlan_dev *src;
 
 	port = rcu_dereference(skb->dev->macvlan_port);
 	if (port == NULL)
 		return skb;
 
 	if (is_multicast_ether_addr(eth->h_dest)) {
-		macvlan_broadcast(skb, port, NULL);
+		src = macvlan_hash_lookup(port, eth->h_source);
+		if (!src)
+			/* frame comes from an external address */
+			macvlan_broadcast(skb, port, NULL, MACVLAN_MODE_VEPA
+				| MACVLAN_MODE_VEPA | MACVLAN_MODE_BRIDGE);
+		else if (src->mode == MACVLAN_MODE_VEPA)
+			/* flood to everyone except source */
+			macvlan_broadcast(skb, port, src->dev,
+				MACVLAN_MODE_VEPA | MACVLAN_MODE_BRIDGE);
+		else if (src->mode == MACVLAN_MODE_BRIDGE)
+			/* flood only to VEPA ports, bridge ports
+			   already saw the frame */
+			macvlan_broadcast(skb, port, src->dev,
+				MACVLAN_MODE_VEPA);
 		return skb;
 	}
 
@@ -218,14 +243,17 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	secpath_reset(skb);
 	nf_reset(skb);
 
-	if (is_multicast_ether_addr(eth->h_dest)) {
-		macvlan_broadcast(skb, port, dev);
-		return macvlan_xmit_world(skb, dev);
-	}
+	if (vlan->mode == MACVLAN_MODE_BRIDGE) {
+		/* send to other bridge ports directly */
+		if (is_multicast_ether_addr(eth->h_dest)) {
+			macvlan_broadcast(skb, port, dev, MACVLAN_MODE_BRIDGE);
+			return macvlan_xmit_world(skb, dev);
+		}
 
-	dest = macvlan_hash_lookup(port, eth->h_dest);
-	if (dest)
-		return macvlan_unicast(skb, dest);
+		dest = macvlan_hash_lookup(port, eth->h_dest);
+		if (dest && dest->mode == MACVLAN_MODE_BRIDGE)
+			return macvlan_unicast(skb, dest);
+	}
 
 	return macvlan_xmit_world(skb, dev);
 }
-- 
1.6.3.3

