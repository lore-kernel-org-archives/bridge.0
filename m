Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HukKeZEePLGYcfWW3UN/WsRcjshJ3r821tIfQZy/ZXg=;
 b=Jbqg/TzeW6oZ+xYGQtPbwLgQGMhh0EGojkRkGTbDxy5sSezp8mWN4Sm1QuOA1nVTCM
 JWtmLXeostYtNuxCX6VT5E7PVGuqw+K9bmATarGTzQrAgUiEQ27lQqat0FefjrhRb+uw
 WXtQPnPuVP79PHwD15gffT8ah0ji8zECaQx0Gt6Naw2IdLiqgG80URDeyRLdIsYuef9U
 wSm7FNo6Hff6tHR0yB46n78K7doQPapRyhoL+41nAx1kUd7o31yOz13Tg+ZlaT9PmOSS
 T+E5YRBwkr5qZipqb4ru93413QIb9NRewlGBzbEZUn3UGgMWxih3ULBwclNOIixG4Rwd
 JB9w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 22 Sep 2020 10:30:13 +0300
Message-Id: <20200922073027.1196992-3-razor@blackwall.org>
In-Reply-To: <20200922073027.1196992-1-razor@blackwall.org>
References: <20200922073027.1196992-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 02/16] net: bridge: mdb: move all port
	and bridge checks to br_mdb_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

To avoid doing duplicate device checks and searches (the same were done
in br_mdb_add and __br_mdb_add) pass the already found port to __br_mdb_add
and pull the bridge's netif_running and enabled multicast checks to
br_mdb_add. This would also simplify the future extack errors.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_mdb.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index d4031f5554f7..92ab7369fee0 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -775,31 +775,18 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 }
 
 static int __br_mdb_add(struct net *net, struct net_bridge *br,
+			struct net_bridge_port *p,
 			struct br_mdb_entry *entry)
 {
 	struct br_ip ip;
-	struct net_device *dev;
-	struct net_bridge_port *p = NULL;
 	int ret;
 
-	if (!netif_running(br->dev) || !br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		return -EINVAL;
-
-	if (entry->ifindex != br->dev->ifindex) {
-		dev = __dev_get_by_index(net, entry->ifindex);
-		if (!dev)
-			return -ENODEV;
-
-		p = br_port_get_rtnl(dev);
-		if (!p || p->br != br || p->state == BR_STATE_DISABLED)
-			return -EINVAL;
-	}
-
 	__mdb_entry_to_br_ip(entry, &ip);
 
 	spin_lock_bh(&br->multicast_lock);
 	ret = br_mdb_add_group(br, p, &ip, entry);
 	spin_unlock_bh(&br->multicast_lock);
+
 	return ret;
 }
 
@@ -821,6 +808,9 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
+	if (!netif_running(br->dev) || !br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		return -EINVAL;
+
 	if (entry->ifindex != br->dev->ifindex) {
 		pdev = __dev_get_by_index(net, entry->ifindex);
 		if (!pdev)
@@ -840,12 +830,12 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(br->dev) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-			err = __br_mdb_add(net, br, entry);
+			err = __br_mdb_add(net, br, p, entry);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_add(net, br, entry);
+		err = __br_mdb_add(net, br, p, entry);
 	}
 
 	return err;
-- 
2.25.4

