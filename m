Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4pMx6l0YYeUH1Ue/yJgSLlU7DZgaC0irwjD10yhH7wg=;
	b=GJGq7e2k7RrXokq0spfHEQHJNSbKro9begb99qrCaYmE+KJdx1/6IpGJGl9hnHPKuiK2MhUYOTZb27+mJMyFBZvAcUJrliBJP+jiNhdj7SoofDM/nWqZVd/GRjuZWTU2pmsP+v8SK4PF3xmN5JL7DKQcBPbdIdHam0QYN/ZQyKE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:06:58 +0000
Message-ID: <20181128200558.31343-2-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 1/8] net: bridge: Extend
 br_vlan_get_pvid() for bridge ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Currently, the function only works for the bridge device itself, but
subsequent patches will need to be able to query the PVID of a given
bridge port, so extend the function.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br_vlan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index b21838b51220..48f50d7ac624 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1217,9 +1217,13 @@ void br_vlan_get_stats(const struct net_bridge_vlan =
*v,
 int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid)
 {
 	struct net_bridge_vlan_group *vg;
+	struct net_bridge_port *p;
=20
 	ASSERT_RTNL();
-	if (netif_is_bridge_master(dev))
+	p =3D br_port_get_check_rtnl(dev);
+	if (p)
+		vg =3D nbp_vlan_group(p);
+	else if (netif_is_bridge_master(dev))
 		vg =3D br_vlan_group(netdev_priv(dev));
 	else
 		return -EINVAL;
--=20
2.19.1

