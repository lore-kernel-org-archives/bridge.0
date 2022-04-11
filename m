Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=WN01e0l1+WdxQJa+iowT/x59ccthHRPG+MX9yqwnNBA=;
 b=k6eQUW56l8UrIWz2VghKJwhoP+InVqCMGkWpqHj8IB5vnlckcn1NfXqeDIn++xGzlB
 TZpLNsGKadS121SKMl1/k7fKlFEG8nt1DuoJyoovAJ4f16DqP+RGMaqdt9BCzUmJaNj/
 +PFK+YGtiPdrBSE//1i+jCmxh6PUDJcj0lps/RZsXNS8R3lWzTWXmB8CK8G+j5ylrI9N
 E4NMTCIFy70mWuO4uo4gQFAZgjKKBPfKBiGA5ZHWieT6Tg7ncfYvtUPJWIv09VaCCNSO
 ek/MIL8VLbZaIbMON+6Q3Iw2BXmg1QF5zg1J0MHa2v7Cx+iFzYL2FzrNP9mbYxMNgZAp
 Jtaw==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:25 +0200
Message-Id: <20220411133837.318876-2-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 01/13] net: bridge: add control of bum
	flooding to bridge itself
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

The bridge itself is also a port, but unfortunately it does not (yet)
have a 'struct net_bridge_port'.  However, in many cases we want to
treat it as a proper port so concessions have been made, e.g., NULL
port or host_joined attributes.

This patch is an attempt to more of the same by adding support for
controlling flooding of unknown broadcast/unicast/multicast to the
bridge.  Something we often also want to control in an offloaded
switching fabric.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 net/bridge/br_device.c  |  4 ++++
 net/bridge/br_input.c   | 11 ++++++++---
 net/bridge/br_private.h |  3 +++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8d6bab244c4a..0aa7d21ac82c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -526,6 +526,10 @@ void br_dev_setup(struct net_device *dev)
 	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
 	dev->max_mtu = ETH_MAX_MTU;
 
+	br_opt_toggle(br, BROPT_UNICAST_FLOOD, 1);
+	br_opt_toggle(br, BROPT_MCAST_FLOOD, 1);
+	br_opt_toggle(br, BROPT_BCAST_FLOOD, 1);
+
 	br_netfilter_rtable_init(br);
 	br_stp_timer_init(br);
 	br_multicast_init(br);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 196417859c4a..d439b876bdf5 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -118,7 +118,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		/* by definition the broadcast is also a multicast address */
 		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
 			pkt_type = BR_PKT_BROADCAST;
-			local_rcv = true;
+			if (br_opt_get(br, BROPT_BCAST_FLOOD))
+				local_rcv = true;
 		} else {
 			pkt_type = BR_PKT_MULTICAST;
 			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
@@ -161,12 +162,16 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			}
 			mcast_hit = true;
 		} else {
-			local_rcv = true;
-			br->dev->stats.multicast++;
+			if (br_opt_get(br, BROPT_MCAST_FLOOD)) {
+				local_rcv = true;
+				br->dev->stats.multicast++;
+			}
 		}
 		break;
 	case BR_PKT_UNICAST:
 		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
+		if (!dst && br_opt_get(br, BROPT_UNICAST_FLOOD))
+			local_rcv = true;
 		break;
 	default:
 		break;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 18ccc3d5d296..683bd0ee4c64 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -449,6 +449,9 @@ enum net_bridge_opts {
 	BROPT_VLAN_BRIDGE_BINDING,
 	BROPT_MCAST_VLAN_SNOOPING_ENABLED,
 	BROPT_MST_ENABLED,
+	BROPT_UNICAST_FLOOD,
+	BROPT_MCAST_FLOOD,
+	BROPT_BCAST_FLOOD,
 };
 
 struct net_bridge {
-- 
2.25.1

