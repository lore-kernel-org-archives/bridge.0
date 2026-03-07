Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2633C52F
	for <bridge@lists.linux.dev>; Sat,  7 Mar 2026 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858776; cv=none; b=oicXCNtXuNB+v8ueOQNA3fIvJAQc/N7PX8TapGMmJgu+es6I5MrB0+7jbpHw2dkWa2dOrvYodn2S5WF/xw7oBKV7dr58NeyqoT9SzAS+4Bp3n3smbI4tdHtvfhuOcMg+cBl5lmTeCva9NuV1Kss20RQz0LNJYP0gnGQIU81ITOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858776; c=relaxed/simple;
	bh=BqcMT4Y91PQ7i2yERyfXLRZwXIdnTvjRM1ZWv8tlGQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0JCBFtla3aDRSRnY1ETP9neXJFm1jshiqAgmCjwdXDIOEW/i1YfQd0HhTx2dbm/L7wBQ6HwwDuBGZZo3lF3GGwCN/YL6diYm5S/FewdWDMD18aLyZUYolXNZ2X3mj9hc/wVuh0pY0JgFLY5K8GS4/h3En9WeCHDdz5BBKxrMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 083C054CE9A;
	Sat,  7 Mar 2026 05:46:04 +0100 (CET)
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
Subject: [PATCH net-next v4 03/14] net: bridge: mcast: avoid sleeping on bridge-down
Date: Sat,  7 Mar 2026 05:45:37 +0100
Message-ID: <20260307044548.5230-4-linus.luessing@c0d3.blue>
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

We later want to use the multicast lock when setting the bridge
interface up or down, to be able to atomically both check all conditions
to toggle the multicast active state and to subsequently toggle it.
While most variables we check / contexts we check from are serialized
(toggled variables through netlink/sysfs) the timer_pending() check is
not and might run in parallel.

However so far we are not allowed to spinlock __br_multicast_stop() as
its call to timer_delete_sync() might sleep. Therefore replacing the
sleeping variant with the non-sleeping timer_shutdown(). It is sufficient
to only wait for any timer callback to finish when we are freeing the
multicast context.

While the disadvantage of using a non-syncing variant might lead us to
race and still execute its timer callback just after timer_shutdown() was
called timer_shutdown() also has the following additional advantage(s):
It for one thing clears the callback function pointer and by that avoids
rearming. For another a missing function pointer allows us to detect
early in the timer callback if we, this timer, were just canceled.

In other words, this also allows us to make sure that once
timer_shutdown() was called while we do potentially enter its timer
callback briefly we never run the main task of this timer. Similar to
what a timer_delete_sync() would have avoided, too. Except we are not
waiting/sleeping/syncing in br_multicast_stop() but instead (in rare cases)
briefly busy-wait/sync a bit later when grabbing the multicast spinlock
in the timer callback.

This new check also makes the netif_running() check redundant/obsolete
in these contexts.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 146 ++++++++++++++++++++++++++++----------
 net/bridge/br_private.h   |   5 ++
 2 files changed, 113 insertions(+), 38 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..cfe8d42f0214 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1663,6 +1663,14 @@ static void br_multicast_router_expired(struct net_bridge_mcast_port *pmctx,
 	spin_unlock(&br->multicast_lock);
 }
 
+static bool br_multicast_is_stopping(const struct net_bridge *br,
+				     const struct timer_list *timer)
+{
+	lockdep_assert_held_once(&br->multicast_lock);
+
+	return !timer->function;
+}
+
 static void br_ip4_multicast_router_expired(struct timer_list *t)
 {
 	struct net_bridge_mcast_port *pmctx = timer_container_of(pmctx, t,
@@ -1698,7 +1706,8 @@ static void br_multicast_local_router_expired(struct net_bridge_mcast *brmctx,
 					      struct timer_list *timer)
 {
 	spin_lock(&brmctx->br->multicast_lock);
-	if (brmctx->multicast_router == MDB_RTR_TYPE_DISABLED ||
+	if (br_multicast_is_stopping(brmctx->br, timer) ||
+	    brmctx->multicast_router == MDB_RTR_TYPE_DISABLED ||
 	    brmctx->multicast_router == MDB_RTR_TYPE_PERM ||
 	    br_ip4_multicast_is_router(brmctx) ||
 	    br_ip6_multicast_is_router(brmctx))
@@ -1728,10 +1737,11 @@ static void br_ip6_multicast_local_router_expired(struct timer_list *t)
 #endif
 
 static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
-					 struct bridge_mcast_own_query *query)
+					 struct bridge_mcast_own_query *query,
+					 struct timer_list *timer)
 {
 	spin_lock(&brmctx->br->multicast_lock);
-	if (!netif_running(brmctx->br->dev) ||
+	if (br_multicast_is_stopping(brmctx->br, timer) ||
 	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		goto out;
@@ -1747,7 +1757,7 @@ static void br_ip4_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_other_query.timer);
 
-	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query);
+	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query, t);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1756,7 +1766,7 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_other_query.timer);
 
-	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query);
+	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query, t);
 }
 #endif
 
