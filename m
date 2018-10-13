Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+cPVwpZzGa64WZ/uY2vRsnwpknc0RdyTC5jRrA9jrw0=;
	b=aoI2WLjyju6pl96ao2SpezNs8r39P2wfMgifT8HAjdBzgIVJ1xbcYA893cMtjjoR3r57RMoRfvpyksEYDfSo2+nYT0h6bqQCdQErikurFiK45pjv/NlqTcIfU6PpUj1W79MKfsi72nCQQzvNRU/kZTk98IzIV6R8B3w7zklujA0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:31 +0000
Message-ID: <20181013171725.3261-8-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 07/18] mlxsw: spectrum_nve: Implement
	common NVE core
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

The Spectrum ASIC supports different types of NVE encapsulations (e.g.,
VxLAN, NVGRE) with more types to be supported by future ASICs.

Despite being different, all these encapsulations share some common
functionality such as the enablement of NVE encapsulation on a given
filtering identifier (FID) and the addition of remote VTEPs to the
linked-list of VTEPs that traffic should be flooded to.

Implement this common core and allow different ASICs to register
different operations for different encapsulation types.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/Makefile  |   3 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  21 +
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  41 +
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    | 982 ++++++++++++++++++
 .../ethernet/mellanox/mlxsw/spectrum_nve.h    |  49 +
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  63 ++
 6 files changed, 1158 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.=
c

diff --git a/drivers/net/ethernet/mellanox/mlxsw/Makefile b/drivers/net/eth=
ernet/mellanox/mlxsw/Makefile
index 68fa44a41485..1f77e97e2d7a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Makefile
+++ b/drivers/net/ethernet/mellanox/mlxsw/Makefile
@@ -27,7 +27,8 @@ mlxsw_spectrum-objs		:=3D spectrum.o spectrum_buffers.o \
 				   spectrum_acl_flex_keys.o \
 				   spectrum1_mr_tcam.o spectrum2_mr_tcam.o \
 				   spectrum_mr_tcam.o spectrum_mr.o \
-				   spectrum_qdisc.o spectrum_span.o
+				   spectrum_qdisc.o spectrum_span.o \
+				   spectrum_nve.o spectrum_nve_vxlan.o
 mlxsw_spectrum-$(CONFIG_MLXSW_SPECTRUM_DCB)	+=3D spectrum_dcb.o
 mlxsw_spectrum-$(CONFIG_NET_DEVLINK) +=3D spectrum_dpipe.o
 obj-$(CONFIG_MLXSW_MINIMAL)	+=3D mlxsw_minimal.o
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.c
index ed7e4c4e7403..68079b16adfa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2994,6 +2994,13 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlx=
sw_sp, u8 local_port,
 		goto err_port_qdiscs_init;
 	}
=20
+	err =3D mlxsw_sp_port_nve_init(mlxsw_sp_port);
+	if (err) {
+		dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize NVE\n",
+			mlxsw_sp_port->local_port);
+		goto err_port_nve_init;
+	}
+
 	mlxsw_sp_port_vlan =3D mlxsw_sp_port_vlan_get(mlxsw_sp_port, 1);
 	if (IS_ERR(mlxsw_sp_port_vlan)) {
 		dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to create VID 1\n",
@@ -3022,6 +3029,8 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxs=
w_sp, u8 local_port,
 	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_put(mlxsw_sp_port_vlan);
 err_port_vlan_get:
+	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
+err_port_nve_init:
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
 err_port_qdiscs_init:
 	mlxsw_sp_port_fids_fini(mlxsw_sp_port);
@@ -3061,6 +3070,7 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlx=
sw_sp, u8 local_port)
 	mlxsw_sp->ports[local_port] =3D NULL;
 	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port);
+	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
 	mlxsw_sp_port_fids_fini(mlxsw_sp_port);
 	mlxsw_sp_port_dcb_fini(mlxsw_sp_port);
@@ -3795,6 +3805,12 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_co=
re,
 		goto err_afa_init;
 	}
=20
+	err =3D mlxsw_sp_nve_init(mlxsw_sp);
+	if (err) {
+		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize NVE\n");
+		goto err_nve_init;
+	}
+
 	err =3D mlxsw_sp_router_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize router\n");
@@ -3841,6 +3857,8 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_cor=
e,
 err_netdev_notifier:
 	mlxsw_sp_router_fini(mlxsw_sp);
 err_router_init:
+	mlxsw_sp_nve_fini(mlxsw_sp);
+err_nve_init:
 	mlxsw_sp_afa_fini(mlxsw_sp);
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
@@ -3873,6 +3891,7 @@ static int mlxsw_sp1_init(struct mlxsw_core *mlxsw_co=
re,
 	mlxsw_sp->afk_ops =3D &mlxsw_sp1_afk_ops;
 	mlxsw_sp->mr_tcam_ops =3D &mlxsw_sp1_mr_tcam_ops;
 	mlxsw_sp->acl_tcam_ops =3D &mlxsw_sp1_acl_tcam_ops;
+	mlxsw_sp->nve_ops_arr =3D mlxsw_sp1_nve_ops_arr;
=20
 	return mlxsw_sp_init(mlxsw_core, mlxsw_bus_info);
 }
@@ -3887,6 +3906,7 @@ static int mlxsw_sp2_init(struct mlxsw_core *mlxsw_co=
re,
 	mlxsw_sp->afk_ops =3D &mlxsw_sp2_afk_ops;
 	mlxsw_sp->mr_tcam_ops =3D &mlxsw_sp2_mr_tcam_ops;
 	mlxsw_sp->acl_tcam_ops =3D &mlxsw_sp2_acl_tcam_ops;
+	mlxsw_sp->nve_ops_arr =3D mlxsw_sp2_nve_ops_arr;
=20
 	return mlxsw_sp_init(mlxsw_core, mlxsw_bus_info);
 }
@@ -3900,6 +3920,7 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_co=
re)
 	mlxsw_sp_acl_fini(mlxsw_sp);
 	unregister_netdevice_notifier(&mlxsw_sp->netdevice_nb);
 	mlxsw_sp_router_fini(mlxsw_sp);
