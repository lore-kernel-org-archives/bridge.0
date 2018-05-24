Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=yxblHswXhGYM2IcT5AhHrpXNdhvcCirzTJWyhXOYUaQ=;
	b=NeM9rpf0N8SUjT0eYCXNCZnL4lKWHK11Ywlh0DDZlPKGn0zmtIyoribl2WBYiarQq7YTFxOwAJMDb99W+KkLSOYKKU0Lt50ZmDLYbTe7LCs6kflUmXa4iZKVzMm6eMC05hNyW+Hj3fSQPnBQRbmLwB0sFldoTdXFJ7Hx9OR82y8=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527173527.git.petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
Message-Id: <4ad1086a1fa8dad85bcba11d186fe040511411c3.1527173527.git.petrm@mellanox.com>
Date: Thu, 24 May 2018 17:10:22 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 3/7] rocker: rocker_main: Ignore bridge
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
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

Ignore VLAN events where the orig_dev is the bridge device itself.

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

