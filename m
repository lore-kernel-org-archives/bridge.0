Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 118B360B30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38F7C60D72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GfMsVv6H7/hWq1qWkAPKSCxsToaIVqZEZ1kBwsImrQ=;
 b=PhYRMTQovditbP548tRdVDJzY2e8EfqMG4uh6SqYYJIvBwSvJ13gXMtW4cj7IBSGdssDSrzkYDpc3vzxRKdw75Vkp/IHc4Jhbuxs6+ZvefYGo4pRVsa3psv+zZS1oHXUbDEQqy9D9szTBU+fv0JfbtkTnx1yTr22u8sTlYtBBfKTWvlcguEoI2NpwDOEsFm2+Zt4xyhz4NdS117u9CwpXwiHaQHJbN60elA5RnaZAKlz6n8gn4Dbfz6h7jQ88I6ja0KG4NEPsZ39ZvKwOAQ+NlhBghg1QqRaek3zlwtgEPeBbjkyOoNsarMms6GFC0nSL2nYAUFxIwmRyZLwUubtdQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon,  5 Dec 2022 09:42:50 +0200
Message-Id: <20221205074251.4049275-8-idosch@nvidia.com>
In-Reply-To: <20221205074251.4049275-1-idosch@nvidia.com>
References: <20221205074251.4049275-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 7/8] bridge: mcast: Move checks out of
	critical section
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The checks only require information parsed from the RTM_NEWMDB netlink
message and do not rely on any state stored in the bridge driver.
Therefore, there is no need to perform the checks in the critical
section under the multicast lock.

Move the checks out of the critical section.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 67b6bc7272d3..aa5faccf09f8 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -805,24 +805,6 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	if (!brmctx)
 		return -EINVAL;
 
-	/* host join errors which can happen before creating the group */
-	if (!port && !br_group_is_l2(&group)) {
-		/* don't allow any flags for host-joined IP groups */
-		if (entry->state) {
-			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
-			return -EINVAL;
-		}
-		if (!br_multicast_is_star_g(&group)) {
-			NL_SET_ERR_MSG_MOD(extack, "Groups with sources cannot be manually host joined");
-			return -EINVAL;
-		}
-	}
-
-	if (br_group_is_l2(&group) && entry->state != MDB_PERMANENT) {
-		NL_SET_ERR_MSG_MOD(extack, "Only permanent L2 entries allowed");
-		return -EINVAL;
-	}
-
 	mp = br_multicast_new_group(br, &group);
 	if (IS_ERR(mp))
 		return PTR_ERR(mp);
@@ -1026,6 +1008,24 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
+	/* host join errors which can happen before creating the group */
+	if (!cfg.p && !br_group_is_l2(&cfg.group)) {
+		/* don't allow any flags for host-joined IP groups */
+		if (cfg.entry->state) {
+			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
+			return -EINVAL;
+		}
+		if (!br_multicast_is_star_g(&cfg.group)) {
+			NL_SET_ERR_MSG_MOD(extack, "Groups with sources cannot be manually host joined");
+			return -EINVAL;
+		}
+	}
+
+	if (br_group_is_l2(&cfg.group) && cfg.entry->state != MDB_PERMANENT) {
+		NL_SET_ERR_MSG_MOD(extack, "Only permanent L2 entries allowed");
+		return -EINVAL;
+	}
+
 	if (cfg.p) {
 		if (cfg.p->state == BR_STATE_DISABLED && cfg.entry->state != MDB_PERMANENT) {
 			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
-- 
2.37.3

