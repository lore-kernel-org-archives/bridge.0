Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qZ+w6NypwLrquHGLlezSrUoHQgjHNXwdwbbQGveSU5M=;
	b=mVIcX+aOP2dXPVez3n/ZZW6k16rZKOaqvLt7Rpzw1XjvbENUrmfMgfxEciVgSTuJ2M
	6RkbLtichTY8i4nT8P1FR0oMCwoW+8bpBc2ms+ieIwIhqBJ+BNYU2Y9qMJaHb9JOCJJd
	haFfArtACWjVioO+fQRgoJ3pxa3WxkCzOkhvdwCf+yp9Q5tDFlHP0IiVxi7i7VxMEmiS
	4j1iGV4sq4kYvjEF31gUTbWPvZoutFzCYG/gktqDDA6CyEBSEb8PQcqmJKzGL5IYoJhc
	fg+qYJz0n9ORtM901zbN9LMv92A7Vgy13gpN3qNoiYQ1pnx98ETWCC96VBKTLqELtaZ6
	rbSQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 13 Feb 2019 14:06:32 -0800
Message-Id: <20190213220638.1552-4-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 3/9] mlxsw: spectrum: Check bridge flags
	during prepare phase
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
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1f492b7dbea8..7616eab50035 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -598,13 +598,17 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct switchdev_trans *trans,
 					   struct net_device *orig_dev,
-					   unsigned long brport_flags)
+					   unsigned long brport_flags,
+					   bool pre_set)
 {
 	struct mlxsw_sp_bridge_port *bridge_port;
 	int err;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans) && pre_set) {
+		if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	bridge_port = mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->bridge,
 						orig_dev);
@@ -833,6 +837,7 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 				  struct switchdev_trans *trans)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	bool pre_set = false;
 	int err;
 
 	switch (attr->id) {
@@ -841,10 +846,13 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 						       attr->orig_dev,
 						       attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true;	/* fall through */
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port, trans,
 						      attr->orig_dev,
-						      attr->u.brport_flags);
+						      attr->u.brport_flags,
+						      pre_set);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		err = mlxsw_sp_port_attr_br_ageing_set(mlxsw_sp_port, trans,
-- 
2.17.1

