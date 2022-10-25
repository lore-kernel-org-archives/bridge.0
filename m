Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0747240390
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07B6240399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY2uysjvS0N9kmWplWmXyBaDDHG17l4WCjcNJi7lyho=;
 b=F12/0dYiYIgDfquGuxF79kD+fPoyGYTgrR/WtcxyehzZtiaR0u2DHuE5Topl6HGElilSeGBUt01d1MZW+4bdz9btgfYV8WsBHzVqvaT9/ShEoPyClFuO0gg/NBgWzt00PNWX7TB7EsJQYbj1rrDO0ucs+3yMxSGtYJB4e6lSWdauQRIy1tgC0ftDbFQW6BPG97UNyJwfX+yUIPJnQ0IhjbBH1W/JMpkuUYp9uE3qWf5bPWxNmBL+54uf6lyNo9+V1+Ca7W27srkHCjjGWMNHwzleRdecpidp7FxD3bKWwRgAgkx9dYv21UT+bZMYlfKbzWF2YQsrVNTj5Uc9sN5S9A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:12 +0300
Message-Id: <20221025100024.1287157-5-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 04/16] bridge: switchdev: Allow device
	drivers to install locked FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, razor@blackwall.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

From: "Hans J. Schultz" <netdev@kapio-technology.com>

When the bridge is offloaded to hardware, FDB entries are learned and
aged-out by the hardware. Some device drivers synchronize the hardware
and software FDBs by generating switchdev events towards the bridge.

When a port is locked, the hardware must not learn autonomously, as
otherwise any host will blindly gain authorization. Instead, the
hardware should generate events regarding hosts that are trying to gain
authorization and their MAC addresses should be notified by the device
driver as locked FDB entries towards the bridge driver.

Allow device drivers to notify the bridge driver about such entries by
extending the 'switchdev_notifier_fdb_info' structure with the 'locked'
bit. The bit can only be set by device drivers and not by the bridge
driver.

Prevent a locked entry from being installed if MAB is not enabled on the
bridge port. By placing this check in the bridge driver we avoid the
need to reflect the 'BR_PORT_MAB' flag to device drivers.

If an entry already exists in the bridge driver, reject the locked entry
if the current entry does not have the "locked" flag set or if it points
to a different port. The same semantics are implemented in the software
data path.

Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    Changes made by me:
    
     * Reword commit message.
     * Forbid locked entries when MAB is not enabled.
     * Forbid roaming of locked entries.
     * Avoid setting 'locked' bit towards device drivers.

 include/net/switchdev.h   |  1 +
 net/bridge/br.c           |  3 ++-
 net/bridge/br_fdb.c       | 22 ++++++++++++++++++++--
 net/bridge/br_private.h   |  2 +-
 net/bridge/br_switchdev.c |  1 +
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 7dcdc97c0bc3..ca0312b78294 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -248,6 +248,7 @@ struct switchdev_notifier_fdb_info {
 	u16 vid;
 	u8 added_by_user:1,
 	   is_local:1,
+	   locked:1,
 	   offloaded:1;
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 145999b8c355..4f5098d33a46 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-						fdb_info->vid, false);
+						fdb_info->vid,
+						fdb_info->locked, false);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 3b83af4458b8..e69a872bfc1d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1139,7 +1139,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 					   "FDB entry towards bridge must be permanent");
 			return -EINVAL;
 		}
-		err = br_fdb_external_learn_add(br, p, addr, vid, true);
+		err = br_fdb_external_learn_add(br, p, addr, vid, false, true);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
@@ -1377,7 +1377,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 }
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid,
+			      const unsigned char *addr, u16 vid, bool locked,
 			      bool swdev_notify)
 {
 	struct net_bridge_fdb_entry *fdb;
@@ -1386,6 +1386,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 	trace_br_fdb_external_learn_add(br, p, addr, vid);
 
+	if (locked && (!p || !(p->flags & BR_PORT_MAB)))
+		return -EINVAL;
+
 	spin_lock_bh(&br->hash_lock);
 
 	fdb = br_fdb_find(br, addr, vid);
@@ -1398,6 +1401,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		if (!p)
 			flags |= BIT(BR_FDB_LOCAL);
 
+		if (locked)
+			flags |= BIT(BR_FDB_LOCKED);
+
 		fdb = fdb_create(br, p, addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
@@ -1405,6 +1411,13 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		}
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
+		if (locked &&
+		    (!test_bit(BR_FDB_LOCKED, &fdb->flags) ||
+		     READ_ONCE(fdb->dst) != p)) {
+			err = -EINVAL;
+			goto err_unlock;
+		}
+
 		fdb->updated = jiffies;
 
 		if (READ_ONCE(fdb->dst) != p) {
@@ -1421,6 +1434,11 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
+		if (locked != test_bit(BR_FDB_LOCKED, &fdb->flags)) {
+			change_bit(BR_FDB_LOCKED, &fdb->flags);
+			modified = true;
+		}
+
 		if (swdev_notify)
 			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4ce8b8e5ae0b..4c4fda930068 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -811,7 +811,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-			      bool swdev_notify);
+			      bool locked, bool swdev_notify);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 8f3d76c751dd..6afd4f241474 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -136,6 +136,7 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
 	item->added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 	item->offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
 	item->is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
+	item->locked = 0;
 	item->info.dev = (!p || item->is_local) ? br->dev : p->dev;
 	item->info.ctx = ctx;
 }
-- 
2.37.3

