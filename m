Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=JxyV5djIl/VRQnKUN8DXhmuwa6Oozfa8/E9OhzYbBjk=;
	b=tqbYZbePSD8pqc5mZG3sTHGEzI3c7F8B0H4hF4/pswZTlAlF3tnTsflk7kVGri5tSh
	yqgQfWI6MB3UWfuu7oIGtK6B+elFCBc1e/93hoyrkWVsnA/1yg+YxKprmXkfwtrbjBk1
	Kpb9KnoHQpcdKq4meRFwFhmOlnC6hskmdTXzMdKaRpSyGkdUIdcAj0VyZDg20O0JWcos
	QLEvZl64PEVqTt1MP50QUBiQj4OxAnnr68gNVfIY6lriPW6SHZbdq+fG+3cGU4/7a+dL
	LyCPlRkPsJFTynPlQXLD6Dk3l9kEVQUINIyi1irPERRJK+KpMRKlyCPQJtTCgGnRd/lv
	gnUg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:20 -0800
Message-Id: <20190221005826.26317-3-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 2/8] mlxsw: spectrum: Handle
	PORT_PRE_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
check for the bridge flags being set through switchdev_port_attr_set()
when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
used.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1f492b7dbea8..9a8798f74d2b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -595,6 +595,17 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return err;
 }
 
+static int mlxsw_sp_port_attr_br_pre_flags_set(struct mlxsw_sp_port
+					       *mlxsw_sp_port,
+					       struct switchdev_trans *trans,
+					       unsigned long brport_flags)
+{
+	if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct switchdev_trans *trans,
 					   struct net_device *orig_dev,
@@ -841,6 +852,11 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 						       attr->orig_dev,
 						       attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = mlxsw_sp_port_attr_br_pre_flags_set(mlxsw_sp_port,
+							  trans,
+							  attr->u.brport_flags);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port, trans,
 						      attr->orig_dev,
-- 
2.17.1

