Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24A0341959
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB3EC41950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fkwh202eXgpsxIjCf8XrnU2/86UOeQGTa0oGgKb+tI=;
 b=RzbD2gerKyYtKxnxypBPO3N5iTkk4gU+1wXSo/4iB9Z/CwFgm2Vytn4zK8S6it8qJjJQHfOtzdAAzSYGSjXY3jXQwZ8HeLQWdO9lqfeJOiZGd36uLTeRMWuqa6chp/i3jPbI6aEgo321qDgttUdgb1TwRIhzrOxnJtCsqEmRFXAg20UVSGo1TuQRo3lNs0OYgRHSmH2/WZn+rIdUj3JQdg0pPA04XfaGhkaqQ+/iXliubSdDabQiYgulxHZyVMrid5pC4vTIVen8uGcRK6LWALD83f2PWBtGrzvMbDWG4HObFl2RiiwnFPQ46ZSTP9tSXzs8DzghzrX3l7zrkp9pPg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:20 +0300
Message-Id: <20221018120420.561846-20-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 19/19] bridge: mcast: Support
	replacement of MDB port group entries
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

Now that user space can specify additional attributes of port group
entries such as filter mode and source list, it makes sense to allow
user space to atomically modify these attributes by replacing entries
instead of forcing user space to delete the entries and add them back.

Replace MDB port group entries when the 'NLM_F_REPLACE' flag is
specified in the netlink message header.

When a (*, G) entry is replaced, update the following attributes: Source
list, state, filter mode, protocol and flags. If the entry is temporary
and in EXCLUDE mode, reset the group timer to the group membership
interval. If the entry is temporary and in INCLUDE mode, reset the
source timers of associated sources to the group membership interval.

Examples:

 # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent source_list 192.0.2.1,192.0.2.2 filter_mode include
 # bridge -d -s mdb show
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.2 permanent filter_mode include proto static     0.00
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto static     0.00
 dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode include source_list 192.0.2.2/0.00,192.0.2.1/0.00 proto static     0.00

 # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent source_list 192.0.2.1,192.0.2.3 filter_mode exclude proto zebra
 # bridge -d -s mdb show
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 permanent filter_mode include proto zebra  blocked    0.00
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto zebra  blocked    0.00
 dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode exclude source_list 192.0.2.3/0.00,192.0.2.1/0.00 proto zebra     0.00

 # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 temp source_list 192.0.2.4,192.0.2.3 filter_mode include proto bgp
 # bridge -d -s mdb show
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.4 temp filter_mode include proto bgp     0.00
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 temp filter_mode include proto bgp     0.00
 dev br0 port dummy10 grp 239.1.1.1 temp filter_mode include source_list 192.0.2.4/259.44,192.0.2.3/259.44 proto bgp     0.00

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c     | 103 ++++++++++++++++++++++++++++++++++++++--
 net/bridge/br_private.h |   1 +
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7ee6d383ad07..b0c506a3e09e 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -802,6 +802,28 @@ __br_mdb_choose_context(struct net_bridge *br,
 	return brmctx;
 }
 
