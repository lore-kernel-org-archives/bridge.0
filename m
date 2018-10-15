Return-Path: <lirongqing@baidu.com>
From: Li RongQing <lirongqing@baidu.com>
Date: Mon, 15 Oct 2018 19:00:31 +0800
Message-Id: <1539601231-32755-1-git-send-email-lirongqing@baidu.com>
Subject: [Bridge] [PATCH][net-next][v2] net: bridge: fix a possible memory
	leak in __vlan_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

After per-port vlan stats, vlan stats should be released
when fail to add vlan

Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
CC: bridge@lists.linux-foundation.org
cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/bridge/br_vlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9b707234e4ae..8c9297a01947 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -303,6 +303,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 	if (p) {
 		__vlan_vid_del(dev, br, v->vid);
 		if (masterv) {
+			if (v->stats && masterv->stats != v->stats)
+				free_percpu(v->stats);
+			v->stats = NULL;
+
 			br_vlan_put_master(masterv);
 			v->brvlan = NULL;
 		}
-- 
2.16.2

