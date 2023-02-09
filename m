Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3923409DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 288BB40612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MSdRyowfkz64UV5rptMDYknkdbhAubmzsGyfZQhTjc=;
 b=X5gW7BrGW/1gZMJLhH+AenkL4DG7Gh4A7TVvM2QFeG1kLx6xYvYfsw9yzR4lEaw0WOCBzoN9t/viPt2b6bcCCJUrewIxGad0crBYuUp7fCXbAtwUc2WbcSIZ85q2lIdShptwKb6htD0hXND2Odz6P4kMpfTd7OG1TtwyroopWKiFHd3Lz21Dtr6Cws2cglO1D0SyVrcd0nb79IqEGtSYguzXDVJC8abAeJ8oM/1z02R0gE3nne67puwYU7M1WDym4d7jcXsbLbI1hueHnzoThc5AQ4ZCY6gsd6eRkvyykXPW59z2Io61SY9KSRHpIJNVWeD/C/dtxALrM7ZoMcgqmQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  9 Feb 2023 09:18:51 +0200
Message-Id: <20230209071852.613102-4-idosch@nvidia.com>
In-Reply-To: <20230209071852.613102-1-idosch@nvidia.com>
References: <20230209071852.613102-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 3/4] bridge: mcast: Move validation to a
	policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Future patches are going to move parts of the bridge MDB code to the
common rtnetlink code in preparation for VXLAN MDB support. To
facilitate code sharing between both drivers, move the validation of the
top level attributes in RTM_{NEW,DEL}MDB messages to a policy that will
eventually be moved to the rtnetlink code.

Use 'NLA_NESTED' for 'MDBA_SET_ENTRY_ATTRS' instead of
NLA_POLICY_NESTED() as this attribute is going to be validated using
different policies in the underlying drivers.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 96f36febfb30..25c48d81a597 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -683,51 +683,58 @@ static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
 	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
 };
 
-static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
-			       struct netlink_ext_ack *extack)
+static int validate_mdb_entry(const struct nlattr *attr,
+			      struct netlink_ext_ack *extack)
 {
+	struct br_mdb_entry *entry = nla_data(attr);
+
+	if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid MDBA_SET_ENTRY attribute length");
+		return -EINVAL;
+	}
+
 	if (entry->ifindex == 0) {
 		NL_SET_ERR_MSG_MOD(extack, "Zero entry ifindex is not allowed");
-		return false;
+		return -EINVAL;
 	}
 
 	if (entry->addr.proto == htons(ETH_P_IP)) {
 		if (!ipv4_is_multicast(entry->addr.u.ip4)) {
 			NL_SET_ERR_MSG_MOD(extack, "IPv4 entry group address is not multicast");
-			return false;
+			return -EINVAL;
 		}
 		if (ipv4_is_local_multicast(entry->addr.u.ip4)) {
 			NL_SET_ERR_MSG_MOD(extack, "IPv4 entry group address is local multicast");
-			return false;
+			return -EINVAL;
 		}
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (entry->addr.proto == htons(ETH_P_IPV6)) {
 		if (ipv6_addr_is_ll_all_nodes(&entry->addr.u.ip6)) {
 			NL_SET_ERR_MSG_MOD(extack, "IPv6 entry group address is link-local all nodes");
-			return false;
+			return -EINVAL;
 		}
 #endif
 	} else if (entry->addr.proto == 0) {
 		/* L2 mdb */
 		if (!is_multicast_ether_addr(entry->addr.u.mac_addr)) {
 			NL_SET_ERR_MSG_MOD(extack, "L2 entry group is not multicast");
-			return false;
+			return -EINVAL;
 		}
 	} else {
 		NL_SET_ERR_MSG_MOD(extack, "Unknown entry protocol");
-		return false;
+		return -EINVAL;
 	}
 
 	if (entry->state != MDB_PERMANENT && entry->state != MDB_TEMPORARY) {
 		NL_SET_ERR_MSG_MOD(extack, "Unknown entry state");
-		return false;
+		return -EINVAL;
 	}
 	if (entry->vid >= VLAN_VID_MASK) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid entry VLAN id");
-		return false;
+		return -EINVAL;
 	}
 
-	return true;
+	return 0;
 }
 
 static bool is_valid_mdb_source(struct nlattr *attr, __be16 proto,
@@ -1292,6 +1299,14 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 	return 0;
 }
 
+static const struct nla_policy mdba_policy[MDBA_SET_ENTRY_MAX + 1] = {
+	[MDBA_SET_ENTRY_UNSPEC] = { .strict_start_type = MDBA_SET_ENTRY_ATTRS + 1 },
+	[MDBA_SET_ENTRY] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+						  validate_mdb_entry,
+						  sizeof(struct br_mdb_entry)),
+	[MDBA_SET_ENTRY_ATTRS] = { .type = NLA_NESTED },
+};
+
 static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
 			      struct br_mdb_config *cfg,
 			      struct netlink_ext_ack *extack)
@@ -1302,7 +1317,7 @@ static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
 	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*bpm), tb,
-				     MDBA_SET_ENTRY_MAX, NULL, extack);
+				     MDBA_SET_ENTRY_MAX, mdba_policy, extack);
 	if (err)
 		return err;
 
@@ -1344,14 +1359,8 @@ static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
 		NL_SET_ERR_MSG_MOD(extack, "Missing MDBA_SET_ENTRY attribute");
 		return -EINVAL;
 	}
-	if (nla_len(tb[MDBA_SET_ENTRY]) != sizeof(struct br_mdb_entry)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid MDBA_SET_ENTRY attribute length");
-		return -EINVAL;
-	}
 
 	cfg->entry = nla_data(tb[MDBA_SET_ENTRY]);
-	if (!is_valid_mdb_entry(cfg->entry, extack))
-		return -EINVAL;
 
 	if (cfg->entry->ifindex != cfg->br->dev->ifindex) {
 		struct net_device *pdev;
-- 
2.37.3

