Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VO+GydnJlCg6jIT7IS740k+fT+rhrHeEJm8gymS+RYQ=;
	b=EyrGyZfhJiLykI12iQNd0I54DuELWva+I+AL5gjsPBb3iXMiywl0jrTi1dmJhuzwBYLp0doVHZ0MAzNcyzK3ZHPYY7xdsYVw0W8/yvBVFerGWS1EyPWyP1CuwTyXt68+ht3tyLp+C8TwIoIPIGSTPUxxuMxrmnudQ6Zgtpd+P7o=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:16 +0000
Message-ID: <20181017085215.26607-9-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 08/18] mlxsw: spectrum_nve: Implement
 VxLAN operations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

The common NVE core expects each encapsulation type to implement a
certain set of operations that are specific to this type and the
currently used ASIC. These operations include things such as the ability
to determine whether a certain NVE configuration can be offloaded and
ASIC-specific initialization for this type.

Implement these operations for VxLAN on the Spectrum ASIC. Spectrum-2
support will be added by a future patchset.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       | 190 +++++++++++++++++-
 1 file changed, 188 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 4abc4d8a1e68..d21c7be5b1c9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -3,30 +3,216 @@
=20
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/random.h>
+#include <net/vxlan.h>
=20
+#include "reg.h"
 #include "spectrum_nve.h"
=20
+/* Eth (18B) | IPv6 (40B) | UDP (8B) | VxLAN (8B) | Eth (14B) | IPv6 (40B)
+ *
+ * In the worst case - where we have a VLAN tag on the outer Ethernet
+ * header and IPv6 in overlay and underlay - we need to parse 128 bytes
+ */
+#define MLXSW_SP_NVE_VXLAN_PARSING_DEPTH 128
+#define MLXSW_SP_NVE_DEFAULT_PARSING_DEPTH 96
+
+#define MLXSW_SP_NVE_VXLAN_SUPPORTED_FLAGS	VXLAN_F_UDP_ZERO_CSUM_TX
+
 static bool mlxsw_sp1_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve=
,
 					    const struct net_device *dev,
 					    struct netlink_ext_ack *extack)
 {
-	return false;
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	struct vxlan_config *cfg =3D &vxlan->cfg;
+
+	if (cfg->saddr.sa.sa_family !=3D AF_INET) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Only IPv4 underlay is supported");
+		return false;
+	}
+
+	if (vxlan_addr_multicast(&cfg->remote_ip)) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Multicast destination IP is not suppo=
rted");
+		return false;
+	}
+
+	if (vxlan_addr_any(&cfg->saddr)) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Source address must be specified");
+		return false;
+	}
+
+	if (cfg->remote_ifindex) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Local interface is not supported");
+		return false;
+	}
+
+	if (cfg->port_min || cfg->port_max) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Only default UDP source port range is=
 supported");
+		return false;
+	}
+
+	if (cfg->tos !=3D 1) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: TOS must be configured to inherit");
+		return false;
+	}
+
+	if (cfg->flags & VXLAN_F_TTL_INHERIT) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: TTL must not be configured to inherit=
");
+		return false;
+	}
+
+	if (cfg->flags & VXLAN_F_LEARN) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Learning is not supported");
+		return false;
+	}
+
+	if (!(cfg->flags & VXLAN_F_UDP_ZERO_CSUM_TX)) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: UDP checksum is not supported");
+		return false;
+	}
+
+	if (cfg->flags & ~MLXSW_SP_NVE_VXLAN_SUPPORTED_FLAGS) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Unsupported flag");
+		return false;
+	}
+
+	if (cfg->ttl =3D=3D 0) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: TTL must not be configured to 0");
+		return false;
+	}
+
+	if (cfg->label !=3D 0) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Flow label must be configured to 0");
+		return false;
+	}
+
+	return true;
 }
