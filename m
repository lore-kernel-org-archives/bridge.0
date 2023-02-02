Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE12C611E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00029611E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upzR7VV2sJ9tAyioqhC27xFIDvYZi0sCsX60QZBE1Go=;
 b=QmN/5ZGWcWQrOje4vIhts5CK7sEfHJafrVzeCjrDiONe+vDScF7q+RAEenkEGMhe8YfiAuBP7ZNeZeCCct+V2D5DT1w56m/XhwXT2C9dtKcPnmylICJ7OewAy/pquCWs5Ol30S1mrSFTjweLBXdnmDtLVc8/SQldqpo+Aic4QYySuubHX8tM9EO/UL8zESYLd7z/XZoSqTM1QL+1acV908GG+nmfNzWXf3XNrD+VIx/IhkAnmNm2y4sZMR/Woy2H7T40VJnaGM7GsQNeBFFlwR2kMz4JBAXPxAqTeEpAAREr5Cz28IunzKlUlj+TcdMV28SkvnTH0ZOvl8uUwmyjAQ==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 2 Feb 2023 18:59:20 +0100
Message-ID: <62e07d61d15a3113ccbd85ef85d0fdd74a87762d.1675359453.git.petrm@nvidia.com>
In-Reply-To: <cover.1675359453.git.petrm@nvidia.com>
References: <cover.1675359453.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 02/16] net: bridge: Add extack to
	br_multicast_new_port_group()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

Make it possible to set an extack in br_multicast_new_port_group().
Eventually, this function will check for per-port and per-port-vlan
MDB maximums, and will use the extack to communicate the reason for
the bounce.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c       | 5 +++--
 net/bridge/br_multicast.c | 5 +++--
 net/bridge/br_private.h   | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 00e5743647b0..069061366541 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -849,7 +849,7 @@ static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					MCAST_INCLUDE, cfg->rt_protocol);
+					MCAST_INCLUDE, cfg->rt_protocol, extack);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (S, G) port group");
 		return -ENOMEM;
@@ -1075,7 +1075,8 @@ static int br_mdb_add_group_star_g(const struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					cfg->filter_mode, cfg->rt_protocol);
+					cfg->filter_mode, cfg->rt_protocol,
+					extack);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (*, G) port group");
 		return -ENOMEM;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index dea1ee1bd095..de67d176838f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1284,7 +1284,8 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 			unsigned char flags,
 			const unsigned char *src,
 			u8 filter_mode,
-			u8 rt_protocol)
+			u8 rt_protocol,
+			struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port_group *p;
 
@@ -1387,7 +1388,7 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 	}
 
 	p = br_multicast_new_port_group(pmctx->port, group, *pp, 0, src,
-					filter_mode, RTPROT_KERNEL);
+					filter_mode, RTPROT_KERNEL, NULL);
 	if (unlikely(!p)) {
 		p = ERR_PTR(-ENOMEM);
 		goto out;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 15ef7fd508ee..1805c468ae03 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -956,7 +956,8 @@ br_multicast_new_port_group(struct net_bridge_port *port,
 			    const struct br_ip *group,
 			    struct net_bridge_port_group __rcu *next,
 			    unsigned char flags, const unsigned char *src,
-			    u8 filter_mode, u8 rt_protocol);
+			    u8 filter_mode, u8 rt_protocol,
+			    struct netlink_ext_ack *extack);
 int br_mdb_hash_init(struct net_bridge *br);
 void br_mdb_hash_fini(struct net_bridge *br);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
-- 
2.39.0

