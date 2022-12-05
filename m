Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7584540918
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8ECBC40905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ETmXry3f+7bWBnHi7TJsQfqt3JBJsRP1p6vLGxiN1E=;
 b=dmS3GNK7EyH+j7/ElNVBl6befusVxEimB/SUfZxBeX1GhAAB50DdqA5nFIhMz0f7jh/Ahm2fb1RzEo/X9AEslDyX/s7KSuENJmlhcykksrKGvtxLM2CN5JT3KDgBWK66Mg/QWXXO/Xs3M40h0f0RELUsj1xt613jQ+WBZ7nvQExrGs+hfI92N2XRRuRrX/RZ9OTYdObWPhmMQeiqALxUVeQKQGKWdWbfLI0Eh3NVRASPu4N3UNLiZwT7m1egVOyJnvg7k0JpNTnYdRy6LghhXOOV4RgOj51EhyowgWkYXf3vqV/Ltf9Cgx7nSi2mCPNqt3wZRFccu3NcGp34Tch53w==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon,  5 Dec 2022 09:42:51 +0200
Message-Id: <20221205074251.4049275-9-idosch@nvidia.com>
In-Reply-To: <20221205074251.4049275-1-idosch@nvidia.com>
References: <20221205074251.4049275-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 8/8] bridge: mcast: Remove redundant
	function arguments
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Drop the first three arguments and instead extract them from the MDB
configuration structure.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index aa5faccf09f8..850a04177c91 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -786,13 +786,14 @@ __br_mdb_choose_context(struct net_bridge *br,
 	return brmctx;
 }
 
-static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
-			    struct br_mdb_entry *entry,
-			    struct br_mdb_config *cfg,
+static int br_mdb_add_group(struct br_mdb_config *cfg,
 			    struct netlink_ext_ack *extack)
 {
 	struct net_bridge_mdb_entry *mp, *star_mp;
 	struct net_bridge_port_group __rcu **pp;
+	struct br_mdb_entry *entry = cfg->entry;
+	struct net_bridge_port *port = cfg->p;
+	struct net_bridge *br = cfg->br;
 	struct net_bridge_port_group *p;
 	struct net_bridge_mcast *brmctx;
 	struct br_ip group = cfg->group;
@@ -879,7 +880,7 @@ static int __br_mdb_add(struct br_mdb_config *cfg,
 	int ret;
 
 	spin_lock_bh(&cfg->br->multicast_lock);
-	ret = br_mdb_add_group(cfg->br, cfg->p, cfg->entry, cfg, extack);
+	ret = br_mdb_add_group(cfg, extack);
 	spin_unlock_bh(&cfg->br->multicast_lock);
 
 	return ret;
-- 
2.37.3

