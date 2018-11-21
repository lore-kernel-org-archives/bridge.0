Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rbgx1zjX0Vxeg7MHA3g5EJT0wxQkU6TgwMgd5cbBdNg=;
	b=GMcAzLSw0VQ+OMnE19XKjoT4FQHzwoOZhd4NHH+s+1xFfHzym67ZAZdhAG0nYA8uEeTGbja3jLmieylD6SKJg4xzK0UywDwifiPpEWbeOWCfonlGWYNKHotICxStpIUCQsyxwnne/OrvwxVo46gR0VzTgeT9cdOOXDrxC2ctrfY=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:42 +0000
Message-ID: <20181121080141.16676-9-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 08/16] mlxsw: reg: Add definition of
 unicast tunnel record for SFN register
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Will be used to process learned FDB records from an NVE tunnel.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethern=
et/mellanox/mlxsw/reg.h
index be2ffbd19e3a..5c8a38f61a93 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -641,6 +641,10 @@ enum mlxsw_reg_sfn_rec_type {
 	MLXSW_REG_SFN_REC_TYPE_AGED_OUT_MAC =3D 0x7,
 	/* Aged-out MAC address on a LAG port. */
 	MLXSW_REG_SFN_REC_TYPE_AGED_OUT_MAC_LAG =3D 0x8,
+	/* Learned unicast tunnel record. */
+	MLXSW_REG_SFN_REC_TYPE_LEARNED_UNICAST_TUNNEL =3D 0xD,
+	/* Aged-out unicast tunnel record. */
+	MLXSW_REG_SFN_REC_TYPE_AGED_OUT_UNICAST_TUNNEL =3D 0xE,
 };
=20
 /* reg_sfn_rec_type
@@ -704,6 +708,66 @@ static inline void mlxsw_reg_sfn_mac_lag_unpack(char *=
payload, int rec_index,
 	*p_lag_id =3D mlxsw_reg_sfn_mac_lag_lag_id_get(payload, rec_index);
 }
=20
+/* reg_sfn_uc_tunnel_uip_msb
+ * When protocol is IPv4, the most significant byte of the underlay IPv4
+ * address of the remote VTEP.
+ * When protocol is IPv6, reserved.
+ * Access: RO
+ */
+MLXSW_ITEM32_INDEXED(reg, sfn, uc_tunnel_uip_msb, MLXSW_REG_SFN_BASE_LEN, =
24,
+		     8, MLXSW_REG_SFN_REC_LEN, 0x08, false);
+
+enum mlxsw_reg_sfn_uc_tunnel_protocol {
+	MLXSW_REG_SFN_UC_TUNNEL_PROTOCOL_IPV4,
+	MLXSW_REG_SFN_UC_TUNNEL_PROTOCOL_IPV6,
+};
+
+/* reg_sfn_uc_tunnel_protocol
+ * IP protocol.
+ * Access: RO
+ */
+MLXSW_ITEM32_INDEXED(reg, sfn, uc_tunnel_protocol, MLXSW_REG_SFN_BASE_LEN,=
 27,
+		     1, MLXSW_REG_SFN_REC_LEN, 0x0C, false);
+
+/* reg_sfn_uc_tunnel_uip_lsb
+ * When protocol is IPv4, the least significant bytes of the underlay
+ * IPv4 address of the remote VTEP.
+ * When protocol is IPv6, ipv6_id to be queried from TNIPSD.
+ * Access: RO
+ */
+MLXSW_ITEM32_INDEXED(reg, sfn, uc_tunnel_uip_lsb, MLXSW_REG_SFN_BASE_LEN, =
0,
+		     24, MLXSW_REG_SFN_REC_LEN, 0x0C, false);
+
+enum mlxsw_reg_sfn_tunnel_port {
+	MLXSW_REG_SFN_TUNNEL_PORT_NVE,
+	MLXSW_REG_SFN_TUNNEL_PORT_VPLS,
+	MLXSW_REG_SFN_TUNNEL_FLEX_TUNNEL0,
+	MLXSW_REG_SFN_TUNNEL_FLEX_TUNNEL1,
+};
+
+/* reg_sfn_uc_tunnel_port
+ * Tunnel port.
+ * Reserved on Spectrum.
+ * Access: RO
+ */
+MLXSW_ITEM32_INDEXED(reg, sfn, tunnel_port, MLXSW_REG_SFN_BASE_LEN, 0, 4,
+		     MLXSW_REG_SFN_REC_LEN, 0x10, false);
+
+static inline void
+mlxsw_reg_sfn_uc_tunnel_unpack(char *payload, int rec_index, char *mac,
+			       u16 *p_fid, u32 *p_uip,
+			       enum mlxsw_reg_sfn_uc_tunnel_protocol *p_proto)
+{
+	u32 uip_msb, uip_lsb;
+
+	mlxsw_reg_sfn_rec_mac_memcpy_from(payload, rec_index, mac);
+	*p_fid =3D mlxsw_reg_sfn_mac_fid_get(payload, rec_index);
+	uip_msb =3D mlxsw_reg_sfn_uc_tunnel_uip_msb_get(payload, rec_index);
+	uip_lsb =3D mlxsw_reg_sfn_uc_tunnel_uip_lsb_get(payload, rec_index);
+	*p_uip =3D uip_msb << 24 | uip_lsb;
+	*p_proto =3D mlxsw_reg_sfn_uc_tunnel_protocol_get(payload, rec_index);
+}
+
 /* SPMS - Switch Port MSTP/RSTP State Register
  * -------------------------------------------
  * Configures the spanning tree state of a physical port.
--=20
2.19.1