=20
 static void mlxsw_sp_nve_vxlan_config(const struct mlxsw_sp_nve *nve,
 				      const struct net_device *dev,
 				      struct mlxsw_sp_nve_config *config)
 {
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	struct vxlan_config *cfg =3D &vxlan->cfg;
+
+	config->type =3D MLXSW_SP_NVE_TYPE_VXLAN;
+	config->ttl =3D cfg->ttl;
+	config->flowlabel =3D cfg->label;
+	config->learning_en =3D cfg->flags & VXLAN_F_LEARN ? 1 : 0;
+	config->ul_tb_id =3D RT_TABLE_MAIN;
+	config->ul_proto =3D MLXSW_SP_L3_PROTO_IPV4;
+	config->ul_sip.addr4 =3D cfg->saddr.sin.sin_addr.s_addr;
+	config->udp_dport =3D cfg->dst_port;
+}
+
+static int mlxsw_sp_nve_parsing_set(struct mlxsw_sp *mlxsw_sp,
+				    unsigned int parsing_depth,
+				    __be16 udp_dport)
+{
+	char mprs_pl[MLXSW_REG_MPRS_LEN];
+
+	mlxsw_reg_mprs_pack(mprs_pl, parsing_depth, be16_to_cpu(udp_dport));
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(mprs), mprs_pl);
+}
+
+static int
+mlxsw_sp1_nve_vxlan_config_set(struct mlxsw_sp *mlxsw_sp,
+			       const struct mlxsw_sp_nve_config *config)
+{
+	char tngcr_pl[MLXSW_REG_TNGCR_LEN];
+	u16 ul_vr_id;
+	u8 udp_sport;
+	int err;
+
+	err =3D mlxsw_sp_router_tb_id_vr_id(mlxsw_sp, config->ul_tb_id,
+					  &ul_vr_id);
+	if (err)
+		return err;
+
+	mlxsw_reg_tngcr_pack(tngcr_pl, MLXSW_REG_TNGCR_TYPE_VXLAN, true,
+			     config->ttl);
+	/* VxLAN driver's default UDP source port range is 32768 (0x8000)
+	 * to 60999 (0xee47). Set the upper 8 bits of the UDP source port
+	 * to a random number between 0x80 and 0xee
+	 */
+	get_random_bytes(&udp_sport, sizeof(udp_sport));
+	udp_sport =3D (udp_sport % (0xee - 0x80 + 1)) + 0x80;
+	mlxsw_reg_tngcr_nve_udp_sport_prefix_set(tngcr_pl, udp_sport);
+	mlxsw_reg_tngcr_learn_enable_set(tngcr_pl, config->learning_en);
+	mlxsw_reg_tngcr_underlay_virtual_router_set(tngcr_pl, ul_vr_id);
+	mlxsw_reg_tngcr_usipv4_set(tngcr_pl, be32_to_cpu(config->ul_sip.addr4));
+
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tngcr), tngcr_pl);
+}
+
+static void mlxsw_sp1_nve_vxlan_config_clear(struct mlxsw_sp *mlxsw_sp)
+{
+	char tngcr_pl[MLXSW_REG_TNGCR_LEN];
+
+	mlxsw_reg_tngcr_pack(tngcr_pl, MLXSW_REG_TNGCR_TYPE_VXLAN, false, 0);
+
+	mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tngcr), tngcr_pl);
+}
+
+static int mlxsw_sp1_nve_vxlan_rtdp_set(struct mlxsw_sp *mlxsw_sp,
+					unsigned int tunnel_index)
+{
+	char rtdp_pl[MLXSW_REG_RTDP_LEN];
+
+	mlxsw_reg_rtdp_pack(rtdp_pl, MLXSW_REG_RTDP_TYPE_NVE, tunnel_index);
+
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(rtdp), rtdp_pl);
 }
=20
 static int mlxsw_sp1_nve_vxlan_init(struct mlxsw_sp_nve *nve,
 				    const struct mlxsw_sp_nve_config *config)
 {
-	return -EOPNOTSUPP;
+	struct mlxsw_sp *mlxsw_sp =3D nve->mlxsw_sp;
+	int err;
+
+	err =3D mlxsw_sp_nve_parsing_set(mlxsw_sp,
+				       MLXSW_SP_NVE_VXLAN_PARSING_DEPTH,
+				       config->udp_dport);
+	if (err)
+		return err;
+
+	err =3D mlxsw_sp1_nve_vxlan_config_set(mlxsw_sp, config);
+	if (err)
+		goto err_config_set;
+
+	err =3D mlxsw_sp1_nve_vxlan_rtdp_set(mlxsw_sp, nve->tunnel_index);
+	if (err)
+		goto err_rtdp_set;
+
+	err =3D mlxsw_sp_router_nve_promote_decap(mlxsw_sp, config->ul_tb_id,
+						config->ul_proto,
+						&config->ul_sip,
+						nve->tunnel_index);
+	if (err)
+		goto err_promote_decap;
+
+	return 0;
+
+err_promote_decap:
+err_rtdp_set:
+	mlxsw_sp1_nve_vxlan_config_clear(mlxsw_sp);
+err_config_set:
+	mlxsw_sp_nve_parsing_set(mlxsw_sp, MLXSW_SP_NVE_DEFAULT_PARSING_DEPTH,
+				 config->udp_dport);
+	return err;
 }
=20
 static void mlxsw_sp1_nve_vxlan_fini(struct mlxsw_sp_nve *nve)
 {
+	struct mlxsw_sp_nve_config *config =3D &nve->config;
+	struct mlxsw_sp *mlxsw_sp =3D nve->mlxsw_sp;
+
+	mlxsw_sp_router_nve_demote_decap(mlxsw_sp, config->ul_tb_id,
+					 config->ul_proto, &config->ul_sip);
+	mlxsw_sp1_nve_vxlan_config_clear(mlxsw_sp);
+	mlxsw_sp_nve_parsing_set(mlxsw_sp, MLXSW_SP_NVE_DEFAULT_PARSING_DEPTH,
+				 config->udp_dport);
 }
=20
 const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops =3D {
--=20
2.17.2

