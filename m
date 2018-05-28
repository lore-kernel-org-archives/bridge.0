Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=yxblHswXhGYM2IcT5AhHrpXNdhvcCirzTJWyhXOYUaQ=;
	b=vIAPD2rjaUwaOZ2XmS22qG95H1pH2KjlLENSahtMhlyHZNLUrn7pzoniLHVW0YdJYZNUFDaKpegKNdCVII/8SP1w2NVc4j+eNqN3XSzhBdRO9/MD9w4YjEyheoMyyDpayEPCtQc5y1iPy7n++Wn0y/EWY2MReCVUY307j3K5nTA=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527503302.git.petrm@mellanox.com>
References: <cover.1527503302.git.petrm@mellanox.com>
Message-Id: <708f594ac6cef4a63a6f6a28759098c4d7922976.1527503302.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 12:50:09 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 3/7] rocker: rocker_main: Ignore bridge
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

