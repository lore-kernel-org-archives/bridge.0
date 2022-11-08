Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB62D410E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EF8B414C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtE7u9MQDSIbAqLf032Zj0aue9ZFrFmS/MZfZeVQBBA=;
 b=pEtS0mq8blvFkk+9WPVzZRJGsYAd4QHwWTbS8r7Y9PZp0J68BRTE4jhYrQTcdyqN692RSnCXkRwl0UeG6l590PtX8l5VMvdliQVbSo2iKymuuTBDPOrioAhmhpe0KqzHWvIpcZS67x00Hi3In73XSZOZtQQymIPmWZlclC0HYjyyyG/DHDhnHtkaeJ1QX51YKQsyb1oYEoGA/P2PDbxH1XZTY8WrHEQ2UIx8gGZcg5GqFB2Zk/FnE4mqX3Y3AJIpIee8K0BK4DiStTAwNpwJcjnmFdubpFAJcT547qQuHkoaFz0DkIATt1w4f5emA4mhEkfwCvgs+4xBwQfcCpUA6g==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:14 +0100
Message-ID: <41dd6cd6fd24a0a47e4085ccf534e5cdea8b33a4.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 08/15] mlxsw: spectrum_switchdev: Prepare
	for locked FDB notifications
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

From: Ido Schimmel <idosch@nvidia.com>

Subsequent patches will need to report locked FDB entries to the bridge
driver. Prepare for that by adding a 'locked' argument to
mlxsw_sp_fdb_call_notifiers() according to which the 'locked' bit is set
in the FDB notification info. For now, always pass 'false'.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 4efccd942fb8..0fbefa43f9b1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2888,13 +2888,14 @@ static void mlxsw_sp_fdb_nve_call_notifiers(struct net_device *dev,
 static void
 mlxsw_sp_fdb_call_notifiers(enum switchdev_notifier_type type,
 			    const char *mac, u16 vid,
-			    struct net_device *dev, bool offloaded)
+			    struct net_device *dev, bool offloaded, bool locked)
 {
 	struct switchdev_notifier_fdb_info info = {};
 
 	info.addr = mac;
 	info.vid = vid;
 	info.offloaded = offloaded;
+	info.locked = locked;
 	call_switchdev_notifiers(type, dev, &info.info, NULL);
 }
 
@@ -2952,7 +2953,8 @@ static void mlxsw_sp_fdb_notify_mac_process(struct mlxsw_sp *mlxsw_sp,
 	if (!do_notification)
 		return;
 	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRIDGE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding,
+				    false);
 
 	return;
 
@@ -3015,7 +3017,8 @@ static void mlxsw_sp_fdb_notify_mac_lag_process(struct mlxsw_sp *mlxsw_sp,
 	if (!do_notification)
 		return;
 	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRIDGE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding,
+				    false);
 
 	return;
 
@@ -3122,7 +3125,7 @@ static void mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlxsw_sp,
 
 	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE :
 			SWITCHDEV_FDB_DEL_TO_BRIDGE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, nve_dev, adding);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, nve_dev, adding, false);
 
 	mlxsw_sp_fid_put(fid);
 
@@ -3264,7 +3267,7 @@ mlxsw_sp_switchdev_bridge_vxlan_fdb_event(struct mlxsw_sp *mlxsw_sp,
 					 &vxlan_fdb_info.info, NULL);
 		mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
 					    vxlan_fdb_info.eth_addr,
-					    fdb_info->vid, dev, true);
+					    fdb_info->vid, dev, true, false);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		err = mlxsw_sp_port_fdb_tunnel_uc_op(mlxsw_sp,
@@ -3359,7 +3362,7 @@ static void mlxsw_sp_switchdev_bridge_fdb_event_work(struct work_struct *work)
 			break;
 		mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
 					    fdb_info->addr,
-					    fdb_info->vid, dev, true);
+					    fdb_info->vid, dev, true, false);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb_info = &switchdev_work->fdb_info;
@@ -3443,7 +3446,8 @@ mlxsw_sp_switchdev_vxlan_fdb_add(struct mlxsw_sp *mlxsw_sp,
 	call_switchdev_notifiers(SWITCHDEV_VXLAN_FDB_OFFLOADED, dev,
 				 &vxlan_fdb_info->info, NULL);
 	mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
-				    vxlan_fdb_info->eth_addr, vid, dev, true);
+				    vxlan_fdb_info->eth_addr, vid, dev, true,
+				    false);
 
 	mlxsw_sp_fid_put(fid);
 
@@ -3493,7 +3497,8 @@ mlxsw_sp_switchdev_vxlan_fdb_del(struct mlxsw_sp *mlxsw_sp,
 				       false, false);
 	vid = bridge_device->ops->fid_vid(bridge_device, fid);
 	mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
-				    vxlan_fdb_info->eth_addr, vid, dev, false);
+				    vxlan_fdb_info->eth_addr, vid, dev, false,
+				    false);
 
 	mlxsw_sp_fid_put(fid);
 }
-- 
2.35.3

