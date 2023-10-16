Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CED7082156
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C25DC820EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwGvxzFaRNUgq/+3HyNi1CY3UXPyoqzFSQ7rdYIziUQ=;
 b=kL0gYPtDaEJJY5JSz/GDuzJnTrJ2H1xCV6QwtlyaBy8BH1O5MibxSzZSYKTxeu80BD5KD8hXLuKQSH53kvdexFctlPnDmI1SKOk7NMq0NSLPxES7stVlzolniqjqNMVpDoQ7YieR6lva+LuRRfWSJ+MUZZuIhQGmeZbP4iINsmVcB2jmPoMmqo6O8SboQD4ogAxVD8HFfq/YVkVkSK01KmaKoQ0OHTPu9YiR72tRnN3JcmfpEeX47ZLGRbOnqlwX5I28lQXzGG2/dZlUuKOkS7LqMfPv7JxuZcA/YOIfVZMnj4nfhNw/G9Fh/17WXURGIrAw87Yz8SzQnxIL1ThOFw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:56 +0300
Message-ID: <20231016131259.3302298-11-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 10/13] vxlan: mdb: Add MDB get support
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

Implement support for MDB get operation by looking up a matching MDB
entry, allocating the skb according to the entry's size and then filling
in the response.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    |   1 +
 drivers/net/vxlan/vxlan_mdb.c     | 150 ++++++++++++++++++++++++++++++
 drivers/net/vxlan/vxlan_private.h |   2 +
 3 files changed, 153 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6f7d45e3cfa2..7ed19f2cf6f5 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3302,6 +3302,7 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_mdb_add		= vxlan_mdb_add,
 	.ndo_mdb_del		= vxlan_mdb_del,
 	.ndo_mdb_dump		= vxlan_mdb_dump,
+	.ndo_mdb_get		= vxlan_mdb_get,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
 };
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 19640f7e3a88..e472fd67fc2e 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1306,6 +1306,156 @@ int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
+static const struct nla_policy vxlan_mdbe_attrs_get_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
+					      sizeof(struct in_addr),
+					      sizeof(struct in6_addr)),
+	[MDBE_ATTR_SRC_VNI] = NLA_POLICY_FULL_RANGE(NLA_U32, &vni_range),
+};
+
+static int vxlan_mdb_get_parse(struct net_device *dev, struct nlattr *tb[],
+			       struct vxlan_mdb_entry_key *group,
+			       struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(tb[MDBA_GET_ENTRY]);
+	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err;
+
+	memset(group, 0, sizeof(*group));
+	group->vni = vxlan->default_dst.remote_vni;
+
+	if (!tb[MDBA_GET_ENTRY_ATTRS]) {
+		vxlan_mdb_group_set(group, entry, NULL);
+		return 0;
+	}
+
+	err = nla_parse_nested(mdbe_attrs, MDBE_ATTR_MAX,
+			       tb[MDBA_GET_ENTRY_ATTRS],
+			       vxlan_mdbe_attrs_get_pol, extack);
+	if (err)
+		return err;
+
+	if (mdbe_attrs[MDBE_ATTR_SOURCE] &&
+	    !vxlan_mdb_is_valid_source(mdbe_attrs[MDBE_ATTR_SOURCE],
+				       entry->addr.proto, extack))
+		return -EINVAL;
+
+	vxlan_mdb_group_set(group, entry, mdbe_attrs[MDBE_ATTR_SOURCE]);
+
+	if (mdbe_attrs[MDBE_ATTR_SRC_VNI])
+		group->vni =
+			cpu_to_be32(nla_get_u32(mdbe_attrs[MDBE_ATTR_SRC_VNI]));
+
+	return 0;
+}
+
+static struct sk_buff *
+vxlan_mdb_get_reply_alloc(const struct vxlan_dev *vxlan,
+			  const struct vxlan_mdb_entry *mdb_entry)
+{
+	struct vxlan_mdb_remote *remote;
+	size_t nlmsg_size;
+
+	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+		     /* MDBA_MDB */
+		     nla_total_size(0) +
+		     /* MDBA_MDB_ENTRY */
+		     nla_total_size(0);
+
+	list_for_each_entry(remote, &mdb_entry->remotes, list)
+		nlmsg_size += vxlan_mdb_nlmsg_remote_size(vxlan, mdb_entry,
+							  remote);
+
+	return nlmsg_new(nlmsg_size, GFP_KERNEL);
+}
+
+static int
+vxlan_mdb_get_reply_fill(const struct vxlan_dev *vxlan,
+			 struct sk_buff *skb,
+			 const struct vxlan_mdb_entry *mdb_entry,
+			 u32 portid, u32 seq)
+{
+	struct nlattr *mdb_nest, *mdb_entry_nest;
+	struct vxlan_mdb_remote *remote;
+	struct br_port_msg *bpm;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = nlmsg_put(skb, portid, seq, RTM_NEWMDB, sizeof(*bpm), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	bpm = nlmsg_data(nlh);
+	memset(bpm, 0, sizeof(*bpm));
+	bpm->family  = AF_BRIDGE;
+	bpm->ifindex = vxlan->dev->ifindex;
+	mdb_nest = nla_nest_start_noflag(skb, MDBA_MDB);
+	if (!mdb_nest) {
+		err = -EMSGSIZE;
+		goto cancel;
+	}
+	mdb_entry_nest = nla_nest_start_noflag(skb, MDBA_MDB_ENTRY);
+	if (!mdb_entry_nest) {
+		err = -EMSGSIZE;
+		goto cancel;
+	}
+
+	list_for_each_entry(remote, &mdb_entry->remotes, list) {
+		err = vxlan_mdb_entry_info_fill(vxlan, skb, mdb_entry, remote);
+		if (err)
+			goto cancel;
+	}
+
+	nla_nest_end(skb, mdb_entry_nest);
+	nla_nest_end(skb, mdb_nest);
+	nlmsg_end(skb, nlh);
+
+	return 0;
+
+cancel:
+	nlmsg_cancel(skb, nlh);
+	return err;
+}
+
+int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
+		  u32 seq, struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_mdb_entry *mdb_entry;
+	struct vxlan_mdb_entry_key group;
+	struct sk_buff *skb;
+	int err;
+
+	ASSERT_RTNL();
+
+	err = vxlan_mdb_get_parse(dev, tb, &group, extack);
+	if (err)
+		return err;
+
+	mdb_entry = vxlan_mdb_entry_lookup(vxlan, &group);
+	if (!mdb_entry) {
+		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
+		return -ENOENT;
+	}
+
+	skb = vxlan_mdb_get_reply_alloc(vxlan, mdb_entry);
+	if (!skb)
+		return -ENOMEM;
+
+	err = vxlan_mdb_get_reply_fill(vxlan, skb, mdb_entry, portid, seq);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
+		goto free;
+	}
+
+	return rtnl_unicast(skb, dev_net(dev), portid);
+
+free:
+	kfree_skb(skb);
+	return err;
+}
+
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 						struct sk_buff *skb,
 						__be32 src_vni)
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 817fa3075842..db679c380955 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -235,6 +235,8 @@ int vxlan_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 		  struct netlink_ext_ack *extack);
 int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 		  struct netlink_ext_ack *extack);
+int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
+		  u32 seq, struct netlink_ext_ack *extack);
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 						struct sk_buff *skb,
 						__be32 src_vni);
-- 
2.40.1

