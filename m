Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 356A660B60
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB08460B30
From: "Hans J. Schultz" <netdev@kapio-technology.com>
Date: Sat, 18 Mar 2023 15:10:06 +0100
Message-Id: <20230318141010.513424-3-netdev@kapio-technology.com>
In-Reply-To: <20230318141010.513424-1-netdev@kapio-technology.com>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 2/6] net: dsa: propagate flags down
	towards drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Hans J. Schultz" <netdev@kapio-technology.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>

Dynamic FDB flag needs to be propagated through the DSA layer to be
added to drivers.
Use a u16 for fdb flags for future use, so that other flags can also be
sent the same way without having to change function interfaces. If we
have unsupported flags in the new flags, we do not do unnecessary work
and so we return at once. This ensures that the drivers are not called
with unsupported flags, so that the drivers do not need to check the
new flags. As the dynamic flag is a legacy flag, all drivers support it
by default at least as they have done hitherto.
Ensure that the dynamic FDB flag is only set when added from userspace,
as the feature it supports is to be handled from userspace.

Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
---
 include/net/dsa.h |  5 +++++
 net/dsa/dsa.c     |  6 ++++++
 net/dsa/port.c    | 28 ++++++++++++++++------------
 net/dsa/port.h    |  8 ++++----
 net/dsa/slave.c   | 20 ++++++++++++++++----
 net/dsa/switch.c  | 18 ++++++++++++------
 net/dsa/switch.h  |  1 +
 7 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index a15f17a38eca..9e98c4fe1520 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -437,6 +437,9 @@ struct dsa_switch {
 	 */
 	u32			fdb_isolation:1;
 
+	/* Supported fdb flags going from the bridge to drivers */
+	u16			supported_fdb_flags;
+
 	/* Listener for switch fabric events */
 	struct notifier_block	nb;
 
@@ -818,6 +821,8 @@ static inline bool dsa_port_tree_same(const struct dsa_port *a,
 	return a->ds->dst == b->ds->dst;
 }
 
+#define DSA_FDB_FLAG_DYNAMIC		BIT(0)
+
 typedef int dsa_fdb_dump_cb_t(const unsigned char *addr, u16 vid,
 			      bool is_static, void *data);
 struct dsa_switch_ops {
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index e5f156940c67..c07a2e225ae5 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -626,6 +626,12 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 
 	ds->configure_vlan_while_not_filtering = true;
 
+	/* Since dynamic FDB entries are legacy, all switch drivers should
+	 * support the flag at least by just installing a static entry and
+	 * letting the bridge age it.
+	 */
+	ds->supported_fdb_flags = DSA_FDB_FLAG_DYNAMIC;
+
 	err = ds->ops->setup(ds);
 	if (err < 0)
 		goto unregister_notifier;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 67ad1adec2a2..9a7c1265546d 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -976,12 +976,13 @@ int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu)
 }
 
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+		     u16 vid, u16 flags)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
 		.addr = addr,
 		.vid = vid,
+		.flags = flags,
 		.db = {
 			.type = DSA_DB_BRIDGE,
 			.bridge = *dp->bridge,
@@ -999,12 +1000,13 @@ int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 }
 
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+		     u16 vid, u16 flags)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
 		.addr = addr,
 		.vid = vid,
+		.flags = flags,
 		.db = {
 			.type = DSA_DB_BRIDGE,
 			.bridge = *dp->bridge,
@@ -1019,12 +1021,13 @@ int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 
 static int dsa_port_host_fdb_add(struct dsa_port *dp,
 				 const unsigned char *addr, u16 vid,
-				 struct dsa_db db)
+				 u16 flags, struct dsa_db db)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
 		.addr = addr,
 		.vid = vid,
+		.flags = flags,
 		.db = db,
 	};
 
@@ -1042,11 +1045,11 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 		.dp = dp,
 	};
 
