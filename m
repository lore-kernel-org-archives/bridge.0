Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2267260E30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2172160E3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hogRoRe32ZEXLLI8cZNnSdtBjQxQi3l5i28H5Rj8VhQ=;
 b=YFCa974kZZCR1pUUza8ysIOd+Rz/5TgECoskE08r2hOrDT9MnD6htkXbc+yIGsrweBGA8fBmrWk5hsgSmIGxbiLe3rYBMF3mzY/YoubRpnNqT3GQ5U4LpP+5UK1KMusxhTt7Hs6WbTkKMjGht5FGgPRD9ajP1AwN1RmmQzBGmsntd7U0j9ZUhIWptowkpaR22NHqLo5QzozR7uMFEi3141TF1HOk8vZCZLrfwKNHSvKD+Yv9dmSlk+2qns7M96kisr7klbfIKN1xrMQPz4Nv5SwO1HOjekhoyZLD+QQLMkqtO260vhdy8+wKYGJGOOoLK6pZ3AwzgZH9A1Wh6R1Ytw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 15 Mar 2023 15:11:46 +0200
Message-Id: <20230315131155.4071175-3-idosch@nvidia.com>
In-Reply-To: <20230315131155.4071175-1-idosch@nvidia.com>
References: <20230315131155.4071175-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 02/11] bridge: mcast: Implement MDB net
	device operations
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

Implement the previously added MDB net device operations in the bridge
driver so that they could be invoked by core rtnetlink code in the next
patch.

The operations are identical to the existing br_mdb_{dump,add,del}
functions. The '_new' suffix will be removed in the next patch. The
functions are re-implemented in this patch to make the conversion in the
next patch easier to review.

Add dummy implementations when 'CONFIG_BRIDGE_IGMP_SNOOPING' is
disabled, so that an error will be returned to user space when it is
trying to add or delete an MDB entry. This is consistent with existing
behavior where the bridge driver does not even register rtnetlink
handlers for RTM_{NEW,DEL,GET}MDB messages when this Kconfig option is
disabled.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_device.c  |   3 +
 net/bridge/br_mdb.c     | 124 ++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h |  25 ++++++++
 3 files changed, 152 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index b82906fc999a..85fa4d73bb53 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -468,6 +468,9 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,
 	.ndo_fdb_dump		 = br_fdb_dump,
 	.ndo_fdb_get		 = br_fdb_get,
+	.ndo_mdb_add		 = br_mdb_add_new,
+	.ndo_mdb_del		 = br_mdb_del_new,
+	.ndo_mdb_dump		 = br_mdb_dump_new,
 	.ndo_bridge_getlink	 = br_getlink,
 	.ndo_bridge_setlink	 = br_setlink,
 	.ndo_bridge_dellink	 = br_dellink,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 25c48d81a597..cb8270a5480b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -458,6 +458,39 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+int br_mdb_dump_new(struct net_device *dev, struct sk_buff *skb,
+		    struct netlink_callback *cb)
+{
+	struct net_bridge *br = netdev_priv(dev);
+	struct br_port_msg *bpm;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			cb->nlh->nlmsg_seq, RTM_GETMDB, sizeof(*bpm),
+			NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	bpm = nlmsg_data(nlh);
+	memset(bpm, 0, sizeof(*bpm));
+	bpm->ifindex = dev->ifindex;
+
+	rcu_read_lock();
+
+	err = br_mdb_fill_info(skb, cb, dev);
+	if (err)
+		goto out;
+	err = br_rports_fill_info(skb, &br->multicast_ctx);
+	if (err)
+		goto out;
+
+out:
+	rcu_read_unlock();
+	nlmsg_end(skb, nlh);
+	return err;
+}
+
 static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
 				   struct net_device *dev,
 				   struct net_bridge_mdb_entry *mp,
