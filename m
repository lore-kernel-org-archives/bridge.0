Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kiUS2CPdNpFXJFqv9eX0+DNjENCVOdlOnZfHNdgomR0=;
	b=Byer0RFFa5Ydj/uXrw9IkI/NBfFnuT6b3gXmdfJpjRBzjHkX1Vk1Eoml3tSy6bMHlNjATC5rvFciQBGb2Xfws9zT9QVpoS1go3qMFxyelAylSsVbInDsgCEQF/CmpMuO5uh5mJq+Mw5L4lPKE9rnGvsr38o2qiihK2FrOsHmdL0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:07 +0000
Message-ID: <20181017085215.26607-4-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 03/18] mlxsw: spectrum_router: Enable
 local routes promotion to perform NVE decap
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

When an NVE tunnel with an IP underlay (e.g., VxLAN) is configured the
local route to the tunnel's source IP needs to be promoted to perform
NVE decapsulation.

Expose an API in the unicast IP router to promote / demote local routes.

The case where a local route is configured after the creation of the NVE
tunnel will be handled in a subsequent patch in the set.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   7 ++
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 115 +++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index f463be58c6dc..739a62d024c9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -431,6 +431,13 @@ struct mlxsw_sp_rif *mlxsw_sp_rif_find_by_dev(const st=
ruct mlxsw_sp *mlxsw_sp,
 					      const struct net_device *dev);
 u8 mlxsw_sp_router_port(const struct mlxsw_sp *mlxsw_sp);
 struct mlxsw_sp_fid *mlxsw_sp_rif_fid(const struct mlxsw_sp_rif *rif);
+int mlxsw_sp_router_nve_promote_decap(struct mlxsw_sp *mlxsw_sp, u32 ul_tb=
_id,
+				      enum mlxsw_sp_l3proto ul_proto,
+				      const union mlxsw_sp_l3addr *ul_sip,
+				      u32 tunnel_index);
+void mlxsw_sp_router_nve_demote_decap(struct mlxsw_sp *mlxsw_sp, u32 ul_tb=
_id,
+				      enum mlxsw_sp_l3proto ul_proto,
+				      const union mlxsw_sp_l3addr *ul_sip);
=20
 /* spectrum_kvdl.c */
 enum mlxsw_sp_kvdl_entry_type {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/driver=
s/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2ab9cf25a08a..ca4289d15561 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -366,6 +366,7 @@ enum mlxsw_sp_fib_entry_type {
 	 * encapsulating entries.)
 	 */
 	MLXSW_SP_FIB_ENTRY_TYPE_IPIP_DECAP,
+	MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP,
 };
=20
 struct mlxsw_sp_nexthop_group;
@@ -1128,6 +1129,52 @@ mlxsw_sp_ipip_entry_promote_decap(struct mlxsw_sp *m=
lxsw_sp,
 		mlxsw_sp_ipip_entry_demote_decap(mlxsw_sp, ipip_entry);
 }