-	return dsa_port_host_fdb_add(dp, addr, vid, db);
+	return dsa_port_host_fdb_add(dp, addr, vid, 0, db);
 }
 
-int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
-				 const unsigned char *addr, u16 vid)
+int dsa_port_bridge_host_fdb_add(struct dsa_port *dp, const unsigned char *addr,
+				 u16 vid, u16 flags)
 {
 	struct net_device *master = dsa_port_to_master(dp);
 	struct dsa_db db = {
@@ -1065,17 +1068,18 @@ int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
 			return err;
 	}
 
-	return dsa_port_host_fdb_add(dp, addr, vid, db);
+	return dsa_port_host_fdb_add(dp, addr, vid, flags, db);
 }
 
 static int dsa_port_host_fdb_del(struct dsa_port *dp,
 				 const unsigned char *addr, u16 vid,
-				 struct dsa_db db)
+				 u16 flags, struct dsa_db db)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
 		.addr = addr,
 		.vid = vid,
+		.flags = flags,
 		.db = db,
 	};
 
@@ -1093,11 +1097,11 @@ int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 		.dp = dp,
 	};
 
-	return dsa_port_host_fdb_del(dp, addr, vid, db);
+	return dsa_port_host_fdb_del(dp, addr, vid, 0, db);
 }
 
-int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
-				 const unsigned char *addr, u16 vid)
+int dsa_port_bridge_host_fdb_del(struct dsa_port *dp, const unsigned char *addr,
+				 u16 vid, u16 flags)
 {
 	struct net_device *master = dsa_port_to_master(dp);
 	struct dsa_db db = {
@@ -1112,7 +1116,7 @@ int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 			return err;
 	}
 
-	return dsa_port_host_fdb_del(dp, addr, vid, db);
+	return dsa_port_host_fdb_del(dp, addr, vid, flags, db);
 }
 
 int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 9c218660d223..88a9dfed3bce 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -47,17 +47,17 @@ int dsa_port_vlan_msti(struct dsa_port *dp,
 		       const struct switchdev_vlan_msti *msti);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid);
+		     u16 vid, u16 flags);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid);
+		     u16 vid, u16 flags);
 int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
 int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
 int dsa_port_bridge_host_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-				 u16 vid);
+				 u16 vid, u16 flags);
 int dsa_port_bridge_host_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-				 u16 vid);
+				 u16 vid, u16 flags);
 int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 			 u16 vid);
 int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 6957971c2db2..20d2d1c000ea 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -39,6 +39,7 @@ struct dsa_switchdev_event_work {
 	 */
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
+	u16 fdb_flags;
 	bool host_addr;
 };
 
@@ -3331,6 +3332,7 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 		container_of(work, struct dsa_switchdev_event_work, work);
 	const unsigned char *addr = switchdev_work->addr;
 	struct net_device *dev = switchdev_work->dev;
+	u16 flags = switchdev_work->fdb_flags;
 	u16 vid = switchdev_work->vid;
 	struct dsa_switch *ds;
 	struct dsa_port *dp;
@@ -3342,11 +3344,12 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (switchdev_work->host_addr)
-			err = dsa_port_bridge_host_fdb_add(dp, addr, vid);
+			err = dsa_port_bridge_host_fdb_add(dp, addr,
+							   vid, flags);
 		else if (dp->lag)
 			err = dsa_port_lag_fdb_add(dp, addr, vid);
 		else
-			err = dsa_port_fdb_add(dp, addr, vid);
+			err = dsa_port_fdb_add(dp, addr, vid, flags);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to add %pM vid %d to fdb: %d\n",
@@ -3358,11 +3361,12 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		if (switchdev_work->host_addr)
-			err = dsa_port_bridge_host_fdb_del(dp, addr, vid);
+			err = dsa_port_bridge_host_fdb_del(dp, addr,
+							   vid, flags);
 		else if (dp->lag)
 			err = dsa_port_lag_fdb_del(dp, addr, vid);
 		else
