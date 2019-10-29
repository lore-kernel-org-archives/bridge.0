Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Hww5upUnq25xA8e1i+GROPBnDe7gAIXH4P2JTLAGhpo=;
	b=BmXmPPEMnBn8AMCYbbyh5WFo1JxDmxLI2YYcNXUvBkYjQe+fi3MAcbxX5UHJN96QDK
	AjcQ+GPml4hcVwUTuLCjG3OXEe+fp7W7lR0QxZ4AXdZ/F1hqrtFDpqQWtFu01gSIzPMM
	1UbUJSRrDj+3S7/T8u2OowAUyigkyP3eVIL4k=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 29 Oct 2019 13:45:57 +0200
Message-Id: <20191029114559.28653-6-nikolay@cumulusnetworks.com>
In-Reply-To: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
References: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 5/7] net: bridge: fdb: convert
	added_by_external_learn to use bitops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Convert the added_by_external_learn field to a flag and use bitops.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c     | 19 +++++++++----------
 net/bridge/br_private.h |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 6f00cca4afc8..83d6be3f87f1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -76,7 +76,7 @@ static inline int has_expired(const struct net_bridge *br,
 				  const struct net_bridge_fdb_entry *fdb)
 {
 	return !test_bit(BR_FDB_STATIC, &fdb->flags) &&
-	       !fdb->added_by_external_learn &&
+	       !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags) &&
 	       time_before_eq(fdb->updated + hold_time(br), jiffies);
 }
 
@@ -352,7 +352,7 @@ void br_fdb_cleanup(struct work_struct *work)
 		unsigned long this_timer;
 
 		if (test_bit(BR_FDB_STATIC, &f->flags) ||
-		    f->added_by_external_learn)
+		    test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags))
 			continue;
 		this_timer = f->updated + delay;
 		if (time_after(this_timer, now)) {
@@ -506,7 +506,6 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 			set_bit(BR_FDB_LOCAL, &fdb->flags);
 		if (is_static)
 			set_bit(BR_FDB_STATIC, &fdb->flags);
-		fdb->added_by_external_learn = 0;
 		fdb->offloaded = 0;
 		fdb->updated = fdb->used = jiffies;
 		if (rhashtable_lookup_insert_fast(&br->fdb_hash_tbl,
@@ -593,8 +592,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
-				if (unlikely(fdb->added_by_external_learn))
-					fdb->added_by_external_learn = 0;
+				test_and_clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+						   &fdb->flags);
 			}
 			if (now != fdb->updated)
 				fdb->updated = now;
@@ -659,7 +658,7 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 
 	if (fdb->offloaded)
 		ndm->ndm_flags |= NTF_OFFLOADED;
-	if (fdb->added_by_external_learn)
+	if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
 		ndm->ndm_flags |= NTF_EXT_LEARNED;
 	if (test_bit(BR_FDB_STICKY, &fdb->flags))
 		ndm->ndm_flags |= NTF_STICKY;
@@ -1129,7 +1128,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		}
 		if (swdev_notify)
 			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-		fdb->added_by_external_learn = 1;
+		set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
 		fdb->updated = jiffies;
@@ -1139,12 +1138,12 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
-		if (fdb->added_by_external_learn) {
+		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used = jiffies;
 		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
 			/* Take over SW learned entry */
-			fdb->added_by_external_learn = 1;
+			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
 			modified = true;
 		}
 
@@ -1171,7 +1170,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 	spin_lock_bh(&br->hash_lock);
 
 	fdb = br_fdb_find(br, addr, vid);
-	if (fdb && fdb->added_by_external_learn)
+	if (fdb && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
 		fdb_delete(br, fdb, swdev_notify);
 	else
 		err = -ENOENT;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bf4a4d1cc3bb..cf325177a34e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -178,6 +178,7 @@ enum {
 	BR_FDB_STATIC,
 	BR_FDB_STICKY,
 	BR_FDB_ADDED_BY_USER,
+	BR_FDB_ADDED_BY_EXT_LEARN,
 };
 
 struct net_bridge_fdb_key {
@@ -192,8 +193,7 @@ struct net_bridge_fdb_entry {
 	struct net_bridge_fdb_key	key;
 	struct hlist_node		fdb_node;
 	unsigned long			flags;
-	unsigned char			added_by_external_learn:1,
-					offloaded:1;
+	unsigned char			offloaded:1;
 
 	/* write-heavy members should not affect lookups */
 	unsigned long			updated ____cacheline_aligned_in_smp;
-- 
2.21.0

