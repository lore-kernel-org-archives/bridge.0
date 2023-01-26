Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C21181759
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE2218149A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwEhCLoivGA09sh7DOR4jZ9EiM8HbtlamttGhnxlmvM=;
 b=V4hPDKmN/S+0K2mZrITTCbmJt4QE58aWYbAgYZMJnYkselCi9e4gAGHQ7Q9EgTiFtHg8kOzB4l+nodyCdUgxQiSJFs7YY1wnsUnMi7yHYafXjqzJThlxNLKWMZGMNbN4vAD1GJUssvaGhqvC3tk7BfHbrZSJ1rSYTwP5J5Ki6R1InqMBEqRquVUzaAd7Xuv0gOiYuEqhpM3xhQdT6sfmEgCPEiItz8GEEu3O0i5RmRKgTWe8KDAePEo7edaw5PzFTUtEi7l8hcSzvqZA9R2wH4V85GEtUOQ9lbtcr5xRGHQ5ct9LADEIK2z8/3TIm4Tyv6xUU5CR0hqevWmWTmF/ww==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 26 Jan 2023 18:01:11 +0100
Message-ID: <16e6b1f664e053bd5c057b7c5b0bd23e3d7652f9.1674752051.git.petrm@nvidia.com>
In-Reply-To: <cover.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 03/16] net: bridge: Move extack-setting to
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

Now that br_multicast_new_port_group() takes an extack argument, move
setting the extack there. The downside is that the error messages end
up being less specific (the function cannot distinguish between (S,G)
and (*,G) groups). However, the alternative is to check in the caller
whether the callee set the extack, and if it didn't, set it. But that
is only done when the callee is not exactly known. (E.g. in case of a
notifier invocation.)

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c       | 9 +++------
 net/bridge/br_multicast.c | 5 ++++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 069061366541..139de8ac532c 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -850,10 +850,9 @@ static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
 					MCAST_INCLUDE, cfg->rt_protocol, extack);
-	if (unlikely(!p)) {
-		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (S, G) port group");
+	if (unlikely(!p))
 		return -ENOMEM;
-	}
+
 	rcu_assign_pointer(*pp, p);
 	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
 		mod_timer(&p->timer,
@@ -1077,10 +1076,8 @@ static int br_mdb_add_group_star_g(const struct br_mdb_config *cfg,
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
 					cfg->filter_mode, cfg->rt_protocol,
 					extack);
-	if (unlikely(!p)) {
-		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (*, G) port group");
+	if (unlikely(!p))
 		return -ENOMEM;
-	}
 
 	err = br_mdb_add_group_srcs(cfg, p, brmctx, extack);
 	if (err)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index de67d176838f..f9f4d54226fd 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1290,8 +1290,10 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	struct net_bridge_port_group *p;
 
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
-	if (unlikely(!p))
+	if (unlikely(!p)) {
+		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new port group");
 		return NULL;
+	}
 
 	p->key.addr = *group;
 	p->key.port = port;
@@ -1306,6 +1308,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	if (!br_multicast_is_star_g(group) &&
 	    rhashtable_lookup_insert_fast(&port->br->sg_port_tbl, &p->rhnode,
 					  br_sg_port_rht_params)) {
+		NL_SET_ERR_MSG_MOD(extack, "Couldn't insert new port group");
 		kfree(p);
 		return NULL;
 	}
-- 
2.39.0

