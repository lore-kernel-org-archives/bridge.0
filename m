Return-Path: <dqfext@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YG+p9bpPBHqyI4mCiMrVfo4BojUmW4QV1jvJ5YQRhnY=;
 b=hHE1PNZgAIGvBQTOD3CUD4s+7VggJSeq6TnzxrF3uubC7quWhfgn7tRKDYFs+xlAbc
 +KV+tqw1PUHAsh3qRxT4zw1Y+8hjoONwZcGjRqvtZZoW4t1v94x40FvDL1nlhxqRXqAL
 Qf/bXUUtZ2viScyRqbtwtkz56JfAiDIugkeD1/z1zfdbn2SiSE+e6lcpc1D9kZu34hc4
 g+rA+fY8YIDld6yxHeMuNeiqye20nk88NVxb83OUaGxzGlJ4Du7fltMj1KSJgyqgnJUU
 YY1rxThk5EH5azh1q9ox8+CfG5TiveZ9dXo6hFTa2gxKRARs7+h7Vd9Dth/YL4FxQIQf
 YNgQ==
From: DENG Qingfang <dqfext@gmail.com>
Message-Id: <20200419161946.19984-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC PATCH net-next] net: bridge: fix client roaming from
	DSA user port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sun, 19 Apr 2020 16:19:53 -0000
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

When a client roams from a DSA user port to a soft-bridged port (such as WiFi
interface), the left-over MAC entry in the switch HW is not deleted, causing
inconsistency between Linux fdb and the switch MAC table. As a result, the
client cannot talk to other hosts which are on that DSA user port until the
MAC entry expires.

Solve this by notifying switchdev fdb to delete the leftover entry when an
entry is updated. Remove the added_by_user check in DSA

Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
I tried this on mt7530 and mv88e6xxx, but only mt7530 works.
In previous discussion[1], Andrew Lunn said "try playing with auto learning
for the CPU port" but it didn't work on mv88e6xxx either

I think commit 7e26bf45e4cb ("net: bridge: allow SW learn to take over HW fdb
entries") already tried to fix this issue..

[1] https://lore.kernel.org/netdev/20200405150915.GD161768@lunn.ch/

 net/bridge/br_fdb.c | 3 +++
 net/dsa/slave.c     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4877a0db16c6..46003e78f2ac 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -579,6 +579,9 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			/* fastpath: update of existing entry */
 			if (unlikely(source != fdb->dst &&
 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
+				/* Remove the entry in HW */
+				br_switchdev_fdb_notify(fdb, RTM_DELNEIGH);
+
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index e94eb1aac602..6133a1be1a74 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1932,8 +1932,6 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb_info = &switchdev_work->fdb_info;
-		if (!fdb_info->added_by_user)
-			break;
 
 		err = dsa_port_fdb_del(dp, fdb_info->addr, fdb_info->vid);
 		if (err) {
-- 
2.26.0

