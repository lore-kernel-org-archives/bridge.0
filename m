Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I3GZTkmCUTgzs3luWXRqxZVOgjcYi99lwM4VQeSgHV0=;
	b=Jd1Gzx+onGddNKmbsaI3Yq00Wk3a2LfzT232Y1drs+RvLuvy4hUEE94lmpbBt6O6HK
	gIFob1B/fEsKt+Bz7nyUffSgSO4PR9NwGyvSS4f4qfxZIzRvRvJKy+cQ6hwOXJA/nqFW
	xykibLZaoRsIiEVFxcFU2oxhJwNJY6q9vC2qE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 29 Oct 2019 13:45:53 +0200
Message-Id: <20191029114559.28653-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
References: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/7] net: bridge: fdb: convert is_local to
	bitops
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

The patch adds a new fdb flags field in the hole between the two cache
lines and uses it to convert is_local to bitops.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c     | 32 +++++++++++++++++++-------------
 net/bridge/br_input.c   |  2 +-
 net/bridge/br_private.h |  9 +++++++--
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b1d3248c0252..e67d5eb8bc1d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -250,7 +250,8 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 
 	spin_lock_bh(&br->hash_lock);
 	f = br_fdb_find(br, addr, vid);
-	if (f && f->is_local && !f->added_by_user && f->dst == p)
+	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+	    !f->added_by_user && f->dst == p)
 		fdb_delete_local(br, p, f);
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -265,7 +266,8 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	spin_lock_bh(&br->hash_lock);
 	vg = nbp_vlan_group(p);
 	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {
-		if (f->dst == p && f->is_local && !f->added_by_user) {
+		if (f->dst == p && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !f->added_by_user) {
 			/* delete old one */
 			fdb_delete_local(br, p, f);
 
@@ -306,7 +308,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 
 	/* If old entry was unassociated with any port, then delete it. */
 	f = br_fdb_find(br, br->dev->dev_addr, 0);
-	if (f && f->is_local && !f->dst && !f->added_by_user)
+	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+	    !f->dst && !f->added_by_user)
 		fdb_delete_local(br, NULL, f);
 
 	fdb_insert(br, NULL, newaddr, 0);
@@ -321,7 +324,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 		if (!br_vlan_should_use(v))
 			continue;
 		f = br_fdb_find(br, br->dev->dev_addr, v->vid);
-		if (f && f->is_local && !f->dst && !f->added_by_user)
+		if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !f->dst && !f->added_by_user)
 			fdb_delete_local(br, NULL, f);
 		fdb_insert(br, NULL, newaddr, v->vid);
 	}
@@ -400,7 +404,7 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 			if (f->is_static || (vid && f->key.vlan_id != vid))
 				continue;
 
-		if (f->is_local)
+		if (test_bit(BR_FDB_LOCAL, &f->flags))
 			fdb_delete_local(br, p, f);
 		else
 			fdb_delete(br, f, true);
@@ -469,7 +473,7 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		fe->port_no = f->dst->port_no;
 		fe->port_hi = f->dst->port_no >> 8;
 
-		fe->is_local = f->is_local;
+		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
 		if (!f->is_static)
 			fe->ageing_timer_value = jiffies_delta_to_clock_t(jiffies - f->updated);
 		++fe;
@@ -494,7 +498,9 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
 		fdb->dst = source;
 		fdb->key.vlan_id = vid;
-		fdb->is_local = is_local;
+		fdb->flags = 0;
+		if (is_local)
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
 		fdb->is_static = is_static;
 		fdb->added_by_user = 0;
 		fdb->added_by_external_learn = 0;
@@ -526,7 +532,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		/* it is okay to have multiple ports with same
 		 * address, just use the first one.
 		 */
-		if (fdb->is_local)
+		if (test_bit(BR_FDB_LOCAL, &fdb->flags))
 			return 0;
 		br_warn(br, "adding interface %s with same address as a received packet (addr:%pM, vlan:%u)\n",
 		       source ? source->dev->name : br->dev->name, addr, vid);
@@ -572,7 +578,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
-		if (unlikely(fdb->is_local)) {
+		if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
 			if (net_ratelimit())
 				br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
 					source->dev->name, addr, vid);
@@ -616,7 +622,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 static int fdb_to_nud(const struct net_bridge *br,
 		      const struct net_bridge_fdb_entry *fdb)
 {
-	if (fdb->is_local)
+	if (test_bit(BR_FDB_LOCAL, &fdb->flags))
 		return NUD_PERMANENT;
 	else if (fdb->is_static)
 		return NUD_NOARP;
@@ -840,19 +846,19 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 	if (fdb_to_nud(br, fdb) != state) {
 		if (state & NUD_PERMANENT) {
-			fdb->is_local = 1;
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (!fdb->is_static) {
 				fdb->is_static = 1;
 				fdb_add_hw_addr(br, addr);
 			}
 		} else if (state & NUD_NOARP) {
-			fdb->is_local = 0;
+			clear_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (!fdb->is_static) {
 				fdb->is_static = 1;
 				fdb_add_hw_addr(br, addr);
 			}
 		} else {
-			fdb->is_local = 0;
+			clear_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (fdb->is_static) {
 				fdb->is_static = 0;
 				fdb_del_hw_addr(br, addr);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 09b1dd8cd853..7f5f646dba6e 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -151,7 +151,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (dst) {
 		unsigned long now = jiffies;
 
-		if (dst->is_local)
+		if (test_bit(BR_FDB_LOCAL, &dst->flags))
 			return br_pass_frame_up(skb);
 
 		if (now != dst->used)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ce2ab14ee605..888cbe9c639a 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -172,6 +172,11 @@ struct net_bridge_vlan_group {
 	u16				pvid;
 };
 
+/* bridge fdb flags */
+enum {
+	BR_FDB_LOCAL,
+};
+
 struct net_bridge_fdb_key {
 	mac_addr addr;
 	u16 vlan_id;
@@ -183,8 +188,8 @@ struct net_bridge_fdb_entry {
 
 	struct net_bridge_fdb_key	key;
 	struct hlist_node		fdb_node;
-	unsigned char			is_local:1,
-					is_static:1,
+	unsigned long			flags;
+	unsigned char			is_static:1,
 					is_sticky:1,
 					added_by_user:1,
 					added_by_external_learn:1,
-- 
2.21.0

