Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=qYXEOTeHtP3Wrmjy2EL/SCrs3cMrCdhUJz2mMV/de4M=;
	b=NmPZOUh5j1E3jP7Lr0rzVSc5Q+D4RA1VkJ+qnFID7n6YZCegUQHRS8RHatSwWFnoUV
	ICCg4THtFo+nUHrEaScASD+BXd17p09ODDpUKB9oKeRnL69e0d3+ZVNNMunIDDSDqaTj
	4SXD4ATfQvnfEmHIscQUjPWjTcqrIBGrMsyCg=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 10 Sep 2018 13:16:01 +0300
Message-Id: <20180910101601.28073-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] net: bridge: add support for sticky fdb
	entries
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

Add support for entries which are "sticky", i.e. will not change their port
if they show up from a different one. A new ndm flag is introduced for that
purpose - NTF_STICKY. We allow to set it only to non-local entries.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
I'll send the selftest for sticky with the iproute2 patch if this one is
accepted. We've had multiple requests to support such flag and now it's
also needed for some eVPN and clag setups.

 include/uapi/linux/neighbour.h |  1 +
 net/bridge/br_fdb.c            | 19 ++++++++++++++++---
 net/bridge/br_private.h        |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 904db6148476..998155444e0d 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -43,6 +43,7 @@ enum {
 #define NTF_PROXY	0x08	/* == ATF_PUBL */
 #define NTF_EXT_LEARNED	0x10
 #define NTF_OFFLOADED   0x20
+#define NTF_STICKY	0x40
 #define NTF_ROUTER	0x80
 
 /*
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 502f66349530..26569ed06a4d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -584,7 +584,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			unsigned long now = jiffies;
 
 			/* fastpath: update of existing entry */
-			if (unlikely(source != fdb->dst)) {
+			if (unlikely(source != fdb->dst && !fdb->is_sticky)) {
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
@@ -656,6 +656,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 		ndm->ndm_flags |= NTF_OFFLOADED;
 	if (fdb->added_by_external_learn)
 		ndm->ndm_flags |= NTF_EXT_LEARNED;
+	if (fdb->is_sticky)
+		ndm->ndm_flags |= NTF_STICKY;
 
 	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
 		goto nla_put_failure;
@@ -772,7 +774,8 @@ int br_fdb_dump(struct sk_buff *skb,
 
 /* Update (create or replace) forwarding database entry */
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
-			 const __u8 *addr, __u16 state, __u16 flags, __u16 vid)
+			 const u8 *addr, u16 state, u16 flags, u16 vid,
+			 u8 is_sticky)
 {
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
@@ -789,6 +792,9 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		return -EINVAL;
 	}
 
+	if (is_sticky && (state & NUD_PERMANENT))
+		return -EINVAL;
+
 	fdb = br_fdb_find(br, addr, vid);
 	if (fdb == NULL) {
 		if (!(flags & NLM_F_CREATE))
@@ -832,6 +838,12 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 		modified = true;
 	}
+
+	if (is_sticky != fdb->is_sticky) {
+		fdb->is_sticky = is_sticky;
+		modified = true;
+	}
+
 	fdb->added_by_user = 1;
 
 	fdb->used = jiffies;
@@ -865,7 +877,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm->ndm_state,
-				    nlh_flags, vid);
+				    nlh_flags, vid,
+				    !!(ndm->ndm_flags & NTF_STICKY));
 		spin_unlock_bh(&br->hash_lock);
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 11ed2029985f..d21035a17f4c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -181,6 +181,7 @@ struct net_bridge_fdb_entry {
 	struct hlist_node		fdb_node;
 	unsigned char			is_local:1,
 					is_static:1,
+					is_sticky:1,
 					added_by_user:1,
 					added_by_external_learn:1,
 					offloaded:1;
-- 
2.11.0

