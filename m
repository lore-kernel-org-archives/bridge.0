Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 106A3403C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BB0340352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsV18BrJn9vQpbGDxMjhLUxMsklefycCVDYIiYRc1X8=;
 b=kop5zsxRD5QomdgzipbqsZsU4d+AgI1h/xkYLA+lmljnmg7fSRprwux/WNL73csWBcj9om+CwuXHMMydeVlyk4wye/axd4Xq7snkgPa8UuoZEiYbWgPwA/I3GF0n3B3I0lx0vYkOApZQ5eDCPg5/mE3m0x9xdWN4tDClkvB7C7lIijX52+unBJRfOrSrm3TSR/QQ5A4hDHxOpJgXG4hRafP96xSIIeJ8eAQFEUJfF0yUO04TXvNj2ct5+A1VW4EUiENVhmiKm7fO4rDwmamZsZCfEiJVG0+y9LtuaIXEmOl7FXs0Q9PKezheGKFALmVBoiGVuQl9qWrJlsCZ59B86g==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:16 +0300
Message-Id: <20221025100024.1287157-9-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 08/16] mlxsw: spectrum: Add an API to
	configure security checks
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

Add an API to enable or disable security checks on a local port. It will
be used by subsequent patches when the 'BR_PORT_LOCKED' flag is toggled.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 18 ++++++++++++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 5bcf5bceff71..10f438bc83dd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -466,6 +466,24 @@ int mlxsw_sp_port_vid_learning_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
 	return err;
 }
 
+int mlxsw_sp_port_security_set(struct mlxsw_sp_port *mlxsw_sp_port, bool enable)
+{
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	char spfsr_pl[MLXSW_REG_SPFSR_LEN];
+	int err;
+
+	if (mlxsw_sp_port->security == enable)
+		return 0;
+
+	mlxsw_reg_spfsr_pack(spfsr_pl, mlxsw_sp_port->local_port, enable);
+	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(spfsr), spfsr_pl);
+	if (err)
+		return err;
+
+	mlxsw_sp_port->security = enable;
+	return 0;
+}
+
 int mlxsw_sp_ethtype_to_sver_type(u16 ethtype, u8 *p_sver_type)
 {
 	switch (ethtype) {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index c8ff2a6d7e90..bbc73324451d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -321,7 +321,8 @@ struct mlxsw_sp_port {
 	struct mlxsw_sp *mlxsw_sp;
 	u16 local_port;
 	u8 lagged:1,
-	   split:1;
+	   split:1,
+	   security:1;
 	u16 pvid;
 	u16 lag_id;
 	struct {
@@ -687,6 +688,8 @@ int mlxsw_sp_port_vid_stp_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
 int mlxsw_sp_port_vp_mode_set(struct mlxsw_sp_port *mlxsw_sp_port, bool enable);
 int mlxsw_sp_port_vid_learning_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
 				   bool learn_enable);
+int mlxsw_sp_port_security_set(struct mlxsw_sp_port *mlxsw_sp_port,
+			       bool enable);
 int mlxsw_sp_ethtype_to_sver_type(u16 ethtype, u8 *p_sver_type);
 int mlxsw_sp_port_egress_ethtype_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				     u16 ethtype);
-- 
2.37.3

