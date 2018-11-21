Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sDmwS1C2AhIvLUQvOzrGkOyupJwA175CBj6IMCNAnhI=;
	b=htrc20Acek7bZAio9IKlntwGYZmUq7Fs1zI/iSGoHCbWxoCWhgxBWWL8cXh20YmC89LDd+bwL+oAh6bJNWbmSFW3EtQufZaJhYyN4x+yY5XxNgPmX+WNe+mcjp7HWBdhuui/AQamaOLvCSEyueJubMkL+YmIeg64RW8vd6c4AvA=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:46 +0000
Message-ID: <20181121080141.16676-12-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 11/16] mlxsw: spectrum_nve: Add API to
 resolve learned IP addresses
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

FDB notifications for entries learned from an NVE tunnel contain the IP
address of the remote VTEP. In the case of IPv4 underlay, the IP address
is specified as-is. IPv6 addresses on the other hand, are specified as
handles which then need to be used to query the actual address from the
device.

Only IPv4 underlay is currently supported, so we cannot receive
notifications for IPv6 addresses and therefore an error is returned when
one tries to resolve such an address.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  3 +++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/e=
thernet/mellanox/mlxsw/spectrum.h
index 879ac65886af..973a9d2901f7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -813,6 +813,9 @@ struct mlxsw_sp_nve_params {
 extern const struct mlxsw_sp_nve_ops *mlxsw_sp1_nve_ops_arr[];
 extern const struct mlxsw_sp_nve_ops *mlxsw_sp2_nve_ops_arr[];
=20
+int mlxsw_sp_nve_learned_ip_resolve(struct mlxsw_sp *mlxsw_sp, u32 uip,
+				    enum mlxsw_sp_l3proto proto,
+				    union mlxsw_sp_l3addr *addr);
 int mlxsw_sp_nve_flood_ip_add(struct mlxsw_sp *mlxsw_sp,
 			      struct mlxsw_sp_fid *fid,
 			      enum mlxsw_sp_l3proto proto,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_nve.c
index 4498e3b3c3f0..c4d5a0865c8f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -174,6 +174,20 @@ mlxsw_sp_nve_mc_record_ops_arr[] =3D {
 	[MLXSW_SP_L3_PROTO_IPV6] =3D &mlxsw_sp_nve_mc_record_ipv6_ops,
 };
=20
+int mlxsw_sp_nve_learned_ip_resolve(struct mlxsw_sp *mlxsw_sp, u32 uip,
+				    enum mlxsw_sp_l3proto proto,
+				    union mlxsw_sp_l3addr *addr)
+{
+	switch (proto) {
+	case MLXSW_SP_L3_PROTO_IPV4:
+		addr->addr4 =3D cpu_to_be32(uip);
+		return 0;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
 static struct mlxsw_sp_nve_mc_list *
 mlxsw_sp_nve_mc_list_find(struct mlxsw_sp *mlxsw_sp,
 			  const struct mlxsw_sp_nve_mc_list_key *key)
--=20
2.19.1

