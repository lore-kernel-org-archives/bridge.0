Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 253F341591
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A8BE41583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYgRQjJod9sxq0dZSHBMevA+JFjKhO4R5dJtsuTAAB0=;
 b=dbSJD9N0aNmUxeclCQi2MDCDc0Leq9ZvtsCQHe0wUYAYHqe4hUADbHVPezHFm6qGcHrJ3ZHoE05fCOqMfF/a15sOTzqk4+GIBsE5ZUzb2sf7EJglEcTQzjV4KhVxxkw6ga2I8ErlHdb6+lKI/bLMPvsrW7ACbiZpjKCSbYuK1b6q1q2sMURqF2RrPxHWb2Vosa/V1Qt/mdymhyCTKdtA/EFFGHLncMMVMCzdawXHtBvrHdMh86S3A7/AAs/tw7JwOe6XgQdPX+Shi9UETtE/IziLwd3pggCiSGLwkM1IKQc6s2swgeopw5Nm0FEEb+yuxKo+byyFjrfC0Yc8CxzdPA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat, 10 Dec 2022 16:56:27 +0200
Message-Id: <20221210145633.1328511-9-idosch@nvidia.com>
In-Reply-To: <20221210145633.1328511-1-idosch@nvidia.com>
References: <20221210145633.1328511-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 08/14] bridge: mcast: Avoid arming
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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c     | 2 +-
 net/bridge/br_private.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 95780652cdbf..7cda9d1c5c93 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -814,7 +814,7 @@ static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
 		return -ENOMEM;
 	}
 	rcu_assign_pointer(*pp, p);
-	if (!(flags & MDB_PG_FLAGS_PERMANENT))
+	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
 		mod_timer(&p->timer,
 			  now + brmctx->multicast_membership_interval);
 	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 74f17b56c9eb..e98bfe3c02e1 100644
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

