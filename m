Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=97jL08vpSK7nllW2QUkWLce6ED4PA+azRx4iN+y5Cq8=;
	b=VSSFbcjanh2AZArygX2xQEyxtpKK5NPazkQc/3oq8bJOXCEWbLVfTpPfqPnW/AFI2T
	sscvulK04A7/d/v90HkGjVQm4l8BnBWmGGBey1TEJLWGSOQ3EfDWIFpxRRiegYGH00Qh
	R5Qm5xvzlHc2vkYsvf6PzqoJkBC+gTVEi1gUCKZNvorK6k/4d0p2Wjhz6+v7GZgCHWjO
	XVHN5Pm+NSEhSDZFXFZAJJmoRdW9JbwhXdedMsCM/QNoJt7Qc3FzLBvksScN96XcetgN
	hE4TBj2IfPjxLXFBNMEfb4ZtL7tm6YDiEFDTAm1X71WV9lvDKxQk4b5/A/HklltMHed8
	uANg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 13 Feb 2019 14:06:38 -0800
Message-Id: <20190213220638.1552-10-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 9/9] net: Get rid of
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
 Documentation/networking/switchdev.txt                   | 5 ++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 7 -------
 drivers/net/ethernet/rocker/rocker_main.c                | 7 -------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c                  | 7 -------
 include/net/switchdev.h                                  | 8 --------
 net/dsa/slave.c                                          | 7 -------
 6 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index ea90243340a9..327afe754230 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -233,9 +233,8 @@ the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
 To support learning and learning_sync port attributes, the driver implements
-switchdev op switchdev_port_attr_get/set for
-SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the attributes
-to the hardware defaults.
+switchdev op switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
+The driver should initialize the attributes to the hardware defaults.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c11cf7fa4863..5263abe6224e 100644
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
@@ -1937,7 +1931,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
 	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 8e80301eae7b..5d06c7edf696 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2054,12 +2054,6 @@ static const struct net_device_ops rocker_port_netdev_ops = {
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
@@ -2135,7 +2129,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
 	.switchdev_port_attr_set	= rocker_port_attr_set,
 };
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 5f58c7df67bb..005c12c08df4 100644
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
@@ -924,7 +918,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
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
index a176d3ba3b7a..1258a0b7a158 100644
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

