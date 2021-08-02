Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yna7iRO9WXs8X4DbwZIW9DkTZl4CcB2f1c078iipS5g=;
 b=PVoyWDBy4EbNWevoEg24Ave7CL4YHxq2zePpwc9X1Nt4nZx1moXeIH3wckNbhkdtSZW74gix4UO+ls00Rb6aQKbLhUYxyO6RGuFEGbmHQXPfFcjUTwqtgljeftEkW5CXcWVXzNgmzbGCWPvyXFdtOMp6ErkyV7M+RParMR3sXGw=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon,  2 Aug 2021 14:36:33 +0300
Message-Id: <20210802113633.189831-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next] net: bridge: switchdev: fix incorrect use
	of FDB flags when picking the dst device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ido Schimmel <idosch@idosch.org>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

Nikolay points out that it is incorrect to assume that it is impossible
to have an fdb entry with fdb->dst == NULL and the BR_FDB_LOCAL bit in
fdb->flags not set. This is because there are reader-side places that
test_bit(BR_FDB_LOCAL, &fdb->flags) without the br->hash_lock, and if
the updating of the FDB entry happens on another CPU, there are no
memory barriers at writer or reader side which would ensure that the
reader sees the updates to both fdb->flags and fdb->dst in the same
order, i.e. the reader will not see an inconsistent FDB entry.

So we must be prepared to deal with FDB entries where fdb->dst and
fdb->flags are in a potentially inconsistent state, and that means that
fdb->dst == NULL should remain a condition to pick the net_device that
we report to switchdev as being the bridge device, which is what the
code did prior to the blamed patch.

Fixes: 52e4bec15546 ("net: bridge: switchdev: treat local FDBs the same as entries towards the bridge")
Suggested-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_fdb.c       | 2 +-
 net/bridge/br_switchdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4ff8c67ac88f..af31cebfda94 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -745,7 +745,7 @@ static int br_fdb_replay_one(struct net_bridge *br, struct notifier_block *nb,
 	item.added_by_user = test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 	item.offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags);
 	item.is_local = test_bit(BR_FDB_LOCAL, &fdb->flags);
-	item.info.dev = item.is_local ? br->dev : p->dev;
+	item.info.dev = (!p || item.is_local) ? br->dev : p->dev;
 	item.info.ctx = ctx;
 
 	err = nb->notifier_call(nb, action, &item);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 023de0e958f1..36d75fd4a80c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -134,7 +134,7 @@ br_switchdev_fdb_notify(struct net_bridge *br,
 		.is_local = test_bit(BR_FDB_LOCAL, &fdb->flags),
 		.offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags),
 	};
-	struct net_device *dev = info.is_local ? br->dev : dst->dev;
+	struct net_device *dev = (!dst || info.is_local) ? br->dev : dst->dev;
 
 	switch (type) {
 	case RTM_DELNEIGH:
-- 
2.25.1