@@ -4040,10 +4050,12 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 }
 
 static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
-				       struct bridge_mcast_own_query *query)
+				       struct bridge_mcast_own_query *query,
+				       struct timer_list *timer)
 {
 	spin_lock(&brmctx->br->multicast_lock);
-	if (br_multicast_ctx_vlan_disabled(brmctx))
+	if (br_multicast_is_stopping(brmctx->br, timer) ||
+	    br_multicast_ctx_vlan_disabled(brmctx))
 		goto out;
 
 	if (query->startup_sent < brmctx->multicast_startup_query_count)
@@ -4059,7 +4071,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
+	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query, t);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4068,7 +4080,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
+	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query, t);
 }
 #endif
 
@@ -4111,29 +4123,40 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
-	timer_setup(&brmctx->ip4_mc_router_timer,
-		    br_ip4_multicast_local_router_expired, 0);
-	timer_setup(&brmctx->ip4_other_query.timer,
-		    br_ip4_multicast_querier_expired, 0);
-	timer_setup(&brmctx->ip4_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
-	timer_setup(&brmctx->ip4_own_query.timer,
-		    br_ip4_multicast_query_expired, 0);
+	timer_setup(&brmctx->ip4_mc_router_timer, NULL, 0);
+	timer_setup(&brmctx->ip4_other_query.timer, NULL, 0);
+	timer_setup(&brmctx->ip4_other_query.delay_timer, NULL, 0);
+	timer_setup(&brmctx->ip4_own_query.timer, NULL, 0);
 #if IS_ENABLED(CONFIG_IPV6)
-	timer_setup(&brmctx->ip6_mc_router_timer,
-		    br_ip6_multicast_local_router_expired, 0);
-	timer_setup(&brmctx->ip6_other_query.timer,
-		    br_ip6_multicast_querier_expired, 0);
-	timer_setup(&brmctx->ip6_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
-	timer_setup(&brmctx->ip6_own_query.timer,
-		    br_ip6_multicast_query_expired, 0);
+	timer_setup(&brmctx->ip6_mc_router_timer, NULL, 0);
+	timer_setup(&brmctx->ip6_other_query.timer, NULL, 0);
+	timer_setup(&brmctx->ip6_other_query.delay_timer, NULL, 0);
+	timer_setup(&brmctx->ip6_own_query.timer, NULL, 0);
 #endif
+
+	/* for non-vlan multicast timer callbacks:
+	 * they are set on br_multicast_open() instead
+	 */
+	if (!vlan)
+		return;
+
+	spin_lock_bh(&br->multicast_lock);
+	br_multicast_reset_timer_cbs(&vlan->br_mcast_ctx);
+	spin_unlock_bh(&br->multicast_lock);
 }
 
 void br_multicast_ctx_deinit(struct net_bridge_mcast *brmctx)
 {
-	__br_multicast_stop(brmctx);
+	timer_shutdown_sync(&brmctx->ip4_mc_router_timer);
+	timer_shutdown_sync(&brmctx->ip4_other_query.timer);
+	timer_shutdown_sync(&brmctx->ip4_other_query.delay_timer);
+	timer_shutdown_sync(&brmctx->ip4_own_query.timer);
+#if IS_ENABLED(CONFIG_IPV6)
+	timer_shutdown_sync(&brmctx->ip6_mc_router_timer);
+	timer_shutdown_sync(&brmctx->ip6_other_query.timer);
+	timer_shutdown_sync(&brmctx->ip6_other_query.delay_timer);
+	timer_shutdown_sync(&brmctx->ip6_own_query.timer);
+#endif
 }
 
 void br_multicast_init(struct net_bridge *br)
@@ -4213,9 +4236,35 @@ void br_multicast_leave_snoopers(struct net_bridge *br)
 	br_ip6_multicast_leave_snoopers(br);
 }
 
