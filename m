Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HjXqsdacpNJiCLbkIDl7eQB0BYRMd6KN27az6p8IUHI=;
	b=CXfrBoAJDWAc8DTUykA4mhV99uNjfvgd0NYDdLc8IumiEj7XFEnue6N7wZZct3UDNY/XytK1xFot2NyFq5zHoGFfM//ppUgljvXyp5oRd5IlGF13wsOcJpH6pNW0nEhf0VNOut7BZeSLVcVURCGpO8Lc3HvcB0ndVvkoM/eNhJE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:35 +0000
Message-ID: <20181013171725.3261-10-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 09/18] mlxsw: spectrum_fid: Clear NVE
 configuration when destroying 802.1D FIDs
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

802.1D FIDs are used to represent VLAN-unaware bridges and currently
this is the only type of FID that supports NVE configuration.

Since the NVE tunnel device does not take a reference on the FID, it is
possible for the FID to be destroyed when it still has NVE
configuration.

Therefore, when destroying the FID make sure to disable its NVE
configuration.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/n=
et/ethernet/mellanox/mlxsw/spectrum_fid.c
index 0ba3d90d4632..a3db033d7399 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -538,6 +538,8 @@ static int mlxsw_sp_fid_8021d_configure(struct mlxsw_sp=
_fid *fid)
=20
 static void mlxsw_sp_fid_8021d_deconfigure(struct mlxsw_sp_fid *fid)
 {
+	if (fid->vni_valid)
+		mlxsw_sp_nve_fid_disable(fid->fid_family->mlxsw_sp, fid);
 	mlxsw_sp_fid_op(fid->fid_family->mlxsw_sp, fid->fid_index, 0, false);
 }
=20
--=20
2.17.2

