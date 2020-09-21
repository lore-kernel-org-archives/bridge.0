Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HukKeZEePLGYcfWW3UN/WsRcjshJ3r821tIfQZy/ZXg=;
 b=zBzNWb7VdE9Q36qyv7OwhfmFqotkR2aY5W7WVgs+kaLvTlgIHTkL3yIzSdhix26eXK
 N14rE7Juhg5xYmRliNHv+HRGD9HG7jMjR8+iEKAWLhdWoa1kck/5UI6roONW7mGhEEt4
 v6jPHNV3RB4HZ1c6LQDjY/SWlkbXgdfk4f9qMFME/aV2C94DtnckPz5F0MJ5xE1+LiBR
 qFfsdVbz3xDgB9evtN1bC9N8ujlEpF7olz3hfkGsrsYte95xOkcJxWtrWHOboURLBG+P
 VltAISB7auya4dUR9tlRNAafzyW/c/gH8HMNx6ntb6aGX7F7GsJG+hF6brWJnXJhvgzo
 fZxg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 21 Sep 2020 13:55:12 +0300
Message-Id: <20200921105526.1056983-3-razor@blackwall.org>
In-Reply-To: <20200921105526.1056983-1-razor@blackwall.org>
References: <20200921105526.1056983-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 02/16] net: bridge: mdb: move all port and
	bridge checks to br_mdb_add
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

