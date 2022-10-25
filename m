Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 654238132E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F5E181328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FXcWVwsBQdAaXI9PWsoFystsy/uPpRkTWQ7oaGegqA=;
 b=ZJifQdPzdBx+HPO1lrgeMRhlbL7JVb0Cc1I8Xu2iGm+JkkA0dcAfuejmI1ilGKkOJAkO9XvutHvxbf5e1UWkCIouy+vY0nSO6yElHNemry2leJLVg2oIG8QaQQERCIfSGmcaIy44ts98UrsR3ORl5l8TyAKYgK5egzGPGxOdDz6jkX59ltmqp/N6DZKJpO6dazlGFHC/kw3nKzFLEvMqDsuo6AIoDmLAR3gkeFkmfK3biihK5RZONMROwlH0hdmlyA2DNcEmbUEjLb+Zis+MtAEbjmyGwb8k/txRFkfgVMWTKZCPNb439H6f0jTPqtmPuPfYSDo3sQWGzhWOxNnqvQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:15 +0300
Message-Id: <20221025100024.1287157-8-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 07/16] mlxsw: reg: Add Switch Port FDB
	Security Register
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

Add the Switch Port FDB Security Register (SPFSR) that allows enabling
and disabling security checks on a given local port. In Linux terms, it
allows locking / unlocking a port.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 7240af45ade5..f2d6f8654e04 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -2046,6 +2046,39 @@ static inline void mlxsw_reg_spvmlr_pack(char *payload, u16 local_port,
 	}
 }
 
+/* SPFSR - Switch Port FDB Security Register
+ * -----------------------------------------
+ * Configures the security mode per port.
+ */
+#define MLXSW_REG_SPFSR_ID 0x2023
+#define MLXSW_REG_SPFSR_LEN 0x08
+
+MLXSW_REG_DEFINE(spfsr, MLXSW_REG_SPFSR_ID, MLXSW_REG_SPFSR_LEN);
+
+/* reg_spfsr_local_port
+ * Local port.
+ * Access: Index
+ *
+ * Note: not supported for CPU port.
+ */
+MLXSW_ITEM32_LP(reg, spfsr, 0x00, 16, 0x00, 12);
+
+/* reg_spfsr_security
+ * Security checks.
+ * 0: disabled (default)
+ * 1: enabled
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, spfsr, security, 0x04, 31, 1);
+
+static inline void mlxsw_reg_spfsr_pack(char *payload, u16 local_port,
+					bool security)
+{
+	MLXSW_REG_ZERO(spfsr, payload);
+	mlxsw_reg_spfsr_local_port_set(payload, local_port);
+	mlxsw_reg_spfsr_security_set(payload, security);
+}
+
 /* SPVC - Switch Port VLAN Classification Register
  * -----------------------------------------------
  * Configures the port to identify packets as untagged / single tagged /
@@ -12762,6 +12795,7 @@ static const struct mlxsw_reg_info *mlxsw_reg_infos[] = {
 	MLXSW_REG(svpe),
 	MLXSW_REG(sfmr),
 	MLXSW_REG(spvmlr),
+	MLXSW_REG(spfsr),
 	MLXSW_REG(spvc),
 	MLXSW_REG(spevet),
 	MLXSW_REG(smpe),
-- 
2.37.3

