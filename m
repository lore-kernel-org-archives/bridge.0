Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=jan+h+2lp6aWk4LdIZJQD1puuv8mcW3lXTiNJE6hHxA=;
	b=YprvvlFaL5GPNyqvxh2jACtdWdm95eQkWdFtMoNgXDtU175wAczVVq6hcRxLlYemYp
	J2bDHNjq+WnSWkDHi0qY8fSXkd609deIhm35vZM3tCCVGnQOXu9Z2FIsac6KXLZxLJJT
	kYx8p9F7D6BFWD4EcK+jRCfqZh3jmy5lMMiMY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 27 Sep 2018 15:05:10 +0300
Message-Id: <20180927120510.7314-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] net: bridge: explicitly zero is_sticky in
	fdb_create
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

We need to explicitly zero is_sticky when creating a new fdb, otherwise
we might get a stale value for a new entry.

Fixes: 435f2e7cc0b7 ("net: bridge: add support for sticky fdb entries")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a56ed7f2a3a3..74331690a390 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -504,6 +504,7 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		fdb->added_by_user = 0;
 		fdb->added_by_external_learn = 0;
 		fdb->offloaded = 0;
+		fdb->is_sticky = 0;
 		fdb->updated = fdb->used = jiffies;
 		if (rhashtable_lookup_insert_fast(&br->fdb_hash_tbl,
 						  &fdb->rhnode,
-- 
2.11.0

