Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4S70UcvTo7C+bHXkqxBW96TsehXd1p8Mt5A63GNR6Fs=;
	b=IkWmFRwpJTjEngjqUQKYvTZKe9x8TdJ7nD9dGCm+Np+ivR36lugUA3leO2j8HIzCEqvnBqJGe9w9s/mfFT7RMNpQ8qaqRk4C04COoTRTx5t8Z/lJKPx8aW4qDlfMB4YsiskdYlThluuXGoPfb8n9BIL3gGUermA8i022eKwst2A=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527173527.git.petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
Message-Id: <0c5c58584f95d814999f7144365b37334d1c9c9b.1527173527.git.petrm@mellanox.com>
Date: Thu, 24 May 2018 17:10:46 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 7/7] mlxsw: spectrum_switchdev: Schedule
 respin during trans prepare
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

Since there's no special support for the bridge events, the driver
returns -EOPNOTSUPP, and thus the commit never happens. Therefore
schedule respin during the prepare stage: there's no real difference one
way or another.

This fixes the problem that mirror-to-gretap offload wouldn't adapt to
changes in bridge vlan configuration right away and another notification
would have to arrive for mlxsw to catch up.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index cbc8fab..8a15ac4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1697,7 +1697,7 @@ static int mlxsw_sp_port_obj_add(struct net_device *dev,
 		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
 		err = mlxsw_sp_port_vlans_add(mlxsw_sp_port, vlan, trans);
 
-		if (switchdev_trans_ph_commit(trans)) {
+		if (switchdev_trans_ph_prepare(trans)) {
 			/* The event is emitted before the changes are actually
 			 * applied to the bridge. Therefore schedule the respin
 			 * call for later, so that the respin logic sees the
-- 
2.4.11

