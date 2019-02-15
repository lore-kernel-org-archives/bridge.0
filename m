Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NK5Nsx4Hxviwe7e67zABRGR+HMqbd3Rniv+pDjc5hfE=;
	b=ShHuGei536BzKpRL+QQ0YUEhre4vFe3Vatvj5ClAjz4aLMZm+wetaMlWn73T159YHI
	Nb/qu152uLlvU5Lb37himDs0YhpnAV+TN/s+v/PDHfDfTmzlUwhLm0fwvZKmZqT+hSHk
	h0tC/O1Q4hslqZBb05HDOyCjlw0DOpzCVoazVhj9f+sGd+pT50bNfGh65rnh02ZZnSyM
	PjtW+bzxeBCtWeE5rMxTwz6YyVJSznQILu66MFwf6nyRpXoipYEhfKPqRDpS2UGjBJuh
	YzmV4V7Fk8aVzMbIvXzrcpNI38cWbtZmgtio0E1s+sVPfhesRW0L6rax9TSN6bSsJVyo
	IHXQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 14:53:07 -0800
Message-Id: <20190215225313.32303-4-f.fainelli@gmail.com>
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 3/9] mlxsw: spectrum: Handle
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
 .../mellanox/mlxsw/spectrum_switchdev.c       | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1f492b7dbea8..8cdc0fe17a2e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -595,10 +595,25 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return err;
 }
 
+static int mlxsw_sp_port_attr_br_pre_flags_set(struct mlxsw_sp_port
+					       *mlxsw_sp_port,
+					       struct switchdev_trans *trans,
+					       unsigned long brport_flags)
+{
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct switchdev_trans *trans,
 					   struct net_device *orig_dev,
-					   unsigned long brport_flags)
+					   unsigned long brport_flags,
+					   bool pre_set)
 {
 	struct mlxsw_sp_bridge_port *bridge_port;
 	int err;
@@ -841,6 +856,11 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
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

