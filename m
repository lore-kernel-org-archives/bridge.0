Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=DxPC5BReKiCR1QepGuxT5RaZfSJbVgTzDGxBviBCJbM=;
	b=o23Dimy/u9XPdn4pl/5glo1MstX8s27HnTnR09ajDBOWERv2oLpwOYFxXmx208E5pTlp4ZPkGXcDVmJIvRjlnFYU8b9fGvhDKYWK5BlMgMt90F2c88ouwe3Ac+mww6RF1wDKkAZwmPFhb43W3PbdclNURAK8+5LcYn7qXeD/9ZE=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527641426.git.petrm@mellanox.com>
References: <cover.1527641426.git.petrm@mellanox.com>
Message-Id: <146400cb6763f42d2b79377980a47a2924673c36.1527641426.git.petrm@mellanox.com>
Date: Wed, 30 May 2018 02:57:46 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 3/8] mlxsw: spectrum_switchdev: Ignore
 bridge VLAN events
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
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 8c9cf8e..cbc8fab 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1144,6 +1144,9 @@ static int mlxsw_sp_port_vlans_add(struct mlxsw_sp_port *mlxsw_sp_port,
 	struct mlxsw_sp_bridge_port *bridge_port;
 	u16 vid;
 
+	if (netif_is_bridge_master(orig_dev))
+		return -EOPNOTSUPP;
+
 	if (switchdev_trans_ph_prepare(trans))
 		return 0;
 
@@ -1741,6 +1744,9 @@ static int mlxsw_sp_port_vlans_del(struct mlxsw_sp_port *mlxsw_sp_port,
 	struct mlxsw_sp_bridge_port *bridge_port;
 	u16 vid;
 
+	if (netif_is_bridge_master(orig_dev))
+		return -EOPNOTSUPP;
+
 	bridge_port = mlxsw_sp_bridge_port_find(mlxsw_sp->bridge, orig_dev);
 	if (WARN_ON(!bridge_port))
 		return -EINVAL;
-- 
2.4.11

