Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3C2EAD1B
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346917; cv=none; b=JNZhxjKZhmLvoqHtpj/i7TIOmponl2r36AVOSED5ZukpCpKj47kf99Vnr62AUT63Qzhkd0XClHrNs6qNgeEu/NUyUW+tlY3OGXZlsc75P8mBYRpN22Kz6NYbI+05zaOtp8YU+/V5AoNogeacbdoLkVi0SONILrFdkqm3CgimAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346917; c=relaxed/simple;
	bh=frhcBkgkTFKwzX3pWSel+U+buO3DsSct1uWmviR1Bsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTMVhoZupbC+D7AQ3vuTuwKo4ehBlVYMzmz24pA4pEu5nhvq2gg+fpn4AkIP+FpntBl50yQYxfrCEjU+Z5IFG+tdmhOROVzVnn8kqyTf8+PJ1dmw4+p8kgA+s9OFpNsD8juw51I5EdrJX+q142Me+CeAPCIkyFXvZuwSq2oP4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AC6554C9F3;
	Fri,  6 Feb 2026 04:01:51 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 14/14] net: bridge: mcast: add inactive state assertions
Date: Fri,  6 Feb 2026 03:52:20 +0100
Message-ID: <20260206030123.5430-15-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206030123.5430-1-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
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
index 8ad1b8fec3c5..5c6c00776dee 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1418,10 +1418,29 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 	return NULL;
 }
 
+static void br_ip4_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	WARN_ON(br_multicast_snooping_active(brmctx, htons(ETH_P_IP), NULL));
+}
+
+static void br_ip6_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	WARN_ON(br_multicast_snooping_active(brmctx, htons(ETH_P_IPV6), NULL));
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
@@ -1891,9 +1910,7 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 					 struct bridge_mcast_own_query *query,
 					 struct timer_list *timer)
 {
-	spin_lock(&brmctx->br->multicast_lock);
-	if (br_multicast_stopping(brmctx->br, timer) ||
-	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
+	if (br_multicast_ctx_vlan_global_disabled(brmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		goto out;
 
@@ -1904,7 +1921,6 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 	 * if our own querier is disabled, too
 	 */
 	br_multicast_update_active(brmctx);
-	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 static void br_ip4_multicast_querier_expired(struct timer_list *t)
@@ -1912,7 +1928,16 @@ static void br_ip4_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_other_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
+	if (br_multicast_stopping(brmctx->br, t))
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
@@ -1921,7 +1946,16 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_other_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
+	if (br_multicast_stopping(brmctx->br, t))
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
 
@@ -4499,6 +4533,7 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 
 	/* bridge interface is down, set multicast state to inactive */
 	br_multicast_update_active(brmctx);
+	br_multicast_assert_inactive(brmctx);
 }
 
 void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
-- 
2.51.0