@@ -1459,6 +1492,65 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+int br_mdb_add_new(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
+		   struct netlink_ext_ack *extack)
+{
+	struct net_bridge_vlan_group *vg;
+	struct br_mdb_config cfg = {};
+	struct net_bridge_vlan *v;
+	int err;
+
+	/* Configuration structure will be initialized here. */
+
+	err = -EINVAL;
+	/* host join errors which can happen before creating the group */
+	if (!cfg.p && !br_group_is_l2(&cfg.group)) {
+		/* don't allow any flags for host-joined IP groups */
+		if (cfg.entry->state) {
+			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
+			goto out;
+		}
+		if (!br_multicast_is_star_g(&cfg.group)) {
+			NL_SET_ERR_MSG_MOD(extack, "Groups with sources cannot be manually host joined");
+			goto out;
+		}
+	}
+
+	if (br_group_is_l2(&cfg.group) && cfg.entry->state != MDB_PERMANENT) {
+		NL_SET_ERR_MSG_MOD(extack, "Only permanent L2 entries allowed");
+		goto out;
+	}
+
+	if (cfg.p) {
+		if (cfg.p->state == BR_STATE_DISABLED && cfg.entry->state != MDB_PERMANENT) {
+			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
+			goto out;
+		}
+		vg = nbp_vlan_group(cfg.p);
+	} else {
+		vg = br_vlan_group(cfg.br);
+	}
+
+	/* If vlan filtering is enabled and VLAN is not specified
+	 * install mdb entry on all vlans configured on the port.
+	 */
+	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
+		list_for_each_entry(v, &vg->vlan_list, vlist) {
+			cfg.entry->vid = v->vid;
+			cfg.group.vid = v->vid;
+			err = __br_mdb_add(&cfg, extack);
+			if (err)
+				break;
+		}
+	} else {
+		err = __br_mdb_add(&cfg, extack);
+	}
+
+out:
+	br_mdb_config_fini(&cfg);
+	return err;
+}
+
 static int __br_mdb_del(const struct br_mdb_config *cfg)
 {
 	struct br_mdb_entry *entry = cfg->entry;
@@ -1535,6 +1627,38 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+int br_mdb_del_new(struct net_device *dev, struct nlattr *tb[],
+		   struct netlink_ext_ack *extack)
+{
+	struct net_bridge_vlan_group *vg;
+	struct br_mdb_config cfg = {};
+	struct net_bridge_vlan *v;
+	int err = 0;
+
+	/* Configuration structure will be initialized here. */
+
+	if (cfg.p)
+		vg = nbp_vlan_group(cfg.p);
+	else
+		vg = br_vlan_group(cfg.br);
+
+	/* If vlan filtering is enabled and VLAN is not specified
+	 * delete mdb entry on all vlans configured on the port.
+	 */
+	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
+		list_for_each_entry(v, &vg->vlan_list, vlist) {
+			cfg.entry->vid = v->vid;
+			cfg.group.vid = v->vid;
+			err = __br_mdb_del(&cfg);
+		}
+	} else {
+		err = __br_mdb_del(&cfg);
+	}
+
+	br_mdb_config_fini(&cfg);
+	return err;
+}
+
 void br_mdb_init(void)
 {
 	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_GETMDB, NULL, br_mdb_dump, 0);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index cef5f6ea850c..a72847c1dc9f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -981,6 +981,12 @@ void br_multicast_get_stats(const struct net_bridge *br,
 u32 br_multicast_ngroups_get(const struct net_bridge_mcast_port *pmctx);
 void br_multicast_ngroups_set_max(struct net_bridge_mcast_port *pmctx, u32 max);
 u32 br_multicast_ngroups_get_max(const struct net_bridge_mcast_port *pmctx);
+int br_mdb_add_new(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
+		   struct netlink_ext_ack *extack);
+int br_mdb_del_new(struct net_device *dev, struct nlattr *tb[],
+		   struct netlink_ext_ack *extack);
+int br_mdb_dump_new(struct net_device *dev, struct sk_buff *skb,
+		    struct netlink_callback *cb);
 void br_mdb_init(void);
 void br_mdb_uninit(void);
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
@@ -1374,6 +1380,25 @@ static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
 	return false;
 }
 
+static inline int br_mdb_add_new(struct net_device *dev, struct nlattr *tb[],
+				 u16 nlmsg_flags,
+				 struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int br_mdb_del_new(struct net_device *dev, struct nlattr *tb[],
+				 struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int br_mdb_dump_new(struct net_device *dev, struct sk_buff *skb,
+				  struct netlink_callback *cb)
+{
+	return 0;
+}
+
 static inline void br_mdb_init(void)
 {
 }
-- 
2.37.3

