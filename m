Return-Path: <lirongqing@baidu.com>
From: Li RongQing <lirongqing@baidu.com>
Date: Sun, 14 Oct 2018 11:21:45 +0800
Message-Id: <1539487305-12761-1-git-send-email-lirongqing@baidu.com>
Subject: [Bridge] [PATCH] net: bridge: fix a memory leak in __vlan_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org

After per-port vlan stats, vlan stats should be released
when fail to add vlan

Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/bridge/br_vlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9b707234e4ae..e08e269041dd 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -305,6 +305,10 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 		if (masterv) {
 			br_vlan_put_master(masterv);
 			v->brvlan = NULL;
+
+			if (masterv->stats != v->stats && v->stats)
+				free_percpu(v->stats);
+			v->stats = NULL;
 		}
 	} else {
 		br_switchdev_port_vlan_del(dev, v->vid);
-- 
2.16.2

