Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=oUCYSkhCOy+ddysJEQ16zKbvIVoVHp4VAlqXCpVCylk=;
	b=EOgo79qQbSYLe7y43j2c7IvSHTHE8W09v2YWxSSqcti1C+QCR3D20ZWhb2WvXSwJhaReAfXyBZwZ6V2LtuA9JkDBfKzD8c6qFWAtaqHsMfjATdWQJ3RHNfKPSQvintV+cP5A4sS7zhUB+h6pPszOusnI9fDw7cBITGYrI7eNNOw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:50 +0000
Message-ID: <20181121080141.16676-15-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 14/16] mlxsw: spectrum_nve: Allow VxLAN
	learning
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

Up until now the driver returned an error when learning was enabled on a
VxLAN device enslaved to an offloaded bridge.

Previous patches added VxLAN learning support, so remove the check.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/dri=
vers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index d21c7be5b1c9..4e9cc00a88fd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -17,7 +17,8 @@
 #define MLXSW_SP_NVE_VXLAN_PARSING_DEPTH 128
 #define MLXSW_SP_NVE_DEFAULT_PARSING_DEPTH 96
=20
-#define MLXSW_SP_NVE_VXLAN_SUPPORTED_FLAGS	VXLAN_F_UDP_ZERO_CSUM_TX
+#define MLXSW_SP_NVE_VXLAN_SUPPORTED_FLAGS	(VXLAN_F_UDP_ZERO_CSUM_TX | \
+						 VXLAN_F_LEARN)
=20
 static bool mlxsw_sp1_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve=
,
 					    const struct net_device *dev,
@@ -61,11 +62,6 @@ static bool mlxsw_sp1_nve_vxlan_can_offload(const struct=
 mlxsw_sp_nve *nve,
 		return false;
 	}
=20
-	if (cfg->flags & VXLAN_F_LEARN) {
-		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Learning is not supported");
-		return false;
-	}
-
 	if (!(cfg->flags & VXLAN_F_UDP_ZERO_CSUM_TX)) {
 		NL_SET_ERR_MSG_MOD(extack, "VxLAN: UDP checksum is not supported");
 		return false;
--=20
2.19.1

