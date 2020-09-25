Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/bSXHNtdU+eEhzycYVit0PPbYq40mXuagPAzmTwFhXc=;
 b=uAHSdiWaP3q78YXDSbkvEyYy9k/VwxAC2Z9ITTrMvZ9VOj4FEjwkgcprsNBzLSC9ae
 N7tp9gnZSzunQ+kmGYqGNgGOTcNgDT42pYAocl0crhCbhEqhX03kWeIoudh5b2Cq4hYN
 1e6RROvVfDvfijmhyfTtRlpHENORCIH/u8Gvnj+5+reepo+J8sBPhdtXDxAPE9HPvOTc
 UnpWNGCzdPdjYtFQWuJvo0JcWsesui7JTZ9uMb6CPam5YNDHi7iR2e5g523g3EIbBYo9
 20wpaBe2nmuUoOxwJL48aM5+xfat5r/BnpyrxPnFfg3y45FPOUQkmjqAVxxwpWVQWTHL
 ypAQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 25 Sep 2020 13:25:49 +0300
Message-Id: <20200925102549.1704905-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: mcast: remove only S,
	G port groups from sg_port hash
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We should remove a group from the sg_port hash only if it's an S,G
entry. This makes it correct and more symmetric with group add. Also
since *,G groups are not added to that hash we can hide a bug.

Fixes: 085b53c8beab ("net: bridge: mcast: add sg_port rhashtable")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 66eb62ded192..eae898c3cff7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -590,17 +590,18 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct net_bridge_group_src *ent;
 	struct hlist_node *tmp;
 
-	rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
-			       br_sg_port_rht_params);
 	rcu_assign_pointer(*pp, pg->next);
 	hlist_del_init(&pg->mglist);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent);
 	br_mdb_notify(br->dev, mp, pg, RTM_DELMDB);
-	if (!br_multicast_is_star_g(&mp->addr))
+	if (!br_multicast_is_star_g(&mp->addr)) {
+		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
+				       br_sg_port_rht_params);
 		br_multicast_sg_del_exclude_ports(mp);
-	else
+	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
+	}
 	hlist_add_head(&pg->mcast_gc.gc_node, &br->mcast_gc_list);
 	queue_work(system_long_wq, &br->mcast_gc_work);
 
-- 
2.25.4

