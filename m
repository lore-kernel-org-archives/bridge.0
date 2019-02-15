Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/YRkK8iY5c2UL+9cmABu8/WhNQuT1lvaF8VvP4wC8eM=;
	b=W3ZwsPb0opAWKR/mm9GSm92WrzvmWuYsx/uHnGFuO7Wz7n1d1sAxNiL6O+GA9VciCb
	u1L30qYgYG8dX680e/s2mK4CDT4ZPz0UxGQtvNQNRodp2FDvBi++Uzui5nYUeTO8DRsy
	997vqIQKeqHGENQpzsRWyiqi3lrFZcFkX0RnjzlVHdqs46GVL8PWOx9vviUdW6agt26B
	JOXHuL+oxwOGV4yT3/8nRAUZ1NuRwnrsCKeyhIwJrhUG8di+hLsBbdkkPbD98TxDFWzW
	euUVIgCyT+j51X7DJlLt4vAYLfoaqZt7Uyrc4AtAoEd/4OlmsPmuCq6AUfmIANhiSFVu
	Ioog==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 14:53:12 -0800
Message-Id: <20190215225313.32303-9-f.fainelli@gmail.com>
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 8/9] net: Remove
	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
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

Now that we have converted the bridge code and the drivers to check for
bridge port(s) flags at the time we try to set them, there is no need
for a get() -> set() sequence anymore and
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt             |  6 ++----
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 11 +----------
 drivers/net/ethernet/rocker/rocker_main.c          | 14 +-------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 10 +---------
 include/net/switchdev.h                            |  2 --
 net/dsa/slave.c                                    | 10 +---------
 6 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index ea90243340a9..b764568deabf 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -232,10 +232,8 @@ Learning_sync attribute enables syncing of the learned/forgotten FDB entry to
 the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
-To support learning and learning_sync port attributes, the driver implements
-switchdev op switchdev_port_attr_get/set for
-SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the attributes
-to the hardware defaults.
+To support learning, the driver implements switchdev op
+switchdev_port_attr_get/set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 8cdc0fe17a2e..2311ef8554d9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -434,16 +434,7 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 static int mlxsw_sp_port_attr_get(struct net_device *dev,
 				  struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
-					       BR_MCAST_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 2102e449c037..107fcbec3234 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2074,19 +2074,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 static int rocker_port_attr_get(struct net_device *dev,
 				struct switchdev_attr *attr)
 {
-	const struct rocker_port *rocker_port = netdev_priv(dev);
-	int err = 0;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
-								      &attr->u.brport_flags_support);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return err;
+	return -EOPNOTSUPP;
 }
 
 static int rocker_port_attr_set(struct net_device *dev,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 640fd6834be1..e71bc7ed363e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -643,15 +643,7 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 static int swdev_port_attr_get(struct net_device *netdev,
 			       struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int port_attr_stp_state_set(struct net_device *netdev,
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index de72b0a3867f..0f352019ef99 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -45,7 +45,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
 	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
@@ -63,7 +62,6 @@ struct switchdev_attr {
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
-		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index d3370e840956..06aa7376d968 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -390,15 +390,7 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 static int dsa_slave_port_attr_get(struct net_device *dev,
 				   struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = 0;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
-- 
2.17.1

