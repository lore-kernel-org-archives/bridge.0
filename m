Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=oavOac0Zvzw93Oq7HWnapjkPCLt028ZKZjJ2yXyOIK4=;
	b=IGHvjwiityNIqEIfHHh2kysJS27iN71S/nu3PcLD6xL8HaSPnECNhGAIf1YRzqrFxQIdvjfzjnsMOF1dqiTilniFqFSi9l0n2aQ9mVFsuiQaz1dvuObR6FQ1UIFnYclO5dbnhlAg60W/Gw9HTyJUjiQIKve/DKbjDzL9l2kqdgQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 26 Apr 2018 12:06:32 +0300
Message-Id: <20180426090637.25262-2-idosch@mellanox.com>
In-Reply-To: <20180426090637.25262-1-idosch@mellanox.com>
References: <20180426090637.25262-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 1/6] net: bridge: Publish bridge accessor
	functions
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

To allow querying FDB and vlan settings of a bridge, publish several
existing functions and add some new ones.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 include/linux/if_bridge.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_fdb.c       | 25 +++++++++++++++++++++
 net/bridge/br_private.h   | 17 +++++++++------
 net/bridge/br_vlan.c      | 32 +++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 02639ebea2f0..2020f61505b9 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -93,11 +93,66 @@ static inline bool br_multicast_router(const struct net_device *dev)
 
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
 bool br_vlan_enabled(const struct net_device *dev);
+
+struct net_bridge_vlan_group *
+br_vlan_group_rtnl(const struct net_device *br_dev);
+
+struct net_bridge_vlan_group *
+br_port_vlan_group_rtnl(const struct net_device *dev);
+
+u16 br_vlan_group_pvid(const struct net_bridge_vlan_group *vg);
+
+struct net_bridge_vlan *br_vlan_find(struct net_bridge_vlan_group *vg, u16 vid);
+
+u16 br_vlan_flags(const struct net_bridge_vlan *v);
+
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
 	return false;
 }
+
+static inline struct net_bridge_vlan_group *
+br_vlan_group_rtnl(const struct net_device *br_dev)
+{
+	return NULL;
+}
+
+static inline struct net_bridge_vlan_group *
+br_port_vlan_group_rtnl(const struct net_device *dev)
+{
+	return NULL;
+}
+
+static inline u16 br_vlan_group_pvid(const struct net_bridge_vlan_group *vg)
+{
+	return 0;
+}
+
+static inline struct net_bridge_vlan *
+br_vlan_find(struct net_bridge_vlan_group *vg, u16 vid)
+{
+	return NULL;
+}
+
+static inline u16 br_vlan_flags(const struct net_bridge_vlan *v)
+{
+	return 0;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_BRIDGE)
+struct net_device *br_fdb_find_port_hold(const struct net_device *br_dev,
+					 const unsigned char *addr,
+					 __u16 vid);
+#else
+static inline struct net_device *
+br_fdb_find_port_hold(const struct net_device *br_dev,
+		      const unsigned char *addr,
+		      __u16 vid)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index d9e69e4514be..cbdcf0e95224 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -121,6 +121,31 @@ static struct net_bridge_fdb_entry *br_fdb_find(struct net_bridge *br,
 	return fdb;
 }
 
+struct net_device *br_fdb_find_port_hold(const struct net_device *br_dev,
+					 const unsigned char *addr,
+					 __u16 vid)
+{
+	struct net_bridge_fdb_entry *f;
+	struct net_device *dev = NULL;
+	struct net_bridge *br;
+
+	if (!netif_is_bridge_master(br_dev))
+		return NULL;
+
+	br = netdev_priv(br_dev);
+
+	spin_lock_bh(&br->hash_lock);
+	f = br_fdb_find(br, addr, vid);
+	if (f && f->dst) {
+		dev = f->dst->dev;
+		dev_hold(dev);
+	}
+	spin_unlock_bh(&br->hash_lock);
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(br_fdb_find_port_hold);
+
 struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 					     const unsigned char *addr,
 					     __u16 vid)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a7cb3ece5031..3c929d587171 100644
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
@@ -955,12 +966,6 @@ static inline void nbp_vlan_flush(struct net_bridge_port *port)
 {
 }
 
-static inline struct net_bridge_vlan *br_vlan_find(struct net_bridge_vlan_group *vg,
-						   u16 vid)
-{
-	return NULL;
-}
-
 static inline int nbp_vlan_init(struct net_bridge_port *port)
 {
 	return 0;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9896f4975353..1c118c190653 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -671,6 +671,7 @@ struct net_bridge_vlan *br_vlan_find(struct net_bridge_vlan_group *vg, u16 vid)
 
 	return br_vlan_lookup(&vg->vlan_hash, vid);
 }
+EXPORT_SYMBOL_GPL(br_vlan_find);
 
 /* Must be protected by RTNL. */
 static void recalculate_group_addr(struct net_bridge *br)
@@ -1149,3 +1150,34 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
 		stats->tx_packets += txpackets;
 	}
 }
+
+struct net_bridge_vlan_group *
+br_vlan_group_rtnl(const struct net_device *br_dev)
+{
+	if (netif_is_bridge_master(br_dev))
+		return br_vlan_group(netdev_priv(br_dev));
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(br_vlan_group_rtnl);
+
+struct net_bridge_vlan_group *
+br_port_vlan_group_rtnl(const struct net_device *dev)
+{
+	struct net_bridge_port *p = br_port_get_check_rtnl(dev);
+
+	return p ? nbp_vlan_group(p) : NULL;
+}
+EXPORT_SYMBOL_GPL(br_port_vlan_group_rtnl);
+
+u16 br_vlan_group_pvid(const struct net_bridge_vlan_group *vg)
+{
+	return br_get_pvid(vg);
+}
+EXPORT_SYMBOL_GPL(br_vlan_group_pvid);
+
+u16 br_vlan_flags(const struct net_bridge_vlan *v)
+{
+	return v->flags;
+}
+EXPORT_SYMBOL_GPL(br_vlan_flags);
-- 
2.14.3

