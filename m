Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D20A060B45
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C16560B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0HNreRujqnIhRStpYyJNFXkwgCdOuuXEmSmG0x12Sc=;
 b=hh1BpaZijgRGFGwG6am4tlh3cHzAYbcCHR2fEbg6mgRkJmMZMH1KOT+m5qno2Fq/8YjMzknRYhR8hL2wrgNo3jrMtbTam4innUb76EAqxWywncndg5u9WBY9rPcY50Shrd/wIHmksXkOx2vbj+2j9VHFCIXoQjG4f4vCdNjJdAvwo1tH/VZRHgSUBEgbpIg8FVdFX9Lmw2ExmhLF3cQYJH2yDPH4egRupzt7EFOck5RH3K7iaGTJyyr2+JcCVy4nO1I1oW8sOwBDw6Q9xWA9h01WXLPjsN01fwZ6tTQ0+TpWsNFqy/PnjBYNT07DDUJXrUgTc8YBx/gkdVOR1aB4KQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:17 +0300
Message-Id: <20221025100024.1287157-10-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 09/16] mlxsw: spectrum_switchdev:
	Prepare for locked FDB notifications
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, razor@blackwall.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Subsequent patches will need to report locked FDB entries to the bridge
driver. Prepare for that by adding a 'locked' argument to
mlxsw_sp_fdb_call_notifiers() according to which the 'locked' bit is set
in the FDB notification info. For now, always pass 'false'.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
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
2.37.3

