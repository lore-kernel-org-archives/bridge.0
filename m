Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 287854194A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C814641940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtOv+Q0+/URrw8mkdChIMkWBywbxXqijseBtDgbLa6M=;
 b=j2q4gDiZ5o8xWqpnLpL0qMt5anXBHJ0Uw/sOc14kHL0d0xgOLrVq6FSlQA34alx3CaOFr1BvrP6XWtNzdCyDGIuvC6MIX/jXTOC7F8OCmE/3XuwFuEquiUOa2MH9cwtUcxsWZJloNCoeBcDbH6JqyhN96Db5r24mmfEqPHpwVZqjYZvKG6qY/1G6ndD0YR92dsCgTabYF+avFqHISfrpTJOSUkiYLm5xKL19ifeHK8wjQaa/AYGnVquzC/eYVlv5LxTy25+p7buXpzWUz1nDKxPcZS+CUq5pTakxahvz5vXOtyEGdPGheXypeyrReEskv8n3tqn31/nkgoQJ9bmNUQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:11 +0300
Message-Id: <20221018120420.561846-11-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 10/19] bridge: mcast: Split (*,
	G) and (S, G) addition into different functions
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

When the bridge is using IGMP version 3 or MLD version 2, it handles the
addition of (*, G) and (S, G) entries differently.

When a new (S, G) port group entry is added, all the (*, G) EXCLUDE
ports need to be added to the port group of the new entry. Similarly,
when a new (*, G) EXCLUDE port group entry is added, the port needs to
be added to the port group of all the matching (S, G) entries.

Subsequent patches will create more differences between both entry
types. Namely, filter mode and source list can only be specified for (*,
G) entries.

Given the current and future differences between both entry types,
handle the addition of each entry type in a different function, thereby
avoiding the creation of one complex function.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 145 +++++++++++++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 49 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index dd56063430ed..a48eef866974 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -786,21 +786,107 @@ __br_mdb_choose_context(struct net_bridge *br,
 	return brmctx;
 }
 
