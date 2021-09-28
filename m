Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632838284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6yrRrecR/xDa6JwQcSu2PQbU6zn6uCv5AzWCbYYTJ1g=;
 b=EAGUZt1eIqht/TEUWtPuDXMC2lwGRoNRqSm7EiA7Ps97VNiakfpSR9nFuLpInWgitWNREF
 +OWMcKZILLHFM0LHciUDzEnyF9DSX9QVNNcsjwfnOphQgbQIE7kPd/GSgK2NB0D5LeW18c
 EKsttVaB8j1m6jHbEyv5yCLhGApQyiWeNXvZFag4wYqrCu+w4nMy1MAFJL8wkAlmV9AY5K
 QRtKfoMf6qslvAott0VLuYyNRxKwOeMJ5WzuGx8dWSpzqqFQj7EZjN3LytEHxakkVpJTLq
 u/CwFgHCuvFhFgO8jKkJyuluaJv8PssO5BcQYR18wkzjUkdtkzZwvs3IrjLxBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632838284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6yrRrecR/xDa6JwQcSu2PQbU6zn6uCv5AzWCbYYTJ1g=;
 b=Y8vkL4ea/C+M+L8E8P+k+72Rs3rmxK0Dj6Hmzc5DfzWc+Hj+6VBSXL1qKyLc7qjYhrE1Iv
 BqF0EnBXkoUtiwDw==
Date: Tue, 28 Sep 2021 16:10:49 +0200
Message-Id: <20210928141049.593833-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] [PATCH net] net: bridge: mcast: Associate the seqcount
	with its protecting lock.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Mike Galbraith <efault@gmx.de>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>

From: Thomas Gleixner <tglx@linutronix.de>

The sequence count bridge_mcast_querier::seq is protected by
net_bridge::multicast_lock but seqcount_init() does not associate the
seqcount with the lock. This leads to a warning on PREEMPT_RT because
preemption is still enabled.

Let seqcount_init() associate the seqcount with lock that protects the
write section. Remove lockdep_assert_held_once() because lockdep already ch=
ecks
whether the associated lock is held.
=09
Fixes: 67b746f94ff39 ("net: bridge: mcast: make sure querier port/address u=
pdates are consistent")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Mike Galbraith <efault@gmx.de>
---
 net/bridge/br_multicast.c |    6 ++----
 net/bridge/br_private.h   |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1677,8 +1677,6 @@ static void br_multicast_update_querier(
 					int ifindex,
 					struct br_ip *saddr)
 {
-	lockdep_assert_held_once(&brmctx->br->multicast_lock);
-
 	write_seqcount_begin(&querier->seq);
 	querier->port_ifidx =3D ifindex;
 	memcpy(&querier->addr, saddr, sizeof(*saddr));
@@ -3867,13 +3865,13 @@ void br_multicast_ctx_init(struct net_br
=20
 	brmctx->ip4_other_query.delay_time =3D 0;
 	brmctx->ip4_querier.port_ifidx =3D 0;
-	seqcount_init(&brmctx->ip4_querier.seq);
+	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version =3D 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version =3D 1;
 	brmctx->ip6_other_query.delay_time =3D 0;
 	brmctx->ip6_querier.port_ifidx =3D 0;
-	seqcount_init(&brmctx->ip6_querier.seq);
+	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
=20
 	timer_setup(&brmctx->ip4_mc_router_timer,
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -82,7 +82,7 @@ struct bridge_mcast_other_query {
 struct bridge_mcast_querier {
 	struct br_ip addr;
 	int port_ifidx;
-	seqcount_t seq;
+	seqcount_spinlock_t seq;
 };
=20
 /* IGMP/MLD statistics */
