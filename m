Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Pis5i6OdiacqvzzEqmv2D6aZVGvH4pU3grH2imLLk9s=;
	b=oX5ix8xcsGXmoN5t2UzZZMyGfdbYV0NpjiRrhhVjnROzvCH53X0agTRBRBEFVjAlmwGm+ZvJkU1XCuwReuc+s5fTdYGPsUz4f4ajibruuRpXbeY2c5ciVpRbO/rb4mjcmmQHWtcjdq9PNC0QOCYW0JKGzkM63vfZIBWiwfkvp8A=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527641426.git.petrm@mellanox.com>
References: <cover.1527641426.git.petrm@mellanox.com>
Message-Id: <bb051f82ac62a424327a81242e9120664838ad76.1527641426.git.petrm@mellanox.com>
Date: Wed, 30 May 2018 02:58:36 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 4/8] rocker: rocker_main: Ignore bridge
 VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

A follow-up patch enables emitting VLAN notifications for the bridge CPU
port in addition to the existing slave port notifications. These
notifications have orig_dev set to the bridge in question.

Because there's no specific support for these VLANs, just ignore the
notifications to maintain the current behavior.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index e73e4fe..aeafdb9 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1632,6 +1632,9 @@ rocker_world_port_obj_vlan_add(struct rocker_port *rocker_port,
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
+	if (netif_is_bridge_master(vlan->obj.orig_dev))
+		return -EOPNOTSUPP;
+
 	if (!wops->port_obj_vlan_add)
 		return -EOPNOTSUPP;
 
@@ -1647,6 +1650,9 @@ rocker_world_port_obj_vlan_del(struct rocker_port *rocker_port,
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
+	if (netif_is_bridge_master(vlan->obj.orig_dev))
+		return -EOPNOTSUPP;
+
 	if (!wops->port_obj_vlan_del)
 		return -EOPNOTSUPP;
 	return wops->port_obj_vlan_del(rocker_port, vlan);
-- 
2.4.11