+	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 	mlxsw_sp_switchdev_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index d0a73935e8bb..2d5eca78576a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -55,6 +55,8 @@ enum mlxsw_sp_resource_id {
 struct mlxsw_sp_port;
 struct mlxsw_sp_rif;
 struct mlxsw_sp_span_entry;
+enum mlxsw_sp_l3proto;
+union mlxsw_sp_l3addr;
=20
 struct mlxsw_sp_upper {
 	struct net_device *dev;
@@ -113,9 +115,11 @@ struct mlxsw_sp_acl;
 struct mlxsw_sp_counter_pool;
 struct mlxsw_sp_fid_core;
 struct mlxsw_sp_kvdl;
+struct mlxsw_sp_nve;
 struct mlxsw_sp_kvdl_ops;
 struct mlxsw_sp_mr_tcam_ops;
 struct mlxsw_sp_acl_tcam_ops;
+struct mlxsw_sp_nve_ops;
=20
 struct mlxsw_sp {
 	struct mlxsw_sp_port **ports;
@@ -132,6 +136,7 @@ struct mlxsw_sp {
 	struct mlxsw_sp_acl *acl;
 	struct mlxsw_sp_fid_core *fid_core;
 	struct mlxsw_sp_kvdl *kvdl;
+	struct mlxsw_sp_nve *nve;
 	struct notifier_block netdevice_nb;
=20
 	struct mlxsw_sp_counter_pool *counter_pool;
@@ -146,6 +151,7 @@ struct mlxsw_sp {
 	const struct mlxsw_afk_ops *afk_ops;
 	const struct mlxsw_sp_mr_tcam_ops *mr_tcam_ops;
 	const struct mlxsw_sp_acl_tcam_ops *acl_tcam_ops;
+	const struct mlxsw_sp_nve_ops **nve_ops_arr;
 };
=20
 static inline struct mlxsw_sp_upper *
@@ -763,4 +769,39 @@ extern const struct mlxsw_sp_mr_tcam_ops mlxsw_sp1_mr_=
tcam_ops;
 /* spectrum2_mr_tcam.c */
 extern const struct mlxsw_sp_mr_tcam_ops mlxsw_sp2_mr_tcam_ops;
=20
+/* spectrum_nve.c */
+enum mlxsw_sp_nve_type {
+	MLXSW_SP_NVE_TYPE_VXLAN,
+};
+
+struct mlxsw_sp_nve_params {
+	enum mlxsw_sp_nve_type type;
+	__be32 vni;
+	const struct net_device *dev;
+};
+
+extern const struct mlxsw_sp_nve_ops *mlxsw_sp1_nve_ops_arr[];
+extern const struct mlxsw_sp_nve_ops *mlxsw_sp2_nve_ops_arr[];
+
+int mlxsw_sp_nve_flood_ip_add(struct mlxsw_sp *mlxsw_sp,
+			      struct mlxsw_sp_fid *fid,
+			      enum mlxsw_sp_l3proto proto,
+			      union mlxsw_sp_l3addr *addr);
+void mlxsw_sp_nve_flood_ip_del(struct mlxsw_sp *mlxsw_sp,
+			       struct mlxsw_sp_fid *fid,
+			       enum mlxsw_sp_l3proto proto,
+			       union mlxsw_sp_l3addr *addr);
+u32 mlxsw_sp_nve_decap_tunnel_index_get(const struct mlxsw_sp *mlxsw_sp);
+bool mlxsw_sp_nve_ipv4_route_is_decap(const struct mlxsw_sp *mlxsw_sp,
+				      u32 tb_id, __be32 addr);
+int mlxsw_sp_nve_fid_enable(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_fid=
 *fid,
+			    struct mlxsw_sp_nve_params *params,
+			    struct netlink_ext_ack *extack);
+void mlxsw_sp_nve_fid_disable(struct mlxsw_sp *mlxsw_sp,
+			      struct mlxsw_sp_fid *fid);
+int mlxsw_sp_port_nve_init(struct mlxsw_sp_port *mlxsw_sp_port);
+void mlxsw_sp_port_nve_fini(struct mlxsw_sp_port *mlxsw_sp_port);
+int mlxsw_sp_nve_init(struct mlxsw_sp *mlxsw_sp);
+void mlxsw_sp_nve_fini(struct mlxsw_sp *mlxsw_sp);
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.c
new file mode 100644
index 000000000000..ad06d9969bc1
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -0,0 +1,982 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/* Copyright (c) 2018 Mellanox Technologies. All rights reserved */
+
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/slab.h>
+#include <net/inet_ecn.h>
+#include <net/ipv6.h>
+
+#include "reg.h"
+#include "spectrum.h"
+#include "spectrum_nve.h"
+
+const struct mlxsw_sp_nve_ops *mlxsw_sp1_nve_ops_arr[] =3D {
+	[MLXSW_SP_NVE_TYPE_VXLAN]	=3D &mlxsw_sp1_nve_vxlan_ops,
+};
+
+const struct mlxsw_sp_nve_ops *mlxsw_sp2_nve_ops_arr[] =3D {
+	[MLXSW_SP_NVE_TYPE_VXLAN]	=3D &mlxsw_sp2_nve_vxlan_ops,
+};
+
+struct mlxsw_sp_nve_mc_entry;
+struct mlxsw_sp_nve_mc_record;
+struct mlxsw_sp_nve_mc_list;
+
+struct mlxsw_sp_nve_mc_record_ops {
+	enum mlxsw_reg_tnumt_record_type type;
+	int (*entry_add)(struct mlxsw_sp_nve_mc_record *mc_record,
+			 struct mlxsw_sp_nve_mc_entry *mc_entry,
+			 const union mlxsw_sp_l3addr *addr);
+	void (*entry_del)(const struct mlxsw_sp_nve_mc_record *mc_record,
+			  const struct mlxsw_sp_nve_mc_entry *mc_entry);
+	void (*entry_set)(const struct mlxsw_sp_nve_mc_record *mc_record,
+			  const struct mlxsw_sp_nve_mc_entry *mc_entry,
+			  char *tnumt_pl, unsigned int entry_index);
+	bool (*entry_compare)(const struct mlxsw_sp_nve_mc_record *mc_record,
+			      const struct mlxsw_sp_nve_mc_entry *mc_entry,
+			      const union mlxsw_sp_l3addr *addr);
+};
+
+struct mlxsw_sp_nve_mc_list_key {
+	u16 fid_index;
+};
+
+struct mlxsw_sp_nve_mc_ipv6_entry {
+	struct in6_addr addr6;
+	u32 addr6_kvdl_index;
+};
+
+struct mlxsw_sp_nve_mc_entry {
+	union {
+		__be32 addr4;
+		struct mlxsw_sp_nve_mc_ipv6_entry ipv6_entry;
+	};
+	u8 valid:1;
+};
+
+struct mlxsw_sp_nve_mc_record {
+	struct list_head list;
+	enum mlxsw_sp_l3proto proto;
+	unsigned int num_entries;
+	struct mlxsw_sp *mlxsw_sp;
+	struct mlxsw_sp_nve_mc_list *mc_list;
+	const struct mlxsw_sp_nve_mc_record_ops *ops;
+	u32 kvdl_index;
+	struct mlxsw_sp_nve_mc_entry entries[0];
+};
+
+struct mlxsw_sp_nve_mc_list {
+	struct list_head records_list;
+	struct rhash_head ht_node;
+	struct mlxsw_sp_nve_mc_list_key key;
+};
+
+static const struct rhashtable_params mlxsw_sp_nve_mc_list_ht_params =3D {
+	.key_len =3D sizeof(struct mlxsw_sp_nve_mc_list_key),
+	.key_offset =3D offsetof(struct mlxsw_sp_nve_mc_list, key),
+	.head_offset =3D offsetof(struct mlxsw_sp_nve_mc_list, ht_node),
+};
+
+static int
+mlxsw_sp_nve_mc_record_ipv4_entry_add(struct mlxsw_sp_nve_mc_record *mc_re=
cord,
+				      struct mlxsw_sp_nve_mc_entry *mc_entry,
+				      const union mlxsw_sp_l3addr *addr)
+{
+	mc_entry->addr4 =3D addr->addr4;
+
+	return 0;
+}
+
+static void
+mlxsw_sp_nve_mc_record_ipv4_entry_del(const struct mlxsw_sp_nve_mc_record =
*mc_record,
+				      const struct mlxsw_sp_nve_mc_entry *mc_entry)
+{
+}
+
+static void
+mlxsw_sp_nve_mc_record_ipv4_entry_set(const struct mlxsw_sp_nve_mc_record =
*mc_record,
+				      const struct mlxsw_sp_nve_mc_entry *mc_entry,
+				      char *tnumt_pl, unsigned int entry_index)
+{
+	u32 udip =3D be32_to_cpu(mc_entry->addr4);
+
+	mlxsw_reg_tnumt_udip_set(tnumt_pl, entry_index, udip);
+}
+
+static bool
+mlxsw_sp_nve_mc_record_ipv4_entry_compare(const struct mlxsw_sp_nve_mc_rec=
ord *mc_record,
+					  const struct mlxsw_sp_nve_mc_entry *mc_entry,
+					  const union mlxsw_sp_l3addr *addr)
+{
+	return mc_entry->addr4 =3D=3D addr->addr4;
+}
+
+static const struct mlxsw_sp_nve_mc_record_ops
+mlxsw_sp_nve_mc_record_ipv4_ops =3D {
+	.type		=3D MLXSW_REG_TNUMT_RECORD_TYPE_IPV4,
+	.entry_add	=3D &mlxsw_sp_nve_mc_record_ipv4_entry_add,
+	.entry_del	=3D &mlxsw_sp_nve_mc_record_ipv4_entry_del,
+	.entry_set	=3D &mlxsw_sp_nve_mc_record_ipv4_entry_set,
+	.entry_compare	=3D &mlxsw_sp_nve_mc_record_ipv4_entry_compare,
+};
+
+static int
+mlxsw_sp_nve_mc_record_ipv6_entry_add(struct mlxsw_sp_nve_mc_record *mc_re=
cord,
+				      struct mlxsw_sp_nve_mc_entry *mc_entry,
+				      const union mlxsw_sp_l3addr *addr)
+{
+	WARN_ON(1);
+
+	return -EINVAL;
+}
+
+static void
+mlxsw_sp_nve_mc_record_ipv6_entry_del(const struct mlxsw_sp_nve_mc_record =
*mc_record,
+				      const struct mlxsw_sp_nve_mc_entry *mc_entry)
+{
+}
+
+static void
+mlxsw_sp_nve_mc_record_ipv6_entry_set(const struct mlxsw_sp_nve_mc_record =
*mc_record,
+				      const struct mlxsw_sp_nve_mc_entry *mc_entry,
+				      char *tnumt_pl, unsigned int entry_index)
+{
+	u32 udip_ptr =3D mc_entry->ipv6_entry.addr6_kvdl_index;
+
+	mlxsw_reg_tnumt_udip_ptr_set(tnumt_pl, entry_index, udip_ptr);
+}
+
+static bool
+mlxsw_sp_nve_mc_record_ipv6_entry_compare(const struct mlxsw_sp_nve_mc_rec=
ord *mc_record,
+					  const struct mlxsw_sp_nve_mc_entry *mc_entry,
+					  const union mlxsw_sp_l3addr *addr)
+{
+	return ipv6_addr_equal(&mc_entry->ipv6_entry.addr6, &addr->addr6);
+}
+
+static const struct mlxsw_sp_nve_mc_record_ops
+mlxsw_sp_nve_mc_record_ipv6_ops =3D {
+	.type		=3D MLXSW_REG_TNUMT_RECORD_TYPE_IPV6,
+	.entry_add	=3D &mlxsw_sp_nve_mc_record_ipv6_entry_add,
+	.entry_del	=3D &mlxsw_sp_nve_mc_record_ipv6_entry_del,
+	.entry_set	=3D &mlxsw_sp_nve_mc_record_ipv6_entry_set,
+	.entry_compare	=3D &mlxsw_sp_nve_mc_record_ipv6_entry_compare,
+};
+
+static const struct mlxsw_sp_nve_mc_record_ops *
+mlxsw_sp_nve_mc_record_ops_arr[] =3D {
+	[MLXSW_SP_L3_PROTO_IPV4] =3D &mlxsw_sp_nve_mc_record_ipv4_ops,
+	[MLXSW_SP_L3_PROTO_IPV6] =3D &mlxsw_sp_nve_mc_record_ipv6_ops,
+};
+
+static struct mlxsw_sp_nve_mc_list *
+mlxsw_sp_nve_mc_list_find(struct mlxsw_sp *mlxsw_sp,
+			  const struct mlxsw_sp_nve_mc_list_key *key)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+
+	return rhashtable_lookup_fast(&nve->mc_list_ht, key,
+				      mlxsw_sp_nve_mc_list_ht_params);
+}
+
+static struct mlxsw_sp_nve_mc_list *
+mlxsw_sp_nve_mc_list_create(struct mlxsw_sp *mlxsw_sp,
+			    const struct mlxsw_sp_nve_mc_list_key *key)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+	struct mlxsw_sp_nve_mc_list *mc_list;
+	int err;
+
+	mc_list =3D kmalloc(sizeof(*mc_list), GFP_KERNEL);
+	if (!mc_list)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&mc_list->records_list);
+	mc_list->key =3D *key;
+
+	err =3D rhashtable_insert_fast(&nve->mc_list_ht, &mc_list->ht_node,
+				     mlxsw_sp_nve_mc_list_ht_params);
+	if (err)
+		goto err_rhashtable_insert;
+
+	return mc_list;
+
+err_rhashtable_insert:
+	kfree(mc_list);
+	return ERR_PTR(err);
+}
+
+static void mlxsw_sp_nve_mc_list_destroy(struct mlxsw_sp *mlxsw_sp,
+					 struct mlxsw_sp_nve_mc_list *mc_list)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+
+	rhashtable_remove_fast(&nve->mc_list_ht, &mc_list->ht_node,
+			       mlxsw_sp_nve_mc_list_ht_params);
+	WARN_ON(!list_empty(&mc_list->records_list));
+	kfree(mc_list);
+}
+
+static struct mlxsw_sp_nve_mc_list *
+mlxsw_sp_nve_mc_list_get(struct mlxsw_sp *mlxsw_sp,
+			 const struct mlxsw_sp_nve_mc_list_key *key)
+{
+	struct mlxsw_sp_nve_mc_list *mc_list;
+
+	mc_list =3D mlxsw_sp_nve_mc_list_find(mlxsw_sp, key);
+	if (mc_list)
+		return mc_list;
+
+	return mlxsw_sp_nve_mc_list_create(mlxsw_sp, key);
+}
+
+static void
+mlxsw_sp_nve_mc_list_put(struct mlxsw_sp *mlxsw_sp,
+			 struct mlxsw_sp_nve_mc_list *mc_list)
+{
+	if (!list_empty(&mc_list->records_list))
+		return;
+	mlxsw_sp_nve_mc_list_destroy(mlxsw_sp, mc_list);
+}
+
+static struct mlxsw_sp_nve_mc_record *
+mlxsw_sp_nve_mc_record_create(struct mlxsw_sp *mlxsw_sp,
+			      struct mlxsw_sp_nve_mc_list *mc_list,
+			      enum mlxsw_sp_l3proto proto)
+{
+	unsigned int num_max_entries =3D mlxsw_sp->nve->num_max_mc_entries[proto]=
;
+	struct mlxsw_sp_nve_mc_record *mc_record;
+	int err;
+
+	mc_record =3D kzalloc(sizeof(*mc_record) + num_max_entries *
+			    sizeof(struct mlxsw_sp_nve_mc_entry), GFP_KERNEL);
+	if (!mc_record)
+		return ERR_PTR(-ENOMEM);
+
+	err =3D mlxsw_sp_kvdl_alloc(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_TNUMT, 1,
+				  &mc_record->kvdl_index);
+	if (err)
+		goto err_kvdl_alloc;
+
+	mc_record->ops =3D mlxsw_sp_nve_mc_record_ops_arr[proto];
+	mc_record->mlxsw_sp =3D mlxsw_sp;
+	mc_record->mc_list =3D mc_list;
+	mc_record->proto =3D proto;
+	list_add_tail(&mc_record->list, &mc_list->records_list);
+
+	return mc_record;
+
+err_kvdl_alloc:
+	kfree(mc_record);
+	return ERR_PTR(err);
+}
+
+static void
+mlxsw_sp_nve_mc_record_destroy(struct mlxsw_sp_nve_mc_record *mc_record)
+{
+	struct mlxsw_sp *mlxsw_sp =3D mc_record->mlxsw_sp;
+
+	list_del(&mc_record->list);
+	mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_TNUMT, 1,
+			   mc_record->kvdl_index);
+	WARN_ON(mc_record->num_entries);
+	kfree(mc_record);
+}
+
+static struct mlxsw_sp_nve_mc_record *
+mlxsw_sp_nve_mc_record_get(struct mlxsw_sp *mlxsw_sp,
+			   struct mlxsw_sp_nve_mc_list *mc_list,
+			   enum mlxsw_sp_l3proto proto)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record;
+
+	list_for_each_entry_reverse(mc_record, &mc_list->records_list, list) {
+		unsigned int num_entries =3D mc_record->num_entries;
+		struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+
+		if (mc_record->proto =3D=3D proto &&
+		    num_entries < nve->num_max_mc_entries[proto])
+			return mc_record;
+	}
+
+	return mlxsw_sp_nve_mc_record_create(mlxsw_sp, mc_list, proto);
+}
+
+static void
+mlxsw_sp_nve_mc_record_put(struct mlxsw_sp_nve_mc_record *mc_record)
+{
+	if (mc_record->num_entries !=3D 0)
+		return;
+
+	mlxsw_sp_nve_mc_record_destroy(mc_record);
+}
+
+static struct mlxsw_sp_nve_mc_entry *
+mlxsw_sp_nve_mc_free_entry_find(struct mlxsw_sp_nve_mc_record *mc_record)
+{
+	struct mlxsw_sp_nve *nve =3D mc_record->mlxsw_sp->nve;
+	unsigned int num_max_entries;
+	int i;
+
+	num_max_entries =3D nve->num_max_mc_entries[mc_record->proto];
+	for (i =3D 0; i < num_max_entries; i++) {
+		if (mc_record->entries[i].valid)
+			continue;
+		return &mc_record->entries[i];
+	}
+
+	return NULL;
+}
+
+static int
+mlxsw_sp_nve_mc_record_refresh(struct mlxsw_sp_nve_mc_record *mc_record)
+{
+	enum mlxsw_reg_tnumt_record_type type =3D mc_record->ops->type;
+	struct mlxsw_sp_nve_mc_list *mc_list =3D mc_record->mc_list;
+	struct mlxsw_sp *mlxsw_sp =3D mc_record->mlxsw_sp;
+	char tnumt_pl[MLXSW_REG_TNUMT_LEN];
+	unsigned int num_max_entries;
+	unsigned int num_entries =3D 0;
+	u32 next_kvdl_index =3D 0;
+	bool next_valid =3D false;
+	int i;
+
+	if (!list_is_last(&mc_record->list, &mc_list->records_list)) {
+		struct mlxsw_sp_nve_mc_record *next_record;
+
+		next_record =3D list_next_entry(mc_record, list);
+		next_kvdl_index =3D next_record->kvdl_index;
+		next_valid =3D true;
+	}
+
+	mlxsw_reg_tnumt_pack(tnumt_pl, type, MLXSW_REG_TNUMT_TUNNEL_PORT_NVE,
+			     mc_record->kvdl_index, next_valid,
+			     next_kvdl_index, mc_record->num_entries);
+
+	num_max_entries =3D mlxsw_sp->nve->num_max_mc_entries[mc_record->proto];
+	for (i =3D 0; i < num_max_entries; i++) {
+		struct mlxsw_sp_nve_mc_entry *mc_entry;
+
+		mc_entry =3D &mc_record->entries[i];
+		if (!mc_entry->valid)
+			continue;
+		mc_record->ops->entry_set(mc_record, mc_entry, tnumt_pl,
+					  num_entries++);
+	}
+
+	WARN_ON(num_entries !=3D mc_record->num_entries);
+
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tnumt), tnumt_pl);
+}
+
+static bool
+mlxsw_sp_nve_mc_record_is_first(struct mlxsw_sp_nve_mc_record *mc_record)
+{
+	struct mlxsw_sp_nve_mc_list *mc_list =3D mc_record->mc_list;
+	struct mlxsw_sp_nve_mc_record *first_record;
+
+	first_record =3D list_first_entry(&mc_list->records_list,
+					struct mlxsw_sp_nve_mc_record, list);
+
+	return mc_record =3D=3D first_record;
+}
+
+static struct mlxsw_sp_nve_mc_entry *
+mlxsw_sp_nve_mc_entry_find(struct mlxsw_sp_nve_mc_record *mc_record,
+			   union mlxsw_sp_l3addr *addr)
+{
+	struct mlxsw_sp_nve *nve =3D mc_record->mlxsw_sp->nve;
+	unsigned int num_max_entries;
+	int i;
+
+	num_max_entries =3D nve->num_max_mc_entries[mc_record->proto];
+	for (i =3D 0; i < num_max_entries; i++) {
+		struct mlxsw_sp_nve_mc_entry *mc_entry;
+
+		mc_entry =3D &mc_record->entries[i];
+		if (!mc_entry->valid)
+			continue;
+		if (mc_record->ops->entry_compare(mc_record, mc_entry, addr))
+			return mc_entry;
+	}
+
+	return NULL;
+}
+
+static int
+mlxsw_sp_nve_mc_record_ip_add(struct mlxsw_sp_nve_mc_record *mc_record,
+			      union mlxsw_sp_l3addr *addr)
+{
+	struct mlxsw_sp_nve_mc_entry *mc_entry =3D NULL;
+	int err;
+
+	mc_entry =3D mlxsw_sp_nve_mc_free_entry_find(mc_record);
+	if (WARN_ON(!mc_entry))
+		return -EINVAL;
+
+	err =3D mc_record->ops->entry_add(mc_record, mc_entry, addr);
+	if (err)
+		return err;
+	mc_record->num_entries++;
+	mc_entry->valid =3D true;
+
+	err =3D mlxsw_sp_nve_mc_record_refresh(mc_record);
+	if (err)
+		goto err_record_refresh;
+
+	/* If this is a new record and not the first one, then we need to
+	 * update the next pointer of the previous entry
+	 */
+	if (mc_record->num_entries !=3D 1 ||
+	    mlxsw_sp_nve_mc_record_is_first(mc_record))
+		return 0;
+
+	err =3D mlxsw_sp_nve_mc_record_refresh(list_prev_entry(mc_record, list));
+	if (err)
+		goto err_prev_record_refresh;
+
+	return 0;
+
+err_prev_record_refresh:
+err_record_refresh:
+	mc_entry->valid =3D false;
+	mc_record->num_entries--;
+	mc_record->ops->entry_del(mc_record, mc_entry);
+	return err;
+}
+
+static void
+mlxsw_sp_nve_mc_record_entry_del(struct mlxsw_sp_nve_mc_record *mc_record,
+				 struct mlxsw_sp_nve_mc_entry *mc_entry)
+{
+	struct mlxsw_sp_nve_mc_list *mc_list =3D mc_record->mc_list;
+
+	mc_entry->valid =3D false;
+	mc_record->num_entries--;
+
+	/* When the record continues to exist we only need to invalidate
+	 * the requested entry
+	 */
+	if (mc_record->num_entries !=3D 0) {
+		mlxsw_sp_nve_mc_record_refresh(mc_record);
+		mc_record->ops->entry_del(mc_record, mc_entry);
+		return;
+	}
+
+	/* If the record needs to be deleted, but it is not the first,
+	 * then we need to make sure that the previous record no longer
+	 * points to it. Remove deleted record from the list to reflect
+	 * that and then re-add it at the end, so that it could be
+	 * properly removed by the record destruction code
+	 */
+	if (!mlxsw_sp_nve_mc_record_is_first(mc_record)) {
+		struct mlxsw_sp_nve_mc_record *prev_record;
+
+		prev_record =3D list_prev_entry(mc_record, list);
+		list_del(&mc_record->list);
+		mlxsw_sp_nve_mc_record_refresh(prev_record);
+		list_add_tail(&mc_record->list, &mc_list->records_list);
+		mc_record->ops->entry_del(mc_record, mc_entry);
+		return;
+	}
+
+	/* If the first record needs to be deleted, but the list is not
+	 * singular, then the second record needs to be written in the
+	 * first record's address, as this address is stored as a property
+	 * of the FID
+	 */
+	if (mlxsw_sp_nve_mc_record_is_first(mc_record) &&
+	    !list_is_singular(&mc_list->records_list)) {
+		struct mlxsw_sp_nve_mc_record *next_record;
+
+		next_record =3D list_next_entry(mc_record, list);
+		swap(mc_record->kvdl_index, next_record->kvdl_index);
+		mlxsw_sp_nve_mc_record_refresh(next_record);
+		mc_record->ops->entry_del(mc_record, mc_entry);
+		return;
+	}
+
+	/* This is the last case where the last remaining record needs to
+	 * be deleted. Simply delete the entry
+	 */
+	mc_record->ops->entry_del(mc_record, mc_entry);
+}
+
+static struct mlxsw_sp_nve_mc_record *
+mlxsw_sp_nve_mc_record_find(struct mlxsw_sp_nve_mc_list *mc_list,
+			    enum mlxsw_sp_l3proto proto,
+			    union mlxsw_sp_l3addr *addr,
+			    struct mlxsw_sp_nve_mc_entry **mc_entry)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record;
+
+	list_for_each_entry(mc_record, &mc_list->records_list, list) {
+		if (mc_record->proto !=3D proto)
+			continue;
+
+		*mc_entry =3D mlxsw_sp_nve_mc_entry_find(mc_record, addr);
+		if (*mc_entry)
+			return mc_record;
+	}
+
+	return NULL;
+}
+
+static int mlxsw_sp_nve_mc_list_ip_add(struct mlxsw_sp *mlxsw_sp,
+				       struct mlxsw_sp_nve_mc_list *mc_list,
+				       enum mlxsw_sp_l3proto proto,
+				       union mlxsw_sp_l3addr *addr)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record;
+	int err;
+
+	mc_record =3D mlxsw_sp_nve_mc_record_get(mlxsw_sp, mc_list, proto);
+	if (IS_ERR(mc_record))
+		return PTR_ERR(mc_record);
+
+	err =3D mlxsw_sp_nve_mc_record_ip_add(mc_record, addr);
+	if (err)
+		goto err_ip_add;
+
+	return 0;
+
+err_ip_add:
+	mlxsw_sp_nve_mc_record_put(mc_record);
+	return err;
+}
+
+static void mlxsw_sp_nve_mc_list_ip_del(struct mlxsw_sp *mlxsw_sp,
+					struct mlxsw_sp_nve_mc_list *mc_list,
+					enum mlxsw_sp_l3proto proto,
+					union mlxsw_sp_l3addr *addr)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record;
+	struct mlxsw_sp_nve_mc_entry *mc_entry;
+
+	mc_record =3D mlxsw_sp_nve_mc_record_find(mc_list, proto, addr,
+						&mc_entry);
+	if (WARN_ON(!mc_record))
+		return;
+
+	mlxsw_sp_nve_mc_record_entry_del(mc_record, mc_entry);
+	mlxsw_sp_nve_mc_record_put(mc_record);
+}
+
+static int
+mlxsw_sp_nve_fid_flood_index_set(struct mlxsw_sp_fid *fid,
+				 struct mlxsw_sp_nve_mc_list *mc_list)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record;
+
+	/* The address of the first record in the list is a property of
+	 * the FID and we never change it. It only needs to be set when
+	 * a new list is created
+	 */
+	if (mlxsw_sp_fid_nve_flood_index_is_set(fid))
+		return 0;
+
+	mc_record =3D list_first_entry(&mc_list->records_list,
+				     struct mlxsw_sp_nve_mc_record, list);
+
+	return mlxsw_sp_fid_nve_flood_index_set(fid, mc_record->kvdl_index);
+}
+
+static void
+mlxsw_sp_nve_fid_flood_index_clear(struct mlxsw_sp_fid *fid,
+				   struct mlxsw_sp_nve_mc_list *mc_list)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record;
+
+	/* The address of the first record needs to be invalidated only when
+	 * the last record is about to be removed
+	 */
+	if (!list_is_singular(&mc_list->records_list))
+		return;
+
+	mc_record =3D list_first_entry(&mc_list->records_list,
+				     struct mlxsw_sp_nve_mc_record, list);
+	if (mc_record->num_entries !=3D 1)
+		return;
+
+	return mlxsw_sp_fid_nve_flood_index_clear(fid);
+}
+
+int mlxsw_sp_nve_flood_ip_add(struct mlxsw_sp *mlxsw_sp,
+			      struct mlxsw_sp_fid *fid,
+			      enum mlxsw_sp_l3proto proto,
+			      union mlxsw_sp_l3addr *addr)
+{
+	struct mlxsw_sp_nve_mc_list_key key =3D { 0 };
+	struct mlxsw_sp_nve_mc_list *mc_list;
+	int err;
+
+	key.fid_index =3D mlxsw_sp_fid_index(fid);
+	mc_list =3D mlxsw_sp_nve_mc_list_get(mlxsw_sp, &key);
+	if (IS_ERR(mc_list))
+		return PTR_ERR(mc_list);
+
+	err =3D mlxsw_sp_nve_mc_list_ip_add(mlxsw_sp, mc_list, proto, addr);
+	if (err)
+		goto err_add_ip;
+
+	err =3D mlxsw_sp_nve_fid_flood_index_set(fid, mc_list);
+	if (err)
+		goto err_fid_flood_index_set;
+
+	return 0;
+
+err_fid_flood_index_set:
+	mlxsw_sp_nve_mc_list_ip_del(mlxsw_sp, mc_list, proto, addr);
+err_add_ip:
+	mlxsw_sp_nve_mc_list_put(mlxsw_sp, mc_list);
+	return err;
+}
+
+void mlxsw_sp_nve_flood_ip_del(struct mlxsw_sp *mlxsw_sp,
+			       struct mlxsw_sp_fid *fid,
+			       enum mlxsw_sp_l3proto proto,
+			       union mlxsw_sp_l3addr *addr)
+{
+	struct mlxsw_sp_nve_mc_list_key key =3D { 0 };
+	struct mlxsw_sp_nve_mc_list *mc_list;
+
+	key.fid_index =3D mlxsw_sp_fid_index(fid);
+	mc_list =3D mlxsw_sp_nve_mc_list_find(mlxsw_sp, &key);
+	if (WARN_ON(!mc_list))
+		return;
+
+	mlxsw_sp_nve_fid_flood_index_clear(fid, mc_list);
+	mlxsw_sp_nve_mc_list_ip_del(mlxsw_sp, mc_list, proto, addr);
+	mlxsw_sp_nve_mc_list_put(mlxsw_sp, mc_list);
+}
+
+static void
+mlxsw_sp_nve_mc_record_delete(struct mlxsw_sp_nve_mc_record *mc_record)
+{
+	struct mlxsw_sp_nve *nve =3D mc_record->mlxsw_sp->nve;
+	unsigned int num_max_entries;
+	int i;
+
+	num_max_entries =3D nve->num_max_mc_entries[mc_record->proto];
+	for (i =3D 0; i < num_max_entries; i++) {
+		struct mlxsw_sp_nve_mc_entry *mc_entry =3D &mc_record->entries[i];
+
+		if (!mc_entry->valid)
+			continue;
+		mlxsw_sp_nve_mc_record_entry_del(mc_record, mc_entry);
+	}
+
+	WARN_ON(mc_record->num_entries);
+	mlxsw_sp_nve_mc_record_put(mc_record);
+}
+
+static void mlxsw_sp_nve_flood_ip_flush(struct mlxsw_sp *mlxsw_sp,
+					struct mlxsw_sp_fid *fid)
+{
+	struct mlxsw_sp_nve_mc_record *mc_record, *tmp;
+	struct mlxsw_sp_nve_mc_list_key key =3D { 0 };
+	struct mlxsw_sp_nve_mc_list *mc_list;
+
+	if (!mlxsw_sp_fid_nve_flood_index_is_set(fid))
+		return;
+
+	mlxsw_sp_fid_nve_flood_index_clear(fid);
+
+	key.fid_index =3D mlxsw_sp_fid_index(fid);
+	mc_list =3D mlxsw_sp_nve_mc_list_find(mlxsw_sp, &key);
+	if (WARN_ON(!mc_list))
+		return;
+
+	list_for_each_entry_safe(mc_record, tmp, &mc_list->records_list, list)
+		mlxsw_sp_nve_mc_record_delete(mc_record);
+
+	WARN_ON(!list_empty(&mc_list->records_list));
+	mlxsw_sp_nve_mc_list_put(mlxsw_sp, mc_list);
+}
+
+u32 mlxsw_sp_nve_decap_tunnel_index_get(const struct mlxsw_sp *mlxsw_sp)
+{
+	WARN_ON(mlxsw_sp->nve->num_nve_tunnels =3D=3D 0);
+
+	return mlxsw_sp->nve->tunnel_index;
+}
+
+bool mlxsw_sp_nve_ipv4_route_is_decap(const struct mlxsw_sp *mlxsw_sp,
+				      u32 tb_id, __be32 addr)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+	struct mlxsw_sp_nve_config *config =3D &nve->config;
+
+	if (nve->num_nve_tunnels &&
+	    config->ul_proto =3D=3D MLXSW_SP_L3_PROTO_IPV4 &&
+	    config->ul_sip.addr4 =3D=3D addr && config->ul_tb_id =3D=3D tb_id)
+		return true;
+
+	return false;
+}
+
+static int mlxsw_sp_nve_tunnel_init(struct mlxsw_sp *mlxsw_sp,
+				    struct mlxsw_sp_nve_config *config)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+	const struct mlxsw_sp_nve_ops *ops;
+	int err;
+
+	if (nve->num_nve_tunnels++ !=3D 0)
+		return 0;
+
+	err =3D mlxsw_sp_kvdl_alloc(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ, 1,
+				  &nve->tunnel_index);
+	if (err)
+		goto err_kvdl_alloc;
+
+	ops =3D nve->nve_ops_arr[config->type];
+	err =3D ops->init(nve, config);
+	if (err)
+		goto err_ops_init;
+
+	return 0;
+
+err_ops_init:
+	mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ, 1,
+			   nve->tunnel_index);
+err_kvdl_alloc:
+	nve->num_nve_tunnels--;
+	return err;
+}
+
+static void mlxsw_sp_nve_tunnel_fini(struct mlxsw_sp *mlxsw_sp)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+	const struct mlxsw_sp_nve_ops *ops;
+
+	ops =3D nve->nve_ops_arr[nve->config.type];
+
+	if (mlxsw_sp->nve->num_nve_tunnels =3D=3D 1) {
+		ops->fini(nve);
+		mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ, 1,
+				   nve->tunnel_index);
+	}
+	nve->num_nve_tunnels--;
+}
+
+static void mlxsw_sp_nve_fdb_flush_by_fid(struct mlxsw_sp *mlxsw_sp,
+					  u16 fid_index)
+{
+	char sfdf_pl[MLXSW_REG_SFDF_LEN];
+
+	mlxsw_reg_sfdf_pack(sfdf_pl, MLXSW_REG_SFDF_FLUSH_PER_NVE_AND_FID);
+	mlxsw_reg_sfdf_fid_set(sfdf_pl, fid_index);
+	mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfdf), sfdf_pl);
+}
+
+int mlxsw_sp_nve_fid_enable(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_fid=
 *fid,
+			    struct mlxsw_sp_nve_params *params,
+			    struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_nve *nve =3D mlxsw_sp->nve;
+	const struct mlxsw_sp_nve_ops *ops;
+	struct mlxsw_sp_nve_config config;
+	int err;
+
+	ops =3D nve->nve_ops_arr[params->type];
+
+	if (!ops->can_offload(nve, params->dev, extack))
+		return -EOPNOTSUPP;
+
+	memset(&config, 0, sizeof(config));
+	ops->nve_config(nve, params->dev, &config);
+	if (nve->num_nve_tunnels &&
+	    memcmp(&config, &nve->config, sizeof(config))) {
+		NL_SET_ERR_MSG_MOD(extack, "Conflicting NVE tunnels configuration");
+		return -EOPNOTSUPP;
+	}
+
+	err =3D mlxsw_sp_nve_tunnel_init(mlxsw_sp, &config);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to initialize NVE tunnel");
+		return err;
+	}
+
+	err =3D mlxsw_sp_fid_vni_set(fid, params->vni);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set VNI on FID");
+		goto err_fid_vni_set;
+	}
+
+	nve->config =3D config;
+
+	return 0;
+
+err_fid_vni_set:
+	mlxsw_sp_nve_tunnel_fini(mlxsw_sp);
+	return err;
+}
+
+void mlxsw_sp_nve_fid_disable(struct mlxsw_sp *mlxsw_sp,
+			      struct mlxsw_sp_fid *fid)
+{
+	u16 fid_index =3D mlxsw_sp_fid_index(fid);
+
+	mlxsw_sp_nve_flood_ip_flush(mlxsw_sp, fid);
+	mlxsw_sp_nve_fdb_flush_by_fid(mlxsw_sp, fid_index);
+	mlxsw_sp_fid_vni_clear(fid);
+	mlxsw_sp_nve_tunnel_fini(mlxsw_sp);
+}
+
+int mlxsw_sp_port_nve_init(struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	struct mlxsw_sp *mlxsw_sp =3D mlxsw_sp_port->mlxsw_sp;
+	char tnqdr_pl[MLXSW_REG_TNQDR_LEN];
+
+	mlxsw_reg_tnqdr_pack(tnqdr_pl, mlxsw_sp_port->local_port);
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tnqdr), tnqdr_pl);
+}
+
+void mlxsw_sp_port_nve_fini(struct mlxsw_sp_port *mlxsw_sp_port)
+{
+}
+
+static int mlxsw_sp_nve_qos_init(struct mlxsw_sp *mlxsw_sp)
+{
+	char tnqcr_pl[MLXSW_REG_TNQCR_LEN];
+
+	mlxsw_reg_tnqcr_pack(tnqcr_pl);
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tnqcr), tnqcr_pl);
+}
+
+static int mlxsw_sp_nve_ecn_encap_init(struct mlxsw_sp *mlxsw_sp)
+{
+	int i;
+
+	/* Iterate over inner ECN values */
+	for (i =3D INET_ECN_NOT_ECT; i <=3D INET_ECN_CE; i++) {
+		u8 outer_ecn =3D INET_ECN_encapsulate(0, i);
+		char tneem_pl[MLXSW_REG_TNEEM_LEN];
+		int err;
+
+		mlxsw_reg_tneem_pack(tneem_pl, i, outer_ecn);
+		err =3D mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tneem),
+				      tneem_pl);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int __mlxsw_sp_nve_ecn_decap_init(struct mlxsw_sp *mlxsw_sp,
+					 u8 inner_ecn, u8 outer_ecn)
+{
+	char tndem_pl[MLXSW_REG_TNDEM_LEN];
+	bool trap_en, set_ce =3D false;
+	u8 new_inner_ecn;
+
+	trap_en =3D !!__INET_ECN_decapsulate(outer_ecn, inner_ecn, &set_ce);
+	new_inner_ecn =3D set_ce ? INET_ECN_CE : inner_ecn;
+
+	mlxsw_reg_tndem_pack(tndem_pl, outer_ecn, inner_ecn, new_inner_ecn,
+			     trap_en, trap_en ? MLXSW_TRAP_ID_DECAP_ECN0 : 0);
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(tndem), tndem_pl);
+}
+
+static int mlxsw_sp_nve_ecn_decap_init(struct mlxsw_sp *mlxsw_sp)
+{
+	int i;
+
+	/* Iterate over inner ECN values */
+	for (i =3D INET_ECN_NOT_ECT; i <=3D INET_ECN_CE; i++) {
+		int j;
+
+		/* Iterate over outer ECN values */
+		for (j =3D INET_ECN_NOT_ECT; j <=3D INET_ECN_CE; j++) {
+			int err;
+
+			err =3D __mlxsw_sp_nve_ecn_decap_init(mlxsw_sp, i, j);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+static int mlxsw_sp_nve_ecn_init(struct mlxsw_sp *mlxsw_sp)
+{
+	int err;
+
+	err =3D mlxsw_sp_nve_ecn_encap_init(mlxsw_sp);
+	if (err)
+		return err;
+
+	return mlxsw_sp_nve_ecn_decap_init(mlxsw_sp);
+}
+
+static int mlxsw_sp_nve_resources_query(struct mlxsw_sp *mlxsw_sp)
+{
+	unsigned int max;
+
+	if (!MLXSW_CORE_RES_VALID(mlxsw_sp->core, MAX_NVE_MC_ENTRIES_IPV4) ||
+	    !MLXSW_CORE_RES_VALID(mlxsw_sp->core, MAX_NVE_MC_ENTRIES_IPV6))
+		return -EIO;
+	max =3D MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_NVE_MC_ENTRIES_IPV4);
+	mlxsw_sp->nve->num_max_mc_entries[MLXSW_SP_L3_PROTO_IPV4] =3D max;
+	max =3D MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_NVE_MC_ENTRIES_IPV6);
+	mlxsw_sp->nve->num_max_mc_entries[MLXSW_SP_L3_PROTO_IPV6] =3D max;
+
+	return 0;
+}
+
+int mlxsw_sp_nve_init(struct mlxsw_sp *mlxsw_sp)
+{
+	struct mlxsw_sp_nve *nve;
+	int err;
+
+	nve =3D kzalloc(sizeof(*mlxsw_sp->nve), GFP_KERNEL);
+	if (!nve)
+		return -ENOMEM;
+	mlxsw_sp->nve =3D nve;
+	nve->mlxsw_sp =3D mlxsw_sp;
+	nve->nve_ops_arr =3D mlxsw_sp->nve_ops_arr;
+
+	err =3D rhashtable_init(&nve->mc_list_ht,
+			      &mlxsw_sp_nve_mc_list_ht_params);
+	if (err)
+		goto err_rhashtable_init;
+
+	err =3D mlxsw_sp_nve_qos_init(mlxsw_sp);
+	if (err)
+		goto err_nve_qos_init;
+
+	err =3D mlxsw_sp_nve_ecn_init(mlxsw_sp);
+	if (err)
+		goto err_nve_ecn_init;
+
+	err =3D mlxsw_sp_nve_resources_query(mlxsw_sp);
+	if (err)
+		goto err_nve_resources_query;
+
+	return 0;
+
+err_nve_resources_query:
+err_nve_ecn_init:
+err_nve_qos_init:
+	rhashtable_destroy(&nve->mc_list_ht);
+err_rhashtable_init:
+	mlxsw_sp->nve =3D NULL;
+	kfree(nve);
+	return err;
+}
+
+void mlxsw_sp_nve_fini(struct mlxsw_sp *mlxsw_sp)
+{
+	WARN_ON(mlxsw_sp->nve->num_nve_tunnels);
+	rhashtable_destroy(&mlxsw_sp->nve->mc_list_ht);
+	mlxsw_sp->nve =3D NULL;
+	kfree(mlxsw_sp->nve);
+}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.h
new file mode 100644
index 000000000000..4cc3297e13d6
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* Copyright (c) 2018 Mellanox Technologies. All rights reserved */
+
+#ifndef _MLXSW_SPECTRUM_NVE_H
+#define _MLXSW_SPECTRUM_NVE_H
+
+#include <linux/netlink.h>
+#include <linux/rhashtable.h>
+
+#include "spectrum.h"
+
+struct mlxsw_sp_nve_config {
+	enum mlxsw_sp_nve_type type;
+	u8 ttl;
+	u8 learning_en:1;
+	__be16 udp_dport;
+	__be32 flowlabel;
+	u32 ul_tb_id;
+	enum mlxsw_sp_l3proto ul_proto;
+	union mlxsw_sp_l3addr ul_sip;
+};
+
+struct mlxsw_sp_nve {
+	struct mlxsw_sp_nve_config config;
+	struct rhashtable mc_list_ht;
+	struct mlxsw_sp *mlxsw_sp;
+	const struct mlxsw_sp_nve_ops **nve_ops_arr;
+	unsigned int num_nve_tunnels;	/* Protected by RTNL */
+	unsigned int num_max_mc_entries[MLXSW_SP_L3_PROTO_MAX];
+	u32 tunnel_index;
+};
+
+struct mlxsw_sp_nve_ops {
+	enum mlxsw_sp_nve_type type;
+	bool (*can_offload)(const struct mlxsw_sp_nve *nve,
+			    const struct net_device *dev,
+			    struct netlink_ext_ack *extack);
+	void (*nve_config)(const struct mlxsw_sp_nve *nve,
+			   const struct net_device *dev,
+			   struct mlxsw_sp_nve_config *config);
+	int (*init)(struct mlxsw_sp_nve *nve,
+		    const struct mlxsw_sp_nve_config *config);
+	void (*fini)(struct mlxsw_sp_nve *nve);
+};
+
+extern const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops;
+extern const struct mlxsw_sp_nve_ops mlxsw_sp2_nve_vxlan_ops;
+
+#endif
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
new file mode 100644
index 000000000000..4abc4d8a1e68
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/* Copyright (c) 2018 Mellanox Technologies. All rights reserved */
+
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
+
+#include "spectrum_nve.h"
+
+static bool mlxsw_sp1_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve=
,
+					    const struct net_device *dev,
+					    struct netlink_ext_ack *extack)
+{
+	return false;
+}
+
+static void mlxsw_sp_nve_vxlan_config(const struct mlxsw_sp_nve *nve,
+				      const struct net_device *dev,
+				      struct mlxsw_sp_nve_config *config)
+{
+}
+
+static int mlxsw_sp1_nve_vxlan_init(struct mlxsw_sp_nve *nve,
+				    const struct mlxsw_sp_nve_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static void mlxsw_sp1_nve_vxlan_fini(struct mlxsw_sp_nve *nve)
+{
+}
+
+const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops =3D {
+	.type		=3D MLXSW_SP_NVE_TYPE_VXLAN,
+	.can_offload	=3D mlxsw_sp1_nve_vxlan_can_offload,
+	.nve_config	=3D mlxsw_sp_nve_vxlan_config,
+	.init		=3D mlxsw_sp1_nve_vxlan_init,
+	.fini		=3D mlxsw_sp1_nve_vxlan_fini,
+};
+
+static bool mlxsw_sp2_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve=
,
+					    const struct net_device *dev,
+					    struct netlink_ext_ack *extack)
+{
+	return false;
+}
+
+static int mlxsw_sp2_nve_vxlan_init(struct mlxsw_sp_nve *nve,
+				    const struct mlxsw_sp_nve_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static void mlxsw_sp2_nve_vxlan_fini(struct mlxsw_sp_nve *nve)
+{
+}
+
+const struct mlxsw_sp_nve_ops mlxsw_sp2_nve_vxlan_ops =3D {
+	.type		=3D MLXSW_SP_NVE_TYPE_VXLAN,
+	.can_offload	=3D mlxsw_sp2_nve_vxlan_can_offload,
+	.nve_config	=3D mlxsw_sp_nve_vxlan_config,
+	.init		=3D mlxsw_sp2_nve_vxlan_init,
+	.fini		=3D mlxsw_sp2_nve_vxlan_fini,
+};
--=20
2.17.2

