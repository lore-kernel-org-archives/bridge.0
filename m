Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=QW8JcZ/TMANYKU0mM+jgd96HI5ojM+/g32zST3rPVL4=;
	b=syy7jg9GM6fd4oTgxnZPA2NGAcRLF8DnLR2RS+mHqvy0ETielG5GbkSj3a7dDS01rg
	oQIQ9h0/qJSAghCRic1gIcSGjBLjQVEe5rOEPwYnNVYXWwOk5odDXIxffd2jwQJNIDl0
	NS81UfJmQUaDzaJjeIiIMaLYbm+z47tHQuUIP6Q/BHtAiowcwV9B0/8L7gCrhA6JLJec
	Grcx6T0CaTboOsULHVy7L9rlghp0HQF/OVpdAbBUJqsObTNUjRo1sKkFpCH+HuXKZm64
	If5lrl+wB8tF/kBd9TsjC+9W8oiL7qkRPxFnPDEXNcZ3XUrWXm4/lDYui0dMD4QSk3i4
	+mdw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 20:55:56 -0800
Message-Id: <20190216045556.3514-10-f.fainelli@gmail.com>
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 9/9] net: Remove switchdev_ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

Now that we have converted all possible callers to using a switchdev
notifier for attributes we do not have a need for implementing
switchdev_ops anymore, and this can be removed from all drivers the
net_device structure.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 ------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  2 --
 .../mellanox/mlxsw/spectrum_switchdev.c        | 13 -------------
 drivers/net/ethernet/mscc/ocelot.c             |  5 -----
 drivers/net/ethernet/rocker/rocker_main.c      |  6 ------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c        |  6 ------
 include/linux/netdevice.h                      |  3 ---
 include/net/switchdev.h                        | 18 ------------------
 net/dsa/slave.c                                |  6 ------
 9 files changed, 71 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 7c9745cecbbd..619965abab43 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3220,7 +3220,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 	}
 	mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
 
-	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
 	mlxsw_sp->ports[local_port] = mlxsw_sp_port;
 	err = register_netdev(dev);
 	if (err) {
@@ -3237,7 +3236,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 
 err_register_netdev:
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
 err_port_vlan_create:
 err_port_pvid_set:
@@ -3280,7 +3278,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u8 local_port)
 	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
 	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
@@ -4001,12 +3998,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_span_init;
 	}
 
-	err = mlxsw_sp_switchdev_init(mlxsw_sp);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
-		goto err_switchdev_init;
-	}
-
 	err = mlxsw_sp_counter_pool_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to init counter pool\n");
@@ -4077,8 +4068,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 err_counter_pool_init:
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
-err_switchdev_init:
 	mlxsw_sp_span_fini(mlxsw_sp);
 err_span_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
@@ -4141,7 +4130,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
 	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index ceebc91f4f1d..82e3e6dc81a1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -375,8 +375,6 @@ u32 mlxsw_sp_bytes_cells(const struct mlxsw_sp *mlxsw_sp, u32 bytes);
 /* spectrum_switchdev.c */
 int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 			bool adding);
 void
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c6d7bb70e8f2..fafd582c2fdc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1957,11 +1957,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
-static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
-	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
-};
-
 static int
 mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 				struct mlxsw_sp_bridge_port *bridge_port,
@@ -3576,11 +3571,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp)
 	kfree(mlxsw_sp->bridge);
 }
 
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-	mlxsw_sp_port->dev->switchdev_ops = &mlxsw_sp_port_switchdev_ops;
-}
-
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-}
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 850a49033a30..21c73a0355d4 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1324,10 +1324,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
-static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_set	= ocelot_port_attr_set,
-};
-
 static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
 				   struct net_device *bridge)
 {
@@ -1654,7 +1650,6 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 
 	dev->netdev_ops = &ocelot_port_netdev_ops;
 	dev->ethtool_ops = &ocelot_ethtool_ops;
-	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 591008c8fa74..16f045b06c55 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2147,11 +2147,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
-	.switchdev_port_attr_set	= rocker_port_attr_set,
-};
-
 struct rocker_fib_event_work {
 	struct work_struct work;
 	union {
@@ -2605,7 +2600,6 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	rocker_port_dev_addr_init(rocker_port);
 	dev->netdev_ops = &rocker_port_netdev_ops;
 	dev->ethtool_ops = &rocker_port_ethtool_ops;
-	dev->switchdev_ops = &rocker_port_switchdev_ops;
 	netif_tx_napi_add(dev, &rocker_port->napi_tx, rocker_port_poll_tx,
 			  NAPI_POLL_WEIGHT);
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index bc9e7de07200..44831990239c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -932,11 +932,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 	return err;
 }
 
-static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_get	= swdev_port_attr_get,
-	.switchdev_port_attr_set	= swdev_port_attr_set,
-};
-
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1466,7 +1461,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
 	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
-	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1fb733f38a47..a747456b9d23 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1836,9 +1836,6 @@ struct net_device {
 #endif
 	const struct net_device_ops *netdev_ops;
 	const struct ethtool_ops *ethtool_ops;
-#ifdef CONFIG_NET_SWITCHDEV
-	const struct switchdev_ops *switchdev_ops;
-#endif
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	const struct l3mdev_ops	*l3mdev_ops;
 #endif
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index b8becabbef38..e9aa920aba57 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -113,21 +113,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
-/**
- * struct switchdev_ops - switchdev operations
- *
- * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
- *
- * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
- */
-struct switchdev_ops {
-	int	(*switchdev_port_attr_get)(struct net_device *dev,
-					   struct switchdev_attr *attr);
-	int	(*switchdev_port_attr_set)(struct net_device *dev,
-					   const struct switchdev_attr *attr,
-					   struct switchdev_trans *trans);
-};
-
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -229,7 +214,6 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 			int (*del_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj));
 
-#define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -322,8 +306,6 @@ switchdev_handle_port_obj_del(struct net_device *dev,
 	return 0;
 }
 
-#define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
-
 #endif
 
 #endif /* _LINUX_SWITCHDEV_H_ */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2a14a38f5f93..236b6a72dba3 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1057,11 +1057,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_port_parent_id	= dsa_slave_get_port_parent_id,
 };
 
-static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_get	= dsa_slave_port_attr_get,
-	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
-};
-
 static struct device_type dsa_type = {
 	.name	= "dsa",
 };
@@ -1321,7 +1316,6 @@ int dsa_slave_create(struct dsa_port *port)
 	eth_hw_addr_inherit(slave_dev, master);
 	slave_dev->priv_flags |= IFF_NO_QUEUE;
 	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
-	slave_dev->switchdev_ops = &dsa_slave_switchdev_ops;
 	slave_dev->min_mtu = 0;
 	slave_dev->max_mtu = ETH_MAX_MTU;
 	SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
-- 
2.19.1

