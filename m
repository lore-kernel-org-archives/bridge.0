Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=blackwall-org.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gi2zafVEN+nOoHs0CIWcuWtqMhG2vp69hL2fgv+t684=;
	b=iDpCzZ+C2fqKUKDRZPGGtkAFbNlMOmzcDom9+Dc3jRSG+JjkvZCjV/iLoBUNAsVuv3
	aQRb6ayhscv/w8a8GUJMA+UVm3nIbiFUY7772IGq5p0NoUpgXrLkOaLeD1hyna18AZo0
	PiiX5QvVxx0aXL5s+Euvv8uJQX8FCq9wY7qWwrUL88wcFtRtfcnYGv5OQZ4yKVkCvF2m
	tWblz3k1YzU01xNojQs6RY2/zFdNt/G9L8igz/T6LNb7cb2LWQsgIbnT417NNxCkmZjM
	Jtw6UiTE/Z9VtJhbNl/HAHeTJW/SMQ5mo7acPRLP9ngKXWqwk4JycgBYFAt80/hN6b+2
	ksmA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed,  6 Jul 2016 12:12:21 -0700
Message-Id: <1467832341-5355-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: extend MLD/IGMP query stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

As was suggested this patch adds support for the different versions of MLD
and IGMP query types. Since the user visible structure is still in net-next
we can augment it instead of adding netlink attributes.
The distinction between the different IGMP/MLD query types is done as
suggested in Section 7.1, RFC 3376 [1] and Section 8.1, RFC 3810 [2] based
on query payload size and code for IGMP. Since all IGMP packets go through
multicast_rcv() and it uses ip_mc_check_igmp/ipv6_mc_check_mld we can be
sure that at least the ip/ipv6 header can be directly used.

[1] https://tools.ietf.org/html/rfc3376#section-7
[2] https://tools.ietf.org/html/rfc3810#section-8.1

