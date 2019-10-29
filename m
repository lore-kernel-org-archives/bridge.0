Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Alx6hwJFqQW86I9mK7sWZ4rlHiAVGWjJO9dOgPYX3IQ=;
	b=DX+diIgk94MzEFpurKXgwZUfqqbITZWORsqnY9rcz2UDh7eYO3yyCzSDJNc3IiyRkE
	lQVGNWhjL0/Zs1igUGeMwsrrPpqk+rgIw7lReYUl/D+xvxfvO5rlky3ceG/S6tCmriEP
	g9e5Cc6bXN4yjhzH9mF1xzSQTTBk+mXqqvTDQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 29 Oct 2019 13:45:59 +0200
Message-Id: <20191029114559.28653-8-nikolay@cumulusnetworks.com>
In-Reply-To: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
References: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 7/7] net: bridge: fdb: set flags directly
	in fdb_create
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

No need to have separate arguments for each flag, just set the flags to
whatever was passed to fdb_create() before the fdb is published.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index d4f6b398303d..f244f2ac7156 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -491,8 +491,7 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 					       struct net_bridge_port *source,
 					       const unsigned char *addr,
 					       __u16 vid,
-					       unsigned char is_local,
-					       unsigned char is_static)
+					       unsigned long flags)
 {
 	struct net_bridge_fdb_entry *fdb;
 
@@ -501,11 +500,7 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
 		fdb->dst = source;
 		fdb->key.vlan_id = vid;
-		fdb->flags = 0;
-		if (is_local)
-			set_bit(BR_FDB_LOCAL, &fdb->flags);
-		if (is_static)
-			set_bit(BR_FDB_STATIC, &fdb->flags);
+		fdb->flags = flags;
 		fdb->updated = fdb->used = jiffies;
 		if (rhashtable_lookup_insert_fast(&br->fdb_hash_tbl,
 						  &fdb->rhnode,
@@ -539,7 +534,8 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		fdb_delete(br, fdb, true);
 	}
 
-	fdb = fdb_create(br, source, addr, vid, 1, 1);
+	fdb = fdb_create(br, source, addr, vid,
+			 BIT(BR_FDB_LOCAL) | BIT(BR_FDB_STATIC));
 	if (!fdb)
 		return -ENOMEM;
 
@@ -605,7 +601,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-		fdb = fdb_create(br, source, addr, vid, 0, 0);
+		fdb = fdb_create(br, source, addr, vid, 0);
 		if (fdb) {
 			if (unlikely(added_by_user))
 				set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
@@ -830,7 +826,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, source, addr, vid, 0, 0);
+		fdb = fdb_create(br, source, addr, vid, 0);
 		if (!fdb)
 			return -ENOMEM;
 
@@ -1120,7 +1116,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 	fdb = br_fdb_find(br, addr, vid);
 	if (!fdb) {
-		fdb = fdb_create(br, p, addr, vid, 0, 0);
+		fdb = fdb_create(br, p, addr, vid, 0);
 		if (!fdb) {
 			err = -ENOMEM;
 			goto err_unlock;
-- 
2.21.0

