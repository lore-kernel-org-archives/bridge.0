Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=6jO9lKWvNXYqdJyM5lCPEQQkRdWVnlQlbjfM8XXf2v8=;
 b=qPnr7n8CwJXjEsTLB4rmYkKB8NRheLcxrmx5roLwS/+3SaNuQnp1P8uP+pPTYuzkz7
 OFaVyG16nqOObJ8KcxNZ3dp+RUUTG9BWrs+lc5w5V+72xzFB/2FggGas8E34uLPN9ahW
 kYegr964IiRipmBOt/wWmJHWi2xS0UaoLqYHAGzpi230EE25kuyK7KLouF15fmzfv4Mi
 VlBbxEYrj+s4qnB+IpbKVzh4Upf3QeppIQ6xhhBy31Yqc1qPp0u21s9oHYVZCi1v8AZ0
 rVvZ2gp01kwbTuVzSrlPlJXy0UTgtWqH07fq0tmYxV3P/3dMr/dNg5V5U/Ps4wyqgozO
 rZOQ==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Mon, 26 Apr 2021 19:04:08 +0200
Message-Id: <20210426170411.1789186-7-tobias@waldekranz.com>
In-Reply-To: <20210426170411.1789186-1-tobias@waldekranz.com>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, olteanv@gmail.com, vivien.didelot@gmail.com

Allow DSA drivers to support forward offloading from a bridge by:

- Passing calls to .ndo_dfwd_{add,del}_station to the drivers.

- Recording the subordinate device of offloaded skbs in the control
  buffer so that the tagger can take the appropriate action.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/dsa.h |  7 +++++++
 net/dsa/slave.c   | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 1f9ba9889034..77d4df819299 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -119,6 +119,7 @@ struct dsa_netdevice_ops {
 
 struct dsa_skb_cb {
 	struct sk_buff *clone;
+	struct net_device *sb_dev;
 };
 
 struct __dsa_skb_cb {
@@ -828,6 +829,12 @@ struct dsa_switch_ops {
 					  const struct switchdev_obj_ring_role_mrp *mrp);
 	int	(*port_mrp_del_ring_role)(struct dsa_switch *ds, int port,
 					  const struct switchdev_obj_ring_role_mrp *mrp);
+
+	/* L2 forward offloading */
+	void *	(*dfwd_add_station)(struct dsa_switch *ds, int port,
+				    struct net_device *sb_dev);
+	void	(*dfwd_del_station)(struct dsa_switch *ds, int port,
+				    struct net_device *sb_dev);
 };
 
 #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 77b33bd161b8..3689ffa2dbb8 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -657,6 +657,13 @@ static netdev_tx_t dsa_slave_xmit(struct sk_buff *skb, struct net_device *dev)
 	return dsa_enqueue_skb(nskb, dev);
 }
 
+static u16 dsa_slave_select_queue(struct net_device *dev, struct sk_buff *skb,
+				  struct net_device *sb_dev)
+{
+	DSA_SKB_CB(skb)->sb_dev = sb_dev;
+	return netdev_pick_tx(dev, skb, sb_dev);
+}
+
 /* ethtool operations *******************************************************/
 
 static void dsa_slave_get_drvinfo(struct net_device *dev,
@@ -1708,10 +1715,33 @@ static int dsa_slave_fill_forward_path(struct net_device_path_ctx *ctx,
 	return 0;
 }
 
+static void *dsa_slave_dfwd_add_station(struct net_device *dev,
+					struct net_device *sb_dev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->dfwd_add_station)
+		return ds->ops->dfwd_add_station(ds, dp->index, sb_dev);
+
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void dsa_slave_dfwd_del_station(struct net_device *dev,
+				       void *sb_dev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->dfwd_del_station)
+		ds->ops->dfwd_del_station(ds, dp->index, sb_dev);
+}
+
 static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_open	 	= dsa_slave_open,
 	.ndo_stop		= dsa_slave_close,
 	.ndo_start_xmit		= dsa_slave_xmit,
+	.ndo_select_queue	= dsa_slave_select_queue,
 	.ndo_change_rx_flags	= dsa_slave_change_rx_flags,
 	.ndo_set_rx_mode	= dsa_slave_set_rx_mode,
 	.ndo_set_mac_address	= dsa_slave_set_mac_address,
@@ -1734,6 +1764,8 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_devlink_port	= dsa_slave_get_devlink_port,
 	.ndo_change_mtu		= dsa_slave_change_mtu,
 	.ndo_fill_forward_path	= dsa_slave_fill_forward_path,
+	.ndo_dfwd_add_station	= dsa_slave_dfwd_add_station,
+	.ndo_dfwd_del_station	= dsa_slave_dfwd_del_station,
 };
 
 static struct device_type dsa_type = {
@@ -1914,8 +1946,8 @@ int dsa_slave_create(struct dsa_port *port)
 	slave_dev->features = master->vlan_features | NETIF_F_HW_TC;
 	if (ds->ops->port_vlan_add && ds->ops->port_vlan_del)
 		slave_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
-	slave_dev->hw_features |= NETIF_F_HW_TC;
-	slave_dev->features |= NETIF_F_LLTX;
+	slave_dev->hw_features |= NETIF_F_HW_TC | NETIF_F_HW_L2FW_DOFFLOAD;
+	slave_dev->features |= NETIF_F_LLTX | NETIF_F_HW_L2FW_DOFFLOAD;
 	slave_dev->ethtool_ops = &dsa_slave_ethtool_ops;
 	if (!is_zero_ether_addr(port->mac))
 		ether_addr_copy(slave_dev->dev_addr, port->mac);
-- 
2.25.1

