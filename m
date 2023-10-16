Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C1A9408EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 924BE40965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvn98rfcbAc2Va2VU7W+Q2Eo0H1y6sr9aaANUCjT7Lk=;
 b=Lnx3Fkk3g4vZ0D4x+lNHaSYDZULDPoeLcq56uXC2ztCM740zpB9chtlB7oukcKqhozAUThNml3ZSe9zRRwc3GRASyfxyp6RhlEfzfGvreqGs3pdGmjSQHwWYp3PIqtpwKmd+F61rscClXuPbvrEiN0XQ5XqIb2Pp0pw0RQK+/YCK7ICrT5XY0JnBAI0fNhkYoMTWhY8yHIxNNAKbKgcv7KYgbEx1+iDuo6J1ciOYMvSAzBasqTIkYZ4tCVjTGPOymGVfCyHoBYZjW6SvBx3BCKSN7gxn73jyukBk4S47+kAiB/sgxDQLfKUnbtq0LZPSgz+0wfUi65DSuzY9am3NuQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:50 +0300
Message-ID: <20231016131259.3302298-5-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 04/13] bridge: mcast: Rename MDB entry get
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The current name is going to conflict with the upcoming net device
operation for the MDB get operation.

Rename the function to br_mdb_entry_skb_get(). No functional changes
intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_device.c    |  2 +-
 net/bridge/br_input.c     |  2 +-
 net/bridge/br_multicast.c |  5 +++--
 net/bridge/br_private.h   | 10 ++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9a5ea06236bd..d624710b384a 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -92,7 +92,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto out;
 		}
 
-		mdst = br_mdb_get(brmctx, skb, vid);
+		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index c729528b5e85..f21097e73482 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -175,7 +175,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 	switch (pkt_type) {
 	case BR_PKT_MULTICAST:
-		mdst = br_mdb_get(brmctx, skb, vid);
+		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
 			if ((mdst && mdst->host_joined) ||
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 96d1fc78dd39..d7d021af1029 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -145,8 +145,9 @@ static struct net_bridge_mdb_entry *br_mdb_ip6_get(struct net_bridge *br,
 }
 #endif
 
-struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
-					struct sk_buff *skb, u16 vid)
+struct net_bridge_mdb_entry *
+br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, struct sk_buff *skb,
+		     u16 vid)
 {
 	struct net_bridge *br = brmctx->br;
 	struct br_ip ip;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index cbbe35278459..3220898424ce 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -951,8 +951,9 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 		     struct net_bridge_mcast_port **pmctx,
 		     struct net_bridge_vlan *vlan,
 		     struct sk_buff *skb, u16 vid);
-struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
-					struct sk_buff *skb, u16 vid);
+struct net_bridge_mdb_entry *
+br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, struct sk_buff *skb,
+		     u16 vid);
 int br_multicast_add_port(struct net_bridge_port *port);
 void br_multicast_del_port(struct net_bridge_port *port);
 void br_multicast_enable_port(struct net_bridge_port *port);
@@ -1341,8 +1342,9 @@ static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 	return 0;
 }
 
-static inline struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
-						      struct sk_buff *skb, u16 vid)
+static inline struct net_bridge_mdb_entry *
+br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, struct sk_buff *skb,
+		     u16 vid)
 {
 	return NULL;
 }
-- 
2.40.1

