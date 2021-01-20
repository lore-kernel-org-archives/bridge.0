Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MnBmjMXyQmfivJvallBlhYYXMX6/FH96w5B1UWhHM0o=;
 b=wKwL3qap9nVEkDwBujNdVmLKwm2mOLFvcXORfuml+1JsXZEBFRRlkf4i4meoAvQqPO
 a2V2DsrVv0t1eOsrTz0DIdzBkzHrsctILlBakd3HKi0/MepvTBd1kD41PyBaIPMfT7jw
 EjwksAvJctlW8+xrdIZpSu/AmMnAWtpMtpTM6cYqgm7fVyeD6DEP514ipnbvsg/mOzBe
 m4Zi5i/oZD7QLk7wXE4ClCyZaguE69ZYW8eht9a27uIHwNMoNK4f0LthN1WoBdezIv1w
 cO/lgE6L0AJJIYQ9ZXjCvLQk3NrxW6MAWhi3+LLoZGczrjVO0dtDjGY8GNXNHbHC4Aih
 +6xg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:51:50 +0200
Message-Id: <20210120145203.1109140-2-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 01/14] net: bridge: multicast: rename
	src_size to addr_size
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

Rename src_size argument to addr_size in preparation for passing host
address as an argument to IGMPv3/MLDv2 functions.
No functional change.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 78 +++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 257ac4e25f6d..3ae2cef6f7ec 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1800,7 +1800,7 @@ static void __grp_send_query_and_rexmit(struct net_bridge_port_group *pg)
  * EXCLUDE (X,Y)  ALLOW (A)     EXCLUDE (X+A,Y-A)        (A)=GMI
  */
 static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg,
-				     void *srcs, u32 nsrcs, size_t src_size)
+				     void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge *br = pg->key.port->br;
 	struct net_bridge_group_src *ent;
@@ -1812,7 +1812,7 @@ static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (!ent) {
 			ent = br_multicast_new_group_src(pg, &src_ip);
@@ -1822,7 +1822,7 @@ static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg,
 
 		if (ent)
 			__grp_src_mod_timer(ent, now + br_multicast_gmi(br));
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	return changed;
@@ -1834,7 +1834,7 @@ static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg,
  *                                                       Group Timer=GMI
  */
 static void __grp_src_isexc_incl(struct net_bridge_port_group *pg,
-				 void *srcs, u32 nsrcs, size_t src_size)
+				 void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge_group_src *ent;
 	struct br_ip src_ip;
@@ -1846,7 +1846,7 @@ static void __grp_src_isexc_incl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent)
 			ent->flags &= ~BR_SGRP_F_DELETE;
@@ -1854,7 +1854,7 @@ static void __grp_src_isexc_incl(struct net_bridge_port_group *pg,
 			ent = br_multicast_new_group_src(pg, &src_ip);
 		if (ent)
 			br_multicast_fwd_src_handle(ent);
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	__grp_src_delete_marked(pg);
@@ -1867,7 +1867,7 @@ static void __grp_src_isexc_incl(struct net_bridge_port_group *pg,
  *                                                       Group Timer=GMI
  */
 static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg,
-				 void *srcs, u32 nsrcs, size_t src_size)
+				 void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge *br = pg->key.port->br;
 	struct net_bridge_group_src *ent;
@@ -1882,7 +1882,7 @@ static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags &= ~BR_SGRP_F_DELETE;
@@ -1894,7 +1894,7 @@ static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg,
 				changed = true;
 			}
 		}
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	if (__grp_src_delete_marked(pg))
@@ -1904,19 +1904,19 @@ static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg,
 }
 
 static bool br_multicast_isexc(struct net_bridge_port_group *pg,
-			       void *srcs, u32 nsrcs, size_t src_size)
+			       void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge *br = pg->key.port->br;
 	bool changed = false;
 
 	switch (pg->filter_mode) {
 	case MCAST_INCLUDE:
-		__grp_src_isexc_incl(pg, srcs, nsrcs, src_size);
+		__grp_src_isexc_incl(pg, srcs, nsrcs, addr_size);
 		br_multicast_star_g_handle_mode(pg, MCAST_EXCLUDE);
 		changed = true;
 		break;
 	case MCAST_EXCLUDE:
-		changed = __grp_src_isexc_excl(pg, srcs, nsrcs, src_size);
+		changed = __grp_src_isexc_excl(pg, srcs, nsrcs, addr_size);
 		break;
 	}
 