Suggested-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h |  7 ++++--
 net/bridge/br_forward.c        |  7 ++----
 net/bridge/br_input.c          |  2 +-
 net/bridge/br_multicast.c      | 48 ++++++++++++++++++++++++++++++++----------
 net/bridge/br_private.h        |  5 +++--
 5 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 8304fe6f0561..c186f64fffca 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -261,14 +261,17 @@ enum {
 
 /* IGMP/MLD statistics */
 struct br_mcast_stats {
-	__u64 igmp_queries[BR_MCAST_DIR_SIZE];
+	__u64 igmp_v1queries[BR_MCAST_DIR_SIZE];
+	__u64 igmp_v2queries[BR_MCAST_DIR_SIZE];
+	__u64 igmp_v3queries[BR_MCAST_DIR_SIZE];
 	__u64 igmp_leaves[BR_MCAST_DIR_SIZE];
 	__u64 igmp_v1reports[BR_MCAST_DIR_SIZE];
 	__u64 igmp_v2reports[BR_MCAST_DIR_SIZE];
 	__u64 igmp_v3reports[BR_MCAST_DIR_SIZE];
 	__u64 igmp_parse_errors;
 
-	__u64 mld_queries[BR_MCAST_DIR_SIZE];
+	__u64 mld_v1queries[BR_MCAST_DIR_SIZE];
+	__u64 mld_v2queries[BR_MCAST_DIR_SIZE];
 	__u64 mld_leaves[BR_MCAST_DIR_SIZE];
 	__u64 mld_v1reports[BR_MCAST_DIR_SIZE];
 	__u64 mld_v2reports[BR_MCAST_DIR_SIZE];
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 6c196037d818..d610644368b9 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -199,7 +199,6 @@ static void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		     bool unicast)
 {
 	u8 igmp_type = br_multicast_igmp_type(skb);
-	__be16 proto = skb->protocol;
 	struct net_bridge_port *prev;
 	struct net_bridge_port *p;
 
@@ -221,7 +220,7 @@ static void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		if (IS_ERR(prev))
 			goto out;
 		if (prev == p)
-			br_multicast_count(p->br, p, proto, igmp_type,
+			br_multicast_count(p->br, p, skb, igmp_type,
 					   BR_MCAST_DIR_TX);
 	}
 
@@ -266,8 +265,6 @@ static void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
-	__be16 proto = skb->protocol;
-
 	struct hlist_node *rp;
 
 	rp = rcu_dereference(hlist_first_rcu(&br->router_list));
@@ -286,7 +283,7 @@ static void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		if (IS_ERR(prev))
 			goto out;
 		if (prev == port)
-			br_multicast_count(port->br, port, proto, igmp_type,
+			br_multicast_count(port->br, port, skb, igmp_type,
 					   BR_MCAST_DIR_TX);
 
 		if ((unsigned long)lport >= (unsigned long)port)
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 786602bc0567..a7817e6f306f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -61,7 +61,7 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	if (!skb)
 		return NET_RX_DROP;
 	/* update the multicast stats if the packet is IGMP/MLD */
-	br_multicast_count(br, NULL, skb->protocol, br_multicast_igmp_type(skb),
+	br_multicast_count(br, NULL, skb, br_multicast_igmp_type(skb),
 			   BR_MCAST_DIR_TX);
 
 	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e405eef0ae2e..a5423a1eec05 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -843,14 +843,14 @@ static void __br_multicast_send_query(struct net_bridge *br,
 
 	if (port) {
 		skb->dev = port->dev;
-		br_multicast_count(br, port, skb->protocol, igmp_type,
+		br_multicast_count(br, port, skb, igmp_type,
 				   BR_MCAST_DIR_TX);
 		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
 			dev_net(port->dev), NULL, skb, NULL, skb->dev,
 			br_dev_queue_push_xmit);
 	} else {
 		br_multicast_select_own_querier(br, ip, skb);
-		br_multicast_count(br, port, skb->protocol, igmp_type,
+		br_multicast_count(br, port, skb, igmp_type,
 				   BR_MCAST_DIR_RX);
 		netif_rx(skb);
 	}
@@ -1676,7 +1676,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 	if (skb_trimmed && skb_trimmed != skb)
 		kfree_skb(skb_trimmed);
 
-	br_multicast_count(br, port, skb->protocol, BR_INPUT_SKB_CB(skb)->igmp,
+	br_multicast_count(br, port, skb, BR_INPUT_SKB_CB(skb)->igmp,
 			   BR_MCAST_DIR_RX);
 
 	return err;
@@ -1725,7 +1725,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 	if (skb_trimmed && skb_trimmed != skb)
 		kfree_skb(skb_trimmed);
 
-	br_multicast_count(br, port, skb->protocol, BR_INPUT_SKB_CB(skb)->igmp,
+	br_multicast_count(br, port, skb, BR_INPUT_SKB_CB(skb)->igmp,
 			   BR_MCAST_DIR_RX);
 
 	return err;
@@ -2251,13 +2251,16 @@ unlock:
 EXPORT_SYMBOL_GPL(br_multicast_has_querier_adjacent);
 
 static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
-			       __be16 proto, u8 type, u8 dir)
+			       const struct sk_buff *skb, u8 type, u8 dir)
 {
 	struct bridge_mcast_stats *pstats = this_cpu_ptr(stats);
+	__be16 proto = skb->protocol;
+	unsigned int t_len;
 
 	u64_stats_update_begin(&pstats->syncp);
 	switch (proto) {
 	case htons(ETH_P_IP):
+		t_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
 		switch (type) {
 		case IGMP_HOST_MEMBERSHIP_REPORT:
 			pstats->mstats.igmp_v1reports[dir]++;
@@ -2269,7 +2272,21 @@ static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
 			pstats->mstats.igmp_v3reports[dir]++;
 			break;
 		case IGMP_HOST_MEMBERSHIP_QUERY:
-			pstats->mstats.igmp_queries[dir]++;
+			if (t_len != sizeof(struct igmphdr)) {
+				pstats->mstats.igmp_v3queries[dir]++;
+			} else {
+				unsigned int offset = skb_transport_offset(skb);
+				struct igmphdr *ih, _ihdr;
+
+				ih = skb_header_pointer(skb, offset,
+							sizeof(_ihdr), &_ihdr);
+				if (!ih)
+					break;
+				if (!ih->code)
+					pstats->mstats.igmp_v1queries[dir]++;
+				else
+					pstats->mstats.igmp_v2queries[dir]++;
+			}
 			break;
 		case IGMP_HOST_LEAVE_MESSAGE:
 			pstats->mstats.igmp_leaves[dir]++;
@@ -2278,6 +2295,9 @@ static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
+		t_len = ntohs(ipv6_hdr(skb)->payload_len) +
+			sizeof(struct ipv6hdr);
+		t_len -= skb_network_header_len(skb);
 		switch (type) {
 		case ICMPV6_MGM_REPORT:
 			pstats->mstats.mld_v1reports[dir]++;
@@ -2286,7 +2306,10 @@ static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
 			pstats->mstats.mld_v2reports[dir]++;
 			break;
 		case ICMPV6_MGM_QUERY:
-			pstats->mstats.mld_queries[dir]++;
+			if (t_len != sizeof(struct mld_msg))
+				pstats->mstats.mld_v2queries[dir]++;
+			else
+				pstats->mstats.mld_v1queries[dir]++;
 			break;
 		case ICMPV6_MGM_REDUCTION:
 			pstats->mstats.mld_leaves[dir]++;
@@ -2299,7 +2322,7 @@ static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
 }
 
 void br_multicast_count(struct net_bridge *br, const struct net_bridge_port *p,
-			__be16 proto, u8 type, u8 dir)
+			const struct sk_buff *skb, u8 type, u8 dir)
 {
 	struct bridge_mcast_stats __percpu *stats;
 
@@ -2314,7 +2337,7 @@ void br_multicast_count(struct net_bridge *br, const struct net_bridge_port *p,
 	if (WARN_ON(!stats))
 		return;
 
-	br_mcast_stats_add(stats, proto, type, dir);
+	br_mcast_stats_add(stats, skb, type, dir);
 }
 
 int br_multicast_init_stats(struct net_bridge *br)
@@ -2359,14 +2382,17 @@ void br_multicast_get_stats(const struct net_bridge *br,
 			memcpy(&temp, &cpu_stats->mstats, sizeof(temp));
 		} while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
 
-		mcast_stats_add_dir(tdst.igmp_queries, temp.igmp_queries);
+		mcast_stats_add_dir(tdst.igmp_v1queries, temp.igmp_v1queries);
+		mcast_stats_add_dir(tdst.igmp_v2queries, temp.igmp_v2queries);
+		mcast_stats_add_dir(tdst.igmp_v3queries, temp.igmp_v3queries);
 		mcast_stats_add_dir(tdst.igmp_leaves, temp.igmp_leaves);
 		mcast_stats_add_dir(tdst.igmp_v1reports, temp.igmp_v1reports);
 		mcast_stats_add_dir(tdst.igmp_v2reports, temp.igmp_v2reports);
 		mcast_stats_add_dir(tdst.igmp_v3reports, temp.igmp_v3reports);
 		tdst.igmp_parse_errors += temp.igmp_parse_errors;
 
-		mcast_stats_add_dir(tdst.mld_queries, temp.mld_queries);
+		mcast_stats_add_dir(tdst.mld_v1queries, temp.mld_v1queries);
+		mcast_stats_add_dir(tdst.mld_v2queries, temp.mld_v2queries);
 		mcast_stats_add_dir(tdst.mld_leaves, temp.mld_leaves);
 		mcast_stats_add_dir(tdst.mld_v1reports, temp.mld_v1reports);
 		mcast_stats_add_dir(tdst.mld_v2reports, temp.mld_v2reports);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4dc851166ad1..40f200947ddc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -586,7 +586,7 @@ void br_mdb_notify(struct net_device *dev, struct net_bridge_port *port,
 void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
 		   int type);
 void br_multicast_count(struct net_bridge *br, const struct net_bridge_port *p,
-			__be16 proto, u8 type, u8 dir);
+			const struct sk_buff *skb, u8 type, u8 dir);
 int br_multicast_init_stats(struct net_bridge *br);
 void br_multicast_get_stats(const struct net_bridge *br,
 			    const struct net_bridge_port *p,
@@ -719,7 +719,8 @@ static inline void br_mdb_uninit(void)
 
 static inline void br_multicast_count(struct net_bridge *br,
 				      const struct net_bridge_port *p,
-				      __be16 proto, u8 type, u8 dir)
+				      const struct sk_buff *skb,
+				      u8 type, u8 dir)
 {
 }
 
-- 
2.8.2

