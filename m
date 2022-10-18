Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C6A1833C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 543F483396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk166414OYTnh30cMgdsgifjVP5OsqPSiKYrTmvtCOo=;
 b=SBNc/9+708NFCvWCj2PgAKnu3TlWbSZkGBoQYLjseHrlcT2gcqtfvUrtwZvhECVn9/XMhYNqdKTsZYvnpbNCNDvACDhbs7ij91t2V5sPtoXIla4SR3mTP1lg69E5XpuvEHv8sq0TJBqX/l0k9zJuisw0TD1Fz6p/WdZQlvyU6ju7HJSMoN4MBx2IcKMi4NjuGKGTbFnqiu5lvMs/kjTAjvLFpGxk2tHhOVGxIMAjmPGJzd+741cbEMUB6uOzx8V+pIls0A6vnzvk8Sf2mPfSdSQ/g6vTVBAZ/cclZgfid8OnEVnj2SH6P70oXAnZS6fQqO1Da1m3KJFbw+u4T0H/OA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:17 +0300
Message-Id: <20221018120420.561846-17-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 16/19] bridge: mcast: Add support for
	(*, G) with a source list and filter mode
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

In preparation for allowing user space to add (*, G) entries with a
source list and associated filter mode, add the necessary plumbing to
handle such requests.

Extend the MDB configuration structure with a currently empty source
list and filter mode that is currently hard coded to EXCLUDE.

Add the source entries and the corresponding (S, G) entries before
making the new (*, G) port group entry visible to the data path.

Handle the creation of each source entry in a similar fashion to how it
is created from the data path in response to received Membership
Reports: Create the source entry, arm the source timer (if needed), add
a corresponding (S, G) forwarding entry and finally mark the source
entry as installed (by user space).

Add the (S, G) entry by populating an MDB configuration structure and
calling br_mdb_add_group_sg() as if a new entry is created by user
space, with the sole difference that the 'src_entry' field is set to
make sure that the group timer of such entries is never armed.

Note that it is not currently possible to add more than 32 source
entries to a port group entry. If this proves to be a problem we can
either increase 'PG_SRC_ENT_LIMIT' or avoid forcing a limit on entries
created by user space. For example, by adding a new argument to
br_multicast_new_group_src().

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c     | 130 +++++++++++++++++++++++++++++++++++++++-
 net/bridge/br_private.h |   7 +++
 2 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 2804da7b0aa1..8fc8816a76bf 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -836,6 +836,115 @@ static int br_mdb_add_group_sg(struct br_mdb_config *cfg,
 	return 0;
 }
 
+static int br_mdb_add_group_src_fwd(struct br_mdb_config *cfg,
+				    struct br_ip *src_ip,
+				    struct net_bridge_mcast *brmctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct net_bridge_mdb_entry *sgmp;
+	struct br_mdb_config sg_cfg;
+	struct br_ip sg_ip;
+	u8 flags = 0;
+
+	sg_ip = cfg->group;
+	sg_ip.src = src_ip->src;
+	sgmp = br_multicast_new_group(cfg->br, &sg_ip);
+	if (IS_ERR(sgmp)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to add (S, G) MDB entry");
+		return PTR_ERR(sgmp);
+	}
+
+	if (cfg->entry->state == MDB_PERMANENT)
+		flags |= MDB_PG_FLAGS_PERMANENT;
+	if (cfg->filter_mode == MCAST_EXCLUDE)
+		flags |= MDB_PG_FLAGS_BLOCKED;
+
+	memset(&sg_cfg, 0, sizeof(sg_cfg));
+	INIT_LIST_HEAD(&sg_cfg.src_list);
+	sg_cfg.br = cfg->br;
+	sg_cfg.p = cfg->p;
+	sg_cfg.entry = cfg->entry;
+	sg_cfg.group = sg_ip;
+	sg_cfg.src_entry = true;
+	sg_cfg.filter_mode = MCAST_INCLUDE;
+	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
+}
+
+static int br_mdb_add_group_src(struct br_mdb_config *cfg,
+				struct net_bridge_port_group *pg,
+				struct net_bridge_mcast *brmctx,
+				struct br_mdb_src_entry *src,
+				struct netlink_ext_ack *extack)
+{
+	struct net_bridge_group_src *ent;
+	unsigned long now = jiffies;
+	int err;
+
+	ent = br_multicast_find_group_src(pg, &src->addr);
+	if (!ent) {
+		ent = br_multicast_new_group_src(pg, &src->addr);
+		if (!ent) {
+			NL_SET_ERR_MSG_MOD(extack, "Failed to add new source entry");
+			return -ENOSPC;
+		}
+	} else {
+		NL_SET_ERR_MSG_MOD(extack, "Source entry already exists");
+		return -EEXIST;
+	}
+
+	if (cfg->filter_mode == MCAST_INCLUDE &&
+	    cfg->entry->state == MDB_TEMPORARY)
+		mod_timer(&ent->timer, now + br_multicast_gmi(brmctx));
+	else
+		del_timer(&ent->timer);
+
+	/* Install a (S, G) forwarding entry for the source. */
+	err = br_mdb_add_group_src_fwd(cfg, &src->addr, brmctx, extack);
+	if (err)
+		goto err_del_sg;
+
+	ent->flags = BR_SGRP_F_INSTALLED | BR_SGRP_F_USER_ADDED;
+
+	return 0;
+
+err_del_sg:
+	br_multicast_del_group_src(ent, false);
+	return err;
+}
+
+static void br_mdb_del_group_src(struct net_bridge_port_group *pg,
+				 struct br_mdb_src_entry *src)
+{
+	struct net_bridge_group_src *ent;
+
+	ent = br_multicast_find_group_src(pg, &src->addr);
+	if (WARN_ON_ONCE(!ent))
+		return;
+	br_multicast_del_group_src(ent, false);
+}
+
+static int br_mdb_add_group_srcs(struct br_mdb_config *cfg,
+				 struct net_bridge_port_group *pg,
+				 struct net_bridge_mcast *brmctx,
+				 struct netlink_ext_ack *extack)
+{
+	struct br_mdb_src_entry *src;
+	int err;
+
+	list_for_each_entry(src, &cfg->src_list, list) {
+		err = br_mdb_add_group_src(cfg, pg, brmctx, src, extack);
+		if (err)
+			goto err_del_group_srcs;
+	}
+
+	return 0;
+
+err_del_group_srcs:
+	list_for_each_entry_continue_reverse(src, &cfg->src_list, list)
+		br_mdb_del_group_src(pg, src);
+	return err;
+}
+
 static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
 				   struct net_bridge_mdb_entry *mp,
 				   struct net_bridge_mcast *brmctx,
