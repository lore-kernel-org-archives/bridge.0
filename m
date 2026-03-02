Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33942350D74
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430070; cv=none; b=PlB5292XUlymLwzNaEWAymA0LpXbm0HrO3lU8iTWlr+mFYZOHsAeJtvGXuDQXhknjH2V/K3CXbl1VEqlt0KgagY5LSlK60bKs4ynICpVXDYGCkNV8Q6azgqcKw1kLjGLCHHNuqQ43VaZkL3MgA70yjDHdKjsSnt/liqIFJY/SPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430070; c=relaxed/simple;
	bh=ckJkKdCtJpGg8xp1DRlDCVvsAYTBhMh/XF5zBhQcRI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9Ib1r2GsuQCVl94LS6WWpgwIVUJ98bEMXLfZqUFxbIIDNKW91PXNiJQoPdE2LtXE8w9rboFoBzvYoiBs3Yb/+O5T+yWgbwskFGUVsiCHBUr1W3DjeCePr7plHBOsU2qw7/lqFWm2MIX5xZ8lMXgTjMtqZuZ153um2JquTz2Pus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FA9954CC65;
	Mon,  2 Mar 2026 06:40:59 +0100 (CET)
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
Subject: [PATCH net-next v3 14/14] net: bridge: mcast: add inactive state assertions
Date: Mon,  2 Mar 2026 06:40:08 +0100
Message-ID: <20260302054008.21638-15-linus.luessing@c0d3.blue>
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

To avoid packetloss and as it is very hard from a user's perspective to
debug multicast snooping related issues it is even more crucial to properly
switch from an active to an inactive multicast snooping state than the
other way around.

Therefore adding a few kernel warnings if any of our assertions to be in
an inactive state would fail.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 43 +++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4a1005bb68f1..106d6dd78328 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1421,10 +1421,29 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 	return NULL;
 }
 
+static void br_ip4_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	WARN_ON_ONCE(br_multicast_snooping_active(brmctx, htons(ETH_P_IP), NULL));
+}
+
+static void br_ip6_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	WARN_ON_ONCE(br_multicast_snooping_active(brmctx, htons(ETH_P_IPV6), NULL));
+}
+
+static void br_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	br_ip4_multicast_assert_inactive(brmctx);
+	br_ip6_multicast_assert_inactive(brmctx);
+}
+
 static void br_multicast_toggle_enabled(struct net_bridge *br, bool on)
 {
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, on);
 	br_multicast_update_active(&br->multicast_ctx);
+
+	if (!on)
+		br_multicast_assert_inactive(&br->multicast_ctx);
 }
 
 struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
@@ -1894,9 +1913,7 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 					 struct bridge_mcast_own_query *query,
 					 struct timer_list *timer)
 {
-	spin_lock(&brmctx->br->multicast_lock);
-	if (br_multicast_is_stopping(brmctx->br, timer) ||
-	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
+	if (br_multicast_ctx_vlan_global_disabled(brmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		goto out;
 
@@ -1907,7 +1924,6 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 	 * if our own querier is disabled, too
 	 */
 	br_multicast_update_active(brmctx);
-	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 static void br_ip4_multicast_querier_expired(struct timer_list *t)
@@ -1915,7 +1931,16 @@ static void br_ip4_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_other_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
+	if (br_multicast_is_stopping(brmctx->br, t))
+		goto out;
+
 	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query, t);
+
+	if (!brmctx->multicast_querier)
+		br_ip4_multicast_assert_inactive(brmctx);
+out:
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1924,7 +1949,16 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_other_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
+	if (br_multicast_is_stopping(brmctx->br, t))
+		goto out;
+
 	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query, t);
+
+	if (!brmctx->multicast_querier)
+		br_ip6_multicast_assert_inactive(brmctx);
+out:
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 #endif
 
@@ -4502,6 +4536,7 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 
 	/* bridge interface is down, set multicast state to inactive */
 	br_multicast_update_active(brmctx);
+	br_multicast_assert_inactive(brmctx);
 }
 
 void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
-- 
2.51.0

