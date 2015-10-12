Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 12 Oct 2015 21:47:04 +0200
Message-Id: <1444679225-7354-4-git-send-email-razor@blackwall.org>
In-Reply-To: <1444679225-7354-1-git-send-email-razor@blackwall.org>
References: <1444679225-7354-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next v2 3/4] bridge: vlan: drop unnecessary
	flush code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: idosch@mellanox.com, shm@cumulusnetworks.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

As Ido Schimmel pointed out the vlan_vid_del() code in nbp_vlan_flush is
unnecessary (and is actually a remnant of the old vlan code) so we can
remove it.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: new patch

 net/bridge/br_vlan.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 4d8a21daf728..573ddfc31fb1 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -973,14 +973,7 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 
 void nbp_vlan_flush(struct net_bridge_port *port)
 {
-	struct net_bridge_vlan_group *vg;
-	struct net_bridge_vlan *vlan;
-
 	ASSERT_RTNL();
 
-	vg = nbp_vlan_group(port);
-	list_for_each_entry(vlan, &vg->vlan_list, vlist)
-		vlan_vid_del(port->dev, port->br->vlan_proto, vlan->vid);
-
-	__vlan_flush(vg);
+	__vlan_flush(nbp_vlan_group(port));
 }
-- 
2.4.3

