Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B26240889
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BFC040888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGAdrMfjbxvwPcFkMLK7vIWLclDlIPR8xC0JST0wvtg=;
 b=ZpX9KeWkheyij490KLQvvbvBtEDgb/AeNMpSyHzb7D2G4a3nMHP7N9A000ASM9ylJWyxdM8oTC07p2Wd9pvl2Bm4ndrZeWfoB0Z/JK44xgTiMPreXknF2UD3hILB0Xp4ASxuAPomUUr8kyA4Und89DjFcUZwbwGbKd6XlX8UmCR+2PDPSQcr+KNkW0BzACHaWDqZqKc5npFCJldliOxnVWDobQUPbeO7EOWR0jlOVCDkjyagCmXyU2d1nkDFe8TRa8Bj2/Jo2jMWypTB3pWdT4RDR4wZdqttF7NWLd+KBSJouUbEHklll2XcTCe1sxg3PdGE83bNO2hJ3Mi4lTlS3A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  8 Dec 2022 17:28:33 +0200
Message-Id: <20221208152839.1016350-9-idosch@nvidia.com>
In-Reply-To: <20221208152839.1016350-1-idosch@nvidia.com>
References: <20221208152839.1016350-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 08/14] bridge: mcast: Avoid arming group
	timer when (S, G) corresponds to a source
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

