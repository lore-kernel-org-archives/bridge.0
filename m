Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C7816113E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9990B60A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Xwoh/eJJghknkS0pyoMisV7jmbkbgBWSMvMVm8e0E=;
 b=alwPXdr1dOHrZh7pZ1d04Oe5NW503/xK4ZxAMLN7Zr2ilj+xOuhgT/l6nyBoLERjaTUjzM7XARILqhwxQWlxw8T9C4KtdCxSij/+N4f1QXh3D5g7aIXWj5HVVB+Z+YUIcidmI8amq7ktnrZsaYd+AKu9ZW4osv/2WVuTuZNXGVcjfQNdz4o3TQt/9urGkZjGyMFephWiR0wcZ2U4iGlkyhMzY6DgKSy2HapS+NStzuTbbI2kpi3lN7jR3QyG8KGEpNXN59NUlGGXYo7Z05SXxwgW+9DtauziGx5lwvZMjmLU4VTIxdKDjL0Gs7ZbknGKyKMvVfBccZWGfNxP25AUuA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  8 Dec 2022 17:28:28 +0200
Message-Id: <20221208152839.1016350-4-idosch@nvidia.com>
In-Reply-To: <20221208152839.1016350-1-idosch@nvidia.com>
References: <20221208152839.1016350-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 03/14] bridge: mcast: Place netlink policy
	before validation functions
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
index e3bd2122d559..fcdd464cf997 100644
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

