Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DA2340CC1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CF8B400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvfuZz2RtcNsOMIxkmeqAAvj9pMe3FQETaJUeG4BNv4=;
 b=TJPdct3OCrsuuE0aHPNa2+Zbo3xj0IGgxqTP+XnNTpKjz8XoEHoOq4IaiWDRxRguSN34pk2xHstoG0+2GBRRAiC84qcfcWhcLA+ZWkdLYtO3AEhH6hhkDEwqwz/vq3ftbOug15hYaMtix4nRLfWpTqC567nvxnXvIX8q0bM/xaFS6x9hAFtOqfAdMxE/3/qLidQhGvFV0zol2RdGY2YqgFn1N+KLCfrG/NDoLk7t7649ddNczF5iLa0T4zG77cIJqywV83hNyFGzNCham1ZjI6yxdSRVW9QM1ofPZk1/zNH+b377lhdwgWf+dy8fTg33Xyt/iBvLMn7yQ3OdtAnrgw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Apr 2023 12:58:23 +0300
Message-Id: <20230413095830.2182382-3-idosch@nvidia.com>
In-Reply-To: <20230413095830.2182382-1-idosch@nvidia.com>
References: <20230413095830.2182382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 2/9] bridge: Pass VLAN ID to br_flood()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Subsequent patches are going to add per-{Port, VLAN} neighbor
suppression, which will require br_flood() to potentially suppress ARP /
NS packets on a per-{Port, VLAN} basis.

As a preparation, pass the VLAN ID of the packet as another argument to
br_flood().

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_device.c  | 8 ++++----
 net/bridge/br_forward.c | 3 ++-
 net/bridge/br_input.c   | 2 +-
 net/bridge/br_private.h | 3 ++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index df47c876230e..8eca8a5c80c6 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -80,10 +80,10 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	dest = eth_hdr(skb)->h_dest;
 	if (is_broadcast_ether_addr(dest)) {
-		br_flood(br, skb, BR_PKT_BROADCAST, false, true);
+		br_flood(br, skb, BR_PKT_BROADCAST, false, true, vid);
 	} else if (is_multicast_ether_addr(dest)) {
 		if (unlikely(netpoll_tx_running(dev))) {
-			br_flood(br, skb, BR_PKT_MULTICAST, false, true);
+			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
 			goto out;
 		}
 		if (br_multicast_rcv(&brmctx, &pmctx_null, vlan, skb, vid)) {
@@ -96,11 +96,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
-			br_flood(br, skb, BR_PKT_MULTICAST, false, true);
+			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
 	} else if ((dst = br_fdb_find_rcu(br, dest, vid)) != NULL) {
 		br_forward(dst->dst, skb, false, true);
 	} else {
-		br_flood(br, skb, BR_PKT_UNICAST, false, true);
+		br_flood(br, skb, BR_PKT_UNICAST, false, true, vid);
 	}
 out:
 	rcu_read_unlock();
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 0fe133fa214c..94a8d757ae4e 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -197,7 +197,8 @@ static struct net_bridge_port *maybe_deliver(
 
 /* called under rcu_read_lock */
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
-	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig)
+	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
+	      u16 vid)
 {
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 3027e8f6be15..fc17b9fd93e6 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -207,7 +207,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		br_forward(dst->dst, skb, local_rcv, false);
 	} else {
 		if (!mcast_hit)
-			br_flood(br, skb, pkt_type, local_rcv, false);
+			br_flood(br, skb, pkt_type, local_rcv, false, vid);
 		else
 			br_multicast_flood(mdst, skb, brmctx, local_rcv, false);
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7264fd40f82f..1ff4d64ab584 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -849,7 +849,8 @@ void br_forward(const struct net_bridge_port *to, struct sk_buff *skb,
 		bool local_rcv, bool local_orig);
 int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
-	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig);
+	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
+	      u16 vid);
 
 /* return true if both source port and dest port are isolated */
 static inline bool br_skb_isolated(const struct net_bridge_port *to,
-- 
2.37.3

