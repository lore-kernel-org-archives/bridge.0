Return-Path: <yotamg@mellanox.com>
From: Yotam Gigi <yotamg@mellanox.com>
Date: Wed,  1 Mar 2017 16:50:45 +0200
Message-Id: <1488379845-38625-1-git-send-email-yotamg@mellanox.com>
Subject: [Bridge] [PATCH net] bridge: Fix error path in nbp_vlan_init
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, idosch@mellanox.com, eladr@mellanox.com, jiri@mellanox.com, roopa@cumulusnetworks.com
Cc: Yotam Gigi <yotamg@mellanox.com>

Fix error path order in nbp_vlan_init, so if switchdev_port_attr_set
call failes, the vlan_hash wouldn't be destroyed before inited.

Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
CC: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: Yotam Gigi <yotamg@mellanox.com>
---
 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 62e68c0..b838213 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -997,10 +997,10 @@ int nbp_vlan_init(struct net_bridge_port *p)
 	RCU_INIT_POINTER(p->vlgrp, NULL);
 	synchronize_rcu();
 	vlan_tunnel_deinit(vg);
-err_vlan_enabled:
 err_tunnel_init:
 	rhashtable_destroy(&vg->vlan_hash);
 err_rhtbl:
+err_vlan_enabled:
 	kfree(vg);
 
 	goto out;
-- 
2.4.11

