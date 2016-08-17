Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sIYoFRE2+JpezoT41CgKJcwPKPL6GKu5tdx4FR7cuOQ=;
	b=LTEy1CH8H22GQ/4+ReLJwLvySFm2DCXNRaLD1L/5ily/wZlWzF3e3QsGPc0232oVwj
	HCMn2W89rR5dwVvFp8yVpx0vbPR/rPsqyRJ6jZCHZHNiPE4+N5ibFo/bp1ZgEXiYWCe1
	jWaf9Phf56ogrT5YbpKW512Su+zEsgtURuqEY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 17 Aug 2016 12:53:09 +0200
Message-Id: <1471431190-27442-2-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/2] net: bridge: consolidate bridge and
	port linkxstats calls
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

In the bridge driver we usually have the same function working for both
port and bridge. In order to follow that logic and also avoid code
duplication, consolidate the bridge_ and brport_ linkxstats calls into
one since they share most of their code. As a side effect this allows us
to dump the vlan stats also via the slave call which is in preparation for
the upcoming per-port vlan stats and vlan flag dumping.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 114 +++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 75 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f2a29e467e78..493ab9b3d51a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1245,14 +1245,30 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	return 0;
 }
 
-static size_t bridge_get_linkxstats_size(const struct net_device *dev)
+static size_t br_get_linkxstats_size(const struct net_device *dev, int attr)
 {
-	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge_port *p = NULL;
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
+	struct net_bridge *br;
 	int numvls = 0;
 
-	vg = br_vlan_group(br);
+	switch (attr) {
+	case IFLA_STATS_LINK_XSTATS:
+		br = netdev_priv(dev);
+		vg = br_vlan_group(br);
+		break;
+	case IFLA_STATS_LINK_XSTATS_SLAVE:
+		p = br_port_get_rtnl(dev);
+		if (!p)
+			return 0;
+		br = p->br;
+		vg = nbp_vlan_group(p);
+		break;
+	default:
+		return 0;
+	}
+
 	if (vg) {
 		/* we need to count all, even placeholder entries */
 		list_for_each_entry(v, &vg->vlan_list, vlist)
@@ -1264,44 +1280,38 @@ static size_t bridge_get_linkxstats_size(const struct net_device *dev)
 	       nla_total_size(0);
 }
 
-static size_t brport_get_linkxstats_size(const struct net_device *dev)
-{
-	return nla_total_size(sizeof(struct br_mcast_stats)) +
-	       nla_total_size(0);
-}
-
-static size_t br_get_linkxstats_size(const struct net_device *dev, int attr)
+static int br_fill_linkxstats(struct sk_buff *skb,
+			      const struct net_device *dev,
+			      int *prividx, int attr)
 {
-	size_t retsize = 0;
+	struct nlattr *nla __maybe_unused;
+	struct net_bridge_port *p = NULL;
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_bridge *br;
+	struct nlattr *nest;
+	int vl_idx = 0;
 
 	switch (attr) {
 	case IFLA_STATS_LINK_XSTATS:
-		retsize = bridge_get_linkxstats_size(dev);
+		br = netdev_priv(dev);
+		vg = br_vlan_group(br);
 		break;
 	case IFLA_STATS_LINK_XSTATS_SLAVE:
-		retsize = brport_get_linkxstats_size(dev);
+		p = br_port_get_rtnl(dev);
+		if (!p)
+			return 0;
+		br = p->br;
+		vg = nbp_vlan_group(p);
 		break;
+	default:
+		return -EINVAL;
 	}
 
-	return retsize;
-}
-
-static int bridge_fill_linkxstats(struct sk_buff *skb,
-				  const struct net_device *dev,
-				  int *prividx)
-{
-	struct net_bridge *br = netdev_priv(dev);
-	struct nlattr *nla __maybe_unused;
-	struct net_bridge_vlan_group *vg;
-	struct net_bridge_vlan *v;
-	struct nlattr *nest;
-	int vl_idx = 0;
-
 	nest = nla_nest_start(skb, LINK_XSTATS_TYPE_BRIDGE);
 	if (!nest)
 		return -EMSGSIZE;
 
-	vg = br_vlan_group(br);
 	if (vg) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			struct bridge_vlan_xstats vxi;
@@ -1329,7 +1339,7 @@ static int bridge_fill_linkxstats(struct sk_buff *skb,
 					BRIDGE_XSTATS_PAD);
 		if (!nla)
 			goto nla_put_failure;
-		br_multicast_get_stats(br, NULL, nla_data(nla));
+		br_multicast_get_stats(br, p, nla_data(nla));
 	}
 #endif
 	nla_nest_end(skb, nest);
@@ -1344,52 +1354,6 @@ nla_put_failure:
 	return -EMSGSIZE;
 }
 
-static int brport_fill_linkxstats(struct sk_buff *skb,
-				  const struct net_device *dev,
-				  int *prividx)
-{
-	struct net_bridge_port *p = br_port_get_rtnl(dev);
-	struct nlattr *nla __maybe_unused;
-	struct nlattr *nest;
-
-	if (!p)
-		return 0;
-
-	nest = nla_nest_start(skb, LINK_XSTATS_TYPE_BRIDGE);
-	if (!nest)
-		return -EMSGSIZE;
-#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
-	nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_MCAST,
-				sizeof(struct br_mcast_stats),
-				BRIDGE_XSTATS_PAD);
-	if (!nla) {
-		nla_nest_end(skb, nest);
-		return -EMSGSIZE;
-	}
-	br_multicast_get_stats(p->br, p, nla_data(nla));
-#endif
-	nla_nest_end(skb, nest);
-
-	return 0;
-}
-
-static int br_fill_linkxstats(struct sk_buff *skb, const struct net_device *dev,
-			      int *prividx, int attr)
-{
-	int ret = -EINVAL;
-
-	switch (attr) {
-	case IFLA_STATS_LINK_XSTATS:
-		ret = bridge_fill_linkxstats(skb, dev, prividx);
-		break;
-	case IFLA_STATS_LINK_XSTATS_SLAVE:
-		ret = brport_fill_linkxstats(skb, dev, prividx);
-		break;
-	}
-
-	return ret;
-}
-
 static struct rtnl_af_ops br_af_ops __read_mostly = {
 	.family			= AF_BRIDGE,
 	.get_link_af_size	= br_get_link_af_size_filtered,
-- 
2.1.4

