Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I8hGSuiDX0siuyCstsxGZV1KLBVAGFihygZ3ZtImzPE=;
	b=bTPrn29DM4oxQdTG9g2LPl94YKLIXY4Q+Mt5OJFj9hTIE8Rcc+KdHCoxhdonjxjFOO
	a+WM8zrbbykyb6weBLkEtrbqqJSCx5JShRTlmDb4mvwAyhxNIdO8S/qmN24e8wqQdg81
	rFRwvcZe8JN25EIs4EQNf2+rhglkfRwfaf8AI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri,  1 Nov 2019 14:38:43 +0200
Message-Id: <20191101123844.17518-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20191101123844.17518-1-nikolay@cumulusnetworks.com>
References: <20191101123844.17518-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/3] net: bridge: fdb: avoid two atomic
	bitops in br_fdb_external_learn_add()
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

If we setup the fdb flags prior to calling fdb_create() we can avoid
two atomic bitops when learning a new entry.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b37e0f4c1b2b..7500c84fc675 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1113,14 +1113,15 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 	fdb = br_fdb_find(br, addr, vid);
 	if (!fdb) {
-		fdb = fdb_create(br, p, addr, vid, 0);
+		unsigned long flags = BIT(BR_FDB_ADDED_BY_EXT_LEARN);
+
+		if (swdev_notify)
+			flags |= BIT(BR_FDB_ADDED_BY_USER);
+		fdb = fdb_create(br, p, addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
-		if (swdev_notify)
-			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-		set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
 		fdb->updated = jiffies;
-- 
2.21.0

