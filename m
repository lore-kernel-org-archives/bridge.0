Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/2Hp6zM1W+LZN6PtbeaytmNBZutIvxwrSMkcgkNRVFc=;
 b=y7/FYlZX0XlIs2bnp//8qtDAYl+ORuCg5XJWBd3TkwDtffTeiKnTvX9uf2FOjqP+wy
 6gnm9OvgBIlgcV0xVMl2tEwXsDyI78CDBhdyt0VAjt3UQIBcniYbpZKjaRF1DQR4xoZq
 PAfsPHYxM7PFkt9sNJRBm3+XiKIH3jGd9ag7z2qi8K++CHjBm/StoutTqEdsE4lZPoPy
 L62oxACq+mLhN4fQ00hQSXNNRxZMPQc6mTIWZyYUS11Ae7vaMsjMJOHOWkufm2JUBkyK
 WI1AloadLRrCNulh2DwwyEYd5twa4gN95TEWv8JtHULA0WtnFcIP+NSZEgWzdJP2BPhD
 SHzw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 15 Mar 2021 19:13:41 +0200
Message-Id: <20210315171342.232809-2-razor@blackwall.org>
In-Reply-To: <20210315171342.232809-1-razor@blackwall.org>
References: <20210315171342.232809-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 1/2] net: bridge: mcast: remove
	unreachable EHT code
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

In the initial EHT versions there were common functions which handled
allow/block messages for both INCLUDE and EXCLUDE modes, but later they
were separated. It seems I've left some common code which cannot be
reached because the filter mode is checked before calling the respective
functions, i.e. the host filter is always in EXCLUDE mode when using
__eht_allow_excl() and __eht_block_excl() thus we can drop the host_excl
checks inside and simplify the code a bit.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast_eht.c | 57 +++++++++--------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index fea38b9a7268..982398e44658 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -522,31 +522,24 @@ static bool __eht_allow_excl(struct net_bridge_port_group *pg,
 			     u32 nsrcs,
 			     size_t addr_size)
 {
-	bool changed = false, host_excl = false;
 	union net_bridge_eht_addr eht_src_addr;
 	struct net_bridge_group_src *src_ent;
+	bool changed = false;
 	struct br_ip src_ip;
 	u32 src_idx;
 
-	host_excl = !!(br_multicast_eht_host_filter_mode(pg, h_addr) == MCAST_EXCLUDE);
 	memset(&eht_src_addr, 0, sizeof(eht_src_addr));
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
 		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
-		if (!host_excl) {
-			br_multicast_create_eht_set_entry(pg, &eht_src_addr, h_addr,
-							  MCAST_INCLUDE,
-							  false);
-		} else {
-			if (!br_multicast_del_eht_set_entry(pg, &eht_src_addr,
-							    h_addr))
-				continue;
-			memcpy(&src_ip, srcs + (src_idx * addr_size), addr_size);
-			src_ent = br_multicast_find_group_src(pg, &src_ip);
-			if (!src_ent)
-				continue;
-			br_multicast_del_group_src(src_ent, true);
-			changed = true;
-		}
+		if (!br_multicast_del_eht_set_entry(pg, &eht_src_addr,
+						    h_addr))
+			continue;
+		memcpy(&src_ip, srcs + (src_idx * addr_size), addr_size);
+		src_ent = br_multicast_find_group_src(pg, &src_ip);
+		if (!src_ent)
+			continue;
+		br_multicast_del_group_src(src_ent, true);
+		changed = true;
 	}
 
 	return changed;
@@ -602,42 +595,22 @@ static bool __eht_block_incl(struct net_bridge_port_group *pg,
 	return changed;
 }
 
-static bool __eht_block_excl(struct net_bridge_port_group *pg,
+static void __eht_block_excl(struct net_bridge_port_group *pg,
 			     union net_bridge_eht_addr *h_addr,
 			     void *srcs,
 			     u32 nsrcs,
 			     size_t addr_size)
 {
-	bool changed = false, host_excl = false;
 	union net_bridge_eht_addr eht_src_addr;
-	struct net_bridge_group_src *src_ent;
-	struct br_ip src_ip;
 	u32 src_idx;
 
-	host_excl = !!(br_multicast_eht_host_filter_mode(pg, h_addr) == MCAST_EXCLUDE);
 	memset(&eht_src_addr, 0, sizeof(eht_src_addr));
-	memset(&src_ip, 0, sizeof(src_ip));
-	src_ip.proto = pg->key.addr.proto;
 	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
 		memcpy(&eht_src_addr, srcs + (src_idx * addr_size), addr_size);
-		if (host_excl) {
-			br_multicast_create_eht_set_entry(pg, &eht_src_addr, h_addr,
-							  MCAST_EXCLUDE,
-							  false);
-		} else {
-			if (!br_multicast_del_eht_set_entry(pg, &eht_src_addr,
-							    h_addr))
-				continue;
-			memcpy(&src_ip, srcs + (src_idx * addr_size), addr_size);
-			src_ent = br_multicast_find_group_src(pg, &src_ip);
-			if (!src_ent)
-				continue;
-			br_multicast_del_group_src(src_ent, true);
-			changed = true;
-		}
+		br_multicast_create_eht_set_entry(pg, &eht_src_addr, h_addr,
+						  MCAST_EXCLUDE,
+						  false);
 	}
-
-	return changed;
 }
 
 static bool br_multicast_eht_block(struct net_bridge_port_group *pg,
@@ -653,7 +626,7 @@ static bool br_multicast_eht_block(struct net_bridge_port_group *pg,
 		changed = __eht_block_incl(pg, h_addr, srcs, nsrcs, addr_size);
 		break;
 	case MCAST_EXCLUDE:
-		changed = __eht_block_excl(pg, h_addr, srcs, nsrcs, addr_size);
+		__eht_block_excl(pg, h_addr, srcs, nsrcs, addr_size);
 		break;
 	}
 
-- 
2.29.2

