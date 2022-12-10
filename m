Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3D4B415A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 381704159F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prt3U8OQ1/aCcOV92KzZD0IF4LtS8oQDmLJTpiae5qI=;
 b=DsJ3Z9tx4jEen5KtN8+aqtaLQ712+DSRZIhDCPJLzKJG8FTKUitnfiqrShIF2ivNMjR8EXt62WjLzTIWZt1rdDRHjV0Pmf2oTyYnd+fmCRnUugGoBdc0zJtcqr1ZdBfCqLT59qFwXS6cS504tWAEmnzUTo931Vme7VqTeL1ZEp43w5OxeGvbLREcewXLiCQuzN24Fd5BA5w8gAW+eKqZ9vKVXcIdOl7LNzUnSEyi+DZQ3ezedxXERP8ASQ8ZVyAatPu1dOz0mzoxZct/EzUDFgqaBapZDAM1H5vvckeIXGJZtsVQ0oQUeVQFzjBouxVfvKifLPBhxOTOY8/dx4OjGw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat, 10 Dec 2022 16:56:29 +0200
Message-Id: <20221210145633.1328511-11-idosch@nvidia.com>
In-Reply-To: <20221210145633.1328511-1-idosch@nvidia.com>
References: <20221210145633.1328511-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 10/14] bridge: mcast: Allow user space
	to add (*, G) with a source list and filter mode
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

Add new netlink attributes to the RTM_NEWMDB request that allow user
space to add (*, G) with a source list and filter mode.

The RTM_NEWMDB message can already dump such entries (created by the
kernel) so there is no need to add dump support. However, the message
contains a different set of attributes depending if it is a request or a
response. The naming and structure of the new attributes try to follow
the existing ones used in the response.

Request:

[ struct nlmsghdr ]
[ struct br_port_msg ]
[ MDBA_SET_ENTRY ]
	struct br_mdb_entry
[ MDBA_SET_ENTRY_ATTRS ]
	[ MDBE_ATTR_SOURCE ]
		struct in_addr / struct in6_addr
	[ MDBE_ATTR_SRC_LIST ]		// new
		[ MDBE_SRC_LIST_ENTRY ]
			[ MDBE_SRCATTR_ADDRESS ]
				struct in_addr / struct in6_addr
		[ ...]
	[ MDBE_ATTR_GROUP_MODE ]	// new
		u8

Response:

[ struct nlmsghdr ]
[ struct br_port_msg ]
[ MDBA_MDB ]
	[ MDBA_MDB_ENTRY ]
		[ MDBA_MDB_ENTRY_INFO ]
			struct br_mdb_entry
		[ MDBA_MDB_EATTR_TIMER ]
			u32
		[ MDBA_MDB_EATTR_SOURCE ]
			struct in_addr / struct in6_addr
		[ MDBA_MDB_EATTR_RTPROT ]
			u8
		[ MDBA_MDB_EATTR_SRC_LIST ]
			[ MDBA_MDB_SRCLIST_ENTRY ]
				[ MDBA_MDB_SRCATTR_ADDRESS ]
					struct in_addr / struct in6_addr
				[ MDBA_MDB_SRCATTR_TIMER ]
					u8
			[...]
		[ MDBA_MDB_EATTR_GROUP_MODE ]
			u8

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v1:
    * Use an array instead of list to store source entries.
    * Drop br_mdb_config_attrs_fini().

 include/uapi/linux/if_bridge.h |  20 +++++
 net/bridge/br_mdb.c            | 130 +++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index a86a7e7b811f..0d9fe73fc48c 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -723,10 +723,30 @@ enum {
 enum {
 	MDBE_ATTR_UNSPEC,
 	MDBE_ATTR_SOURCE,
+	MDBE_ATTR_SRC_LIST,
+	MDBE_ATTR_GROUP_MODE,
 	__MDBE_ATTR_MAX,
 };
 #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
 
+/* per mdb entry source */
+enum {
+	MDBE_SRC_LIST_UNSPEC,
+	MDBE_SRC_LIST_ENTRY,
+	__MDBE_SRC_LIST_MAX,
+};
+#define MDBE_SRC_LIST_MAX (__MDBE_SRC_LIST_MAX - 1)
+
+/* per mdb entry per source attributes
+ * these are embedded in MDBE_SRC_LIST_ENTRY
+ */
+enum {
+	MDBE_SRCATTR_UNSPEC,
+	MDBE_SRCATTR_ADDRESS,
+	__MDBE_SRCATTR_MAX,
+};
+#define MDBE_SRCATTR_MAX (__MDBE_SRCATTR_MAX - 1)
+
 /* Embedded inside LINK_XSTATS_TYPE_BRIDGE */
 enum {
 	BRIDGE_XSTATS_UNSPEC,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index e9a4b7e247e7..61d46b0a31b6 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -663,10 +663,25 @@ void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
 	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
 }
 
+static const struct nla_policy
+br_mdbe_src_list_entry_pol[MDBE_SRCATTR_MAX + 1] = {
+	[MDBE_SRCATTR_ADDRESS] = NLA_POLICY_RANGE(NLA_BINARY,
+						  sizeof(struct in_addr),
+						  sizeof(struct in6_addr)),
+};
+
+static const struct nla_policy
+br_mdbe_src_list_pol[MDBE_SRC_LIST_MAX + 1] = {
+	[MDBE_SRC_LIST_ENTRY] = NLA_POLICY_NESTED(br_mdbe_src_list_entry_pol),
+};
+
 static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
 	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
 					      sizeof(struct in_addr),
 					      sizeof(struct in6_addr)),
