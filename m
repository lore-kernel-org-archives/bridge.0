Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=264JYdCxBOloVGEFMCTTrVh7QU/1mydZxM+myMH92wQ=;
	b=gjcSMI9op4qc/00JOoh/5LHljaZJ+W8PG1nEBdgabOiCeHbaUOhEWmeixPQEnWkSJe
	S1vlHwTuyNKkwNq0VMJim+RwRmBZvOE7t9gsPsv7w5e91idi4QrAZeSFHZ3Vi6DXFCCB
	AHQShNroNOPBVwvgrksXA0n2IFMvTLIPOssGY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:01:05 +0300
Message-Id: <20180926140107.10218-8-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 7/9] net: bridge: convert
	neigh_suppress_enabled option to a bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@idosch.org, davem@davemloft.net

Convert the neigh_suppress_enabled option to a bit.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/bridge/br_arp_nd_proxy.c | 13 ++++++++-----
 net/bridge/br_device.c       |  4 ++--
 net/bridge/br_input.c        |  2 +-
 net/bridge/br_private.h      |  2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index d42e3904b498..6b78e6351719 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -39,7 +39,7 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
 		}
 	}
 
-	br->neigh_suppress_enabled = neigh_suppress;
+	br_opt_toggle(br, BROPT_NEIGH_SUPPRESS_ENABLED, neigh_suppress);
 }
 
 #if IS_ENABLED(CONFIG_INET)
@@ -155,7 +155,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 	    ipv4_is_multicast(tip))
 		return;
 
-	if (br->neigh_suppress_enabled) {
+	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
 		if (p && (p->flags & BR_NEIGH_SUPPRESS))
 			return;
 		if (ipv4_is_zeronet(sip) || sip == tip) {
@@ -175,7 +175,8 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			return;
 	}
 
-	if (br->neigh_suppress_enabled && br_is_local_ip(vlandev, tip)) {
+	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED) &&
+	    br_is_local_ip(vlandev, tip)) {
 		/* its our local ip, so don't proxy reply
 		 * and don't forward to neigh suppress ports
 		 */
@@ -213,7 +214,8 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			/* If we have replied or as long as we know the
 			 * mac, indicate to arp replied
 			 */
-			if (replied || br->neigh_suppress_enabled)
+			if (replied ||
+			    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED))
 				BR_INPUT_SKB_CB(skb)->proxyarp_replied = true;
 		}
 
@@ -460,7 +462,8 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 			 * mac, indicate to NEIGH_SUPPRESS ports that we
 			 * have replied
 			 */
-			if (replied || br->neigh_suppress_enabled)
+			if (replied ||
+			    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED))
 				BR_INPUT_SKB_CB(skb)->proxyarp_replied = true;
 		}
 		neigh_release(n);
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index e682a668ce57..a0afdca73d8f 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -67,11 +67,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (IS_ENABLED(CONFIG_INET) &&
 	    (eth->h_proto == htons(ETH_P_ARP) ||
 	     eth->h_proto == htons(ETH_P_RARP)) &&
-	    br->neigh_suppress_enabled) {
+	    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
 		br_do_proxy_suppress_arp(skb, br, vid, NULL);
 	} else if (IS_ENABLED(CONFIG_IPV6) &&
 		   skb->protocol == htons(ETH_P_IPV6) &&
-		   br->neigh_suppress_enabled &&
+		   br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED) &&
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 				 sizeof(struct nd_msg)) &&
 		   ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 72074276c088..3ddca11f44c2 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -122,7 +122,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		br_do_proxy_suppress_arp(skb, br, vid, p);
 	} else if (IS_ENABLED(CONFIG_IPV6) &&
 		   skb->protocol == htons(ETH_P_IPV6) &&
-		   br->neigh_suppress_enabled &&
+		   br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED) &&
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 				 sizeof(struct nd_msg)) &&
 		   ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index e6bdb107fe04..6bdcc701bc71 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -318,6 +318,7 @@ enum net_bridge_opts {
 	BROPT_MULTICAST_QUERY_USE_IFADDR,
 	BROPT_MULTICAST_STATS_ENABLED,
 	BROPT_HAS_IPV6_ADDR,
+	BROPT_NEIGH_SUPPRESS_ENABLED,
 };
 
 struct net_bridge {
@@ -414,7 +415,6 @@ struct net_bridge {
 #ifdef CONFIG_NET_SWITCHDEV
 	int offload_fwd_mark;
 #endif
-	bool				neigh_suppress_enabled;
 	bool				mtu_set_by_user;
 	struct hlist_head		fdb_list;
 };
-- 
2.11.0

