Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lDPD0SBTXMHitArGqEGbSSR6qohaslJSZJZXxjRVv1U=;
 b=YhhLlt0uqbMasWSbMwK/dPayNdtOXNFqS3OPtwC1ODv9AlY1KvuDNDgIY5zvZxb2W5
 HWI+UwI3i4TT6DpjxSGr91vrYK542xNVV6tvdZ7P9F/vksLJy8H3fR+2DN38LYbch7Ry
 i3IdqngnHJvYqZIRtrH9nCbHKA+yRUj9uFZoQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  5 Sep 2020 11:24:04 +0300
Message-Id: <20200905082410.2230253-10-nikolay@cumulusnetworks.com>
In-Reply-To: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 09/15] net: bridge: mcast: delete
	expired port groups without srcs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

If an expired port group is in EXCLUDE mode, then we have to turn it
into INCLUDE mode, remove all srcs with zero timer and finally remove
the group itself if there are no more srcs with an active timer.
For IGMPv2 use there would be no sources, so this will reduce to just
removing the group as before.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a54d5fb810d1..e8d2f653344f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -222,15 +222,34 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 static void br_multicast_port_group_expired(struct timer_list *t)
 {
 	struct net_bridge_port_group *pg = from_timer(pg, t, timer);
+	struct net_bridge_group_src *src_ent;
 	struct net_bridge *br = pg->port->br;
+	struct hlist_node *tmp;
+	bool changed;
 
 	spin_lock(&br->multicast_lock);
 	if (!netif_running(br->dev) || timer_pending(&pg->timer) ||
 	    hlist_unhashed(&pg->mglist) || pg->flags & MDB_PG_FLAGS_PERMANENT)
 		goto out;
 
-	br_multicast_find_del_pg(br, pg);
+	changed = !!(pg->filter_mode == MCAST_EXCLUDE);
+	pg->filter_mode = MCAST_INCLUDE;
+	hlist_for_each_entry_safe(src_ent, tmp, &pg->src_list, node) {
+		if (!timer_pending(&src_ent->timer)) {
+			br_multicast_del_group_src(src_ent);
+			changed = true;
+		}
+	}
 
+	if (hlist_empty(&pg->src_list)) {
+		br_multicast_find_del_pg(br, pg);
+	} else if (changed) {
+		struct net_bridge_mdb_entry *mp = br_mdb_ip_get(br, &pg->addr);
+
+		if (WARN_ON(!mp))
+			goto out;
+		br_mdb_notify(br->dev, mp, pg, RTM_NEWMDB);
+	}
 out:
 	spin_unlock(&br->multicast_lock);
 }
-- 
2.25.4

