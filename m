Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rBlZYF2o52MYtK2vITqo4Rc1vI3ePaP0/DCNSe/XPoY=;
 b=KcYG9+ZnGLH4Muqrdwz/1igcQfxu847z8W86Kcvn8NXa2DiqBWegZBHSs8MliNFzfU
 G/ZT3anEs++z/SRnEiKMy48pftEK/UhsvDkg0KMYFLX2lepBodVQx5Iecmsm4GShiCkQ
 Hkrju8uVQ8tvqwli9m8GVACMLhk/V67xfj+C0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon,  7 Sep 2020 12:56:17 +0300
Message-Id: <20200907095619.11216-14-nikolay@cumulusnetworks.com>
In-Reply-To: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
References: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 13/15] net: bridge: mcast: support for
	IGMPV3/MLDv2 BLOCK_OLD_SOURCES report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

We already have all necessary helpers, so process IGMPV3/MLDv2
BLOCK_OLD_SOURCES as per the RFCs.

v3: add IPv6/MLDv2 support
v2: directly do flag bit operations

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index bce5560709d1..6cfac6cbaf3b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1663,6 +1663,95 @@ static bool br_multicast_toex(struct net_bridge_port_group *pg,
 	return changed;
 }
 
+/* State          Msg type      New state                Actions
+ * INCLUDE (A)    BLOCK (B)     INCLUDE (A)              Send Q(G,A*B)
+ */
+static void __grp_src_block_incl(struct net_bridge_port_group *pg,
+				 void *srcs, u32 nsrcs, size_t src_size)
+{
+	struct net_bridge_group_src *ent;
+	u32 src_idx, to_send = 0;
+	struct br_ip src_ip;
+
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags &= ~BR_SGRP_F_SEND;
+
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = pg->addr.proto;
+	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
+		memcpy(&src_ip.u, srcs, src_size);
+		ent = br_multicast_find_group_src(pg, &src_ip);
+		if (ent) {
+			ent->flags |= BR_SGRP_F_SEND;
+			to_send++;
+		}
+		srcs += src_size;
+	}
+
+	if (to_send)
+		__grp_src_query_marked_and_rexmit(pg);
+
+	if (pg->filter_mode == MCAST_INCLUDE && hlist_empty(&pg->src_list))
+		br_multicast_find_del_pg(pg->port->br, pg);
+}
+
+/* State          Msg type      New state                Actions
+ * EXCLUDE (X,Y)  BLOCK (A)     EXCLUDE (X+(A-Y),Y)      (A-X-Y)=Group Timer
+ *                                                       Send Q(G,A-Y)
+ */
+static bool __grp_src_block_excl(struct net_bridge_port_group *pg,
+				 void *srcs, u32 nsrcs, size_t src_size)
+{
+	struct net_bridge_group_src *ent;
+	u32 src_idx, to_send = 0;
+	bool changed = false;
+	struct br_ip src_ip;
+
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags &= ~BR_SGRP_F_SEND;
+
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = pg->addr.proto;
+	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
+		memcpy(&src_ip.u, srcs, src_size);
+		ent = br_multicast_find_group_src(pg, &src_ip);
+		if (!ent) {
+			ent = br_multicast_new_group_src(pg, &src_ip);
+			if (ent) {
+				mod_timer(&ent->timer, pg->timer.expires);
+				changed = true;
+			}
+		}
+		if (ent && timer_pending(&ent->timer)) {
+			ent->flags |= BR_SGRP_F_SEND;
+			to_send++;
+		}
+		srcs += src_size;
+	}
+
+	if (to_send)
+		__grp_src_query_marked_and_rexmit(pg);
+
+	return changed;
+}
+
+static bool br_multicast_block(struct net_bridge_port_group *pg,
+			       void *srcs, u32 nsrcs, size_t src_size)
+{
+	bool changed = false;
+
+	switch (pg->filter_mode) {
+	case MCAST_INCLUDE:
+		__grp_src_block_incl(pg, srcs, nsrcs, src_size);
+		break;
+	case MCAST_EXCLUDE:
+		changed = __grp_src_block_excl(pg, srcs, nsrcs, src_size);
+		break;
+	}
+
+	return changed;
+}
+
 static struct net_bridge_port_group *
 br_multicast_find_port(struct net_bridge_mdb_entry *mp,
 		       struct net_bridge_port *p,
@@ -1776,6 +1865,10 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge *br,
 			changed = br_multicast_toex(pg, grec->grec_src, nsrcs,
 						    sizeof(__be32));
 			break;
+		case IGMPV3_BLOCK_OLD_SOURCES:
+			changed = br_multicast_block(pg, grec->grec_src, nsrcs,
+						     sizeof(__be32));
+			break;
 		}
 		if (changed)
 			br_mdb_notify(br->dev, mdst, pg, RTM_NEWMDB);
@@ -1898,6 +1991,10 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 			changed = br_multicast_toex(pg, grec->grec_src, nsrcs,
 						    sizeof(struct in6_addr));
 			break;
+		case MLD2_BLOCK_OLD_SOURCES:
+			changed = br_multicast_block(pg, grec->grec_src, nsrcs,
+						     sizeof(struct in6_addr));
+			break;
 		}
 		if (changed)
 			br_mdb_notify(br->dev, mdst, pg, RTM_NEWMDB);
-- 
2.25.4

