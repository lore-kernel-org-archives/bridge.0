Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fZz7pbaMFBXMMthY41Q8WXcS+BZF9NZr318RJ38DIsk=;
 b=yhsXLFla7f+RYUqMuSi67fHFv/I/NIox181f3t4PaOeMA4hR2IjEUrCjfyqH+WJT5M
 sllGYxNIOCqfaoB7fIO5dpmFHq/xrYip6StSRwUOtHXpBT7Q19ltG1H30GoU/QvgG7No
 xVtjXvMltMkxnyno9Tz3nuHHoA6tY7bJXGC0KLuxSVKvTL39DF8qFf4YOraieqIAqfez
 SAPhkbl/j4hKfhl/Zy3Px74M2pp6csBi35ShRGS40tveH9BXkkzS2rjNF5I8I2Jj853D
 0It0t90cFpvnlJX53YNLoWZIrFJw0m4TKax4IlHV/AKhtyl1kteizoNdnqjj9e91m2un
 CxXg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 19 Jul 2021 20:06:30 +0300
Message-Id: <20210719170637.435541-9-razor@blackwall.org>
In-Reply-To: <20210719170637.435541-1-razor@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 08/15] net: bridge: multicast: use the
	port group to port context helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We need to use the new port group to port context helper in places where
we cannot pass down the proper context (i.e. functions that can be
called by timers or outside the packet snooping paths).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 353406f2971a..e61e23c0ce17 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -309,7 +309,9 @@ void br_multicast_star_g_handle_mode(struct net_bridge_port_group *pg,
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (!mp)
 		return;
-	pmctx = &pg->key.port->multicast_ctx;
+	pmctx = br_multicast_pg_to_port_ctx(pg);
+	if (!pmctx)
+		return;
 
 	memset(&sg_ip, 0, sizeof(sg_ip));
 	sg_ip = pg->key.addr;
@@ -435,7 +437,6 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
 	br_multicast_sg_host_state(star_mp, sg);
 	memset(&sg_key, 0, sizeof(sg_key));
 	sg_key.addr = sg->key.addr;
-	brmctx = &br->multicast_ctx;
 	/* we need to add all exclude ports to the S,G */
 	for (pg = mlock_dereference(star_mp->ports, br);
 	     pg;
@@ -449,7 +450,11 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
 		if (br_sg_port_find(br, &sg_key))
 			continue;
 
-		pmctx = &pg->key.port->multicast_ctx;
+		pmctx = br_multicast_pg_to_port_ctx(pg);
+		if (!pmctx)
+			continue;
+		brmctx = br_multicast_port_ctx_get_global(pmctx);
+
 		src_pg = __br_multicast_add_group(brmctx, pmctx,
 						  &sg->key.addr,
 						  sg->eth_addr,
@@ -473,7 +478,9 @@ static void br_multicast_fwd_src_add(struct net_bridge_group_src *src)
 		return;
 
 	memset(&sg_ip, 0, sizeof(sg_ip));
-	pmctx = &src->pg->key.port->multicast_ctx;
+	pmctx = br_multicast_pg_to_port_ctx(src->pg);
+	if (!pmctx)
+		return;
 	brmctx = br_multicast_port_ctx_get_global(pmctx);
 	sg_ip = src->pg->key.addr;
 	sg_ip.src = src->addr.src;
@@ -1696,8 +1703,10 @@ static void br_multicast_port_group_rexmit(struct timer_list *t)
 	    !br_opt_get(br, BROPT_MULTICAST_QUERIER))
 		goto out;
 
-	brmctx = &br->multicast_ctx;
-	pmctx = &pg->key.port->multicast_ctx;
+	pmctx = br_multicast_pg_to_port_ctx(pg);
+	if (!pmctx)
+		goto out;
+	brmctx = br_multicast_port_ctx_get_global(pmctx);
 	if (pg->key.addr.proto == htons(ETH_P_IP))
 		other_query = &brmctx->ip4_other_query;
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.31.1

