Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMV1rNTy+B73je0YKCFaLZbYflrMYlTRHnsjo3Wx6zU=;
 b=d7e7bcWSJJT1bCTeJk40jf7yVWOU+NDWX1c/VCVpODDi3YCfLKTmULaJVdsiluP+PCOyf35e+/DzQfFrZFT6hJoYzvB9ru76UyB/Sbv1awEGaD1Y6+J2zYtb33bNVYU5zIebHEnboV3114Z4lMLWsLX+BzceSgEYtxUIkXOmkjo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:30 +0300
Message-Id: <20210712152142.800651-13-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 12/24] net: bridge: drop context
	pointer from br_fdb_replay
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

As opposed to the port objects (mdb, vlan), the FDB entries on a LAG are
a bit special.

While a VLAN installed on a bridge port that is a LAG can reasonably be
modeled from the bridge's perspective as individual VLANs being
installed on all physical ports that are beneath that LAG (and similar
for multicast addresses), the same cannot really be said about a unicast
forwarding destination MAC address.

Actually there is no driver today that makes meaningful use of FDB
entries towards bridge ports that are LAG (bond/team) interfaces, so it
is hard to assume anything. But intuitively, since FDB entries are
usually exclusive to a single destination port, replicating them on all
LAG lowers sounds like a bad idea. Maybe, instead, the switchdev driver
models the LAG as a logical port, and the FDB entries associated with
the LAG target that.

Anyway, do not assume anything and drop the context pointer from the fdb
replay helpers. The context pointer was introduced specifically for the
case where the bridge port is a LAG, beneath which there are multiple
switchdev lowers, all of which must do the same thing when offloading a
given switchdev object, and none of the ports must act on the same
object twice. It appears that in the case of FDB entries it is not
useful: the driver appears to be required to be able to do something
more elaborate even though it is not clear what.

The trouble, really, is that call_switchdev_notifiers() is not able
today to pass the context pointer, but br_fdb_replay calls a hand-coded
version of that function which is. Refactoring call_switchdev_notifiers
does not appear really worth it without at least knowing the requrements,
so drop the functionality with no users for now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/if_bridge.h | 4 ++--
 net/bridge/br_fdb.c       | 8 +++-----
 net/dsa/port.c            | 8 ++++----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index d0bec83488b9..13acc1ff476c 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -168,7 +168,7 @@ bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 u8 br_port_get_stp_state(const struct net_device *dev);
 clock_t br_get_ageing_time(const struct net_device *br_dev);
 int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
-		  const void *ctx, bool adding, struct notifier_block *nb);
+		  bool adding, struct notifier_block *nb);
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -199,7 +199,7 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 }
 
 static inline int br_fdb_replay(const struct net_device *br_dev,
-				const struct net_device *dev, const void *ctx,
+				const struct net_device *dev,
 				bool adding, struct notifier_block *nb)
 {
 	return -EOPNOTSUPP;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 2b862cffc03a..c93a2b3a0ad8 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -734,8 +734,7 @@ static inline size_t fdb_nlmsg_size(void)
 
 static int br_fdb_replay_one(struct notifier_block *nb,
 			     const struct net_bridge_fdb_entry *fdb,
-			     struct net_device *dev, unsigned long action,
-			     const void *ctx)
+			     struct net_device *dev, unsigned long action)
 {
 	struct switchdev_notifier_fdb_info item;
 	int err;
@@ -746,14 +745,13 @@ static int br_fdb_replay_one(struct notifier_block *nb,
 	item.offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
 	item.is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
 	item.info.dev = dev;
-	item.info.ctx = ctx;
 
 	err = nb->notifier_call(nb, action, &item);
 	return notifier_to_errno(err);
 }
 
 int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
-		  const void *ctx, bool adding, struct notifier_block *nb)
+		  bool adding, struct notifier_block *nb)
 {
 	struct net_bridge_fdb_entry *fdb;
 	struct net_bridge *br;
@@ -783,7 +781,7 @@ int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
 		if (dst_dev != br_dev && dst_dev != dev)
 			continue;
 
-		err = br_fdb_replay_one(nb, fdb, dst_dev, action, ctx);
+		err = br_fdb_replay_one(nb, fdb, dst_dev, action);
 		if (err)
 			break;
 	}
diff --git a/net/dsa/port.c b/net/dsa/port.c
index b824b6f8aa84..34b7f64348c2 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -200,13 +200,13 @@ static int dsa_port_switchdev_sync(struct dsa_port *dp,
 		return err;
 
 	/* Forwarding and termination FDB entries on the port */
-	err = br_fdb_replay(br, brport_dev, dp, true,
+	err = br_fdb_replay(br, brport_dev, true,
 			    &dsa_slave_switchdev_notifier);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
 	/* Termination FDB entries on the bridge itself */
-	err = br_fdb_replay(br, br, dp, true, &dsa_slave_switchdev_notifier);
+	err = br_fdb_replay(br, br, true, &dsa_slave_switchdev_notifier);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
@@ -232,13 +232,13 @@ static int dsa_port_switchdev_unsync_objs(struct dsa_port *dp,
 		return err;
 
 	/* Forwarding and termination FDB entries on the port */
-	err = br_fdb_replay(br, brport_dev, dp, false,
+	err = br_fdb_replay(br, brport_dev, false,
 			    &dsa_slave_switchdev_notifier);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
 	/* Termination FDB entries on the bridge itself */
-	err = br_fdb_replay(br, br, dp, false, &dsa_slave_switchdev_notifier);
+	err = br_fdb_replay(br, br, false, &dsa_slave_switchdev_notifier);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-- 
2.25.1

