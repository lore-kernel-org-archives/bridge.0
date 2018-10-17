Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=g9U/5ZfOe8KYUnIBvDCF+/BXcUbZP9vuwhQhOB4bErI=;
	b=wrzsySF4GtEOZJ1zG8WjLNRGAhZyExpLCQCeHLTggDaEqQ9NAPYr2h7V4NlTnCaUAEQZyAAQ8joWp8v0YyIaGXHaZMD+h+zIciYyN4UtQijkmZHJkq7RBT4QKfOtQyeDeBaXGnLnIeZKqdlSdaArXq0zSaqh2/xCNoHfLVUYpdc=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:19 +0000
Message-ID: <20181017085215.26607-11-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 10/18] mlxsw: spectrum_router:
 Configure matching local routes for NVE decap
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

When a local route that matches the source IP of an offloaded NVE tunnel
is notified, the driver needs to program it to perform NVE decapsulation
instead of merely trapping packets to the CPU.

This patch complements "mlxsw: spectrum_router: Enable local routes
promotion to perform NVE decap" where existing local routes were
promoted to perform NVE decapsulation.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/driver=
s/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 31b5491d6737..9e9bb57134f2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -4247,6 +4247,7 @@ mlxsw_sp_fib4_entry_type_set(struct mlxsw_sp *mlxsw_s=
p,
 			     struct mlxsw_sp_fib_entry *fib_entry)
 {
 	union mlxsw_sp_l3addr dip =3D { .addr4 =3D htonl(fen_info->dst) };
+	u32 tb_id =3D mlxsw_sp_fix_tb_id(fen_info->tb_id);
 	struct net_device *dev =3D fen_info->fi->fib_dev;
 	struct mlxsw_sp_ipip_entry *ipip_entry;
 	struct fib_info *fi =3D fen_info->fi;
@@ -4261,6 +4262,15 @@ mlxsw_sp_fib4_entry_type_set(struct mlxsw_sp *mlxsw_=
sp,
 							     fib_entry,
 							     ipip_entry);
 		}
+		if (mlxsw_sp_nve_ipv4_route_is_decap(mlxsw_sp, tb_id,
+						     dip.addr4)) {
+			u32 t_index;
+
+			t_index =3D mlxsw_sp_nve_decap_tunnel_index_get(mlxsw_sp);
+			fib_entry->decap.tunnel_index =3D t_index;
+			fib_entry->type =3D MLXSW_SP_FIB_ENTRY_TYPE_NVE_DECAP;
+			return 0;
+		}
 		/* fall through */
 	case RTN_BROADCAST:
 		fib_entry->type =3D MLXSW_SP_FIB_ENTRY_TYPE_TRAP;
--=20
2.17.2