+static int br_mdb_replace_group_sg(struct br_mdb_config *cfg,
+				   struct net_bridge_mdb_entry *mp,
+				   struct net_bridge_port_group *pg,
+				   struct net_bridge_mcast *brmctx,
+				   unsigned char flags,
+				   struct netlink_ext_ack *extack)
+{
+	unsigned long now = jiffies;
+
+	pg->flags = flags;
+	pg->rt_protocol = cfg->rt_protocol;
+	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
+		mod_timer(&pg->timer,
+			  now + brmctx->multicast_membership_interval);
+	else
+		del_timer(&pg->timer);
+
+	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
+
+	return 0;
+}
+
 static int br_mdb_add_group_sg(struct br_mdb_config *cfg,
 			       struct net_bridge_mdb_entry *mp,
 			       struct net_bridge_mcast *brmctx,
@@ -816,8 +838,12 @@ static int br_mdb_add_group_sg(struct br_mdb_config *cfg,
 	     (p = mlock_dereference(*pp, cfg->br)) != NULL;
 	     pp = &p->next) {
 		if (p->key.port == cfg->p) {
-			NL_SET_ERR_MSG_MOD(extack, "(S, G) group is already joined by port");
-			return -EEXIST;
+			if (!(cfg->nlflags & NLM_F_REPLACE)) {
+				NL_SET_ERR_MSG_MOD(extack, "(S, G) group is already joined by port");
+				return -EEXIST;
+			}
+			return br_mdb_replace_group_sg(cfg, mp, p, brmctx,
+						       flags, extack);
 		}
 		if ((unsigned long)p->key.port < (unsigned long)cfg->p)
 			break;
@@ -884,6 +910,7 @@ static int br_mdb_add_group_src_fwd(struct br_mdb_config *cfg,
 	sg_cfg.src_entry = true;
 	sg_cfg.filter_mode = MCAST_INCLUDE;
 	sg_cfg.rt_protocol = cfg->rt_protocol;
+	sg_cfg.nlflags = cfg->nlflags;
 	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
 }
 
@@ -904,7 +931,7 @@ static int br_mdb_add_group_src(struct br_mdb_config *cfg,
 			NL_SET_ERR_MSG_MOD(extack, "Failed to add new source entry");
 			return -ENOSPC;
 		}
-	} else {
+	} else if (!(cfg->nlflags & NLM_F_REPLACE)) {
 		NL_SET_ERR_MSG_MOD(extack, "Source entry already exists");
 		return -EEXIST;
 	}
@@ -962,6 +989,67 @@ static int br_mdb_add_group_srcs(struct br_mdb_config *cfg,
 	return err;
 }
 
+static int br_mdb_replace_group_srcs(struct br_mdb_config *cfg,
+				     struct net_bridge_port_group *pg,
+				     struct net_bridge_mcast *brmctx,
+				     struct netlink_ext_ack *extack)
+{
+	struct net_bridge_group_src *ent;
+	struct hlist_node *tmp;
+	int err;
+
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags |= BR_SGRP_F_DELETE;
+
+	err = br_mdb_add_group_srcs(cfg, pg, brmctx, extack);
+	if (err)
+		goto err_clear_delete;
+
+	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node) {
+		if (ent->flags & BR_SGRP_F_DELETE)
+			br_multicast_del_group_src(ent, false);
+	}
+
+	return 0;
+
+err_clear_delete:
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags &= ~BR_SGRP_F_DELETE;
+	return err;
+}
+
+static int br_mdb_replace_group_star_g(struct br_mdb_config *cfg,
+				       struct net_bridge_mdb_entry *mp,
+				       struct net_bridge_port_group *pg,
+				       struct net_bridge_mcast *brmctx,
+				       unsigned char flags,
+				       struct netlink_ext_ack *extack)
+{
+	unsigned long now = jiffies;
+	int err;
+
+	err = br_mdb_replace_group_srcs(cfg, pg, brmctx, extack);
+	if (err)
+		return err;
+
+	pg->flags = flags;
+	pg->filter_mode = cfg->filter_mode;
+	pg->rt_protocol = cfg->rt_protocol;
+	if (!(flags & MDB_PG_FLAGS_PERMANENT) &&
+	    cfg->filter_mode == MCAST_EXCLUDE)
+		mod_timer(&pg->timer,
+			  now + brmctx->multicast_membership_interval);
+	else
+		del_timer(&pg->timer);
+
+	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
+
+	if (br_multicast_should_handle_mode(brmctx, cfg->group.proto))
+		br_multicast_star_g_handle_mode(pg, cfg->filter_mode);
+
+	return 0;
+}
+
 static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
 				   struct net_bridge_mdb_entry *mp,
 				   struct net_bridge_mcast *brmctx,
@@ -977,8 +1065,12 @@ static int br_mdb_add_group_star_g(struct br_mdb_config *cfg,
 	     (p = mlock_dereference(*pp, cfg->br)) != NULL;
 	     pp = &p->next) {
 		if (p->key.port == cfg->p) {
-			NL_SET_ERR_MSG_MOD(extack, "(*, G) group is already joined by port");
-			return -EEXIST;
+			if (!(cfg->nlflags & NLM_F_REPLACE)) {
+				NL_SET_ERR_MSG_MOD(extack, "(*, G) group is already joined by port");
+				return -EEXIST;
+			}
+			return br_mdb_replace_group_star_g(cfg, mp, p, brmctx,
+							   flags, extack);
 		}
 		if ((unsigned long)p->key.port < (unsigned long)cfg->p)
 			break;
@@ -1222,6 +1314,7 @@ static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
 	cfg->filter_mode = MCAST_EXCLUDE;
 	INIT_LIST_HEAD(&cfg->src_list);
 	cfg->rt_protocol = RTPROT_STATIC;
+	cfg->nlflags = nlh->nlmsg_flags;
 
 	bpm = nlmsg_data(nlh);
 	if (!bpm->ifindex) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 73f0e98de33b..7831f01fa018 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -107,6 +107,7 @@ struct br_mdb_config {
 	u8				filter_mode;
 	u8				rt_protocol;
 	struct list_head		src_list;
+	u32				nlflags;
 };
 #endif
 
-- 
2.37.3

