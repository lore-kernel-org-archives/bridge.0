Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFD7240919
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B15D2410A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq5Oq8fcOFcPYTjwT1aMU/D8S+XTSuUQicYnQIZzCLM=;
 b=Dt/WQJLsQ+YLhwVM37poPiMS2c0uuzOLo2dCUDxKSMTILKxmFO8sbhsABykuHF75U9wd9gaO4LxvNOtS/9F4ljRkbphpseQGKn9WFu1o01TW2Oz3tcYVxlmu86rdKM6LXfKMyHN/Iq0nqZZhOU0u/llAh/yCNKkGNGaxLSO0NJWXNw1x3AFILixxHIQ9AHHIoUw0xKnBmemGSbbgTUARXvD0dN7BxYOmxGs8BBPWSZs/IgQG7G3VyDn3VOCuzLQKvBOrgTI4mWdwT3b9A54zIB7SZYs9MD+oGfsGqB286Ugg3bRE2DpAm9LAKjp6awom9tEHd2MjraKWzZwJ6kU6ww==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:12 +0100
Message-ID: <acba123f510d401a7eda4536caa33218767b75d9.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 06/15] mlxsw: reg: Add Switch Port FDB
	Security Register
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

Add the Switch Port FDB Security Register (SPFSR) that allows enabling
and disabling security checks on a given local port. In Linux terms, it
allows locking / unlocking a port.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
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
2.35.3

