Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB43342532
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430063; cv=none; b=Ro64t8nEdPU7n1fxopyxvw3kKkGd+kTdohOHCkkF75PheK96fAVQ3856A+10LHWbviTzE3zx0pEej99+bFCB9XeWax475vpBTYlZnzPWROQpuIJNoojyeimBTKG9Jvga6nLLiROjGzkbVh85VH/U5D0U/I+qZ3LGuAuD+dKS7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430063; c=relaxed/simple;
	bh=i/iWHXwkq65V9aBHtj3ovzHTCgNp7Fl6leBmNTOUJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGNoCdrD/24G1jj8Dd/CjVZbQ7D0QJM5rgcJR4oK3yH8XqX5etpwt3IHaS0qPDiB4sEts+P4AsYDJHk24oue8cSOyFceT20K9YAX+MCzNKVR84BFQlfnzqiSCJecRE+LC/8fex6P3jwTPzVmfKtB8HphvWS092iuvKERz6sZQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CE3D54CC66;
	Mon,  2 Mar 2026 06:40:58 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	shuah@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v3 13/14] net: bridge: mcast: use combined active state in fast/data path
Date: Mon,  2 Mar 2026 06:40:07 +0100
Message-ID: <20260302054008.21638-14-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302054008.21638-1-linus.luessing@c0d3.blue>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

As the multicast active state variable is now always up to date and
functionally equivalent to our manual, extensive checks in fast path
we can just use this state variable in fast path, too. This allows to
save some CPU cycles for every multicast packet in the fast/data path.

Next to using brmctx->ip4_active / brmctx->ip6_active in fast path this
mostly just moves some code around to not expose it via br_private.h
anymore. While at it now also passing the ethernet protocol number
directly, instead of a pointer into the ethernet header.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_device.c    |  3 ++-
 net/bridge/br_input.c     |  3 ++-
 net/bridge/br_multicast.c | 41 ++++++++++++++++++++++++++++++++++-----
 net/bridge/br_private.h   | 38 ++++++++----------------------------
 4 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ee01122f466f..1ac363826b4c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -102,7 +102,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
+						 mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 1405f1061a54..e79963e3d05f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -187,7 +187,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
+						 mdst)) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb) ||
 			    br->dev->flags & IFF_ALLMULTI) {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 715a0e0aa5ad..4a1005bb68f1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1067,6 +1067,26 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	return skb;
 }
 
+static bool
+__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
+			      struct bridge_mcast_other_query *querier,
+			      bool is_ipv6)
+{
+	bool own_querier_enabled;
+
+	if (brmctx->multicast_querier) {
+		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
+			own_querier_enabled = false;
+		else
+			own_querier_enabled = true;
+	} else {
+		own_querier_enabled = false;
+	}
+
+	return !timer_pending(&querier->delay_timer) &&
+	       (own_querier_enabled || timer_pending(&querier->timer));
+}
+
 static bool br_ip4_multicast_querier_exists(struct net_bridge_mcast *brmctx)
 {
 	return __br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query, false);
@@ -1079,6 +1099,21 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
 }
 #endif
 
+static bool
+br_multicast_querier_exists(struct net_bridge_mcast *brmctx, u16 proto)
+{
+	switch (proto) {
+	case ETH_P_IP:
+		return br_ip4_multicast_querier_exists(brmctx);
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
+		return br_ip6_multicast_querier_exists(brmctx);
+#endif
+	default:
+		return false;
+	}
+}
+
 static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
 					   bool force_inactive)
 {
@@ -5132,7 +5167,6 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
 {
 	struct net_bridge *br;
 	struct net_bridge_port *port;
-	struct ethhdr eth;
 	bool ret = false;
 
 	rcu_read_lock();
@@ -5145,10 +5179,7 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
 
 	br = port->br;
 
-	memset(&eth, 0, sizeof(eth));
-	eth.h_proto = htons(proto);
-
-	ret = br_multicast_querier_exists(&br->multicast_ctx, &eth, NULL);
+	ret = br_multicast_querier_exists(&br->multicast_ctx, proto);
 
 unlock:
 	rcu_read_unlock();
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8150ecc2c919..75684f8079f2 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1159,37 +1159,15 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
 }
 
 static inline bool
-__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-			      struct bridge_mcast_other_query *querier,
-			      const bool is_ipv6)
+br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,
+			     const struct net_bridge_mdb_entry *mdb)
 {
-	bool own_querier_enabled;
-
-	if (brmctx->multicast_querier) {
-		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
-			own_querier_enabled = false;
-		else
-			own_querier_enabled = true;
-	} else {
-		own_querier_enabled = false;
-	}
-
-	return !timer_pending(&querier->delay_timer) &&
-	       (own_querier_enabled || timer_pending(&querier->timer));
-}
-
-static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-					       struct ethhdr *eth,
-					       const struct net_bridge_mdb_entry *mdb)
-{
-	switch (eth->h_proto) {
+	switch (eth_proto) {
 	case (htons(ETH_P_IP)):
-		return __br_multicast_querier_exists(brmctx,
-			&brmctx->ip4_other_query, false);
+		return READ_ONCE(brmctx->ip4_active);
 #if IS_ENABLED(CONFIG_IPV6)
 	case (htons(ETH_P_IPV6)):
-		return __br_multicast_querier_exists(brmctx,
-			&brmctx->ip6_other_query, true);
+		return READ_ONCE(brmctx->ip6_active);
 #endif
 	default:
 		return !!mdb && br_group_is_l2(&mdb->addr);
@@ -1448,9 +1426,9 @@ static inline bool br_multicast_is_router(struct net_bridge_mcast *brmctx,
 	return false;
 }
 
-static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-					       struct ethhdr *eth,
-					       const struct net_bridge_mdb_entry *mdb)
+static inline bool
+br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,
+			     const struct net_bridge_mdb_entry *mdb)
 {
 	return false;
 }
-- 
2.51.0