@@ -845,6 +954,7 @@ static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
 	struct net_bridge_port_group __rcu **pp;
 	struct net_bridge_port_group *p;
 	unsigned long now = jiffies;
+	int err;
 
 	for (pp = &mp->ports;
 	     (p = mlock_dereference(*pp, cfg->br)) != NULL;
@@ -858,23 +968,35 @@ static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
 	}
 
 	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					MCAST_EXCLUDE, RTPROT_STATIC);
+					cfg->filter_mode, RTPROT_STATIC);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new (*, G) port group");
 		return -ENOMEM;
 	}
+
+	err = br_mdb_add_group_srcs(cfg, p, brmctx, extack);
+	if (err)
+		goto err_del_port_group;
+
 	rcu_assign_pointer(*pp, p);
-	if (!(flags & MDB_PG_FLAGS_PERMANENT))
+	if (!(flags & MDB_PG_FLAGS_PERMANENT) &&
+	    cfg->filter_mode == MCAST_EXCLUDE)
 		mod_timer(&p->timer,
 			  now + brmctx->multicast_membership_interval);
 	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
 	/* If we are adding a new EXCLUDE port group (*, G), it needs to be
 	 * also added to all (S, G) entries for proper replication.
 	 */
-	if (br_multicast_should_handle_mode(brmctx, cfg->group.proto))
+	if (br_multicast_should_handle_mode(brmctx, cfg->group.proto) &&
+	    cfg->filter_mode == MCAST_EXCLUDE)
 		br_multicast_star_g_handle_mode(p, MCAST_EXCLUDE);
 
 	return 0;
+
+err_del_port_group:
+	hlist_del_init(&p->mglist);
+	kfree(p);
+	return err;
 }
 
 static int br_mdb_add_group(struct br_mdb_config *cfg,
@@ -967,6 +1089,8 @@ static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
 		return err;
 
 	memset(cfg, 0, sizeof(*cfg));
+	cfg->filter_mode = MCAST_EXCLUDE;
+	INIT_LIST_HEAD(&cfg->src_list);
 
 	bpm = nlmsg_data(nlh);
 	if (!bpm->ifindex) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1bd6eebad002..0189fce6f3b7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -93,12 +93,19 @@ struct bridge_mcast_stats {
 	struct u64_stats_sync syncp;
 };
 
+struct br_mdb_src_entry {
+	struct list_head		list;
+	struct br_ip			addr;
+};
+
 struct br_mdb_config {
 	struct net_bridge		*br;
 	struct net_bridge_port		*p;
 	struct br_mdb_entry		*entry;
 	struct br_ip			group;
 	bool				src_entry;
+	u8				filter_mode;
+	struct list_head		src_list;
 };
 #endif
 
-- 
2.37.3

