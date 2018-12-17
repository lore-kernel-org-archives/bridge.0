Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 17 Dec 2018 17:46:23 +0800
Message-ID: <20181217094623.32668-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] net: bridge: remove unneeded variable
	'err'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org

function br_multicast_toggle now always return 0,
so the variable 'err' is unneeded.
Also cleanup dead branch in br_changelink.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bridge/br_multicast.c | 3 +--
 net/bridge/br_netlink.c   | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 879cd23..3aeff08 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1937,7 +1937,6 @@ static void br_multicast_start_querier(struct net_bridge *br,
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 {
 	struct net_bridge_port *port;
-	int err = 0;
 
 	spin_lock_bh(&br->multicast_lock);
 	if (!!br_opt_get(br, BROPT_MULTICAST_ENABLED) == !!val)
@@ -1958,7 +1957,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
-	return err;
+	return 0;
 }
 
 bool br_multicast_enabled(const struct net_device *dev)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 935495b..9c07591 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1175,9 +1175,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_MCAST_SNOOPING]) {
 		u8 mcast_snooping = nla_get_u8(data[IFLA_BR_MCAST_SNOOPING]);
 
-		err = br_multicast_toggle(br, mcast_snooping);
-		if (err)
-			return err;
+		br_multicast_toggle(br, mcast_snooping);
 	}
 
 	if (data[IFLA_BR_MCAST_QUERY_USE_IFADDR]) {
-- 
2.7.0


