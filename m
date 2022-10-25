Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5201440432
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EC9240423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsSX65Hc9NPlM2RQ9207KWt9PjGr09N1IFejciEgLQ4=;
 b=QOxqTHHEt1pS8/pu0lHNxUs9UOEtXYGYZKteyEiqQx1nv1b17VDK0VlQQiGacWKq4DdVIJdt4hW3dbg1sb/7coRgQAUOnQ1xbKccFhHlAWBGbP/dwlOrayqMUSKVmgJIismP/jFPYMU9ZJBk9WtbxjDu7mnXTDsFYtZMVsm3EpyuoH4zxPLQ0C8EvyHUlFoao01T9sYsDQugwFjSfHvxSjwsDW7Vl/GMQfjGzgZQxBcSklY8IHs2odB6A3EIhRlorsh3DWmH7i7G+P2hf3mRGe13Pfgru1mwHvaxAtAwOM4e8YfTwI2XmearIptgaaN8Oi/QlyF8DaZzhmklKkkeVQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:19 +0300
Message-Id: <20221025100024.1287157-12-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 11/16] mlxsw: spectrum_switchdev: Use
	extack in bridge port flag validation
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

Propagate extack to mlxsw_sp_port_attr_br_pre_flags_set() in order to
communicate error messages related to bridge port flag validation.

Example:

 # bridge link set dev swp1 locked on
 Error: mlxsw_spectrum: Unsupported bridge port flag.

More error messages will be added in subsequent patches.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index f336be77019f..db149af7c888 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -782,10 +782,13 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 
 static int
 mlxsw_sp_port_attr_br_pre_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
-				    struct switchdev_brport_flags flags)
+				    struct switchdev_brport_flags flags,
+				    struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported bridge port flag");
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -1186,7 +1189,8 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev, const void *ctx,
 		break;
 	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_pre_flags_set(mlxsw_sp_port,
-							  attr->u.brport_flags);
+							  attr->u.brport_flags,
+							  extack);
 		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port,
-- 
2.37.3

