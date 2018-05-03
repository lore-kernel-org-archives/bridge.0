Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=UGmWcGu4/GVjZvZE6MPLUrrfgjbD1ohOcoUvOC90+j8=;
	b=LDGwW1ZmB8E91dWbfYJLdDvSVw7CAGLmOGLkUXGx+SGsM86UOWBzvd5C1Au7Zfdm7B7Yp3gIuMXcRwZ7WJJXrAvXGC+h1M0PviHyn4djG7bFu+5e6yeRBF5DFwy7Vhepo9vyXtDLpdAB2uuscwlJxN2NB3atOf95veAvmCcbnVU=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1525350809.git.petrm@mellanox.com>
References: <cover.1525350809.git.petrm@mellanox.com>
Message-Id: <33ac8ce3fcd084190c5797a409ebd7858f7d47db.1525350809.git.petrm@mellanox.com>
Date: Thu, 03 May 2018 14:43:53 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 2/2] net: bridge: Notify about
 !added_by_user FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

Do not automatically bail out on sending notifications about activity on
non-user-added FDB entries. Instead, notify about this activity except
for cases where the activity itself originates in a notification, to
avoid sending duplicate notifications.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br.c           |  4 ++--
 net/bridge/br_fdb.c       | 47 ++++++++++++++++++++++++++---------------------
 net/bridge/br_private.h   |  6 ++++--
 net/bridge/br_switchdev.c |  2 +-
 4 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 671d13c..c6b033e 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -141,7 +141,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-						fdb_info->vid);
+						fdb_info->vid, false);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
@@ -152,7 +152,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_del(br, p, fdb_info->addr,
-						fdb_info->vid);
+						fdb_info->vid, false);
 		if (err)
 			err = notifier_from_errno(err);
 		break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a1c409c..b19e310 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -40,7 +40,7 @@ static struct kmem_cache *br_fdb_cache __read_mostly;
 static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		      const unsigned char *addr, u16 vid);
 static void fdb_notify(struct net_bridge *br,
-		       const struct net_bridge_fdb_entry *, int);
+		       const struct net_bridge_fdb_entry *, int, bool);
 
 int __init br_fdb_init(void)
 {
@@ -195,7 +195,8 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
 	}
 }
 
-static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f)
+static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
+		       bool swdev_notify)
 {
 	trace_fdb_delete(br, f);
 
@@ -205,7 +206,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f)
 	hlist_del_init_rcu(&f->fdb_node);
 	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
 			       br_fdb_rht_params);
-	fdb_notify(br, f, RTM_DELNEIGH);
+	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
 	call_rcu(&f->rcu, fdb_rcu_free);
 }
 
@@ -241,7 +242,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		return;
 	}
 
-	fdb_delete(br, f);
+	fdb_delete(br, f, true);
 }
 
 void br_fdb_find_delete_local(struct net_bridge *br,
@@ -356,7 +357,7 @@ void br_fdb_cleanup(struct work_struct *work)
 		} else {
 			spin_lock_bh(&br->hash_lock);
 			if (!hlist_unhashed(&f->fdb_node))
-				fdb_delete(br, f);
+				fdb_delete(br, f, true);
 			spin_unlock_bh(&br->hash_lock);
 		}
 	}
@@ -376,7 +377,7 @@ void br_fdb_flush(struct net_bridge *br)
 	spin_lock_bh(&br->hash_lock);
 	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
 		if (!f->is_static)
-			fdb_delete(br, f);
+			fdb_delete(br, f, true);
 	}
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -405,7 +406,7 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 		if (f->is_local)
 			fdb_delete_local(br, p, f);
 		else
-			fdb_delete(br, f);
+			fdb_delete(br, f, true);
 	}
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -531,7 +532,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 			return 0;
 		br_warn(br, "adding interface %s with same address as a received packet (addr:%pM, vlan:%u)\n",
 		       source ? source->dev->name : br->dev->name, addr, vid);
-		fdb_delete(br, fdb);
+		fdb_delete(br, fdb, true);
 	}
 
 	fdb = fdb_create(br, source, addr, vid, 1, 1);
