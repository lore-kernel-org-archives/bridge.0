Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1607678794; x=1639214794;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GyMmX3D/jsJ9E6NpxK0JHdKPYb1uHzNbBgKwWLSpo6s=;
 b=0V2eCZdj62qsdhq26taOGUL61+3yoyVmCE6L+mhjxEbugcZsCuNd+dG0
 yXTCHM0Cddx+/f3DxPsF8nzK2kRsI6BnEnWLMP2iSd4ebeieceHG1tnY1
 5I05BI3LaP/xVrRB44h7+63Yk3T/hZwF/dW17EG0GckMM2AaRaDcyWUga
 BzBM8onCEtPGG0ko5OwcrwLLOXW0RHVgG7Mu6EJr8S3FCDr/EXnp8sAwE
 voEzCNc9kJsvRxk68YAmuOwH3FUk+8B9O9Vg7OAOWG07tIyV2RLfoU2wK
 uBph391ZysHvVawE+eqFy9tKYn+nUGoQTLZ+T7bq3t5RGLPX1n+XJSflH w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 11 Dec 2020 10:26:26 +0100
Message-ID: <20201211092626.809206-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [RFC net-next] net: bridge: igmp: Extend IGMP query with
	vlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net, kuba@kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, allan.nielsen@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch tries to add vlan support to IGMP queries.
It extends the function 'br_ip4_multicast_alloc_query' to add
also a vlan tag if vlan is enabled. Therefore the bridge will send
queries for each vlan the ports are in.

There are few other places that needs to be updated to be fully
functional. But I am curious if this is the way to go forward or is
there a different way of implementing this?

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_multicast.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 484820c223a3..4c2db8a9efe0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -688,7 +688,8 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge *br,
 						    __be32 ip_dst, __be32 group,
 						    bool with_srcs, bool over_lmqt,
 						    u8 sflag, u8 *igmp_type,
-						    bool *need_rexmit)
+						    bool *need_rexmit,
+						    __u16 vid)
 {
 	struct net_bridge_port *p = pg ? pg->key.port : NULL;
 	struct net_bridge_group_src *ent;
@@ -724,6 +725,9 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge *br,
 	}
 
 	pkt_size = sizeof(*eth) + sizeof(*iph) + 4 + igmp_hdr_size;
+	if (br_vlan_enabled(br->dev) && vid != 0)
+		pkt_size += 4;
+
 	if ((p && pkt_size > p->dev->mtu) ||
 	    pkt_size > br->dev->mtu)
 		return NULL;
@@ -732,6 +736,9 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge *br,
 	if (!skb)
 		goto out;
 
+	if (br_vlan_enabled(br->dev) && vid != 0)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+
 	skb->protocol = htons(ETH_P_IP);
 
 	skb_reset_mac_header(skb);
@@ -1008,7 +1015,8 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge *br,
 						    ip4_dst, group->dst.ip4,
 						    with_srcs, over_lmqt,
 						    sflag, igmp_type,
-						    need_rexmit);
+						    need_rexmit,
+						    group->vid);
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6): {
 		struct in6_addr ip6_dst;
@@ -1477,6 +1485,8 @@ static void br_multicast_send_query(struct net_bridge *br,
 				    struct bridge_mcast_own_query *own_query)
 {
 	struct bridge_mcast_other_query *other_query = NULL;
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
 	struct br_ip br_group;
 	unsigned long time;
 
@@ -1485,7 +1495,7 @@ static void br_multicast_send_query(struct net_bridge *br,
 	    !br_opt_get(br, BROPT_MULTICAST_QUERIER))
 		return;
 
-	memset(&br_group.dst, 0, sizeof(br_group.dst));
+	memset(&br_group, 0, sizeof(br_group));
 
 	if (port ? (own_query == &port->ip4_own_query) :
 		   (own_query == &br->ip4_own_query)) {
@@ -1501,8 +1511,19 @@ static void br_multicast_send_query(struct net_bridge *br,
 	if (!other_query || timer_pending(&other_query->timer))
 		return;
 
-	__br_multicast_send_query(br, port, NULL, NULL, &br_group, false, 0,
-				  NULL);
+	if (br_vlan_enabled(br->dev) && port) {
+		vg = nbp_vlan_group(port);
+
+		list_for_each_entry(v, &vg->vlan_list, vlist) {
+			br_group.vid = v->vid == vg->pvid ? 0 : v->vid;
+
+			__br_multicast_send_query(br, port, NULL, NULL,
+						  &br_group, false, 0, NULL);
+		}
+	} else {
+		__br_multicast_send_query(br, port, NULL, NULL, &br_group,
+					  false, 0, NULL);
+	}
 
 	time = jiffies;
 	time += own_query->startup_sent < br->multicast_startup_query_count ?
-- 
2.27.0