-			err = dsa_port_fdb_del(dp, addr, vid);
+			err = dsa_port_fdb_del(dp, addr, vid, flags);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to delete %pM vid %d from fdb: %d\n",
@@ -3400,6 +3404,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 	struct dsa_port *dp = dsa_slave_to_port(dev);
 	bool host_addr = fdb_info->is_local;
 	struct dsa_switch *ds = dp->ds;
+	u16 flags = 0;
 
 	if (ctx && ctx != dp)
 		return 0;
@@ -3437,6 +3442,12 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 			return -EOPNOTSUPP;
 	}
 
+	if (fdb_info->is_dyn && fdb_info->added_by_user)
+		flags |= DSA_FDB_FLAG_DYNAMIC;
+
+	if (flags & ~ds->supported_fdb_flags)
+		return 0;
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return -ENOMEM;
@@ -3454,6 +3465,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
 	switchdev_work->host_addr = host_addr;
+	switchdev_work->fdb_flags = flags;
 
 	dsa_schedule_work(&switchdev_work->work);
 
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index d5bc4bb7310d..0f5626a425b6 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -239,7 +239,7 @@ static int dsa_port_do_mdb_del(struct dsa_port *dp,
 }
 
 static int dsa_port_do_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-			       u16 vid, struct dsa_db db)
+			       u16 vid, u16 flags, struct dsa_db db)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_mac_addr *a;
@@ -283,7 +283,7 @@ static int dsa_port_do_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 }
 
 static int dsa_port_do_fdb_del(struct dsa_port *dp, const unsigned char *addr,
-			       u16 vid, struct dsa_db db)
+			       u16 vid, u16 flags, struct dsa_db db)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_mac_addr *a;
@@ -410,7 +410,9 @@ static int dsa_switch_host_fdb_add(struct dsa_switch *ds,
 								info->db);
 			} else {
 				err = dsa_port_do_fdb_add(dp, info->addr,
-							  info->vid, info->db);
+							  info->vid,
+							  info->flags,
+							  info->db);
 			}
 			if (err)
 				break;
@@ -438,7 +440,9 @@ static int dsa_switch_host_fdb_del(struct dsa_switch *ds,
 								info->db);
 			} else {
 				err = dsa_port_do_fdb_del(dp, info->addr,
-							  info->vid, info->db);
+							  info->vid,
+							  info->flags,
+							  info->db);
 			}
 			if (err)
 				break;
@@ -457,7 +461,8 @@ static int dsa_switch_fdb_add(struct dsa_switch *ds,
 	if (!ds->ops->port_fdb_add)
 		return -EOPNOTSUPP;
 
-	return dsa_port_do_fdb_add(dp, info->addr, info->vid, info->db);
+	return dsa_port_do_fdb_add(dp, info->addr, info->vid,
+				   info->flags, info->db);
 }
 
 static int dsa_switch_fdb_del(struct dsa_switch *ds,
@@ -469,7 +474,8 @@ static int dsa_switch_fdb_del(struct dsa_switch *ds,
 	if (!ds->ops->port_fdb_del)
 		return -EOPNOTSUPP;
 
-	return dsa_port_do_fdb_del(dp, info->addr, info->vid, info->db);
+	return dsa_port_do_fdb_del(dp, info->addr, info->vid,
+				   info->flags, info->db);
 }
 
 static int dsa_switch_lag_fdb_add(struct dsa_switch *ds,
diff --git a/net/dsa/switch.h b/net/dsa/switch.h
index 15e67b95eb6e..2c3bf4020158 100644
--- a/net/dsa/switch.h
+++ b/net/dsa/switch.h
@@ -55,6 +55,7 @@ struct dsa_notifier_fdb_info {
 	const struct dsa_port *dp;
 	const unsigned char *addr;
 	u16 vid;
+	u16 flags;
 	struct dsa_db db;
 };
 
-- 
2.34.1

