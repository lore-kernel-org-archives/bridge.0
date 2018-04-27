Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=UyBfac7MG2wcwbSVm/8F2Ie7Of8BwMKua3wSFQIx7mY=;
	b=p+I2xNV7Sy5QVxOaGEVQcgEn4ys4KBj5qrL04z9Yue9AeBjepwzvMVIYGnlR6yFB/oIoNvvgDxCEkmYJDJztK4LGdt8/lv7AW4qe9pvWDrPEg4e+mlK/EIkj+PSWQEan0idTENrQMx+kK0N67LmwcHiGKzIP+Ap2ENmiL/XBrVk=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 27 Apr 2018 18:11:07 +0300
Message-Id: <20180427151111.22099-3-idosch@mellanox.com>
In-Reply-To: <20180427151111.22099-1-idosch@mellanox.com>
References: <20180427151111.22099-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 2/6] mlxsw: spectrum: Extract
	mlxsw_sp_stp_spms_state()
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

Instead of duplicating the decision regarding port forwarding state made
by mlxsw_sp_port_vid_stp_set(), extract the decision-making into a new
function and reuse.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 26 +++++++++++++-------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  1 +
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index ca38a30fbe91..7317fb8079d1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -441,29 +441,29 @@ static void mlxsw_sp_txhdr_construct(struct sk_buff *skb,
 	mlxsw_tx_hdr_type_set(txhdr, MLXSW_TXHDR_TYPE_CONTROL);
 }
 
-int mlxsw_sp_port_vid_stp_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
-			      u8 state)
+enum mlxsw_reg_spms_state mlxsw_sp_stp_spms_state(u8 state)
 {
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
-	enum mlxsw_reg_spms_state spms_state;
-	char *spms_pl;
-	int err;
-
 	switch (state) {
 	case BR_STATE_FORWARDING:
-		spms_state = MLXSW_REG_SPMS_STATE_FORWARDING;
-		break;
+		return MLXSW_REG_SPMS_STATE_FORWARDING;
 	case BR_STATE_LEARNING:
-		spms_state = MLXSW_REG_SPMS_STATE_LEARNING;
-		break;
+		return MLXSW_REG_SPMS_STATE_LEARNING;
 	case BR_STATE_LISTENING: /* fall-through */
 	case BR_STATE_DISABLED: /* fall-through */
 	case BR_STATE_BLOCKING:
-		spms_state = MLXSW_REG_SPMS_STATE_DISCARDING;
-		break;
+		return MLXSW_REG_SPMS_STATE_DISCARDING;
 	default:
 		BUG();
 	}
+}
+
+int mlxsw_sp_port_vid_stp_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
+			      u8 state)
+{
+	enum mlxsw_reg_spms_state spms_state = mlxsw_sp_stp_spms_state(state);
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	char *spms_pl;
+	int err;
 
 	spms_pl = kmalloc(MLXSW_REG_SPMS_LEN, GFP_KERNEL);
 	if (!spms_pl)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 804d4d2c8031..4a519d8edec8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -364,6 +364,7 @@ int __mlxsw_sp_port_headroom_set(struct mlxsw_sp_port *mlxsw_sp_port, int mtu,
 int mlxsw_sp_port_ets_maxrate_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				  enum mlxsw_reg_qeec_hr hr, u8 index,
 				  u8 next_index, u32 maxrate);
+enum mlxsw_reg_spms_state mlxsw_sp_stp_spms_state(u8 stp_state);
 int mlxsw_sp_port_vid_stp_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid,
 			      u8 state);
 int mlxsw_sp_port_vp_mode_set(struct mlxsw_sp_port *mlxsw_sp_port, bool enable);
-- 
2.14.3

