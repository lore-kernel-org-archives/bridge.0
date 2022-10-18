Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A879C41945
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 874A141940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrUwrnsOuhCUGW6KTHebnTsZpuheVpQu+htC/Bq7XBY=;
 b=hVN3LT+Np7U0E0TNwp6uHhTwrMs1jJrevI4CZ5GNrv4F4rVTDmYZx3qivotRNBikuAHsqbY6v4ksDKU79b8PcHE0vUIblbdiESbbz57ngw/dKzQxW7a7/BhcAB+yh0Sp5qi1dKe0TsxZRsarJv3jlU6jIgm4e2MNaGvbzz4WK6ULFp0e9igp7lk66EVvrQ5mJuZ0N/s8LyTKU127LU2REh17DRTIaf8EZmDw5dwG7Y9M45stMV0RPUJyxrcVfMvEvc/i3DuV7xJi6yiLQ8TQ6fNoEJXqVUB0IxwV8cc8o4DbYEZM952YxIYkArfR2z2aG8qfBcYKaA79F9swoMm0iQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:12 +0300
Message-Id: <20221018120420.561846-12-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 11/19] bridge: mcast: Place netlink
	policy before validation functions
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

Subsequent patches are going to add additional validation functions and
netlink policies. Some of these functions will need to perform parsing
using nla_parse_nested() and the new policies.

In order to keep all the policies next to each other, move the current
policy to before the validation functions.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a48eef866974..26740df62fd6 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -663,6 +663,12 @@ void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
 	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
 }
 
+static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
+					      sizeof(struct in_addr),
+					      sizeof(struct in6_addr)),
+};
+
 static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
 			       struct netlink_ext_ack *extack)
 {
@@ -748,12 +754,6 @@ static bool is_valid_mdb_source(struct nlattr *attr, __be16 proto,
 	return true;
 }
 
-static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
-	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
-					      sizeof(struct in_addr),
-					      sizeof(struct in6_addr)),
-};
-
 static struct net_bridge_mcast *
 __br_mdb_choose_context(struct net_bridge *br,
 			const struct br_mdb_entry *entry,
-- 
2.37.3

