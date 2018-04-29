Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=cf/x7h60GGlCAchgZQDaffXAAzBb1ahlFhyYZHNuIJA=;
	b=f7lsZHdvPez8CfbdqSlpgqFe8Pz3naxx1xkauMsGQwWjzfVCx+MtlwygttkiZcvRk7sAc+iWlf7UrhtfmLSkkxaxjyBlX9spKBxvOwU99Zdy5E0iWE3XdnKc2xnovNLU0WsghByc5Lua+rVf/pCuCrj1ZsH8ZHX0f+JWvRady10=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 29 Apr 2018 10:56:11 +0300
Message-Id: <20180429075613.10832-5-idosch@mellanox.com>
In-Reply-To: <20180429075613.10832-1-idosch@mellanox.com>
References: <20180429075613.10832-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 4/6] mlxsw: spectrum: Register SPAN
	before switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

From: Petr Machata <petrm@mellanox.com>

Since switchdev events can trigger SPAN respin, it is necessary that the
data structures are available. Register SPAN first, with a commentary on
what the dependencies are.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 7317fb8079d1..94132f6cec61 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3666,6 +3666,15 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_lag_init;
 	}
 
+	/* Initialize SPAN before router and switchdev, so that those components
+	 * can call mlxsw_sp_span_respin().
+	 */
+	err = mlxsw_sp_span_init(mlxsw_sp);
+	if (err) {
+		dev_err(mlxsw_sp->bus_info->dev, "Failed to init span system\n");
+		goto err_span_init;
+	}
+
 	err = mlxsw_sp_switchdev_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
@@ -3684,15 +3693,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_afa_init;
 	}
 
-	err = mlxsw_sp_span_init(mlxsw_sp);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to init span system\n");
-		goto err_span_init;
-	}
-
-	/* Initialize router after SPAN is initialized, so that the FIB and
-	 * neighbor event handlers can issue SPAN respin.
-	 */
 	err = mlxsw_sp_router_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize router\n");
@@ -3739,14 +3739,14 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_netdev_notifier:
 	mlxsw_sp_router_fini(mlxsw_sp);
 err_router_init:
-	mlxsw_sp_span_fini(mlxsw_sp);
-err_span_init:
 	mlxsw_sp_afa_fini(mlxsw_sp);
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 err_counter_pool_init:
 	mlxsw_sp_switchdev_fini(mlxsw_sp);
 err_switchdev_init:
+	mlxsw_sp_span_fini(mlxsw_sp);
+err_span_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
 err_lag_init:
 	mlxsw_sp_buffers_fini(mlxsw_sp);
@@ -3768,10 +3768,10 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_acl_fini(mlxsw_sp);
 	unregister_netdevice_notifier(&mlxsw_sp->netdevice_nb);
 	mlxsw_sp_router_fini(mlxsw_sp);
-	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 	mlxsw_sp_switchdev_fini(mlxsw_sp);
+	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
 	mlxsw_sp_traps_fini(mlxsw_sp);
-- 
2.14.3

