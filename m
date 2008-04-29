Date: Tue, 29 Apr 2008 10:06:03 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080429100603.7348f36d@extreme>
In-Reply-To: <20080429100458.58249ba7@extreme>
References: <20080429100458.58249ba7@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [RFT 2/2] bridge: network device statistics changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org

The other untested patch for 2.6.25
--------------------------------------
Keep track of dropped frames in bridge.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

---
 net/bridge/br_forward.c |   30 +++++++++++++++++++-----------
 net/bridge/br_input.c   |    3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

--- a/net/bridge/br_forward.c	2008-04-29 09:09:01.000000000 -0700
+++ b/net/bridge/br_forward.c	2008-04-29 09:16:18.000000000 -0700
@@ -34,20 +34,28 @@ static inline unsigned packet_length(con
 
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
+	struct net_bridge_port *p;
+
 	/* drop mtu oversized packets except gso */
-	if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
-		kfree_skb(skb);
-	else {
-		/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
-		if (nf_bridge_maybe_copy_header(skb))
-			kfree_skb(skb);
-		else {
-			skb_push(skb, ETH_HLEN);
+	if (packet_length(skb) > dev->mtu && !skb_is_gso(skb))
+		goto drop;
 
-			dev_queue_xmit(skb);
-		}
-	}
+	/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
+	if (nf_bridge_maybe_copy_header(skb))
+		goto drop;
+
+	skb_push(skb, ETH_HLEN);
 
+	dev_queue_xmit(skb);
+	return 0;
+
+drop:
+	p = rcu_dereference(dev->br_port);
+	if (p && p->br)
+		p->br->dev->stats.tx_dropped++;
+
+	kfree_skb(skb);
 	return 0;
 }
 
--- a/net/bridge/br_input.c	2008-04-29 09:15:56.000000000 -0700
+++ b/net/bridge/br_input.c	2008-04-29 09:25:57.000000000 -0700
@@ -89,6 +89,8 @@ int br_handle_frame_finish(struct sk_buf
 out:
 	return 0;
 drop:
+	if (p && p->br)
+		p->br->dev->stats.rx_dropped++;
 	kfree_skb(skb);
 	goto out;
 }
@@ -165,6 +167,7 @@ struct sk_buff *br_handle_frame(struct n
 		break;
 	default:
 drop:
+		p->br->dev->stats.rx_dropped++;
 		kfree_skb(skb);
 	}
 	return NULL;
