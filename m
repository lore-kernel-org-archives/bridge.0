Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD02C375E
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346913; cv=none; b=oNK3jfZic+CfhH1XlMy0r4OI+fGk+CEzJqyajMyy9mhfXa3+YQrYC+/BDD5CjXbVtrpxzqfJlILB7u+TFSoNic1Ilqwlyp/awUmZCX5KDzw9kv6l19mUS/dJkJdOp60mGqe1Jv6K8y0i4aLSrDw6QCWnaG2gx8JvY+HzQ/qyMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346913; c=relaxed/simple;
	bh=4fl1V0CGDvMUNrGqV03Fu0NDWvm5RDAtj7uzXrw/22U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZGYaRSUOf3voH9n5Yjo82JbGyBjS9UW2ltA8hOnC+qg4nxgFYmWu6CDzrYj3vTLysSbh2LPPRHBe8Wy9k+1uDz4eGkP2HJ4wa0xHssj4k3pp4zNeN92tOnD60whsxnkbl4PSt3tCQMvXX2TX1m7EuWBraEBTL1KpTMS0uUDvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 170B054CD2B;
	Fri,  6 Feb 2026 04:01:48 +0100 (CET)
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
Subject: [PATCH net-next v2 11/14] net: bridge: mcast: track active state, prepare for outside lock reads
Date: Fri,  6 Feb 2026 03:52:17 +0100
Message-ID: <20260206030123.5430-12-linus.luessing@c0d3.blue>
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

We are updating ip{4,6}_active and check all variables their state relies
on while holding the bridge multicast spinlock. However we are going to
read it without this lock in a follow-up commit on fast/data path, too.

As these variables are only booleans this shouldn't be a problem,
ip{4,6}_active will be loaded and stored atomically. And those
read sides should converge eventually. But to allow tooling to verify
this use the READ_ONCE() and WRITE_ONCE macros.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 7a32c6bed111..48552720bcea 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1085,9 +1085,9 @@ static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
 					   bool force_inactive)
 {
 	if (force_inactive)
-		brmctx->ip4_active = false;
+		WRITE_ONCE(brmctx->ip4_active, false);
 	else
-		brmctx->ip4_active = br_ip4_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip4_active, br_ip4_multicast_querier_exists(brmctx));
 }
 
 static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
@@ -1095,23 +1095,25 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (force_inactive)
-		brmctx->ip6_active = false;
+		WRITE_ONCE(brmctx->ip6_active, false);
 	else
-		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip6_active, br_ip6_multicast_querier_exists(brmctx));
 #endif
 }
 
 static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
 				       bool ip4_active_old, bool ip6_active_old)
 {
-	if (brmctx->ip4_active == ip4_active_old &&
-	    brmctx->ip6_active == ip6_active_old)
+	int ip4_active = READ_ONCE(brmctx->ip4_active);
+	int ip6_active = READ_ONCE(brmctx->ip6_active);
+
+	if (ip4_active == ip4_active_old &&
+	    ip6_active == ip6_active_old)
 		return;
 
 	br_info(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
 		brmctx->vlan ? brmctx->vlan->vid : -1,
-		ip4_active_old, brmctx->ip4_active,
-		ip6_active_old, brmctx->ip6_active);
+		ip4_active_old, ip4_active, ip6_active_old, ip6_active);
 }
 
 /**
@@ -1136,7 +1138,8 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  */
 static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 {
-	bool ip4_active_old = brmctx->ip4_active, ip6_active_old = brmctx->ip6_active;
+	bool ip4_active_old = READ_ONCE(brmctx->ip4_active);
+	bool ip6_active_old = READ_ONCE(brmctx->ip6_active);
 	bool force_inactive = false;
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
@@ -4266,13 +4269,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_membership_interval = 260 * HZ;
 
 	brmctx->ip4_querier.port_ifidx = 0;
-	brmctx->ip4_active = 0;
+	WRITE_ONCE(brmctx->ip4_active, 0);
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
 	brmctx->ip6_querier.port_ifidx = 0;
-	brmctx->ip6_active = 0;
+	WRITE_ONCE(brmctx->ip6_active, 0);
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
-- 
2.51.0

