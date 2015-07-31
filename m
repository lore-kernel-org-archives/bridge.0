Return-Path: <makita@lab.ntt.co.jp>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Fri, 31 Jul 2015 15:03:26 +0900
Message-Id: <1438322608-4688-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
In-Reply-To: <1438322608-4688-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1438322608-4688-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Subject: [Bridge] [PATCH net-next 3/4] bridge: Don't segment multiple tagged
	packets on bridge device
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

Bridge devices don't need to segment multiple tagged packets since thier
ports can segment them.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 net/bridge/br_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 4ff77a1..0aa8f5c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -339,6 +339,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_bridge_getlink	 = br_getlink,
 	.ndo_bridge_setlink	 = br_setlink,
 	.ndo_bridge_dellink	 = br_dellink,
+	.ndo_features_check	 = passthru_features_check,
 };
 
 static void br_dev_free(struct net_device *dev)
-- 
1.8.1.2


