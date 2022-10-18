Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D62D83386
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82BE783367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QsM3xrlFg3Hwve88DhT1PMFVHcN/MuwcfAYpgxEF+g=;
 b=SSQKoVAwJICUbYEzqnXBn6rVa05B1FYnNfzNI/7seeHHMhLvFCej14xvxWKFHD2ddj0xUWnyiKl+jrmNFOum0O6v+AVdvLs+WBY4MhoGmqiFpyoFBEqHe0Sc9lP3M2XyZdG6GnoypUk5xyYiHsQG4oerzNjR7QEmGJEwjnpvqSm8qBwE0ucuOfVGRMihFMTaszSgDK++5Bobz8oiCGs+hh4mLwW1Fms4fIwpxTqquJgo+oyHSZJTZlic2g6VjHm2WrBWjOPQc8Zm5bl5Otvn2//WQhfOlVUAdw5q2CibXdEOfpcH/HnirEMLFGA6jwn1R/G1F6RYQx+r0e62dakqcQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:13 +0300
Message-Id: <20221018120420.561846-13-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 12/19] bridge: mcast: Add a
	centralized error path
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

Subsequent patches will add memory allocations in br_mdb_config_init()
as the MDB configuration structure will include a linked list of source
entries. This memory will need to be freed regardless if br_mdb_add()
succeeded or failed.

As a preparation for this change, add a centralized error path where the
memory will be freed.

Note that br_mdb_del() already has one error path and therefore does not
require any changes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 26740df62fd6..157ba4e765c1 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1053,28 +1053,29 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
+	err = -EINVAL;
 	/* host join errors which can happen before creating the group */
 	if (!cfg.p && !br_group_is_l2(&cfg.group)) {
 		/* don't allow any flags for host-joined IP groups */
 		if (cfg.entry->state) {
 			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
-			return -EINVAL;
+			goto out;
 		}
 		if (!br_multicast_is_star_g(&cfg.group)) {
 			NL_SET_ERR_MSG_MOD(extack, "Groups with sources cannot be manually host joined");
-			return -EINVAL;
+			goto out;
 		}
 	}
 
 	if (br_group_is_l2(&cfg.group) && cfg.entry->state != MDB_PERMANENT) {
 		NL_SET_ERR_MSG_MOD(extack, "Only permanent L2 entries allowed");
-		return -EINVAL;
+		goto out;
 	}
 
 	if (cfg.p) {
 		if (cfg.p->state == BR_STATE_DISABLED && cfg.entry->state != MDB_PERMANENT) {
 			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
-			return -EINVAL;
+			goto out;
 		}
 		vg = nbp_vlan_group(cfg.p);
 	} else {
@@ -1096,6 +1097,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = __br_mdb_add(&cfg, extack);
 	}
 
+out:
 	return err;
 }
 
-- 
2.37.3

