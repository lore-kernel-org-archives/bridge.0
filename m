Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B602940948
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 765D240951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhzMinsOnZIvpFDMO8yvvMa57KGkV5CNRbqbQ+fgRsY=;
 b=fE8FaS+zZvwAi+9vBXMQtY3ow60gh+Gb2RMTkbOCvWLSLTCFVQ/tQ7VRa4NGB9SRs/NkNJhZHLZBidYZ4kd13p2gus8ZdvRya/JluZWKrXYb8jMU4Hbk86kfI7Uxp0/u42mULUB6KZu9k9jKyE7ZNOy14Hryk6VU6+slEaA+QsjKULX9aVpK8mliN5BbjQg5fqGZxegZ1b7Mn3OOIaBcVUNj3RApbeJCSKo7c1r/rvthRQT7WlHVurkyIETNjVOj6jzrQz0MgO5HG5ezVVFJGTVllUPb+hIJr6H1n58HcJFD8G6wNdteJqn2X/bWVDpaPybSq4947JkjSgBQ7PcR2A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  6 Dec 2022 12:58:01 +0200
Message-Id: <20221206105809.363767-2-idosch@nvidia.com>
In-Reply-To: <20221206105809.363767-1-idosch@nvidia.com>
References: <20221206105809.363767-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 1/9] bridge: mcast: Centralize netlink
	attribute parsing
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

Netlink attributes are currently passed deep in the MDB creation call
chain, making it difficult to add new attributes. In addition, some
validity checks are performed under the multicast lock although they can
be performed before it is ever acquired.

As a first step towards solving these issues, parse the RTM_{NEW,DEL}MDB
messages into a configuration structure, relieving other functions from
the need to handle raw netlink attributes.

Subsequent patches will convert the MDB code to use this configuration
structure.

This is consistent with how other rtnetlink objects are handled, such as
routes and nexthops.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Remove 'skb' argument from br_mdb_config_init()
    * Mark 'nlh' argument as 'const'.

 net/bridge/br_mdb.c     | 120 ++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h |   7 +++
 2 files changed, 127 insertions(+)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 321be94c445a..bd3a7d881d52 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -974,6 +974,116 @@ static int __br_mdb_add(struct net *net, struct net_bridge *br,
 	return ret;
 }
 
+static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
+				    struct br_mdb_config *cfg,
+				    struct netlink_ext_ack *extack)
+{
+	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(mdb_attrs, MDBE_ATTR_MAX, set_attrs,
+			       br_mdbe_attrs_pol, extack);
+	if (err)
+		return err;
+
+	if (mdb_attrs[MDBE_ATTR_SOURCE] &&
+	    !is_valid_mdb_source(mdb_attrs[MDBE_ATTR_SOURCE],
+				 cfg->entry->addr.proto, extack))
+		return -EINVAL;
+
+	__mdb_entry_to_br_ip(cfg->entry, &cfg->group, mdb_attrs);
+
+	return 0;
+}
+
+static int br_mdb_config_init(struct net *net, const struct nlmsghdr *nlh,
+			      struct br_mdb_config *cfg,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[MDBA_SET_ENTRY_MAX + 1];
+	struct br_port_msg *bpm;
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse_deprecated(nlh, sizeof(*bpm), tb,
+				     MDBA_SET_ENTRY_MAX, NULL, extack);
+	if (err)
+		return err;
+
+	memset(cfg, 0, sizeof(*cfg));
+
+	bpm = nlmsg_data(nlh);
+	if (!bpm->ifindex) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid bridge ifindex");
+		return -EINVAL;
+	}
+
+	dev = __dev_get_by_index(net, bpm->ifindex);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Bridge device doesn't exist");
+		return -ENODEV;
+	}
+
+	if (!netif_is_bridge_master(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device is not a bridge");
+		return -EOPNOTSUPP;
+	}
+
+	cfg->br = netdev_priv(dev);
+
+	if (!netif_running(cfg->br->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Bridge device is not running");
+		return -EINVAL;
+	}
+
+	if (!br_opt_get(cfg->br, BROPT_MULTICAST_ENABLED)) {
+		NL_SET_ERR_MSG_MOD(extack, "Bridge's multicast processing is disabled");
+		return -EINVAL;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, MDBA_SET_ENTRY)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing MDBA_SET_ENTRY attribute");
+		return -EINVAL;
+	}
+	if (nla_len(tb[MDBA_SET_ENTRY]) != sizeof(struct br_mdb_entry)) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid MDBA_SET_ENTRY attribute length");
+		return -EINVAL;
+	}
+
+	cfg->entry = nla_data(tb[MDBA_SET_ENTRY]);
+	if (!is_valid_mdb_entry(cfg->entry, extack))
+		return -EINVAL;
+
+	if (cfg->entry->ifindex != cfg->br->dev->ifindex) {
+		struct net_device *pdev;
+
+		pdev = __dev_get_by_index(net, cfg->entry->ifindex);
+		if (!pdev) {
+			NL_SET_ERR_MSG_MOD(extack, "Port net device doesn't exist");
+			return -ENODEV;
+		}
+
+		cfg->p = br_port_get_rtnl(pdev);
+		if (!cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "Net device is not a bridge port");
+			return -EINVAL;
+		}
+
+		if (cfg->p->br != cfg->br) {
+			NL_SET_ERR_MSG_MOD(extack, "Port belongs to a different bridge device");
+			return -EINVAL;
+		}
+	}
+
+	if (tb[MDBA_SET_ENTRY_ATTRS])
+		return br_mdb_config_attrs_init(tb[MDBA_SET_ENTRY_ATTRS], cfg,
+						extack);
+	else
+		__mdb_entry_to_br_ip(cfg->entry, &cfg->group, NULL);
+
+	return 0;
+}
+
 static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
@@ -984,9 +1094,14 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_device *dev, *pdev;
 	struct br_mdb_entry *entry;
 	struct net_bridge_vlan *v;
+	struct br_mdb_config cfg;
 	struct net_bridge *br;
 	int err;
 
+	err = br_mdb_config_init(net, nlh, &cfg, extack);
+	if (err)
+		return err;
+
 	err = br_mdb_parse(skb, nlh, &dev, &entry, mdb_attrs, extack);
 	if (err < 0)
 		return err;
@@ -1101,9 +1216,14 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_device *dev, *pdev;
 	struct br_mdb_entry *entry;
 	struct net_bridge_vlan *v;
+	struct br_mdb_config cfg;
 	struct net_bridge *br;
 	int err;
 
+	err = br_mdb_config_init(net, nlh, &cfg, extack);
+	if (err)
+		return err;
+
 	err = br_mdb_parse(skb, nlh, &dev, &entry, mdb_attrs, extack);
 	if (err < 0)
 		return err;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4c4fda930068..0a09f10966dc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -92,6 +92,13 @@ struct bridge_mcast_stats {
 	struct br_mcast_stats mstats;
 	struct u64_stats_sync syncp;
 };
+
+struct br_mdb_config {
+	struct net_bridge		*br;
+	struct net_bridge_port		*p;
+	struct br_mdb_entry		*entry;
+	struct br_ip			group;
+};
 #endif
 
 /* net_bridge_mcast_port must be always defined due to forwarding stubs */
-- 
2.37.3