@@ -1931,7 +1931,7 @@ static bool br_multicast_isexc(struct net_bridge_port_group *pg,
  *                                                       Send Q(G,A-B)
  */
 static bool __grp_src_toin_incl(struct net_bridge_port_group *pg,
-				void *srcs, u32 nsrcs, size_t src_size)
+				void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge *br = pg->key.port->br;
 	u32 src_idx, to_send = pg->src_ents;
@@ -1946,7 +1946,7 @@ static bool __grp_src_toin_incl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags &= ~BR_SGRP_F_SEND;
@@ -1958,7 +1958,7 @@ static bool __grp_src_toin_incl(struct net_bridge_port_group *pg,
 		}
 		if (ent)
 			__grp_src_mod_timer(ent, now + br_multicast_gmi(br));
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -1973,7 +1973,7 @@ static bool __grp_src_toin_incl(struct net_bridge_port_group *pg,
  *                                                       Send Q(G)
  */
 static bool __grp_src_toin_excl(struct net_bridge_port_group *pg,
-				void *srcs, u32 nsrcs, size_t src_size)
+				void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge *br = pg->key.port->br;
 	u32 src_idx, to_send = pg->src_ents;
@@ -1989,7 +1989,7 @@ static bool __grp_src_toin_excl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			if (timer_pending(&ent->timer)) {
@@ -2003,7 +2003,7 @@ static bool __grp_src_toin_excl(struct net_bridge_port_group *pg,
 		}
 		if (ent)
 			__grp_src_mod_timer(ent, now + br_multicast_gmi(br));
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -2015,16 +2015,16 @@ static bool __grp_src_toin_excl(struct net_bridge_port_group *pg,
 }
 
 static bool br_multicast_toin(struct net_bridge_port_group *pg,
-			      void *srcs, u32 nsrcs, size_t src_size)
+			      void *srcs, u32 nsrcs, size_t addr_size)
 {
 	bool changed = false;
 
 	switch (pg->filter_mode) {
 	case MCAST_INCLUDE:
-		changed = __grp_src_toin_incl(pg, srcs, nsrcs, src_size);
+		changed = __grp_src_toin_incl(pg, srcs, nsrcs, addr_size);
 		break;
 	case MCAST_EXCLUDE:
-		changed = __grp_src_toin_excl(pg, srcs, nsrcs, src_size);
+		changed = __grp_src_toin_excl(pg, srcs, nsrcs, addr_size);
 		break;
 	}
 
@@ -2038,7 +2038,7 @@ static bool br_multicast_toin(struct net_bridge_port_group *pg,
  *                                                       Group Timer=GMI
  */
 static void __grp_src_toex_incl(struct net_bridge_port_group *pg,
-				void *srcs, u32 nsrcs, size_t src_size)
+				void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge_group_src *ent;
 	u32 src_idx, to_send = 0;
@@ -2050,7 +2050,7 @@ static void __grp_src_toex_incl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags = (ent->flags & ~BR_SGRP_F_DELETE) |
@@ -2061,7 +2061,7 @@ static void __grp_src_toex_incl(struct net_bridge_port_group *pg,
 		}
 		if (ent)
 			br_multicast_fwd_src_handle(ent);
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	__grp_src_delete_marked(pg);
@@ -2077,7 +2077,7 @@ static void __grp_src_toex_incl(struct net_bridge_port_group *pg,
  *                                                       Group Timer=GMI
  */
 static bool __grp_src_toex_excl(struct net_bridge_port_group *pg,
-				void *srcs, u32 nsrcs, size_t src_size)
+				void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge_group_src *ent;
 	u32 src_idx, to_send = 0;
@@ -2090,7 +2090,7 @@ static bool __grp_src_toex_excl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags &= ~BR_SGRP_F_DELETE;
@@ -2105,7 +2105,7 @@ static bool __grp_src_toex_excl(struct net_bridge_port_group *pg,
 			ent->flags |= BR_SGRP_F_SEND;
 			to_send++;
 		}
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	if (__grp_src_delete_marked(pg))
@@ -2117,19 +2117,19 @@ static bool __grp_src_toex_excl(struct net_bridge_port_group *pg,
 }
 
 static bool br_multicast_toex(struct net_bridge_port_group *pg,
-			      void *srcs, u32 nsrcs, size_t src_size)
+			      void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge *br = pg->key.port->br;
 	bool changed = false;
 
 	switch (pg->filter_mode) {
 	case MCAST_INCLUDE:
-		__grp_src_toex_incl(pg, srcs, nsrcs, src_size);
+		__grp_src_toex_incl(pg, srcs, nsrcs, addr_size);
 		br_multicast_star_g_handle_mode(pg, MCAST_EXCLUDE);
 		changed = true;
 		break;
 	case MCAST_EXCLUDE:
-		changed = __grp_src_toex_excl(pg, srcs, nsrcs, src_size);
+		changed = __grp_src_toex_excl(pg, srcs, nsrcs, addr_size);
 		break;
 	}
 
@@ -2143,7 +2143,7 @@ static bool br_multicast_toex(struct net_bridge_port_group *pg,
  * INCLUDE (A)    BLOCK (B)     INCLUDE (A)              Send Q(G,A*B)
  */
 static void __grp_src_block_incl(struct net_bridge_port_group *pg,
-				 void *srcs, u32 nsrcs, size_t src_size)
+				 void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge_group_src *ent;
 	u32 src_idx, to_send = 0;
@@ -2155,13 +2155,13 @@ static void __grp_src_block_incl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (ent) {
 			ent->flags |= BR_SGRP_F_SEND;
 			to_send++;
 		}
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -2176,7 +2176,7 @@ static void __grp_src_block_incl(struct net_bridge_port_group *pg,
  *                                                       Send Q(G,A-Y)
  */
 static bool __grp_src_block_excl(struct net_bridge_port_group *pg,
-				 void *srcs, u32 nsrcs, size_t src_size)
+				 void *srcs, u32 nsrcs, size_t addr_size)
 {
 	struct net_bridge_group_src *ent;
 	u32 src_idx, to_send = 0;
@@ -2189,7 +2189,7 @@ static bool __grp_src_block_excl(struct net_bridge_port_group *pg,
 	memset(&src_ip, 0, sizeof(src_ip));
 	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
-		memcpy(&src_ip.src, srcs, src_size);
+		memcpy(&src_ip.src, srcs, addr_size);
 		ent = br_multicast_find_group_src(pg, &src_ip);
 		if (!ent) {
 			ent = br_multicast_new_group_src(pg, &src_ip);
@@ -2202,7 +2202,7 @@ static bool __grp_src_block_excl(struct net_bridge_port_group *pg,
 			ent->flags |= BR_SGRP_F_SEND;
 			to_send++;
 		}
-		srcs += src_size;
+		srcs += addr_size;
 	}
 
 	if (to_send)
@@ -2212,16 +2212,16 @@ static bool __grp_src_block_excl(struct net_bridge_port_group *pg,
 }
 
 static bool br_multicast_block(struct net_bridge_port_group *pg,
-			       void *srcs, u32 nsrcs, size_t src_size)
+			       void *srcs, u32 nsrcs, size_t addr_size)
 {
 	bool changed = false;
 
 	switch (pg->filter_mode) {
 	case MCAST_INCLUDE:
-		__grp_src_block_incl(pg, srcs, nsrcs, src_size);
+		__grp_src_block_incl(pg, srcs, nsrcs, addr_size);
 		break;
 	case MCAST_EXCLUDE:
-		changed = __grp_src_block_excl(pg, srcs, nsrcs, src_size);
+		changed = __grp_src_block_excl(pg, srcs, nsrcs, addr_size);
 		break;
 	}
 
-- 
2.29.2

