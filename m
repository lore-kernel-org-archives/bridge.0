Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641934D917
	for <bridge@lists.linux.dev>; Sat,  7 Mar 2026 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858779; cv=none; b=vCjrezaW0qgRVVOGFNjBGdgrT5IHgfa2Ea203yQjTbP+m8TQ3xBYOiSKa0JNUOvurd91RyEU3MnucYHTG7OIoadziAtv3dc5lL/KmbbQyC3vHn2P44jLrvCqyu1db9wGT4BTC6RjnTrSsfz2WiDi/CpN8/wJJ2UVL3g7/fuOA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858779; c=relaxed/simple;
	bh=aYI6noFunMVNidkq3fDpollILn8CuOzlAMZ2XG27agk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+ryl41RliNl38LKwXccsbyctdSyQLbABNbCBoSOx/26S5hMYz9FXK/oDot5dBuNqCg+7d5L/KgCVUBn88XY+NS92jR9wfgTRjZvLp+9ijFByaEUUQLhp7EXnIAJeTnKrLpv2fVkgD+hYZyt6yhhnyI/U14ExtVCE+BlTZqNypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42CA054CDF2;
	Sat,  7 Mar 2026 05:46:14 +0100 (CET)
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
	petrm@nvidia.com,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v4 10/14] net: bridge: mcast: track active state, bridge up/down
Date: Sat,  7 Mar 2026 05:45:44 +0100
Message-ID: <20260307044548.5230-11-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260307044548.5230-1-linus.luessing@c0d3.blue>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This is mainly for switchdev and DSA later: To ensure that we switch
to inactive before destroying a bridge interface. A switchdev/DSA driver
might have allocated resources after we switched to an enabled multicast
active state. This gives switchdev/DSA drivers a chance to free these
resources again when we destroy the bridge (later).

Putting it into the ndo_stop / bridge interface down part instead of the
ndo_uninit / bridge destroy part though for a better semantic match. If
the bridge interface is down / stopped then it is also inactive.

No functional change for the fast/data path.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_link.h |  8 ++++----
 net/bridge/br_multicast.c    | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d963be8679b5..679368784643 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -748,14 +748,14 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_MCAST_ACTIVE_V4
  *   Bridge IPv4 mcast active state, read only.
  *
- *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an IGMP querier is present,
- *   0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled, an IGMP querier is present
+ *   and the bridge interface is up, 0 otherwise.
  *
  * @IFLA_BR_MCAST_ACTIVE_V6
  *   Bridge IPv6 mcast active state, read only.
  *
- *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an MLD querier is present,
- *   0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled, an MLD querier is present
+ *   and the bridge interface is up, 0 otherwise.
  */
 enum {
 	IFLA_BR_UNSPEC,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1059984d8147..cb78f9555db6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1124,6 +1124,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - the bridge interface is up
  * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 link-local address is configured on the
@@ -1142,6 +1143,11 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!netif_running(brmctx->br->dev)) {
+		force_inactive = true;
+		goto update;
+	}
+
 	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED)) {
 		force_inactive = true;
 		goto update;
@@ -4431,6 +4437,9 @@ static void __br_multicast_open(struct net_bridge_mcast *brmctx)
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
 #endif
+
+	/* bridge interface is up, maybe set multicast state to active */
+	br_multicast_update_active(brmctx);
 }
 
 static void br_multicast_open_locked(struct net_bridge *br)
@@ -4478,6 +4487,9 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 	timer_shutdown(&brmctx->ip6_other_query.delay_timer);
 	timer_shutdown(&brmctx->ip6_own_query.timer);
 #endif
+
+	/* bridge interface is down, set multicast state to inactive */
+	br_multicast_update_active(brmctx);
 }
 
 void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
-- 
2.53.0

