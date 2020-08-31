Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tkF66m7r4xUb0m+rplUS8hiC/CAl6pksOtOpgPN7vWY=;
 b=PalQxtOUw2ZA8+EUayeTxquqxMovStIieaeQDhJOjtLi99Ce4zOUXRtUGmETOEBsn3
 7DEGm0VxlDHDRjGBKy68NXmcXqwb7uLiDWN87yOyK1GGgOTmZ2kI24+jo+ohIMwElfHy
 uF/Sw6kjv0LPs05toQ5XkcYh/UXPwEdW2MNl8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 31 Aug 2020 18:08:43 +0300
Message-Id: <20200831150845.1062447-14-nikolay@cumulusnetworks.com>
In-Reply-To: <20200831150845.1062447-1-nikolay@cumulusnetworks.com>
References: <20200831150845.1062447-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 13/15] net: bridge: mcast: support for
	IGMPV3_BLOCK_OLD_SOURCES report
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

We already have all necessary helpers, so process IGMPV3_BLOCK_OLD_SOURCES
as per the RFC.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 88 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2777e3eb07b9..55c2729c61f4 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1578,6 +1578,91 @@ static bool br_multicast_toex(struct net_bridge_port_group *pg,
 	return changed;
 }
 
+/* State          Msg type      New state                Actions
+ * INCLUDE (A)    BLOCK (B)     INCLUDE (A)              Send Q(G,A*B)
+ */
+static void __grp_src_block_incl(struct net_bridge_port_group *pg,
+				 __be32 *srcs, u32 nsrcs)
+{
+	struct net_bridge_group_src *ent;
+	u32 src_idx, to_send = 0;
+	struct br_ip src_ip;
+
+	__grp_src_modify_flags_all(pg, 0, BR_SGRP_F_SEND);
+
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = htons(ETH_P_IP);
+	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
+		src_ip.u.ip4 = srcs[src_idx];
+		ent = br_multicast_find_group_src(pg, &src_ip);
+		if (ent) {
+			__grp_src_modify_flags(ent, BR_SGRP_F_SEND, 0);
+			to_send++;
+		}
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
+				 __be32 *srcs, u32 nsrcs)
+{
+	struct net_bridge_group_src *ent;
+	u32 src_idx, to_send = 0;
+	bool changed = false;
+	struct br_ip src_ip;
+
+	__grp_src_modify_flags_all(pg, 0, BR_SGRP_F_SEND);
+
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = htons(ETH_P_IP);
+	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
+		src_ip.u.ip4 = srcs[src_idx];
+		ent = br_multicast_find_group_src(pg, &src_ip);
+		if (!ent) {
+			ent = br_multicast_new_group_src(pg, &src_ip);
+			if (ent) {
+				mod_timer(&ent->timer, pg->timer.expires);
+				changed = true;
+			}
+		}
+		if (ent && timer_pending(&ent->timer)) {
+			__grp_src_modify_flags(ent, BR_SGRP_F_SEND, 0);
+			to_send++;
+		}
+	}
+
+	if (to_send)
+		__grp_src_query_marked_and_rexmit(pg);
+
+	return changed;
+}
+
+static bool br_multicast_block(struct net_bridge_port_group *pg,
+			       __be32 *srcs, u32 nsrcs)
+{
+	bool changed = false;
+
+	switch (pg->filter_mode) {
+	case MCAST_INCLUDE:
+		__grp_src_block_incl(pg, srcs, nsrcs);
+		break;
+	case MCAST_EXCLUDE:
+		changed = __grp_src_block_excl(pg, srcs, nsrcs);
+		break;
+	}
+
+	return changed;
+}
+
 static struct net_bridge_port_group *
 br_multicast_find_port(struct net_bridge_mdb_entry *mp,
 		       struct net_bridge_port *p,
@@ -1686,6 +1771,9 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge *br,
 		case IGMPV3_CHANGE_TO_EXCLUDE:
 			changed = br_multicast_toex(pg, grec->grec_src, nsrcs);
 			break;
+		case IGMPV3_BLOCK_OLD_SOURCES:
+			changed = br_multicast_block(pg, grec->grec_src, nsrcs);
+			break;
 		}
 		if (changed)
 			br_mdb_notify(br->dev, mdst, pg, RTM_NEWMDB);
-- 
2.25.4

