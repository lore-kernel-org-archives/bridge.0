Return-Path: <makita@lab.ntt.co.jp>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Wed, 10 Dec 2014 11:43:14 +0900
Message-Id: <1418179394-4470-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
In-Reply-To: <1418179394-4470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1418179394-4470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Subject: [Bridge] [PATCH net-next] bridge: Add ability to always enable
	TSO/UFO
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S . Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Currently a bridge device turns off TSO/UFO features if no bridge ports
support it. We can always enable them, since packets can be segmented
on ports by software as well as on the bridge device.
This will reduce the number of packets processed in the bridge.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 net/bridge/br_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index ed307db..e93bf17 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -418,7 +418,7 @@ netdev_features_t br_features_recompute(struct net_bridge *br,
 		return features;
 
 	mask = features;
-	features &= ~NETIF_F_ONE_FOR_ALL;
+	features &= ~NETIF_F_ONE_FOR_ALL | NETIF_F_GSO_SOFTWARE;
 
 	list_for_each_entry(p, &br->port_list, list) {
 		features = netdev_increment_features(features,
-- 
1.8.1.2


