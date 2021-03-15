Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ESTLeD/rRbQ5zUXrpQ5m0lZ6N9szWSKZTky7aqh4MOU=;
 b=wpPPFeF9U8eYSajnF91c+M3CErL8izt8nMG5KcuEzkbRi7Cgk1AV1DE6aE3Bruqehw
 O2a2EVeRIvkxrLcEh9N+rkHP5OiXXBPliZqwKtdJ2k+T8QyoiJ8xLvvFKN2yGRekTYSw
 xZsTkHaxRmTK5blRe8rpaVx9HVhmwwIUjoGIs9A3T6wQjy7199vvLuuuNuqm9ZHJ0Qix
 FKXSZjNJa5fceqrzhkqtDFsNNbNwUe8avZqE1LEno0gvZ1b3Nvu82C0CR0Oo80eRa0yF
 3FABXlNPA7k/kvTI2D41qJGmPuMj1Md8pz96j9RRd/Aw6YTPEmyFLgR6APxrC/DMnP4I
 PPOg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 15 Mar 2021 19:13:42 +0200
Message-Id: <20210315171342.232809-3-razor@blackwall.org>
In-Reply-To: <20210315171342.232809-1-razor@blackwall.org>
References: <20210315171342.232809-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 2/2] net: bridge: mcast: factor out
	common allow/block EHT handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We hande EHT state change for ALLOW messages in INCLUDE mode and for
BLOCK messages in EXCLUDE mode similarly - create the new set entries
with the proper filter mode. We also handle EHT state change for ALLOW
messages in EXCLUDE mode and for BLOCK messages in INCLUDE mode in a
similar way - delete the common entries (current set and new set).
Factor out all the common code as follows:
 - ALLOW/INCLUDE, BLOCK/EXCLUDE: call __eht_create_set_entries()
 - ALLOW/EXCLUDE, BLOCK/INCLUDE: call __eht_del_common_set_entries()

The set entries creation can be reused in __eht_inc_exc() as well.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast_eht.c | 98 ++++++++++-------------------------
 1 file changed, 27 insertions(+), 71 deletions(-)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index 982398e44658..13290a749d09 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -498,11 +498,13 @@ static void br_multicast_del_eht_host(struct net_bridge_port_group *pg,
 					       &set_h->h_addr);
 }
 
-static void __eht_allow_incl(struct net_bridge_port_group *pg,
-			     union net_bridge_eht_addr *h_addr,
-			     void *srcs,
-			     u32 nsrcs,
-			     size_t addr_size)
+/* create new set entries from reports */
+static void __eht_create_set_entries(struct net_bridge_port_group *pg,
+				     union net_bridge_eht_addr *h_addr,
+				     void *srcs,
+				     u32 nsrcs,
+				     size_t addr_size,
+				     int filter_mode)
 {
 	union net_bridge_eht_addr eht_src_addr;
 	u32 src_idx;
@@ -511,16 +513,17 @@ static void __eht_allow_incl(struct net_bridge_port_group *pg,
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
 		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
 		br_multicast_create_eht_set_entry(pg, &eht_src_addr, h_addr,
-						  MCAST_INCLUDE,
+						  filter_mode,
 						  false);
 	}
 }
 
