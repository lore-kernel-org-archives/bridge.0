Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6QC5/F+Bhjh0KmzSrlZ+HZJwrQWKGEwgIVPrdI/j5Fk=;
	b=q+iYOTUFVVNCE/YjQlv9P+/4efhkqAwqst44r8uQC6fs9tMVi6OZD7R39iLBP3FEx5
	3f0mlCUyOE1gyTasSbQXTdACuXOetL1uOG7n6V8ebZjJK1qg4QFx7qxXYRTSj2FUEgw1
	L6BnUMvvIhJ5V1tT/5GYrzdv5YRrAqzk92PLSCTpiz+yz67QpKtTVHixfUZ+mho+9q6E
	VjH0BwCAXbQ66Om3+XfoHuogSEQ4OzQngejlF+bGCnPxoLtX5cu3LlWVph89KLuTHnRS
	Zk85UqaTP7IWjWMQA0fcXUyLkeVXEZrsgOaus5Zb9uSvCYOuFtN0t684sa8V/kglcoLa
	9+DQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:26 -0800
Message-Id: <20190221005826.26317-9-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 8/8] net: Get rid of
	switchdev_port_attr_get()
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

With the bridge no longer calling switchdev_port_attr_get() to obtain
the supported bridge port flags from a driver but instead trying to set
the bridge port flags directly and relying on driver to reject
unsupported configurations, we can effectively get rid of
switchdev_port_attr_get() entirely since this was the only place where
it was called.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt                   | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 7 -------
 drivers/net/ethernet/rocker/rocker_main.c                | 7 -------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c                  | 7 -------
 include/net/switchdev.h                                  | 8 --------
 net/dsa/slave.c                                          | 7 -------
 6 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index 79c8b0f16aee..413abbae952f 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -233,7 +233,7 @@ the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
 To support learning, the driver implements switchdev op
-switchdev_port_attr_get/set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
+switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_{PRE}_BRIDGE_FLAGS.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index bbb5a406232e..766f5b5f1cf5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,12 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static int mlxsw_sp_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int
 mlxsw_sp_port_bridge_vlan_stp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct mlxsw_sp_bridge_vlan *bridge_vlan,
@@ -1945,7 +1939,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
 	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 6b8273e2057d..8200fbf91306 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2066,12 +2066,6 @@ static const struct net_device_ops rocker_port_netdev_ops = {
  * swdev interface
  ********************/
 
-static int rocker_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int rocker_port_attr_set(struct net_device *dev,
 				const struct switchdev_attr *attr,
 				struct switchdev_trans *trans)
@@ -2148,7 +2142,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
 	.switchdev_port_attr_set	= rocker_port_attr_set,
 };
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index de4dcabbc29a..018399ee8731 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -640,12 +640,6 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 	fsl_mc_free_irqs(sw_dev);
 }
 
-static int swdev_port_attr_get(struct net_device *netdev,
-			       struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int port_attr_stp_state_set(struct net_device *netdev,
 				   struct switchdev_trans *trans,
 				   u8 state)
@@ -932,7 +926,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 }
 
 static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_get	= swdev_port_attr_get,
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 0f352019ef99..45310ddf2d7e 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -179,8 +179,6 @@ switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *info)
 #ifdef CONFIG_NET_SWITCHDEV
 
 void switchdev_deferred_process(void);
-int switchdev_port_attr_get(struct net_device *dev,
-			    struct switchdev_attr *attr);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr);
 int switchdev_port_obj_add(struct net_device *dev,
@@ -225,12 +223,6 @@ static inline void switchdev_deferred_process(void)
 {
 }
 
-static inline int switchdev_port_attr_get(struct net_device *dev,
-					  struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int switchdev_port_attr_set(struct net_device *dev,
 					  const struct switchdev_attr *attr)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index db0a2651070f..a78b2bba0332 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -385,12 +385,6 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_port_attr_get(struct net_device *dev,
-				   struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
 						     struct sk_buff *skb)
 {
@@ -1057,7 +1051,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_get	= dsa_slave_port_attr_get,
 	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
 };
 
-- 
2.17.1

