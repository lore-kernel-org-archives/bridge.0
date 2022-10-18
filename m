Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30F646107E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E07761080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RAJY2CjoYY05o8YbqzrUXnRhRr9qjw5s82Fb6RBkow=;
 b=H90f3bk8PnqTIiDyztv1/2S8pASZVA50UmdgwUwj0xTKwsVyh5IYnMPgp5ozwDyLksv3zSBf1qsZQLirGjFI7bm/9skZunDXY8BwYY4rXvljbdWChikhlRsDH6cPHM2PnyVTUh/FQuKsSpIZxZ0mfE3IzpBCtm0nne3FNjdwC7onOUduWkikqUCUL6yhrO0EZ/JU8lyeyalbMd3sWp42IsMU+ZoYweFdLaItpyNOuvVatoFD9ppPnoDAraKFq6SqftVyArlbWQb43PL15QeRAwZffvx56HDmmTsO1X9q2J1jyWdeTwjDjPS2Lcq3UA5rCaTqRiy71pFZXqyyZLWGJw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:07 +0300
Message-Id: <20221018120420.561846-7-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 06/19] bridge: mcast: Remove
	br_mdb_parse()
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

The parsing of the netlink messages and the validity checks are now
performed in br_mdb_config_init() so we can remove br_mdb_parse().

This finally allows us to stop passing netlink attributes deep in the
MDB control path and only use the MDB configuration structure.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 93 +++------------------------------------------
 1 file changed, 5 insertions(+), 88 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index cb4fd27f118f..67b6bc7272d3 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -754,73 +754,6 @@ static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
 					      sizeof(struct in6_addr)),
 };
 
-static int br_mdb_parse(struct sk_buff *skb, struct nlmsghdr *nlh,
-			struct net_device **pdev, struct br_mdb_entry **pentry,
-			struct nlattr **mdb_attrs, struct netlink_ext_ack *extack)
-{
-	struct net *net = sock_net(skb->sk);
-	struct br_mdb_entry *entry;
-	struct br_port_msg *bpm;
-	struct nlattr *tb[MDBA_SET_ENTRY_MAX+1];
-	struct net_device *dev;
-	int err;
-
-	err = nlmsg_parse_deprecated(nlh, sizeof(*bpm), tb,
-				     MDBA_SET_ENTRY_MAX, NULL, NULL);
-	if (err < 0)
-		return err;
-
-	bpm = nlmsg_data(nlh);
-	if (bpm->ifindex == 0) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid bridge ifindex");
-		return -EINVAL;
-	}
-
-	dev = __dev_get_by_index(net, bpm->ifindex);
-	if (dev == NULL) {
-		NL_SET_ERR_MSG_MOD(extack, "Bridge device doesn't exist");
-		return -ENODEV;
-	}
-
-	if (!netif_is_bridge_master(dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device is not a bridge");
-		return -EOPNOTSUPP;
-	}
-
-	*pdev = dev;
-
-	if (!tb[MDBA_SET_ENTRY]) {
-		NL_SET_ERR_MSG_MOD(extack, "Missing MDBA_SET_ENTRY attribute");
-		return -EINVAL;
-	}
-	if (nla_len(tb[MDBA_SET_ENTRY]) != sizeof(struct br_mdb_entry)) {
-		NL_SET_ERR_MSG_MOD(extack, "Invalid MDBA_SET_ENTRY attribute length");
-		return -EINVAL;
-	}
-
-	entry = nla_data(tb[MDBA_SET_ENTRY]);
-	if (!is_valid_mdb_entry(entry, extack))
-		return -EINVAL;
-	*pentry = entry;
-
-	if (tb[MDBA_SET_ENTRY_ATTRS]) {
-		err = nla_parse_nested(mdb_attrs, MDBE_ATTR_MAX,
-				       tb[MDBA_SET_ENTRY_ATTRS],
-				       br_mdbe_attrs_pol, extack);
-		if (err)
-			return err;
-		if (mdb_attrs[MDBE_ATTR_SOURCE] &&
-		    !is_valid_mdb_source(mdb_attrs[MDBE_ATTR_SOURCE],
-					 entry->addr.proto, extack))
-			return -EINVAL;
-	} else {
-		memset(mdb_attrs, 0,
-		       sizeof(struct nlattr *) * (MDBE_ATTR_MAX + 1));
-	}
-
-	return 0;
-}
-
 static struct net_bridge_mcast *
 __br_mdb_choose_context(struct net_bridge *br,
 			const struct br_mdb_entry *entry,
@@ -959,7 +892,6 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 }
 
 static int __br_mdb_add(struct br_mdb_config *cfg,
-			struct nlattr **mdb_attrs,
 			struct netlink_ext_ack *extack)
 {
 	int ret;
@@ -1084,23 +1016,16 @@ static int br_mdb_config_init(struct net *net, struct sk_buff *skb,
 static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
-	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct net_bridge_vlan_group *vg;
-	struct br_mdb_entry *entry;
 	struct net_bridge_vlan *v;
 	struct br_mdb_config cfg;
-	struct net_device *dev;
 	int err;
 
 	err = br_mdb_config_init(net, skb, nlh, &cfg, extack);
 	if (err)
 		return err;
 
-	err = br_mdb_parse(skb, nlh, &dev, &entry, mdb_attrs, extack);
-	if (err < 0)
-		return err;
-
 	if (cfg.p) {
 		if (cfg.p->state == BR_STATE_DISABLED && cfg.entry->state != MDB_PERMANENT) {
 			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
@@ -1118,19 +1043,18 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			cfg.entry->vid = v->vid;
 			cfg.group.vid = v->vid;
-			err = __br_mdb_add(&cfg, mdb_attrs, extack);
+			err = __br_mdb_add(&cfg, extack);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_add(&cfg, mdb_attrs, extack);
+		err = __br_mdb_add(&cfg, extack);
 	}
 
 	return err;
 }
 
-static int __br_mdb_del(struct br_mdb_config *cfg,
-			struct nlattr **mdb_attrs)
+static int __br_mdb_del(struct br_mdb_config *cfg)
 {
 	struct br_mdb_entry *entry = cfg->entry;
 	struct net_bridge *br = cfg->br;
@@ -1174,23 +1098,16 @@ static int __br_mdb_del(struct br_mdb_config *cfg,
 static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
-	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct net_bridge_vlan_group *vg;
-	struct br_mdb_entry *entry;
 	struct net_bridge_vlan *v;
 	struct br_mdb_config cfg;
-	struct net_device *dev;
 	int err;
 
 	err = br_mdb_config_init(net, skb, nlh, &cfg, extack);
 	if (err)
 		return err;
 
-	err = br_mdb_parse(skb, nlh, &dev, &entry, mdb_attrs, extack);
-	if (err < 0)
-		return err;
-
 	if (cfg.p)
 		vg = nbp_vlan_group(cfg.p);
 	else
@@ -1203,10 +1120,10 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			cfg.entry->vid = v->vid;
 			cfg.group.vid = v->vid;
-			err = __br_mdb_del(&cfg, mdb_attrs);
+			err = __br_mdb_del(&cfg);
 		}
 	} else {
-		err = __br_mdb_del(&cfg, mdb_attrs);
+		err = __br_mdb_del(&cfg);
 	}
 
 	return err;
-- 
2.37.3

