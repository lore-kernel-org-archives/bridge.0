Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=iHbp08+L1KFZqaKbcOO0fzWBvEM+iGUp6BWgogXYZbg=;
	b=SsvfXejvXiSsC7MUA7RKropIFeBx6ezLCFewishEDWiV9h74hOmGzy42xG/CyjzeB0SYYSIVXRHnxPfZi4Q6b4jbnaYfDVioB/HAY1SHxvkS1w1/deFUKA90WExFLLiDAHFmZ+2bvTQH3ZFXjd15VA2W4ZXrdv+3XEl33DyocLc=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 29 Apr 2018 10:56:08 +0300
Message-Id: <20180429075613.10832-2-idosch@mellanox.com>
In-Reply-To: <20180429075613.10832-1-idosch@mellanox.com>
References: <20180429075613.10832-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 1/6] net: bridge: Publish bridge
	accessor functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

From: Petr Machata <petrm@mellanox.com>

Add a couple new functions to allow querying FDB and vlan settings of a
bridge.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 include/linux/if_bridge.h | 28 ++++++++++++++++++++++++++++
 net/bridge/br_fdb.c       | 22 ++++++++++++++++++++++
 net/bridge/br_private.h   | 11 +++++++++++
 net/bridge/br_vlan.c      | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 02639ebea2f0..585d27182425 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -93,11 +93,39 @@ static inline bool br_multicast_router(const struct net_device *dev)
 
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
 bool br_vlan_enabled(const struct net_device *dev);
+int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid);
+int br_vlan_get_info(const struct net_device *dev, u16 vid,
+		     struct bridge_vlan_info *p_vinfo);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
 	return false;
 }
+
+static inline int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid)
+{
+	return -1;
+}
+
+static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
+				   struct bridge_vlan_info *p_vinfo)
+{
+	return -1;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_BRIDGE)
+struct net_device *br_fdb_find_port(const struct net_device *br_dev,
+				    const unsigned char *addr,
+				    __u16 vid);
+#else
+static inline struct net_device *
+br_fdb_find_port(const struct net_device *br_dev,
+		 const unsigned char *addr,
+		 __u16 vid)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index d9e69e4514be..a1c409cacec4 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -121,6 +121,28 @@ static struct net_bridge_fdb_entry *br_fdb_find(struct net_bridge *br,
 	return fdb;
 }
 
+struct net_device *br_fdb_find_port(const struct net_device *br_dev,
+				    const unsigned char *addr,
+				    __u16 vid)
+{
+	struct net_bridge_fdb_entry *f;
+	struct net_device *dev = NULL;
+	struct net_bridge *br;
+
+	ASSERT_RTNL();
+
+	if (!netif_is_bridge_master(br_dev))
+		return NULL;
+
+	br = netdev_priv(br_dev);
+	f = br_fdb_find(br, addr, vid);
+	if (f && f->dst)
+		dev = f->dst->dev;
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(br_fdb_find_port);
+
 struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 					     const unsigned char *addr,
 					     __u16 vid)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a7cb3ece5031..1a5093115534 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -594,11 +594,22 @@ static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
 	return rcu_dereference(dev->rx_handler) == br_handle_frame;
 }
 
+static inline bool br_rx_handler_check_rtnl(const struct net_device *dev)
+{
+	return rcu_dereference_rtnl(dev->rx_handler) == br_handle_frame;
+}
+
 static inline struct net_bridge_port *br_port_get_check_rcu(const struct net_device *dev)
 {
 	return br_rx_handler_check_rcu(dev) ? br_port_get_rcu(dev) : NULL;
 }
 
+static inline struct net_bridge_port *
+br_port_get_check_rtnl(const struct net_device *dev)
+{
+	return br_rx_handler_check_rtnl(dev) ? br_port_get_rtnl_rcu(dev) : NULL;
+}
+
 /* br_ioctl.c */
 int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 int br_ioctl_deviceless_stub(struct net *net, unsigned int cmd,
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9896f4975353..df37a5137c25 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1149,3 +1149,42 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
 		stats->tx_packets += txpackets;
 	}
 }
+
+int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid)
+{
+	struct net_bridge_vlan_group *vg;
+
+	ASSERT_RTNL();
+	if (netif_is_bridge_master(dev))
+		vg = br_vlan_group(netdev_priv(dev));
+	else
+		return -EINVAL;
+
+	*p_pvid = br_get_pvid(vg);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_pvid);
+
+int br_vlan_get_info(const struct net_device *dev, u16 vid,
+		     struct bridge_vlan_info *p_vinfo)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_bridge_port *p;
+
+	ASSERT_RTNL();
+	p = br_port_get_check_rtnl(dev);
+	if (p)
+		vg = nbp_vlan_group(p);
+	else
+		return -EINVAL;
+
+	v = br_vlan_find(vg, vid);
+	if (!v)
+		return -ENOENT;
+
+	p_vinfo->vid = vid;
+	p_vinfo->flags = v->flags;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_info);
-- 
2.14.3

