Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C4AA40915
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32168409B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vXV0EscbKjPvtQz+Z5GoGH51yAqxSK2mKdAlmDf4A8=;
 b=g6wOCHPSRf4d10ZXr87/oRqmGIKx6lclk59YbYBq29xW5crEqk09VYGOdaWlMlRud1owY4fFuGvlEzpTlp8OJEBe6SjpH8ACwJAGm1ZntunIDnvqLd4cwvzI1LroqrXGRsVcRrepOvdyW8nI/Ef0f2yB2ytB+9VHPB7ighsTDgtlqO66VsKAGdTGHPHfG2XAHMlBK0cI5l54q+IomFScXTMaBghrTS0ssxnXMJpnI5f5q7674N5y+stir9wk/jFnQneQBg7k73SsosBq1ih42gttU0bTWxzGeonaKGxco5TPwZStg+UPDFcIlC2hsjCTOmWtdq+uGp2zp5lX54WimQ==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:13 +0100
Message-ID: <69d965463badfb2f1d714869cb4a86fd252e2114.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 07/15] mlxsw: spectrum: Add an API to
	configure security checks
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

Add an API to enable or disable security checks on a local port. It will
be used by subsequent patches when the 'BR_PORT_LOCKED' flag is toggled.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 18 ++++++++++++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 04dc79da6024..b34366521914 100644
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
2.35.3

