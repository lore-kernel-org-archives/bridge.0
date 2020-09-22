Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lgky1A3hcxj1MPtWkJkYb67UkAbVS/Usr+n+qMifYIA=;
 b=D9zwAmGUM54LtuP3P/O2wzkfZbni95Q/pHqtDgCzfV1+SnOogIxIiIJ/Xg8OgXCfxU
 ZMYuk+ERH7UshjPCmzrgYeIqSV6yAFddsBImTyJwpkJBW0B6SPlC0DWR5cEydajgZyKT
 zicEsvB/+2jOykq2PdOQ3INZLI4Kv1/ZVZh+08baP46DUXg5IfJ4h3eE+eHXTcahD1Yl
 mi7eoWqtLBpxBHJaVhQMpFfKPg9JuGMGyQCYFHx30A29AGlSgyS/JdMW2Qo+spb/1Uj8
 VyDKmRnGkLtb+Ip3OKJK4AipSfFOeBkrpJw5CrGhXuSq7340F7e2TFlWJrS8WnZLf5iI
 SQ8A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 22 Sep 2020 10:30:26 +0300
Message-Id: <20200922073027.1196992-16-razor@blackwall.org>
In-Reply-To: <20200922073027.1196992-1-razor@blackwall.org>
References: <20200922073027.1196992-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 15/16] net: bridge: mcast: handle host
	state
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

Since host joins are considered as EXCLUDE {} joins we need to reflect
that in all of *,G ports' S,G entries. Since the S,Gs can have
host_joined == true only set automatically we can safely set it to false
when removing all automatically added entries upon S,G delete.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 11d224c01914..66eb62ded192 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -286,6 +286,53 @@ void br_multicast_star_g_handle_mode(struct net_bridge_port_group *pg,
 	}
 }
 
+/* called when adding a new S,G with host_joined == false by default */
+static void br_multicast_sg_host_state(struct net_bridge_mdb_entry *star_mp,
+				       struct net_bridge_port_group *sg)
+{
+	struct net_bridge_mdb_entry *sg_mp;
+
+	if (WARN_ON(!br_multicast_is_star_g(&star_mp->addr)))
+		return;
+	if (!star_mp->host_joined)
+		return;
+
+	sg_mp = br_mdb_ip_get(star_mp->br, &sg->key.addr);
+	if (!sg_mp)
+		return;
+	sg_mp->host_joined = true;
+}
+
+/* set the host_joined state of all of *,G's S,G entries */
+static void br_multicast_star_g_host_state(struct net_bridge_mdb_entry *star_mp)
+{
+	struct net_bridge *br = star_mp->br;
+	struct net_bridge_mdb_entry *sg_mp;
+	struct net_bridge_port_group *pg;
+	struct br_ip sg_ip;
+
+	if (WARN_ON(!br_multicast_is_star_g(&star_mp->addr)))
+		return;
+
+	memset(&sg_ip, 0, sizeof(sg_ip));
+	sg_ip = star_mp->addr;
+	for (pg = mlock_dereference(star_mp->ports, br);
+	     pg;
+	     pg = mlock_dereference(pg->next, br)) {
+		struct net_bridge_group_src *src_ent;
+
+		hlist_for_each_entry(src_ent, &pg->src_list, node) {
+			if (!(src_ent->flags & BR_SGRP_F_INSTALLED))
+				continue;
+			sg_ip.src = src_ent->addr.src;
+			sg_mp = br_mdb_ip_get(br, &sg_ip);
+			if (!sg_mp)
+				continue;
+			sg_mp->host_joined = star_mp->host_joined;
+		}
+	}
+}
+
 static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 {
 	struct net_bridge_port_group __rcu **pp;
@@ -305,6 +352,12 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 				  MDB_PG_FLAGS_PERMANENT)))
 			return;
 
+	/* currently the host can only have joined the *,G which means
+	 * we treat it as EXCLUDE {}, so for an S,G it's considered a
+	 * STAR_EXCLUDE entry and we can safely leave it
+	 */
+	sgmp->host_joined = false;
+
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
 		if (!(p->flags & MDB_PG_FLAGS_PERMANENT))
@@ -326,6 +379,7 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
 	if (WARN_ON(!br_multicast_is_star_g(&star_mp->addr)))
 		return;
 
+	br_multicast_sg_host_state(star_mp, sg);
 	memset(&sg_key, 0, sizeof(sg_key));
 	sg_key.addr = sg->key.addr;
 	/* we need to add all exclude ports to the S,G */
@@ -1143,6 +1197,8 @@ void br_multicast_host_join(struct net_bridge_mdb_entry *mp, bool notify)
 {
 	if (!mp->host_joined) {
 		mp->host_joined = true;
+		if (br_multicast_is_star_g(&mp->addr))
+			br_multicast_star_g_host_state(mp);
 		if (notify)
 			br_mdb_notify(mp->br->dev, mp, NULL, RTM_NEWMDB);
 	}
@@ -1155,6 +1211,8 @@ void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify)
 		return;
 
 	mp->host_joined = false;
+	if (br_multicast_is_star_g(&mp->addr))
+		br_multicast_star_g_host_state(mp);
 	if (notify)
 		br_mdb_notify(mp->br->dev, mp, NULL, RTM_DELMDB);
 }
-- 
2.25.4

