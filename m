Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90D9841919
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09968418AD
From: Hans Schultz <netdev@kapio-technology.com>
Date: Fri, 26 Aug 2022 13:45:34 +0200
Message-Id: <20220826114538.705433-3-netdev@kapio-technology.com>
In-Reply-To: <20220826114538.705433-1-netdev@kapio-technology.com>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 2/6] net: switchdev: add support for
	offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Hans Schultz <netdev@kapio-technology.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>

Used for MacAuth/MAB feature in the offloaded case.
Send the fdb locked flag down through the switchdev and DSA layers.

Also add support for drivers to set additional flags on bridge
FDB entries including the new 'blackhole' flag.

And add support for offloading of the MAB/MacAuth feature flag.

Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
---
 include/net/switchdev.h   |  3 +++
 net/bridge/br.c           |  5 ++++-
 net/bridge/br_fdb.c       | 14 ++++++++++++--
 net/bridge/br_private.h   |  3 ++-
 net/bridge/br_switchdev.c |  5 +++--
 net/dsa/dsa_priv.h        |  4 +++-
 net/dsa/port.c            |  7 ++++---
 net/dsa/slave.c           |  4 +++-
 net/dsa/switch.c          |  6 +++---
 9 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 7dcdc97c0bc3..437945179373 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -247,7 +247,10 @@ struct switchdev_notifier_fdb_info {
 	const unsigned char *addr;
 	u16 vid;
 	u8 added_by_user:1,
+	   sticky:1,
 	   is_local:1,
+	   locked:1,
+	   blackhole:1,
 	   offloaded:1;
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 96e91d69a9a8..3671c0a12b7d 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -166,7 +166,10 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-						fdb_info->vid, false);
+						fdb_info->vid, false,
+						fdb_info->locked,
+						fdb_info->blackhole,
+						fdb_info->sticky);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 1962d9594a48..30126af9c42f 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1147,7 +1147,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 					   "FDB entry towards bridge must be permanent");
 			return -EINVAL;
 		}
-		err = br_fdb_external_learn_add(br, p, addr, vid, true);
+		err = br_fdb_external_learn_add(br, p, addr, vid, true, false, false, false);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
@@ -1383,7 +1383,8 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-			      bool swdev_notify)
+			      bool swdev_notify, bool locked,
+			      bool blackhole, bool sticky)
 {
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
@@ -1403,6 +1404,15 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		if (!p)
 			flags |= BIT(BR_FDB_LOCAL);
 
+		if (locked)
+			flags |= BIT(BR_FDB_ENTRY_LOCKED);
+
+		if (blackhole)
+			flags |= BIT(BR_FDB_BLACKHOLE);
+
+		if (sticky)
+			flags |= BIT(BR_FDB_STICKY);
+
 		fdb = fdb_create(br, p, addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 048e4afbc5a0..2836fec2dafb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -812,7 +812,8 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-			      bool swdev_notify);
+			      bool swdev_notify, bool locked,
+			      bool blackhole, bool sticky);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 8f3d76c751dd..9aaefbc07e02 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -71,8 +71,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 }
 
 /* Flags that can be offloaded to hardware */
-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
+#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD | \
+				  BR_PORT_LOCKED | BR_PORT_MAB | \
 				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
@@ -136,6 +136,7 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
 	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
 	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
+	item->locked = test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
 	item->info.dev = (!p || item->is_local) ? br->dev : p->dev;
 	item->info.ctx = ctx;
 }
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 614fbba8fe39..b05685418b20 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -65,6 +65,7 @@ struct dsa_notifier_fdb_info {
 	const struct dsa_port *dp;
 	const unsigned char *addr;
 	u16 vid;
+	bool is_locked;
 	struct dsa_db db;
 };
 
@@ -131,6 +132,7 @@ struct dsa_switchdev_event_work {
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
 	bool host_addr;
+	bool is_locked;
 };
 
 enum dsa_standalone_event {
@@ -232,7 +234,7 @@ int dsa_port_vlan_msti(struct dsa_port *dp,
 		       const struct switchdev_vlan_msti *msti);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid);
+		     u16 vid, bool is_locked);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 7afc35db0c29..3399cc1f7be0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -303,7 +303,7 @@ static int dsa_port_inherit_brport_flags(struct dsa_port *dp,
 					 struct netlink_ext_ack *extack)
 {
 	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
+				   BR_BCAST_FLOOD | BR_PORT_LOCKED | BR_PORT_MAB;
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	int flag, err;
 
@@ -327,7 +327,7 @@ static void dsa_port_clear_brport_flags(struct dsa_port *dp)
 {
 	const unsigned long val = BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
 	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
+				   BR_BCAST_FLOOD | BR_PORT_LOCKED | BR_PORT_MAB;
 	int flag, err;
 
 	for_each_set_bit(flag, &mask, 32) {
@@ -954,12 +954,13 @@ int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu)
 }
 
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-		     u16 vid)
+		     u16 vid, bool is_locked)
 {
 	struct dsa_notifier_fdb_info info = {
 		.dp = dp,
 		.addr = addr,
 		.vid = vid,
+		.is_locked = is_locked,
 		.db = {
 			.type = DSA_DB_BRIDGE,
 			.bridge = *dp->bridge,
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 345106b1ed78..a6486d7d9c7c 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2908,6 +2908,7 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 		container_of(work, struct dsa_switchdev_event_work, work);
 	const unsigned char *addr = switchdev_work->addr;
 	struct net_device *dev = switchdev_work->dev;
+	bool is_locked = switchdev_work->is_locked;
 	u16 vid = switchdev_work->vid;
 	struct dsa_switch *ds;
 	struct dsa_port *dp;
@@ -2923,7 +2924,7 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 		else if (dp->lag)
 			err = dsa_port_lag_fdb_add(dp, addr, vid);
 		else
-			err = dsa_port_fdb_add(dp, addr, vid);
+			err = dsa_port_fdb_add(dp, addr, vid, is_locked);
 		if (err) {
 			dev_err(ds->dev,
 				"port %d failed to add %pM vid %d to fdb: %d\n",
@@ -3031,6 +3032,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
 	switchdev_work->host_addr = host_addr;
+	switchdev_work->is_locked = fdb_info->locked;
 
 	dsa_schedule_work(&switchdev_work->work);
 
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 4dfd68cf61c5..f29604f25c67 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -234,7 +234,7 @@ static int dsa_port_do_mdb_del(struct dsa_port *dp,
 }
 
 static int dsa_port_do_fdb_add(struct dsa_port *dp, const unsigned char *addr,
-			       u16 vid, struct dsa_db db)
+			       u16 vid, bool is_locked, struct dsa_db db)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_mac_addr *a;
@@ -399,7 +399,7 @@ static int dsa_switch_host_fdb_add(struct dsa_switch *ds,
 	dsa_switch_for_each_port(dp, ds) {
 		if (dsa_port_host_address_match(dp, info->dp)) {
 			err = dsa_port_do_fdb_add(dp, info->addr, info->vid,
-						  info->db);
+						  false, info->db);
 			if (err)
 				break;
 		}
@@ -438,7 +438,7 @@ static int dsa_switch_fdb_add(struct dsa_switch *ds,
 	if (!ds->ops->port_fdb_add)
 		return -EOPNOTSUPP;
 
-	return dsa_port_do_fdb_add(dp, info->addr, info->vid, info->db);
+	return dsa_port_do_fdb_add(dp, info->addr, info->vid, info->is_locked, info->db);
 }
 
 static int dsa_switch_fdb_del(struct dsa_switch *ds,
-- 
2.30.2

