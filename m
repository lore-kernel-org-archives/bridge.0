Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53D9082086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E2AA8206A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm2ovCickvnFXCstWja+Dw+7KeSdnFnGAV1e0dRnnTk=;
 b=POhQMAWiOh6k1lQLLYeFgL0CAMcU6BCIPZpAHdJDEj2qym2CC+3CRyl5r83IKnX0OE5PSBTM2eXqYBKcLY0LPJEtEavR3N/A35FEBmhq4wkdGq444AqvKoV0TCAYVGra88DCyy30k6jDh58VLl2WKTM+QhmAc9MSAP2VuJ+nbKQL/iDusCrUol+VY327Ed/dNjqoQ+x2JY2IUQR09/NDJPnTzdmyameXMUnxWFM5sWI+9tMD2J1123cd1/300/M2pDOOM/Lenx8n/ns/hJtbH79B/yOpHq6ZZwksH9O5DDAnYo0RfFFZc6qpJfK4a4BfibRedMGM98ZcXe4f4dg42g==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:07:51 +0200
Message-Id: <20230204170801.3897900-4-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 03/13] bridge: mcast: Move validation
	to a policy
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

Subsequent patches are going to move parts of the bridge MDB code to the
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
index e40a4c275d63..b1ece209cfca 100644
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
@@ -1295,6 +1302,14 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
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
@@ -1305,7 +1320,7 @@ static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
 	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*bpm), tb,
-				     MDBA_SET_ENTRY_MAX, NULL, extack);
+				     MDBA_SET_ENTRY_MAX, mdba_policy, extack);
 	if (err)
 		return err;
 
@@ -1347,14 +1362,8 @@ static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
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

