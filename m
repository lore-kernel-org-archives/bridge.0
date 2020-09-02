Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CBvvkGoY63ume+BxSWZf+l7R9g82AVslqqYoUts1Shc=;
 b=O5Z9tyxp6OnjDBLSi9g3fiKfHZ7PW632yiPWLi51OWRKsvw/R+JfnDekiC1upI8Ytr
 rATDVwXd3kF4pz8Ak1yZwMOrYYo1UWgwSj2ZUBPizujRmHRJDJzRLxLYfeVJiwj+dBmi
 IezWTA5xiRTOUDBE7m9fsHOOzgGHIDv47eP8A=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  2 Sep 2020 14:25:25 +0300
Message-Id: <20200902112529.1570040-12-nikolay@cumulusnetworks.com>
In-Reply-To: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
References: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 11/15] net: bridge: mcast: support for
	IGMPV3_MODE_IS_INCLUDE/EXCLUDE report
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

In order to process IGMPV3_MODE_IS_INCLUDE/EXCLUDE report types we need
some new helpers which allow us to set/clear flags for all current entries
and later delete marked entries after the report sources have been
processed.

v2: drop flag helpers and directly do flag bit operations

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 114 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 93771309f59f..9e0c8a462343 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1156,6 +1156,21 @@ void br_multicast_disable_port(struct net_bridge_port *port)
 	spin_unlock(&br->multicast_lock);
 }
 
+static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
+{
+	struct net_bridge_group_src *ent;
+	struct hlist_node *tmp;
+	int deleted = 0;
+
+	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
+		if (ent->flags & BR_SGRP_F_DELETE) {
+			br_multicast_del_group_src(ent);
+			deleted++;
+		}
+
+	return deleted;
+}
+
 /* State          Msg type      New state                Actions
  * INCLUDE (A)    IS_IN (B)     INCLUDE (A+B)            (B)=GMI
  * INCLUDE (A)    ALLOW (B)     INCLUDE (A+B)            (B)=GMI
@@ -1189,6 +1204,99 @@ static bool br_multicast_isinc_allow(struct net_bridge_port_group *pg,
 	return changed;
 }
 
+/* State          Msg type      New state                Actions
+ * INCLUDE (A)    IS_EX (B)     EXCLUDE (A*B,B-A)        (B-A)=0
+ *                                                       Delete (A-B)
+ *                                                       Group Timer=GMI
+ */
+static void __grp_src_isexc_incl(struct net_bridge_port_group *pg,
+				 __be32 *srcs, u32 nsrcs)
+{
+	struct net_bridge_group_src *ent;
+	struct br_ip src_ip;
+	u32 src_idx;
+
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags |= BR_SGRP_F_DELETE;
+
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = htons(ETH_P_IP);
+	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
+		src_ip.u.ip4 = srcs[src_idx];
+		ent = br_multicast_find_group_src(pg, &src_ip);
+		if (ent)
+			ent->flags &= ~BR_SGRP_F_DELETE;
+		else
+			br_multicast_new_group_src(pg, &src_ip);
+	}
+
+	__grp_src_delete_marked(pg);
+}
+
+/* State          Msg type      New state                Actions
+ * EXCLUDE (X,Y)  IS_EX (A)     EXCLUDE (A-Y,Y*A)        (A-X-Y)=GMI
+ *                                                       Delete (X-A)
+ *                                                       Delete (Y-A)
+ *                                                       Group Timer=GMI
+ */
+static bool __grp_src_isexc_excl(struct net_bridge_port_group *pg,
+				 __be32 *srcs, u32 nsrcs)
+{
+	struct net_bridge *br = pg->port->br;
+	struct net_bridge_group_src *ent;
+	unsigned long now = jiffies;
+	bool changed = false;
+	struct br_ip src_ip;
+	u32 src_idx;
+
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags |= BR_SGRP_F_DELETE;
+
+	memset(&src_ip, 0, sizeof(src_ip));
+	src_ip.proto = htons(ETH_P_IP);
+	for (src_idx = 0; src_idx < nsrcs; src_idx++) {
+		src_ip.u.ip4 = srcs[src_idx];
+		ent = br_multicast_find_group_src(pg, &src_ip);
+		if (ent) {
+			ent->flags &= ~BR_SGRP_F_DELETE;
+		} else {
+			ent = br_multicast_new_group_src(pg, &src_ip);
+			if (ent) {
+				mod_timer(&ent->timer,
+					  now + br_multicast_gmi(br));
+				changed = true;
+			}
+		}
+	}
+
+	if (__grp_src_delete_marked(pg))
+		changed = true;
+
+	return changed;
+}
+
+static bool br_multicast_isexc(struct net_bridge_port_group *pg,
+			       __be32 *srcs, u32 nsrcs)
+{
+	struct net_bridge *br = pg->port->br;
+	bool changed = false;
+
+	switch (pg->filter_mode) {
+	case MCAST_INCLUDE:
+		__grp_src_isexc_incl(pg, srcs, nsrcs);
+		changed = true;
+		break;
+	case MCAST_EXCLUDE:
+		changed = __grp_src_isexc_excl(pg, srcs, nsrcs);
+		break;
+	}
+
+	pg->filter_mode = MCAST_EXCLUDE;
+	mod_timer(&pg->timer, jiffies + br_multicast_gmi(br));
+
+	return changed;
+}
+
 static struct net_bridge_port_group *
 br_multicast_find_port(struct net_bridge_mdb_entry *mp,
 		       struct net_bridge_port *p,
@@ -1285,6 +1393,12 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge *br,
 		case IGMPV3_ALLOW_NEW_SOURCES:
 			changed = br_multicast_isinc_allow(pg, grec->grec_src, nsrcs);
 			break;
+		case IGMPV3_MODE_IS_INCLUDE:
+			changed = br_multicast_isinc_allow(pg, grec->grec_src, nsrcs);
+			break;
+		case IGMPV3_MODE_IS_EXCLUDE:
+			changed = br_multicast_isexc(pg, grec->grec_src, nsrcs);
+			break;
 		}
 		if (changed)
 			br_mdb_notify(br->dev, mdst, pg, RTM_NEWMDB);
-- 
2.25.4

