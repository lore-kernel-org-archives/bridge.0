Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D265861082
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BE6D6107E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bw0x6A29rVN4MmRG2Zk75Y6JYHE1k0KH0Ii7wacLrk=;
 b=o64g0pWF6E+6AvLHy2X2IF4XVuZqj5TT8wk68NXn/iWlnY9w/rdfPb2ko2vaiPewyUN2MBJA04PhI8K5xtN5O0qvQL0sIpvUi5D+FhrrdOp5UwYY7ie6DFjd8McvpT/i5EypRxCxeLMRyhCpg/KqFKjegGrrvEqpDKzju3rFPTeian93DbqwbvbUh/qEF87L1TzbkQXgchLXHohbJHXc75VbIvHLZxO2Mto0XVybwa8a5REOJRjwCM2HwriQIlefzRDNPKDCVwaNS/I8mS5+Ni9BJt5CgAL66n6Qo5Jbu0I50Bgb6nL0Umequd4tTBa5rgtPFMwG3Fmbc9FbqPEI2A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:16 +0300
Message-Id: <20221018120420.561846-16-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 15/19] bridge: mcast: Avoid arming
	group timer when (S, G) corresponds to a source
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

User space will soon be able to install a (*, G) with a source list,
prompting the creation of a (S, G) entry for each source.

In this case, the group timer of the (S, G) entry should never be set.

Solve this by adding a new field to the MDB configuration structure that
denotes whether the (S, G) corresponds to a source or not.

The field will be set in a subsequent patch where br_mdb_add_group_sg()
is called in order to create a (S, G) entry for each user provided
source.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c     | 2 +-
 net/bridge/br_private.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 157ba4e765c1..2804da7b0aa1 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -814,7 +814,7 @@ static int br_mdb_add_group_sg(struct br_mdb_config *cfg,
 		return -ENOMEM;
 	}
 	rcu_assign_pointer(*pp, p);
-	if (!(flags & MDB_PG_FLAGS_PERMANENT))
+	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
 		mod_timer(&p->timer,
 			  now + brmctx->multicast_membership_interval);
 	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6879d2e1128f..1bd6eebad002 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -98,6 +98,7 @@ struct br_mdb_config {
 	struct net_bridge_port		*p;
 	struct br_mdb_entry		*entry;
 	struct br_ip			group;
+	bool				src_entry;
 };
 #endif
 
-- 
2.37.3