=20
+static struct mlxsw_sp_fib_entry *
+mlxsw_sp_router_ip2me_fib_entry_find(struct mlxsw_sp *mlxsw_sp, u32 tb_id,
+				     enum mlxsw_sp_l3proto proto,
+				     const union mlxsw_sp_l3addr *addr,
+				     enum mlxsw_sp_fib_entry_type type)
+{
+	struct mlxsw_sp_fib_entry *fib_entry;
+	struct mlxsw_sp_fib_node *fib_node;
+	unsigned char addr_prefix_len;
+	struct mlxsw_sp_fib *fib;
+	struct mlxsw_sp_vr *vr;
+	const void *addrp;
+	size_t addr_len;
+	u32 addr4;
+
+	vr =3D mlxsw_sp_vr_find(mlxsw_sp, tb_id);
+	if (!vr)
+		return NULL;
+	fib =3D mlxsw_sp_vr_fib(vr, proto);
+
+	switch (proto) {
+	case MLXSW_SP_L3_PROTO_IPV4:
+		addr4 =3D be32_to_cpu(addr->addr4);
+		addrp =3D &addr4;
+		addr_len =3D 4;
+		addr_prefix_len =3D 32;
+		break;
+	case MLXSW_SP_L3_PROTO_IPV6: /* fall through */
+	default:
+		WARN_ON(1);
+		return NULL;
+	}
+
+	fib_node =3D mlxsw_sp_fib_node_lookup(fib, addrp, addr_len,
+					    addr_prefix_len);
+	if (!fib_node || list_empty(&fib_node->entry_list))
+		return NULL;
+
+	fib_entry =3D list_first_entry(&fib_node->entry_list,
+				     struct mlxsw_sp_fib_entry, list);
+	if (fib_entry->type !=3D type)
+		return NULL;
+
+	return fib_entry;
+}
+
 /* Given an IPIP entry, find the corresponding decap route. */
 static struct mlxsw_sp_fib_entry *
 mlxsw_sp_ipip_entry_find_decap(struct mlxsw_sp *mlxsw_sp,
@@ -1765,6 +1812,56 @@ mlxsw_sp_netdevice_ipip_ul_event(struct mlxsw_sp *ml=
xsw_sp,
 	return 0;
 }
=20
+int mlxsw_sp_router_nve_promote_decap(struct mlxsw_sp *mlxsw_sp, u32 ul_tb=
_id,
+				      enum mlxsw_sp_l3proto ul_proto,
+				      const union mlxsw_sp_l3addr *ul_sip,
+				      u32 tunnel_index)
+{
+	enum mlxsw_sp_fib_entry_type type =3D MLXSW_SP_FIB_ENTRY_TYPE_TRAP;
+	struct mlxsw_sp_fib_entry *fib_entry;
+	int err;
+
+	/* It is valid to create a tunnel with a local IP and only later
+	 * assign this IP address to a local interface
+	 */
+	fib_entry =3D mlxsw_sp_router_ip2me_fib_entry_find(mlxsw_sp, ul_tb_id,
+							 ul_proto, ul_sip,
+							 type);
+	if (!fib_entry)
+		return 0;
+
+	fib_entry->decap.tunnel_index =3D tunnel_index;
+	fib_entry->type =3D MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP;
+
+	err =3D mlxsw_sp_fib_entry_update(mlxsw_sp, fib_entry);
+	if (err)
+		goto err_fib_entry_update;
+
+	return 0;
+
+err_fib_entry_update:
+	fib_entry->type =3D MLXSW_SP_FIB_ENTRY_TYPE_TRAP;
+	mlxsw_sp_fib_entry_update(mlxsw_sp, fib_entry);
+	return err;
+}
+
+void mlxsw_sp_router_nve_demote_decap(struct mlxsw_sp *mlxsw_sp, u32 ul_tb=
_id,
+				      enum mlxsw_sp_l3proto ul_proto,
+				      const union mlxsw_sp_l3addr *ul_sip)
+{
+	enum mlxsw_sp_fib_entry_type type =3D MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP;
+	struct mlxsw_sp_fib_entry *fib_entry;
+
+	fib_entry =3D mlxsw_sp_router_ip2me_fib_entry_find(mlxsw_sp, ul_tb_id,
+							 ul_proto, ul_sip,
+							 type);
+	if (!fib_entry)
+		return;
+
+	fib_entry->type =3D MLXSW_SP_FIB_ENTRY_TYPE_TRAP;
+	mlxsw_sp_fib_entry_update(mlxsw_sp, fib_entry);
+}
+
 struct mlxsw_sp_neigh_key {
 	struct neighbour *n;
 };
@@ -3815,6 +3912,7 @@ mlxsw_sp_fib_entry_should_offload(const struct mlxsw_=
sp_fib_entry *fib_entry)
 	case MLXSW_SP_FIB_ENTRY_TYPE_LOCAL:
 		return !!nh_group->nh_rif;
 	case MLXSW_SP_FIB_ENTRY_TYPE_IPIP_DECAP:
+	case MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP:
 		return true;
 	default:
 		return false;
@@ -3848,7 +3946,8 @@ mlxsw_sp_fib4_entry_offload_set(struct mlxsw_sp_fib_e=
ntry *fib_entry)
 	int i;
=20
 	if (fib_entry->type =3D=3D MLXSW_SP_FIB_ENTRY_TYPE_LOCAL ||
-	    fib_entry->type =3D=3D MLXSW_SP_FIB_ENTRY_TYPE_IPIP_DECAP) {
+	    fib_entry->type =3D=3D MLXSW_SP_FIB_ENTRY_TYPE_IPIP_DECAP ||
+	    fib_entry->type =3D=3D MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP) {
 		nh_grp->nexthops->key.fib_nh->nh_flags |=3D RTNH_F_OFFLOAD;
 		return;
 	}
@@ -4072,6 +4171,18 @@ mlxsw_sp_fib_entry_op_ipip_decap(struct mlxsw_sp *ml=
xsw_sp,
 				      fib_entry->decap.tunnel_index);
 }
=20
+static int mlxsw_sp_fib_entry_op_nve_decap(struct mlxsw_sp *mlxsw_sp,
+					   struct mlxsw_sp_fib_entry *fib_entry,
+					   enum mlxsw_reg_ralue_op op)
+{
+	char ralue_pl[MLXSW_REG_RALUE_LEN];
+
+	mlxsw_sp_fib_entry_ralue_pack(ralue_pl, fib_entry, op);
+	mlxsw_reg_ralue_act_ip2me_tun_pack(ralue_pl,
+					   fib_entry->decap.tunnel_index);
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(ralue), ralue_pl);
+}
+
 static int __mlxsw_sp_fib_entry_op(struct mlxsw_sp *mlxsw_sp,
 				   struct mlxsw_sp_fib_entry *fib_entry,
 				   enum mlxsw_reg_ralue_op op)
@@ -4086,6 +4197,8 @@ static int __mlxsw_sp_fib_entry_op(struct mlxsw_sp *m=
lxsw_sp,
 	case MLXSW_SP_FIB_ENTRY_TYPE_IPIP_DECAP:
 		return mlxsw_sp_fib_entry_op_ipip_decap(mlxsw_sp,
 							fib_entry, op);
+	case MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP:
+		return mlxsw_sp_fib_entry_op_nve_decap(mlxsw_sp, fib_entry, op);
 	}
 	return -EINVAL;
 }
--=20
2.17.2

