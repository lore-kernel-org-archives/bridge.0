Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDDAA6107E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF1806108D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+0kRmhHrM1J6k63vIojFeJUG2oueNNbuC1r0sNFJx4=;
 b=e91SdAFIOzbH2Qaa5QW73kgBhZpcCuLZdifhrcHsedIejEp+8MPswlx/IK5XBdvFMYgn0qSfwsW40VeysRuFPXAM8dtCrklGMGuSANvWjENz1HHjP7aeozQX6P1l9zGhP8sp5q/2ZbO/8d2TBE+F8HYfr93hC2AnxVdqaEYvkRMUPd0q32kjURZ7HcswH7yKSxkS6IWBe4rZVH34gLmooPG04nNb03Isvhz4egbT6WUlDhulyUlduX/3ZG0QGck2D0x4UE4LkC6sPdQb6fuKz/anme6amq7j85KBymwgTbPH1uq5XSy0d6bhCIgh0inAAo0WLvCEQVYjUhPcCg31wQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:18 +0300
Message-Id: <20221018120420.561846-18-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 17/19] bridge: mcast: Allow user space
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
---
 include/uapi/linux/if_bridge.h |  20 +++++
 net/bridge/br_mdb.c            | 132 +++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

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
index 8fc8816a76bf..909b0fb49a0c 100644
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
@@ -1052,6 +1067,73 @@ static int __br_mdb_add(struct br_mdb_config *cfg,
 	return ret;
 }
 
+static int br_mdb_config_src_entry_init(struct nlattr *src_entry,
+					struct br_mdb_config *cfg,
+					struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[MDBE_SRCATTR_MAX + 1];
+	struct br_mdb_src_entry *src;
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
+	if (!is_valid_mdb_source(tb[MDBE_SRCATTR_ADDRESS],
+				 cfg->entry->addr.proto, extack))
+		return -EINVAL;
+
+	src = kzalloc(sizeof(*src), GFP_KERNEL);
+	if (!src)
+		return -ENOMEM;
+	src->addr.proto = cfg->entry->addr.proto;
+	nla_memcpy(&src->addr.src, tb[MDBE_SRCATTR_ADDRESS],
+		   nla_len(tb[MDBE_SRCATTR_ADDRESS]));
+	list_add_tail(&src->list, &cfg->src_list);
+
+	return 0;
+}
+
+static void br_mdb_config_src_entry_fini(struct br_mdb_src_entry *src)
+{
+	list_del(&src->list);
+	kfree(src);
+}
+
+static int br_mdb_config_src_list_init(struct nlattr *src_list,
+				       struct br_mdb_config *cfg,
+				       struct netlink_ext_ack *extack)
+{
+	struct br_mdb_src_entry *src, *tmp;
+	struct nlattr *src_entry;
+	int rem, err;
+
+	nla_for_each_nested(src_entry, src_list, rem) {
+		err = br_mdb_config_src_entry_init(src_entry, cfg, extack);
+		if (err)
+			goto err_src_entry_init;
+	}
+
+	return 0;
+
+err_src_entry_init:
+	list_for_each_entry_safe(src, tmp, &cfg->src_list, list)
+		br_mdb_config_src_entry_fini(src);
+	return err;
+}
+
+static void br_mdb_config_src_list_fini(struct br_mdb_config *cfg)
+{
+	struct br_mdb_src_entry *src, *tmp;
+
+	list_for_each_entry_safe(src, tmp, &cfg->src_list, list)
+		br_mdb_config_src_entry_fini(src);
+}
+
 static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 				    struct br_mdb_config *cfg,
 				    struct netlink_ext_ack *extack)
@@ -1071,9 +1153,52 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 
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
+	if (list_empty(&cfg->src_list) && cfg->filter_mode == MCAST_INCLUDE) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot add (*, G) INCLUDE with an empty source list");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
+static void br_mdb_config_attrs_fini(struct br_mdb_config *cfg)
+{
+	br_mdb_config_src_list_fini(cfg);
+}
+
 static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
 			      struct nlmsghdr *nlh, struct br_mdb_config *cfg,
 			      struct netlink_ext_ack *extack)
@@ -1164,6 +1289,11 @@ static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
 	return 0;
 }
 
+static void br_mdb_config_fini(struct br_mdb_config *cfg)
+{
+	br_mdb_config_attrs_fini(cfg);
+}
+
 static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
@@ -1222,6 +1352,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 out:
+	br_mdb_config_fini(&cfg);
 	return err;
 }
 
@@ -1297,6 +1428,7 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = __br_mdb_del(&cfg);
 	}
 
+	br_mdb_config_fini(&cfg);
 	return err;
 }
 
-- 
2.37.3