-static bool __eht_allow_excl(struct net_bridge_port_group *pg,
-			     union net_bridge_eht_addr *h_addr,
-			     void *srcs,
-			     u32 nsrcs,
-			     size_t addr_size)
+/* delete existing set entries and their (S,G) entries if they were the last */
+static bool __eht_del_set_entries(struct net_bridge_port_group *pg,
+				  union net_bridge_eht_addr *h_addr,
+				  void *srcs,
+				  u32 nsrcs,
+				  size_t addr_size)
 {
 	union net_bridge_eht_addr eht_src_addr;
 	struct net_bridge_group_src *src_ent;
@@ -529,10 +532,11 @@ static bool __eht_allow_excl(struct net_bridge_port_group *pg,
 	u32 src_idx;
 
 	memset(&eht_src_addr, 0, sizeof(eht_src_addr));
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
 		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
-		if (!br_multicast_del_eht_set_entry(pg, &eht_src_addr,
-						    h_addr))
+		if (!br_multicast_del_eht_set_entry(pg, &eht_src_addr, h_addr))
 			continue;
 		memcpy(&src_ip, srcs + (src_idx * addr_size), addr_size);
 		src_ent = br_multicast_find_group_src(pg, &src_ip);
@@ -555,64 +559,18 @@ static bool br_multicast_eht_allow(struct net_bridge_port_group *pg,
 
 	switch (br_multicast_eht_host_filter_mode(pg, h_addr)) {
 	case MCAST_INCLUDE:
-		__eht_allow_incl(pg, h_addr, srcs, nsrcs, addr_size);
+		__eht_create_set_entries(pg, h_addr, srcs, nsrcs, addr_size,
+					 MCAST_INCLUDE);
 		break;
 	case MCAST_EXCLUDE:
-		changed = __eht_allow_excl(pg, h_addr, srcs, nsrcs, addr_size);
+		changed = __eht_del_set_entries(pg, h_addr, srcs, nsrcs,
+						addr_size);
 		break;
 	}
 
 	return changed;
 }
 
-static bool __eht_block_incl(struct net_bridge_port_group *pg,
-			     union net_bridge_eht_addr *h_addr,
-			     void *srcs,
-			     u32 nsrcs,
-			     size_t addr_size)
-{
-	union net_bridge_eht_addr eht_src_addr;
-	struct net_bridge_group_src *src_ent;
-	bool changed = false;
-	struct br_ip src_ip;
-	u32 src_idx;
-
-	memset(&eht_src_addr, 0, sizeof(eht_src_addr));
-	memset(&src_ip, 0, sizeof(src_ip));
-	src_ip.proto = pg->key.addr.proto;
-	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
-		if (!br_multicast_del_eht_set_entry(pg, &eht_src_addr, h_addr))
-			continue;
-		memcpy(&src_ip, srcs + (src_idx * addr_size), addr_size);
-		src_ent = br_multicast_find_group_src(pg, &src_ip);
-		if (!src_ent)
-			continue;
-		br_multicast_del_group_src(src_ent, true);
-		changed = true;
-	}
-
-	return changed;
-}
-
-static void __eht_block_excl(struct net_bridge_port_group *pg,
-			     union net_bridge_eht_addr *h_addr,
-			     void *srcs,
-			     u32 nsrcs,
-			     size_t addr_size)
-{
-	union net_bridge_eht_addr eht_src_addr;
-	u32 src_idx;
-
-	memset(&eht_src_addr, 0, sizeof(eht_src_addr));
-	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
-		br_multicast_create_eht_set_entry(pg, &eht_src_addr, h_addr,
-						  MCAST_EXCLUDE,
-						  false);
-	}
-}
-
 static bool br_multicast_eht_block(struct net_bridge_port_group *pg,
 				   union net_bridge_eht_addr *h_addr,
 				   void *srcs,
@@ -623,10 +581,12 @@ static bool br_multicast_eht_block(struct net_bridge_port_group *pg,
 
 	switch (br_multicast_eht_host_filter_mode(pg, h_addr)) {
 	case MCAST_INCLUDE:
-		changed = __eht_block_incl(pg, h_addr, srcs, nsrcs, addr_size);
+		changed = __eht_del_set_entries(pg, h_addr, srcs, nsrcs,
+						addr_size);
 		break;
 	case MCAST_EXCLUDE:
-		__eht_block_excl(pg, h_addr, srcs, nsrcs, addr_size);
+		__eht_create_set_entries(pg, h_addr, srcs, nsrcs, addr_size,
+					 MCAST_EXCLUDE);
 		break;
 	}
 
@@ -644,7 +604,6 @@ static bool __eht_inc_exc(struct net_bridge_port_group *pg,
 {
 	bool changed = false, flush_entries = to_report;
 	union net_bridge_eht_addr eht_src_addr;
-	u32 src_idx;
 
 	if (br_multicast_eht_host_filter_mode(pg, h_addr) != filter_mode)
 		flush_entries = true;
@@ -653,11 +612,8 @@ static bool __eht_inc_exc(struct net_bridge_port_group *pg,
 	/* if we're changing mode del host and its entries */
 	if (flush_entries)
 		br_multicast_del_eht_host(pg, h_addr);
-	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
-		br_multicast_create_eht_set_entry(pg, &eht_src_addr, h_addr,
-						  filter_mode, false);
-	}
+	__eht_create_set_entries(pg, h_addr, srcs, nsrcs, addr_size,
+				 filter_mode);
 	/* we can be missing sets only if we've deleted some entries */
 	if (flush_entries) {
 		struct net_bridge *br = pg->key.port->br;
-- 
2.29.2

