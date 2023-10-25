Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D01D43647
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BFF843645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMc1576cnOAMBc207fObNT5qpR1AE3RoUwTUK2WaTg0=;
 b=M/Vmma80v/2Pf1MvpjyJxwJc2KMk32/bjxOx7qXqml0Fm4m2mTezSgMJlXcDfjBkO1s6lAqLM4xTXNnzuxqWG5j4o0iNuUcf3URsJz5gyIlFggGZBSgFMMODLIqQPuUdAgUKm8NT+VBFbKSIUJgCIjVvimdPHDe0ShSTzq6JhtXHrl78gKamCzTYjOpy5eljOqf7JHO4SFXugRHGhZK7PjA/W2sESQddfHc/ZWdH6YiCDnYQTOjjO5M7Ro5cx1YoN2CBNbQpDckiqLcWUNFejeTpylDzqLrpfj1ODpnBPkm64x/jwJUW8rKga9MMJ96MGkulxX8W3qQwutoFbAmZRg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:16 +0300
Message-ID: <20231025123020.788710-10-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 09/13] bridge: mcast: Add MDB get
	support
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
in the response. The operation is performed under the bridge multicast
lock to ensure that the entry does not change between the time the reply
size is determined and when the reply is filled in.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Add a comment above spin_lock_bh().

 net/bridge/br_device.c  |   1 +
 net/bridge/br_mdb.c     | 158 ++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h |   9 +++
 3 files changed, 168 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index d624710b384a..8f40de3af154 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -472,6 +472,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_mdb_add		 = br_mdb_add,
 	.ndo_mdb_del		 = br_mdb_del,
 	.ndo_mdb_dump		 = br_mdb_dump,
+	.ndo_mdb_get		 = br_mdb_get,
 	.ndo_bridge_getlink	 = br_getlink,
 	.ndo_bridge_setlink	 = br_setlink,
 	.ndo_bridge_dellink	 = br_dellink,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 42983f6a0abd..8cc526067bc2 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1411,3 +1411,161 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	br_mdb_config_fini(&cfg);
 	return err;
 }
+
+static const struct nla_policy br_mdbe_attrs_get_pol[MDBE_ATTR_MAX + 1] = {
+	[MDBE_ATTR_SOURCE] = NLA_POLICY_RANGE(NLA_BINARY,
+					      sizeof(struct in_addr),
+					      sizeof(struct in6_addr)),
+};
+
+static int br_mdb_get_parse(struct net_device *dev, struct nlattr *tb[],
+			    struct br_ip *group, struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(tb[MDBA_GET_ENTRY]);
+	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	int err;
+
+	if (!tb[MDBA_GET_ENTRY_ATTRS]) {
+		__mdb_entry_to_br_ip(entry, group, NULL);
+		return 0;
+	}
+
+	err = nla_parse_nested(mdbe_attrs, MDBE_ATTR_MAX,
+			       tb[MDBA_GET_ENTRY_ATTRS], br_mdbe_attrs_get_pol,
+			       extack);
+	if (err)
+		return err;
+
+	if (mdbe_attrs[MDBE_ATTR_SOURCE] &&
+	    !is_valid_mdb_source(mdbe_attrs[MDBE_ATTR_SOURCE],
+				 entry->addr.proto, extack))
+		return -EINVAL;
+
+	__mdb_entry_to_br_ip(entry, group, mdbe_attrs);
+
+	return 0;
+}
+
+static struct sk_buff *
+br_mdb_get_reply_alloc(const struct net_bridge_mdb_entry *mp)
+{
+	struct net_bridge_port_group *pg;
+	size_t nlmsg_size;
+
+	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+		     /* MDBA_MDB */
+		     nla_total_size(0) +
+		     /* MDBA_MDB_ENTRY */
+		     nla_total_size(0);
+
+	if (mp->host_joined)
+		nlmsg_size += rtnl_mdb_nlmsg_pg_size(NULL);
+
+	for (pg = mlock_dereference(mp->ports, mp->br); pg;
+	     pg = mlock_dereference(pg->next, mp->br))
+		nlmsg_size += rtnl_mdb_nlmsg_pg_size(pg);
+
+	return nlmsg_new(nlmsg_size, GFP_ATOMIC);
+}
+
+static int br_mdb_get_reply_fill(struct sk_buff *skb,
+				 struct net_bridge_mdb_entry *mp, u32 portid,
+				 u32 seq)
+{
+	struct nlattr *mdb_nest, *mdb_entry_nest;
+	struct net_bridge_port_group *pg;
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
+	bpm->ifindex = mp->br->dev->ifindex;
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
+	if (mp->host_joined) {
+		err = __mdb_fill_info(skb, mp, NULL);
+		if (err)
+			goto cancel;
+	}
+
+	for (pg = mlock_dereference(mp->ports, mp->br); pg;
+	     pg = mlock_dereference(pg->next, mp->br)) {
+		err = __mdb_fill_info(skb, mp, pg);
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
+int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
+	       struct netlink_ext_ack *extack)
+{
+	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge_mdb_entry *mp;
+	struct sk_buff *skb;
+	struct br_ip group;
+	int err;
+
+	err = br_mdb_get_parse(dev, tb, &group, extack);
+	if (err)
+		return err;
+
+	/* Hold the multicast lock to ensure that the MDB entry does not change
+	 * between the time the reply size is determined and when the reply is
+	 * filled in.
+	 */
+	spin_lock_bh(&br->multicast_lock);
+
+	mp = br_mdb_ip_get(br, &group);
+	if (!mp) {
+		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
+		err = -ENOENT;
+		goto unlock;
+	}
+
+	skb = br_mdb_get_reply_alloc(mp);
+	if (!skb) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
+		goto free;
+	}
+
+	spin_unlock_bh(&br->multicast_lock);
+
+	return rtnl_unicast(skb, dev_net(dev), portid);
+
+free:
+	kfree_skb(skb);
+unlock:
+	spin_unlock_bh(&br->multicast_lock);
+	return err;
+}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 40bbcd9f63b5..6b7f36769d03 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1022,6 +1022,8 @@ int br_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	       struct netlink_ext_ack *extack);
 int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 		struct netlink_callback *cb);
+int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
+	       struct netlink_ext_ack *extack);
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
 			    struct net_bridge_mdb_entry *mp, bool notify);
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify);
@@ -1432,6 +1434,13 @@ static inline int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+static inline int br_mdb_get(struct net_device *dev, struct nlattr *tb[],
+			     u32 portid, u32 seq,
+			     struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int br_mdb_hash_init(struct net_bridge *br)
 {
 	return 0;
-- 
2.40.1

