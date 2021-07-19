Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aa9EkDLLjEgvNaQ45dS4vjblrco25Edm0gQrhh+rucs=;
 b=s/J9OFUiMDUavPy3lbiT2XjQCbhSDyUpClVHzKIr8FtCmsNIASHLNE7DVNv2Hdxzco
 A3Ydvyk9ubkrCHLCw7rXAiGMJ+iY4IBwtNNik5Df6Fij6xb9IbtS5bn1dy8zHeF7INpr
 x9sfT0do+WONHhnXg6Z5stftCKRpNtmjzUiRAoluGZYAJk0seVacWo5iz0qmNUEZOXxb
 i6sIm27wp/T/yPi+tGzykiIVMGSKcWWum6x3VXy1Fl3Wy+jA0YIvwh9Yd6HoujunDIS0
 TaBneWVPa6tDOabZqmOOfPZHZvq+A3jwVxHASW87s9lMz44mcHme0gkYr5JwchmEwK/B
 d+yQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 19 Jul 2021 20:06:31 +0300
Message-Id: <20210719170637.435541-10-razor@blackwall.org>
In-Reply-To: <20210719170637.435541-1-razor@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 09/15] net: bridge: multicast: check if
	should use vlan mcast ctx
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add helpers which check if the current bridge/port multicast context
should be used (i.e. they're not disabled) and use them for Rx IGMP/MLD
processing, timers and new group addition. It is important for vlans to
disable processing of timer/packet after the multicast_lock is obtained
if the vlan context doesn't have BR_VLFLAG_MCAST_ENABLED. There are two
cases when that flag is missing:
 - if the vlan is getting destroyed it will be removed and timers will
   be stopped
 - if the vlan mcast snooping is being disabled

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 59 +++++++++++++++++++++++++++++----------
 net/bridge/br_private.h   | 18 ++++++++++++
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e61e23c0ce17..4620946ec7d7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -147,7 +147,8 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
 	struct net_bridge *br = brmctx->br;
 	struct br_ip ip;
 
-	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED) ||
+	    br_multicast_ctx_vlan_global_disabled(brmctx))
 		return NULL;
 
 	if (BR_INPUT_SKB_CB(skb)->igmp)
@@ -230,6 +231,24 @@ br_multicast_pg_to_port_ctx(const struct net_bridge_port_group *pg)
 	return pmctx;
 }
 
+/* when snooping we need to check if the contexts should be used
+ * in the following order:
+ * - if pmctx is non-NULL (port), check if it should be used
+ * - if pmctx is NULL (bridge), check if brmctx should be used
+ */
+static bool
+br_multicast_ctx_should_use(const struct net_bridge_mcast *brmctx,
+			    const struct net_bridge_mcast_port *pmctx)
+{
+	if (!netif_running(brmctx->br->dev))
+		return false;
+
+	if (pmctx)
+		return !br_multicast_port_ctx_state_disabled(pmctx);
+	else
+		return !br_multicast_ctx_vlan_disabled(brmctx);
+}
+
 static bool br_port_group_equal(struct net_bridge_port_group *p,
 				struct net_bridge_port *port,
 				const unsigned char *src)
@@ -1311,8 +1330,7 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 	struct net_bridge_mdb_entry *mp;
 	unsigned long now = jiffies;
 
-	if (!netif_running(brmctx->br->dev) ||
-	    (pmctx && pmctx->port->state == BR_STATE_DISABLED))
+	if (!br_multicast_ctx_should_use(brmctx, pmctx))
 		goto out;
 
 	mp = br_multicast_new_group(brmctx->br, group);
