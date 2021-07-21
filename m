Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LfptcPBAYX0XhZdNHSy9bCep6fygv+/dGc7yUbbpivY=;
 b=tPzfUROJpfPxtn5NDGuRsLr0LgX/7zCT7p3xJLZyn3uh+3WOwUSpPJJ/q1B6jKZ2ih
 vNOUeLRiLOUfVBaUjvw8fMtJDXgDfUyaT+DBst12kTsRkoFioi8BiBH0LSpYkVNBclW1
 ZJ0ZpdbUdv0cSHZHvHgs1C9WJnj4MBWREsneHrPFg4F4bYBxsUnfYg95JXAfrq67nKE1
 Ek/VPnGlT2T5TK6/zUFeT+WZZ2cHqiuNjOFsTtC0vo6Mo5YjywW0Z3UqPV1+SrFBuMHL
 4J6epLZZRO5+PQ/saO9eeQiS2f25Y7EM+ub5LStvSsQnVbGMhySMQFtiev50zRVR8E0h
 YNQA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 21 Jul 2021 17:01:27 +0300
Message-Id: <20210721140127.773194-3-razor@blackwall.org>
In-Reply-To: <20210721140127.773194-1-razor@blackwall.org>
References: <20210721140127.773194-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: multicast: add context
	support for host-joined groups
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

Adding bridge multicast context support for host-joined groups is easy
because we only need the proper timer value. We pass the already chosen
context and use its timer value.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_mdb.c       | 2 +-
 net/bridge/br_multicast.c | 8 ++++----
 net/bridge/br_private.h   | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7b6c3b91d272..25d690b96cec 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1105,7 +1105,7 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 			return -EEXIST;
 		}
 
-		br_multicast_host_join(mp, false);
+		br_multicast_host_join(brmctx, mp, false);
 		br_mdb_notify(br->dev, mp, NULL, RTM_NEWMDB);
 
 		return 0;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 214d1bf854ad..470f1ec3b579 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1312,7 +1312,8 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	return p;
 }
 
-void br_multicast_host_join(struct net_bridge_mdb_entry *mp, bool notify)
+void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
+			    struct net_bridge_mdb_entry *mp, bool notify)
 {
 	if (!mp->host_joined) {
 		mp->host_joined = true;
@@ -1325,8 +1326,7 @@ void br_multicast_host_join(struct net_bridge_mdb_entry *mp, bool notify)
 	if (br_group_is_l2(&mp->addr))
 		return;
 
-	mod_timer(&mp->timer,
-		  jiffies + mp->br->multicast_ctx.multicast_membership_interval);
+	mod_timer(&mp->timer, jiffies + brmctx->multicast_membership_interval);
 }
 
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify)
@@ -1363,7 +1363,7 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 		return ERR_CAST(mp);
 
 	if (!pmctx) {
-		br_multicast_host_join(mp, true);
+		br_multicast_host_join(brmctx, mp, true);
 		goto out;
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index af1f5c1c6b88..30fb56637049 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -900,7 +900,8 @@ void br_multicast_get_stats(const struct net_bridge *br,
 			    struct br_mcast_stats *dest);
 void br_mdb_init(void);
 void br_mdb_uninit(void);
-void br_multicast_host_join(struct net_bridge_mdb_entry *mp, bool notify);
+void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
+			    struct net_bridge_mdb_entry *mp, bool notify);
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify);
 void br_multicast_star_g_handle_mode(struct net_bridge_port_group *pg,
 				     u8 filter_mode);
-- 
2.31.1

