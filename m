Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF99E60D4C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEBFF60D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YR5OG9WVlRhkHNDsa2MkQOEA60efe6gGDhHFLTgsQU=;
 b=hJ7c0czasSouveSdeJdzdQuVsMcEprENPc4pKpqlkGXXkrLP2l0XRwaBocAoYbTAR5sFPlQwCwI46u1+yK8/azpnoEI30L8iTwyNVMRgBk7qscAdRWmEpGlSOq2cbB71BUzOJH/cWZS/cT8ybsFqTuAXYXXWwmKxZ9HMocgQxBp/yXFPNISKPFul1sQf407e4ILzh/5oAz58fPCFDoeDmuxUxCWMkl7u2WxZ1WWPysjWqeb98ICQX7a26doc85HfKj6jpshFo/IpfJcw+svq6z13s9l5YZ9mvh+CH2QQsmRsco42gF00QPAe8viXp30rGkEluuhKEoEEGNsT69Fuvw==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:11 +0100
Message-ID: <861f29bb2764d19e9c8a60749c1ad3b187e948eb.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 05/15] mlxsw: spectrum_trap: Register
	802.1X packet traps with devlink
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

Register the previously added packet traps with devlink. This allows
user space to tune their policers and in the case of the locked port
trap, user space can set its action to "trap" in order to gain
visibility into packets that were discarded by the device due to the
locked port check failure.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  1 +
 .../ethernet/mellanox/mlxsw/spectrum_trap.c   | 25 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlxsw/trap.h    |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index b74f30ec629a..7240af45ade5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -6316,6 +6316,7 @@ enum mlxsw_reg_htgt_trap_group {
 	MLXSW_REG_HTGT_TRAP_GROUP_SP_TUNNEL_DISCARDS,
 	MLXSW_REG_HTGT_TRAP_GROUP_SP_ACL_DISCARDS,
 	MLXSW_REG_HTGT_TRAP_GROUP_SP_BUFFER_DISCARDS,
+	MLXSW_REG_HTGT_TRAP_GROUP_SP_EAPOL,
 
 	__MLXSW_REG_HTGT_TRAP_GROUP_MAX,
 	MLXSW_REG_HTGT_TRAP_GROUP_MAX = __MLXSW_REG_HTGT_TRAP_GROUP_MAX - 1
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
index f4bfdb6dab9c..899c954e0e5f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
@@ -510,6 +510,9 @@ mlxsw_sp_trap_policer_items_arr[] = {
 	{
 		.policer = MLXSW_SP_TRAP_POLICER(20, 10240, 4096),
 	},
+	{
+		.policer = MLXSW_SP_TRAP_POLICER(21, 128, 128),
+	},
 };
 
 static const struct mlxsw_sp_trap_group_item mlxsw_sp_trap_group_items_arr[] = {
@@ -628,6 +631,11 @@ static const struct mlxsw_sp_trap_group_item mlxsw_sp_trap_group_items_arr[] = {
 		.hw_group_id = MLXSW_REG_HTGT_TRAP_GROUP_SP_FLOW_LOGGING,
 		.priority = 4,
 	},
+	{
+		.group = DEVLINK_TRAP_GROUP_GENERIC(EAPOL, 21),
+		.hw_group_id = MLXSW_REG_HTGT_TRAP_GROUP_SP_EAPOL,
+		.priority = 5,
+	},
 };
 
 static const struct mlxsw_sp_trap_item mlxsw_sp_trap_items_arr[] = {
@@ -1160,6 +1168,23 @@ static const struct mlxsw_sp_trap_item mlxsw_sp_trap_items_arr[] = {
 			MLXSW_SP_RXL_DISCARD(ROUTER3, L3_DISCARDS),
 		},
 	},
+	{
+		.trap = MLXSW_SP_TRAP_CONTROL(EAPOL, EAPOL, TRAP),
+		.listeners_arr = {
+			MLXSW_SP_RXL_NO_MARK(EAPOL, EAPOL, TRAP_TO_CPU, true),
+		},
+	},
+	{
+		.trap = MLXSW_SP_TRAP_DROP(LOCKED_PORT, L2_DROPS),
+		.listeners_arr = {
+			MLXSW_RXL_DIS(mlxsw_sp_rx_drop_listener, FDB_MISS,
+				      TRAP_EXCEPTION_TO_CPU, false,
+				      SP_L2_DISCARDS, DISCARD, SP_L2_DISCARDS),
+			MLXSW_RXL_DIS(mlxsw_sp_rx_drop_listener, FDB_MISMATCH,
+				      TRAP_EXCEPTION_TO_CPU, false,
+				      SP_L2_DISCARDS, DISCARD, SP_L2_DISCARDS),
+		},
+	},
 };
 
 static struct mlxsw_sp_trap_policer_item *
diff --git a/drivers/net/ethernet/mellanox/mlxsw/trap.h b/drivers/net/ethernet/mellanox/mlxsw/trap.h
index 8da169663bda..83477c8e6971 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/trap.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/trap.h
@@ -25,6 +25,8 @@ enum {
 	MLXSW_TRAP_ID_IGMP_V2_LEAVE = 0x33,
 	MLXSW_TRAP_ID_IGMP_V3_REPORT = 0x34,
 	MLXSW_TRAP_ID_PKT_SAMPLE = 0x38,
+	MLXSW_TRAP_ID_FDB_MISS = 0x3A,
+	MLXSW_TRAP_ID_FDB_MISMATCH = 0x3B,
 	MLXSW_TRAP_ID_FID_MISS = 0x3D,
 	MLXSW_TRAP_ID_DECAP_ECN0 = 0x40,
 	MLXSW_TRAP_ID_MTUERROR = 0x52,
-- 
2.35.3