@@ -1532,6 +1550,7 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 {
 	spin_lock(&brmctx->br->multicast_lock);
 	if (!netif_running(brmctx->br->dev) ||
+	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		goto out;
 
@@ -1619,7 +1638,7 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	struct br_ip br_group;
 	unsigned long time;
 
-	if (!netif_running(brmctx->br->dev) ||
+	if (!br_multicast_ctx_should_use(brmctx, pmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_QUERIER))
 		return;
@@ -1655,16 +1674,16 @@ br_multicast_port_query_expired(struct net_bridge_mcast_port *pmctx,
 				struct bridge_mcast_own_query *query)
 {
 	struct net_bridge *br = pmctx->port->br;
+	struct net_bridge_mcast *brmctx;
 
 	spin_lock(&br->multicast_lock);
-	if (pmctx->port->state == BR_STATE_DISABLED ||
-	    pmctx->port->state == BR_STATE_BLOCKING)
+	if (br_multicast_port_ctx_state_stopped(pmctx))
 		goto out;
-
-	if (query->startup_sent < br->multicast_ctx.multicast_startup_query_count)
+	brmctx = br_multicast_port_ctx_get_global(pmctx);
+	if (query->startup_sent < brmctx->multicast_startup_query_count)
 		query->startup_sent++;
 
-	br_multicast_send_query(&br->multicast_ctx, pmctx, query);
+	br_multicast_send_query(brmctx, pmctx, query);
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -2582,6 +2601,9 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge_mcast *brmctx,
 			continue;
 
 		spin_lock_bh(&brmctx->br->multicast_lock);
+		if (!br_multicast_ctx_should_use(brmctx, pmctx))
+			goto unlock_continue;
+
 		mdst = br_mdb_ip4_get(brmctx->br, group, vid);
 		if (!mdst)
 			goto unlock_continue;
@@ -2717,6 +2739,9 @@ static int br_ip6_multicast_mld2_report(struct net_bridge_mcast *brmctx,
 			continue;
 
 		spin_lock_bh(&brmctx->br->multicast_lock);
+		if (!br_multicast_ctx_should_use(brmctx, pmctx))
+			goto unlock_continue;
+
 		mdst = br_mdb_ip6_get(brmctx->br, &grec->grec_mca, vid);
 		if (!mdst)
 			goto unlock_continue;
@@ -2962,6 +2987,9 @@ static void br_multicast_mark_router(struct net_bridge_mcast *brmctx,
 {
 	unsigned long now = jiffies;
 
+	if (!br_multicast_ctx_should_use(brmctx, pmctx))
+		return;
+
 	if (!pmctx) {
 		if (brmctx->multicast_router == MDB_RTR_TYPE_TEMP_QUERY) {
 			if (!br_ip4_multicast_is_router(brmctx) &&
@@ -3060,8 +3088,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 	__be32 group;
 
 	spin_lock(&brmctx->br->multicast_lock);
-	if (!netif_running(brmctx->br->dev) ||
-	    (pmctx && pmctx->port->state == BR_STATE_DISABLED))
+	if (!br_multicast_ctx_should_use(brmctx, pmctx))
 		goto out;
 
 	group = ih->group;
@@ -3144,8 +3171,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 	int err = 0;
 
 	spin_lock(&brmctx->br->multicast_lock);
-	if (!netif_running(brmctx->br->dev) ||
-	    (pmctx && pmctx->port->state == BR_STATE_DISABLED))
+	if (!br_multicast_ctx_should_use(brmctx, pmctx))
 		goto out;
 
 	if (transport_len == sizeof(*mld)) {
@@ -3229,8 +3255,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 	unsigned long time;
 
 	spin_lock(&brmctx->br->multicast_lock);
-	if (!netif_running(brmctx->br->dev) ||
-	    (pmctx && pmctx->port->state == BR_STATE_DISABLED))
+	if (!br_multicast_ctx_should_use(brmctx, pmctx))
 		goto out;
 
 	mp = br_mdb_ip_get(brmctx->br, group);
@@ -3609,11 +3634,15 @@ static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
 				       struct bridge_mcast_querier *querier)
 {
 	spin_lock(&brmctx->br->multicast_lock);
+	if (br_multicast_ctx_vlan_disabled(brmctx))
+		goto out;
+
 	if (query->startup_sent < brmctx->multicast_startup_query_count)
 		query->startup_sent++;
 
 	RCU_INIT_POINTER(querier->port, NULL);
 	br_multicast_send_query(brmctx, NULL, query);
+out:
 	spin_unlock(&brmctx->br->multicast_lock);
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a643f6bf759f..00b93fcc7870 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1126,6 +1126,24 @@ br_multicast_port_ctx_vlan_disabled(const struct net_bridge_mcast_port *pmctx)
 	return br_multicast_port_ctx_is_vlan(pmctx) &&
 	       !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED);
 }
+
+static inline bool
+br_multicast_port_ctx_state_disabled(const struct net_bridge_mcast_port *pmctx)
+{
+	return pmctx->port->state == BR_STATE_DISABLED ||
+	       (br_multicast_port_ctx_is_vlan(pmctx) &&
+		(br_multicast_port_ctx_vlan_disabled(pmctx) ||
+		 pmctx->vlan->state == BR_STATE_DISABLED));
+}
+
+static inline bool
+br_multicast_port_ctx_state_stopped(const struct net_bridge_mcast_port *pmctx)
+{
+	return br_multicast_port_ctx_state_disabled(pmctx) ||
+	       pmctx->port->state == BR_STATE_BLOCKING ||
+	       (br_multicast_port_ctx_is_vlan(pmctx) &&
+		pmctx->vlan->state == BR_STATE_BLOCKING);
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
-- 
2.31.1

