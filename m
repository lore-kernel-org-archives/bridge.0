Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FA355F4F
	for <bridge@lists.linux.dev>; Sat,  7 Mar 2026 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858780; cv=none; b=Yxgc+p2RLUEg9NNGZ+p2Vt3q+2y9iJS1YjmWsZimqEomU5XYsjH9Bc09Vf24G0NqBX5BEDES7UwZLm0/73vcz5gzMv3YodRCt2FnXzR7aoigrfY8xHJsg1OJAx2bVA3DutZbgo39uCtkKXrfb0w1IIbEQ6xFdIxf7wqGATTtOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858780; c=relaxed/simple;
	bh=qEndSg74IrSsHyC+dBq6x34fpvQkg8HB8RGj8cYl2Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsDo6U6dVMXHZefNfQ1/GWc92br6JTVdhUz4Rm1p/+sg9Nn36NpycAgzwh72QKimOPbiYwaiGCp8XiPnseRCYl2eLZiKIVUSDAHxxyNDud8ts98MG5beWhzAhaHq/NuLfCM6aVCeu7TLJtONqjPakxwmdoj1XAIJTBK2AgaqsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 174B554C936;
	Sat,  7 Mar 2026 05:46:16 +0100 (CET)
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
Subject: [PATCH net-next v4 11/14] net: bridge: mcast: track active state, prepare for outside lock reads
Date: Sat,  7 Mar 2026 05:45:45 +0100
Message-ID: <20260307044548.5230-12-linus.luessing@c0d3.blue>
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

We are updating ip{4,6}_active and check all variables their state relies
on while holding the bridge multicast spinlock. However we are going to
read it without this lock in a follow-up commit on fast/data path, too.

As these variables are only booleans this shouldn't be a problem,
ip{4,6}_active will be loaded and stored atomically. And those
read sides should converge eventually. But to allow tooling to verify
this use the READ_ONCE() and WRITE_ONCE macros.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index cb78f9555db6..6faa484dede7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1085,9 +1085,10 @@ static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
 					   bool force_inactive)
 {
 	if (force_inactive)
-		brmctx->ip4_active = false;
+		WRITE_ONCE(brmctx->ip4_active, false);
 	else
-		brmctx->ip4_active = br_ip4_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip4_active,
+			   br_ip4_multicast_querier_exists(brmctx));
 }
 
 static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
@@ -1095,23 +1096,26 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (force_inactive)
-		brmctx->ip6_active = false;
+		WRITE_ONCE(brmctx->ip6_active, false);
 	else
-		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip6_active,
+			   br_ip6_multicast_querier_exists(brmctx));
 #endif
 }
 
 static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
 				       bool ip4_active_old, bool ip6_active_old)
 {
-	if (brmctx->ip4_active == ip4_active_old &&
-	    brmctx->ip6_active == ip6_active_old)
+	int ip4_active = brmctx->ip4_active;
+	int ip6_active = brmctx->ip6_active;
+
+	if (ip4_active == ip4_active_old &&
+	    ip6_active == ip6_active_old)
 		return;
 
 	br_debug(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
 		 brmctx->vlan ? brmctx->vlan->vid : -1,
-		 ip4_active_old, brmctx->ip4_active,
-		 ip6_active_old, brmctx->ip6_active);
+		 ip4_active_old, ip4_active, ip6_active_old, ip6_active);
 }
 
 /**
@@ -4269,7 +4273,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_membership_interval = 260 * HZ;
 
 	brmctx->ip4_querier.port_ifidx = 0;
-	brmctx->ip4_active = 0;
+	WRITE_ONCE(brmctx->ip4_active, 0);
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4277,7 +4281,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->ip6_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
-	brmctx->ip6_active = 0;
+	WRITE_ONCE(brmctx->ip6_active, 0);
 
 	timer_setup(&brmctx->ip4_mc_router_timer, NULL, 0);
 	timer_setup(&brmctx->ip4_other_query.timer, NULL, 0);
-- 
2.53.0