@@ -539,7 +540,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		return -ENOMEM;
 
 	fdb_add_hw_addr(br, addr);
-	fdb_notify(br, fdb, RTM_NEWNEIGH);
+	fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 	return 0;
 }
 
@@ -594,7 +595,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb->added_by_user = 1;
 			if (unlikely(fdb_modified)) {
 				trace_br_fdb_update(br, source, addr, vid, added_by_user);
-				fdb_notify(br, fdb, RTM_NEWNEIGH);
+				fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 			}
 		}
 	} else {
@@ -605,7 +606,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb->added_by_user = 1;
 			trace_br_fdb_update(br, source, addr, vid,
 					    added_by_user);
-			fdb_notify(br, fdb, RTM_NEWNEIGH);
+			fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 		}
 		/* else  we lose race and someone else inserts
 		 * it first, don't bother updating
@@ -687,13 +688,15 @@ static inline size_t fdb_nlmsg_size(void)
 }
 
 static void fdb_notify(struct net_bridge *br,
-		       const struct net_bridge_fdb_entry *fdb, int type)
+		       const struct net_bridge_fdb_entry *fdb, int type,
+		       bool swdev_notify)
 {
 	struct net *net = dev_net(br->dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	br_switchdev_fdb_notify(fdb, type);
+	if (swdev_notify)
+		br_switchdev_fdb_notify(fdb, type);
 
 	skb = nlmsg_new(fdb_nlmsg_size(), GFP_ATOMIC);
 	if (skb == NULL)
@@ -832,7 +835,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 	fdb->used = jiffies;
 	if (modified) {
 		fdb->updated = jiffies;
-		fdb_notify(br, fdb, RTM_NEWNEIGH);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 	}
 
 	return 0;
@@ -856,7 +859,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 		rcu_read_unlock();
 		local_bh_enable();
 	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
-		err = br_fdb_external_learn_add(br, p, addr, vid);
+		err = br_fdb_external_learn_add(br, p, addr, vid, true);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm->ndm_state,
@@ -945,7 +948,7 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 	if (!fdb || fdb->dst != p)
 		return -ENOENT;
 
-	fdb_delete(br, fdb);
+	fdb_delete(br, fdb, true);
 
 	return 0;
 }
@@ -1065,7 +1068,8 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 }
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid)
+			      const unsigned char *addr, u16 vid,
+			      bool swdev_notify)
 {
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
@@ -1083,7 +1087,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			goto err_unlock;
 		}
 		fdb->added_by_external_learn = 1;
-		fdb_notify(br, fdb, RTM_NEWNEIGH);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
 		fdb->updated = jiffies;
 
@@ -1102,7 +1106,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		}
 
 		if (modified)
-			fdb_notify(br, fdb, RTM_NEWNEIGH);
+			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
 
 err_unlock:
@@ -1112,7 +1116,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 }
 
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid)
+			      const unsigned char *addr, u16 vid,
+			      bool swdev_notify)
 {
 	struct net_bridge_fdb_entry *fdb;
 	int err = 0;
@@ -1121,7 +1126,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 
 	fdb = br_fdb_find(br, addr, vid);
 	if (fdb && fdb->added_by_external_learn)
-		fdb_delete(br, fdb);
+		fdb_delete(br, fdb, swdev_notify);
 	else
 		err = -ENOENT;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1a50931..80a69b8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -553,9 +553,11 @@ int br_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid);
+			      const unsigned char *addr, u16 vid,
+			      bool swdev_notify);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid);
+			      const unsigned char *addr, u16 vid,
+			      bool swdev_notify);
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
 			  const unsigned char *addr, u16 vid);
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 71a03c4..35474d4 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -118,7 +118,7 @@ br_switchdev_fdb_call_notifiers(bool adding, const unsigned char *mac,
 void
 br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 {
-	if (!fdb->added_by_user || !fdb->dst)
+	if (!fdb->dst)
 		return;
 
 	switch (type) {
-- 
2.4.11