+static int br_mdb_add_group_sg(struct br_mdb_config *cfg,
+			       struct net_bridge_mdb_entry *mp,
+			       struct net_bridge_mcast *brmctx,
+			       unsigned char flags,
+			       struct netlink_ext_ack *extack)
+{
+	struct net_bridge_port_group __rcu **pp;
+	struct net_bridge_port_group *p;
+	unsigned long now = jiffies;
+
+	for (pp = &mp->ports;
+	     (p = mlock_dereference(*pp, cfg->br)) != NULL;
+	     pp = &p->next) {
+		if (p->key.port == cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "(S, G) group is already joined by port");
+			return -EEXIST;
+		}
+		if ((unsigned long)p->key.port < (unsigned long)cfg->p)
+			break;
+	}
+
+	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
+					MCAST_INCLUDE, RTPROT_STATIC);
+	if (unlikely(!p)) {
+		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (S, G) port group");
+		return -ENOMEM;
+	}
+	rcu_assign_pointer(*pp, p);
+	if (!(flags & MDB_PG_FLAGS_PERMANENT))
+		mod_timer(&p->timer,
+			  now + brmctx->multicast_membership_interval);
+	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
+
+	/* All of (*, G) EXCLUDE ports need to be added to the new (S, G) for
+	 * proper replication.
+	 */
+	if (br_multicast_should_handle_mode(brmctx, cfg->group.proto)) {
+		struct net_bridge_mdb_entry *star_mp;
+		struct br_ip star_group;
+
+		star_group = p->key.addr;
+		memset(&star_group.src, 0, sizeof(star_group.src));
+		star_mp = br_mdb_ip_get(cfg->br, &star_group);
+		if (star_mp)
+			br_multicast_sg_add_exclude_ports(star_mp, p);
+	}
+
+	return 0;
+}
+
+static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
+				   struct net_bridge_mdb_entry *mp,
+				   struct net_bridge_mcast *brmctx,
+				   unsigned char flags,
+				   struct netlink_ext_ack *extack)
+{
+	struct net_bridge_port_group __rcu **pp;
+	struct net_bridge_port_group *p;
+	unsigned long now = jiffies;
+
+	for (pp = &mp->ports;
+	     (p = mlock_dereference(*pp, cfg->br)) != NULL;
+	     pp = &p->next) {
+		if (p->key.port == cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "(*, G) group is already joined by port");
+			return -EEXIST;
+		}
+		if ((unsigned long)p->key.port < (unsigned long)cfg->p)
+			break;
+	}
+
+	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
+					MCAST_EXCLUDE, RTPROT_STATIC);
+	if (unlikely(!p)) {
+		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (*, G) port group");
+		return -ENOMEM;
+	}
+	rcu_assign_pointer(*pp, p);
+	if (!(flags & MDB_PG_FLAGS_PERMANENT))
+		mod_timer(&p->timer,
+			  now + brmctx->multicast_membership_interval);
+	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
+	/* If we are adding a new EXCLUDE port group (*, G), it needs to be
+	 * also added to all (S, G) entries for proper replication.
+	 */
+	if (br_multicast_should_handle_mode(brmctx, cfg->group.proto))
+		br_multicast_star_g_handle_mode(p, MCAST_EXCLUDE);
+
+	return 0;
+}
+
 static int br_mdb_add_group(struct br_mdb_config *cfg,
 			    struct netlink_ext_ack *extack)
 {
-	struct net_bridge_mdb_entry *mp, *star_mp;
-	struct net_bridge_port_group __rcu **pp;
 	struct br_mdb_entry *entry = cfg->entry;
 	struct net_bridge_port *port = cfg->p;
+	struct net_bridge_mdb_entry *mp;
 	struct net_bridge *br = cfg->br;
-	struct net_bridge_port_group *p;
 	struct net_bridge_mcast *brmctx;
 	struct br_ip group = cfg->group;
-	unsigned long now = jiffies;
 	unsigned char flags = 0;
-	struct br_ip star_group;
-	u8 filter_mode;
 
 	brmctx = __br_mdb_choose_context(br, entry, extack);
 	if (!brmctx)
@@ -823,52 +909,13 @@ static int br_mdb_add_group(struct br_mdb_config *cfg,
 		return 0;
 	}
 
-	for (pp = &mp->ports;
-	     (p = mlock_dereference(*pp, br)) != NULL;
-	     pp = &p->next) {
-		if (p->key.port == port) {
-			NL_SET_ERR_MSG_MOD(extack, "Group is already joined by port");
-			return -EEXIST;
-		}
-		if ((unsigned long)p->key.port < (unsigned long)port)
-			break;
-	}
-
-	filter_mode = br_multicast_is_star_g(&group) ? MCAST_EXCLUDE :
-						       MCAST_INCLUDE;
-
 	if (entry->state == MDB_PERMANENT)
 		flags |= MDB_PG_FLAGS_PERMANENT;
 
-	p = br_multicast_new_port_group(port, &group, *pp, flags, NULL,
-					filter_mode, RTPROT_STATIC);
-	if (unlikely(!p)) {
-		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new port group");
-		return -ENOMEM;
-	}
-	rcu_assign_pointer(*pp, p);
-	if (entry->state == MDB_TEMPORARY)
-		mod_timer(&p->timer,
-			  now + brmctx->multicast_membership_interval);
-	br_mdb_notify(br->dev, mp, p, RTM_NEWMDB);
-	/* if we are adding a new EXCLUDE port group (*,G) it needs to be also
-	 * added to all S,G entries for proper replication, if we are adding
-	 * a new INCLUDE port (S,G) then all of *,G EXCLUDE ports need to be
-	 * added to it for proper replication
-	 */
-	if (br_multicast_should_handle_mode(brmctx, group.proto)) {
-		if (br_multicast_is_star_g(&group)) {
-			br_multicast_star_g_handle_mode(p, filter_mode);
-		} else {
-			star_group = p->key.addr;
-			memset(&star_group.src, 0, sizeof(star_group.src));
-			star_mp = br_mdb_ip_get(br, &star_group);
-			if (star_mp)
-				br_multicast_sg_add_exclude_ports(star_mp, p);
-		}
-	}
-
-	return 0;
+	if (br_multicast_is_star_g(&group))
+		return br_mdb_add_group_star_g(cfg, mp, brmctx, flags, extack);
+	else
+		return br_mdb_add_group_sg(cfg, mp, brmctx, flags, extack);
 }
 
 static int __br_mdb_add(struct br_mdb_config *cfg,
-- 
2.37.3