+void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
+{
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	brmctx->ip4_mc_router_timer.function =
+		br_ip4_multicast_local_router_expired;
+	brmctx->ip4_other_query.timer.function =
+		br_ip4_multicast_querier_expired;
+	brmctx->ip4_other_query.delay_timer.function =
+		br_multicast_query_delay_expired;
+	brmctx->ip4_own_query.timer.function =
+		br_ip4_multicast_query_expired;
+#if IS_ENABLED(CONFIG_IPV6)
+	brmctx->ip6_mc_router_timer.function =
+		br_ip6_multicast_local_router_expired;
+	brmctx->ip6_other_query.timer.function =
+		br_ip6_multicast_querier_expired;
+	brmctx->ip6_other_query.delay_timer.function =
+		br_multicast_query_delay_expired;
+	brmctx->ip6_own_query.timer.function =
+		br_ip6_multicast_query_expired;
+#endif
+}
+
 static void __br_multicast_open_query(struct net_bridge *br,
 				      struct bridge_mcast_own_query *query)
 {
+	lockdep_assert_held_once(&br->multicast_lock);
+
 	query->startup_sent = 0;
 
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
@@ -4226,13 +4275,15 @@ static void __br_multicast_open_query(struct net_bridge *br,
 
 static void __br_multicast_open(struct net_bridge_mcast *brmctx)
 {
+	br_multicast_reset_timer_cbs(brmctx);
+
 	__br_multicast_open_query(brmctx->br, &brmctx->ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
 #endif
 }
 
-void br_multicast_open(struct net_bridge *br)
+static void br_multicast_open_locked(struct net_bridge *br)
 {
 	ASSERT_RTNL();
 
@@ -4256,17 +4307,26 @@ void br_multicast_open(struct net_bridge *br)
 	}
 }
 
+void br_multicast_open(struct net_bridge *br)
+{
+	spin_lock_bh(&br->multicast_lock);
+	br_multicast_open_locked(br);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 {
-	timer_delete_sync(&brmctx->ip4_mc_router_timer);
-	timer_delete_sync(&brmctx->ip4_other_query.timer);
-	timer_delete_sync(&brmctx->ip4_other_query.delay_timer);
-	timer_delete_sync(&brmctx->ip4_own_query.timer);
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	timer_shutdown(&brmctx->ip4_mc_router_timer);
+	timer_shutdown(&brmctx->ip4_other_query.timer);
+	timer_shutdown(&brmctx->ip4_other_query.delay_timer);
+	timer_shutdown(&brmctx->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
-	timer_delete_sync(&brmctx->ip6_mc_router_timer);
-	timer_delete_sync(&brmctx->ip6_other_query.timer);
-	timer_delete_sync(&brmctx->ip6_other_query.delay_timer);
-	timer_delete_sync(&brmctx->ip6_own_query.timer);
+	timer_shutdown(&brmctx->ip6_mc_router_timer);
+	timer_shutdown(&brmctx->ip6_other_query.timer);
+	timer_shutdown(&brmctx->ip6_other_query.delay_timer);
+	timer_shutdown(&brmctx->ip6_own_query.timer);
 #endif
 }
 
@@ -4317,12 +4377,12 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		spin_lock_bh(&br->multicast_lock);
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
-		spin_unlock_bh(&br->multicast_lock);
 
 		if (on)
 			__br_multicast_open(&vlan->br_mcast_ctx);
 		else
 			__br_multicast_stop(&vlan->br_mcast_ctx);
+		spin_unlock_bh(&br->multicast_lock);
 	} else {
 		struct net_bridge_mcast *brmctx;
 
@@ -4380,6 +4440,7 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 	if (!vg)
 		return 0;
 
+	spin_lock_bh(&br->multicast_lock);
 	br_opt_toggle(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED, on);
 
 	/* disable/enable non-vlan mcast contexts based on vlan snooping */
@@ -4387,6 +4448,8 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_stop(&br->multicast_ctx);
 	else
 		__br_multicast_open(&br->multicast_ctx);
+	spin_unlock_bh(&br->multicast_lock);
+
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
 			br_multicast_disable_port_ctx(&p->multicast_ctx);
@@ -4416,7 +4479,7 @@ bool br_multicast_toggle_global_vlan(struct net_bridge_vlan *vlan, bool on)
 	return true;
 }
 
-void br_multicast_stop(struct net_bridge *br)
+static void br_multicast_stop_locked(struct net_bridge *br)
 {
 	ASSERT_RTNL();
 
@@ -4440,6 +4503,13 @@ void br_multicast_stop(struct net_bridge *br)
 	}
 }
 
+void br_multicast_stop(struct net_bridge *br)
+{
+	spin_lock_bh(&br->multicast_lock);
+	br_multicast_stop_locked(br);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
 void br_multicast_dev_del(struct net_bridge *br)
 {
 	struct net_bridge_mdb_entry *mp;
@@ -4675,7 +4745,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	if (!netif_running(br->dev))
 		goto unlock;
 
-	br_multicast_open(br);
+	br_multicast_open_locked(br);
 	list_for_each_entry(port, &br->port_list, list)
 		__br_multicast_enable_port_ctx(&port->multicast_ctx);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 545be319b6cb..af206a41555c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -976,6 +976,7 @@ void br_multicast_disable_port(struct net_bridge_port *port);
 void br_multicast_init(struct net_bridge *br);
 void br_multicast_join_snoopers(struct net_bridge *br);
 void br_multicast_leave_snoopers(struct net_bridge *br);
+void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx);
 void br_multicast_open(struct net_bridge *br);
 void br_multicast_stop(struct net_bridge *br);
 void br_multicast_dev_del(struct net_bridge *br);
@@ -1426,6 +1427,10 @@ static inline void br_multicast_leave_snoopers(struct net_bridge *br)
 {
 }
 
+static inline void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
+{
+}
+
 static inline void br_multicast_open(struct net_bridge *br)
 {
 }
-- 
2.53.0

