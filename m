Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=A4TCvot9x2vVuOlxx97oS3i6vnCWoeACnkRn1Gnvyuo=; b=X109YinQ
 ir3pNNcTE6YsHdNVGHzQiiRY/4QsDxLdt6NItTJ0xkqei6HNX1bdafm32Itco7P8
 ULD4Jaiqkf185w8QgbPK1j2ef96haoADHnssE0KPALBUTn1NObWkdPplnpjLZubR
 VIDZW1y9QCKTcpgfseK/xYZjPUd4Kht0gy7vKoqEnNDONN6hnwFMw9Tb7ZQrAcyz
 9fPw4bYApQnMnpdAEKxyPyWK5+gnK4AmtpNs8F6s2K9Nh8pgpC34mAH1pGplFC+A
 YPPXom1eydh91Co/Brv47uhEY+zRGOXy80G+YWM7KUBSNdPrZvjwmRo45iLz6vIA
 qICj5xu3cYxCcw==
From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 29 Nov 2020 14:54:01 +0200
Message-Id: <20201129125407.1391557-4-idosch@idosch.org>
In-Reply-To: <20201129125407.1391557-1-idosch@idosch.org>
References: <20201129125407.1391557-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/9] mlxsw: spectrum: Only treat 802.1q
	packets as tagged packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, petrm@nvidia.com, amcohen@nvidia.com, danieller@nvidia.com, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>, jiri@nvidia.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Amit Cohen <amcohen@nvidia.com>

By default, the device considers both 802.1ad and 802.1q packets as tagged,
but this is not supported by the driver. It only supports VLAN and bridge
devices that use 802.1q protocol.

Instead, configure the device to only treat 802.1q packets as tagged
packets.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index b08853f71b2b..ee0c4d098c78 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1386,6 +1386,19 @@ static int mlxsw_sp_port_overheat_init_val_set(struct mlxsw_sp_port *mlxsw_sp_po
 	return 0;
 }
 
+static int
+mlxsw_sp_port_vlan_classification_set(struct mlxsw_sp_port *mlxsw_sp_port,
+				      bool is_8021ad_tagged,
+				      bool is_8021q_tagged)
+{
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	char spvc_pl[MLXSW_REG_SPVC_LEN];
+
+	mlxsw_reg_spvc_pack(spvc_pl, mlxsw_sp_port->local_port,
+			    is_8021ad_tagged, is_8021q_tagged);
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(spvc), spvc_pl);
+}
+
 static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				u8 split_base_local_port,
 				struct mlxsw_sp_port_mapping *port_mapping)
@@ -1592,6 +1605,16 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 	}
 	mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
 
+	/* Set SPVC.et0=true and SPVC.et1=false to make the local port to treat
+	 * only packets with 802.1q header as tagged packets.
+	 */
+	err = mlxsw_sp_port_vlan_classification_set(mlxsw_sp_port, false, true);
+	if (err) {
+		dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set default VLAN classification\n",
+			local_port);
+		goto err_port_vlan_classification_set;
+	}
+
 	INIT_DELAYED_WORK(&mlxsw_sp_port->ptp.shaper_dw,
 			  mlxsw_sp->ptp_ops->shaper_work);
 
@@ -1618,6 +1641,8 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 
 err_register_netdev:
 err_port_overheat_init_val_set:
+	mlxsw_sp_port_vlan_classification_set(mlxsw_sp_port, true, true);
+err_port_vlan_classification_set:
 	mlxsw_sp->ports[local_port] = NULL;
 	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
 err_port_vlan_create:
@@ -1664,6 +1689,7 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u8 local_port)
 	mlxsw_sp_port_ptp_clear(mlxsw_sp_port);
 	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
+	mlxsw_sp_port_vlan_classification_set(mlxsw_sp_port, true, true);
 	mlxsw_sp->ports[local_port] = NULL;
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
 	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
-- 
2.28.0

