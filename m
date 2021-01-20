Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tmDUabnqk1Pty9P4k0A64Em1MebogJSVfDgcn6fzSUI=;
 b=SO6ZvCIn9S8u1uv792Ep9fk19Ucb4M5W59iyd6dVwKqWs4iumavWFIJAb3t2miittn
 SsbJwBzgzzHT6p6d62RFNuGx7I0SVaxbqCwwnlWFYJnhBbMAvBVNhFxVluobQKjg7g7p
 CxqJdDRgiCCm1ZHa4vpXrPHDOWc6rLWx8GF21z29a8SxGBNtLn2UCdkGnP4T85bnWgkP
 jAa8iNrx9ubDft/rwnz6W1ik1HQy1tFidNAXmkpLpTBf4BeOShEgb/+Pms/bfDBHyJZL
 XNYcRxb5LaYRQ/YBryIxIzagge2j8WA4R01w19Ve7U041p07xsOLSLFwgvAJq7gzYJ+Q
 1Tpw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:51:53 +0200
Message-Id: <20210120145203.1109140-5-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 04/14] net: bridge: multicast: calculate
	idx position without changing ptr
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

We need to preserve the srcs pointer since we'll be passing it for EHT
handling later.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 79569a398669..f8b685ae56d4 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1812,7 +1812,7 @@ static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg, void *h_a
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (!ent) {
 			ent = br_multicast_new_group_src(pg, &src_ip);
@@ -1822,7 +1822,6 @@ static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg, void *h_a
 
 		if (ent)
 			__grp_src_mod_timer(ent, now + br_multicast_gmi(br));
-		srcs += addr_size;
 	}
 
 	return changed;
@@ -1846,7 +1845,7 @@ static void __grp_src_isexc_incl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent)
 			ent->flags &= ~BR_SGRP_F_DELETE;
@@ -1854,7 +1853,6 @@ static void __grp_src_isexc_incl(struct net_bridge_port_group *pg, void *h_addr,
 			ent = br_multicast_new_group_src(pg, &src_ip);
 		if (ent)
 			br_multicast_fwd_src_handle(ent);
-		srcs += addr_size;
 	}
 
 	__grp_src_delete_marked(pg);
@@ -1882,7 +1880,7 @@ static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags &= ~BR_SGRP_F_DELETE;
@@ -1894,7 +1892,6 @@ static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg, void *h_addr,
 				changed = true;
 			}
 		}
-		srcs += addr_size;
 	}
 
 	if (__grp_src_delete_marked(pg))
@@ -1946,7 +1943,7 @@ static bool __grp_src_toin_incl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags &= ~BR_SGRP_F_SEND;
@@ -1958,7 +1955,6 @@ static bool __grp_src_toin_incl(struct net_bridge_port_group *pg, void *h_addr,
 		}
 		if (ent)
 			__grp_src_mod_timer(ent, now + br_multicast_gmi(br));
-		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -1989,7 +1985,7 @@ static bool __grp_src_toin_excl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			if (timer_pending(&ent->timer)) {
@@ -2003,7 +1999,6 @@ static bool __grp_src_toin_excl(struct net_bridge_port_group *pg, void *h_addr,
 		}
 		if (ent)
 			__grp_src_mod_timer(ent, now + br_multicast_gmi(br));
-		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -2050,7 +2045,7 @@ static void __grp_src_toex_incl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags = (ent->flags & ~BR_SGRP_F_DELETE) |
@@ -2061,7 +2056,6 @@ static void __grp_src_toex_incl(struct net_bridge_port_group *pg, void *h_addr,
 		}
 		if (ent)
 			br_multicast_fwd_src_handle(ent);
-		srcs += addr_size;
 	}
 
 	__grp_src_delete_marked(pg);
@@ -2090,7 +2084,7 @@ static bool __grp_src_toex_excl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags &= ~BR_SGRP_F_DELETE;
@@ -2105,7 +2099,6 @@ static bool __grp_src_toex_excl(struct net_bridge_port_group *pg, void *h_addr,
 			ent->flags |= BR_SGRP_F_SEND;
 			to_send++;
 		}
-		srcs += addr_size;
 	}
 
 	if (__grp_src_delete_marked(pg))
@@ -2156,13 +2149,12 @@ static bool __grp_src_block_incl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags |= BR_SGRP_F_SEND;
 			to_send++;
 		}
-		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -2197,7 +2189,7 @@ static bool __grp_src_block_excl(struct net_bridge_port_group *pg, void *h_addr,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, addr_size);
+		memcpy(&src_ip.src, srcs + (src_idx * addr_size), addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (!ent) {
 			ent = br_multicast_new_group_src(pg, &src_ip);
@@ -2210,7 +2202,6 @@ static bool __grp_src_block_excl(struct net_bridge_port_group *pg, void *h_addr,
 			ent->flags |= BR_SGRP_F_SEND;
 			to_send++;
 		}
-		srcs += addr_size;
 	}
 
 	if (to_send)
-- 
2.29.2