+	[MDBE_ATTR_GROUP_MODE] = NLA_POLICY_RANGE(NLA_U8, MCAST_EXCLUDE,
+						  MCAST_INCLUDE),
+	[MDBE_ATTR_SRC_LIST] = NLA_POLICY_NESTED(br_mdbe_src_list_pol),
 };
 
 static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
@@ -1051,6 +1066,76 @@ static int __br_mdb_add(const struct br_mdb_config *cfg,
 	return ret;
 }
 
+static int br_mdb_config_src_entry_init(struct nlattr *src_entry,
+					struct br_mdb_src_entry *src,
+					__be16 proto,
+					struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[MDBE_SRCATTR_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, MDBE_SRCATTR_MAX, src_entry,
+			       br_mdbe_src_list_entry_pol, extack);
+	if (err)
+		return err;
+
+	if (NL_REQ_ATTR_CHECK(extack, src_entry, tb, MDBE_SRCATTR_ADDRESS))
+		return -EINVAL;
+
+	if (!is_valid_mdb_source(tb[MDBE_SRCATTR_ADDRESS], proto, extack))
+		return -EINVAL;
+
+	src->addr.proto = proto;
+	nla_memcpy(&src->addr.src, tb[MDBE_SRCATTR_ADDRESS],
+		   nla_len(tb[MDBE_SRCATTR_ADDRESS]));
+
+	return 0;
+}
+
+static int br_mdb_config_src_list_init(struct nlattr *src_list,
+				       struct br_mdb_config *cfg,
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *src_entry;
+	int rem, err;
+	int i = 0;
+
+	nla_for_each_nested(src_entry, src_list, rem)
+		cfg->num_src_entries++;
+
+	if (cfg->num_src_entries >= PG_SRC_ENT_LIMIT) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Exceeded maximum number of source entries (%u)",
+				       PG_SRC_ENT_LIMIT - 1);
+		return -EINVAL;
+	}
+
+	cfg->src_entries = kcalloc(cfg->num_src_entries,
+				   sizeof(struct br_mdb_src_entry), GFP_KERNEL);
+	if (!cfg->src_entries)
+		return -ENOMEM;
+
+	nla_for_each_nested(src_entry, src_list, rem) {
+		err = br_mdb_config_src_entry_init(src_entry,
+						   &cfg->src_entries[i],
+						   cfg->entry->addr.proto,
+						   extack);
+		if (err)
+			goto err_src_entry_init;
+		i++;
+	}
+
+	return 0;
+
+err_src_entry_init:
+	kfree(cfg->src_entries);
+	return err;
+}
+
+static void br_mdb_config_src_list_fini(struct br_mdb_config *cfg)
+{
+	kfree(cfg->src_entries);
+}
+
 static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 				    struct br_mdb_config *cfg,
 				    struct netlink_ext_ack *extack)
@@ -1070,6 +1155,44 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 
 	__mdb_entry_to_br_ip(cfg->entry, &cfg->group, mdb_attrs);
 
+	if (mdb_attrs[MDBE_ATTR_GROUP_MODE]) {
+		if (!cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "Filter mode cannot be set for host groups");
+			return -EINVAL;
+		}
+		if (!br_multicast_is_star_g(&cfg->group)) {
+			NL_SET_ERR_MSG_MOD(extack, "Filter mode can only be set for (*, G) entries");
+			return -EINVAL;
+		}
+		cfg->filter_mode = nla_get_u8(mdb_attrs[MDBE_ATTR_GROUP_MODE]);
+	} else {
+		cfg->filter_mode = MCAST_EXCLUDE;
+	}
+
+	if (mdb_attrs[MDBE_ATTR_SRC_LIST]) {
+		if (!cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "Source list cannot be set for host groups");
+			return -EINVAL;
+		}
+		if (!br_multicast_is_star_g(&cfg->group)) {
+			NL_SET_ERR_MSG_MOD(extack, "Source list can only be set for (*, G) entries");
+			return -EINVAL;
+		}
+		if (!mdb_attrs[MDBE_ATTR_GROUP_MODE]) {
+			NL_SET_ERR_MSG_MOD(extack, "Source list cannot be set without filter mode");
+			return -EINVAL;
+		}
+		err = br_mdb_config_src_list_init(mdb_attrs[MDBE_ATTR_SRC_LIST],
+						  cfg, extack);
+		if (err)
+			return err;
+	}
+
+	if (!cfg->num_src_entries && cfg->filter_mode == MCAST_INCLUDE) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot add (*, G) INCLUDE with an empty source list");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1162,6 +1285,11 @@ static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
 	return 0;
 }
 
+static void br_mdb_config_fini(struct br_mdb_config *cfg)
+{
+	br_mdb_config_src_list_fini(cfg);
+}
+
 static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
@@ -1220,6 +1348,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 out:
+	br_mdb_config_fini(&cfg);
 	return err;
 }
 
@@ -1295,6 +1424,7 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = __br_mdb_del(&cfg);
 	}
 
+	br_mdb_config_fini(&cfg);
 	return err;
 }
 
-- 
2.37.3

