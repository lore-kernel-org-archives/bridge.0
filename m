Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCAB040B22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EFAC40B15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yja9VsLnagC72ep9LTUOr8dSAjGOieYh86W4wK44A4=;
 b=DSI0wJujpk4u6ZpIhqGVZEeO7xLqev4DVYVapCbf4WHmm34g1bKSV9gISytLpTJXeHjhfAbMABcqEmwuLeA1Ak2t5PxUesjWlihnK1qS6RBrNjMo+MR7iUttLuBWhRrdyDAZsHZcLa1X0j5aCvdyXGSnh8Llfx8ME+heZ1fr4nYewPx25AQnBPkcM7sRmnD+87Ev85OPGf44gfoUPG9RWEyDEIMjQd0rLiwjPNoAWMCHnCrz/JF9+4m25jFu13zTuNL2JBBQ6KuWOw7jbrWURfleKG5RKmOP4xtearu+y6zPoT4uf7Bzeb+2dHa8rsdmIYkzptdrMwqj5oS3Lx6Luw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:03 +0300
Message-Id: <20221018120420.561846-3-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 02/19] bridge: mcast: Remove redundant
	checks
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

These checks are now redundant as they are performed by
br_mdb_config_init() while parsing the RTM_{NEW,DEL}MDB messages.

Remove them.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 63 +++++++--------------------------------------
 1 file changed, 9 insertions(+), 54 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index c53050e47a0f..68fd34161a40 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1090,11 +1090,10 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct net_bridge_vlan_group *vg;
-	struct net_bridge_port *p = NULL;
-	struct net_device *dev, *pdev;
 	struct br_mdb_entry *entry;
 	struct net_bridge_vlan *v;
 	struct br_mdb_config cfg;
+	struct net_device *dev;
 	struct net_bridge *br;
 	int err;
 
@@ -1108,38 +1107,12 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
-	if (!netif_running(br->dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Bridge device is not running");
-		return -EINVAL;
-	}
-
-	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
-		NL_SET_ERR_MSG_MOD(extack, "Bridge's multicast processing is disabled");
-		return -EINVAL;
-	}
-
 	if (entry->ifindex != br->dev->ifindex) {
-		pdev = __dev_get_by_index(net, entry->ifindex);
-		if (!pdev) {
-			NL_SET_ERR_MSG_MOD(extack, "Port net device doesn't exist");
-			return -ENODEV;
-		}
-
-		p = br_port_get_rtnl(pdev);
-		if (!p) {
-			NL_SET_ERR_MSG_MOD(extack, "Net device is not a bridge port");
-			return -EINVAL;
-		}
-
-		if (p->br != br) {
-			NL_SET_ERR_MSG_MOD(extack, "Port belongs to a different bridge device");
-			return -EINVAL;
-		}
-		if (p->state == BR_STATE_DISABLED && entry->state != MDB_PERMANENT) {
+		if (cfg.p->state == BR_STATE_DISABLED && entry->state != MDB_PERMANENT) {
 			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
 			return -EINVAL;
 		}
-		vg = nbp_vlan_group(p);
+		vg = nbp_vlan_group(cfg.p);
 	} else {
 		vg = br_vlan_group(br);
 	}
@@ -1150,12 +1123,12 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(br->dev) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-			err = __br_mdb_add(net, br, p, entry, mdb_attrs, extack);
+			err = __br_mdb_add(net, br, cfg.p, entry, mdb_attrs, extack);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_add(net, br, p, entry, mdb_attrs, extack);
+		err = __br_mdb_add(net, br, cfg.p, entry, mdb_attrs, extack);
 	}
 
 	return err;
@@ -1170,9 +1143,6 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry,
 	struct br_ip ip;
 	int err = -EINVAL;
 
-	if (!netif_running(br->dev) || !br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		return -EINVAL;
-
 	__mdb_entry_to_br_ip(entry, &ip, mdb_attrs);
 
 	spin_lock_bh(&br->multicast_lock);
@@ -1212,11 +1182,10 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct net_bridge_vlan_group *vg;
-	struct net_bridge_port *p = NULL;
-	struct net_device *dev, *pdev;
 	struct br_mdb_entry *entry;
 	struct net_bridge_vlan *v;
 	struct br_mdb_config cfg;
+	struct net_device *dev;
 	struct net_bridge *br;
 	int err;
 
@@ -1230,24 +1199,10 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
-	if (entry->ifindex != br->dev->ifindex) {
-		pdev = __dev_get_by_index(net, entry->ifindex);
-		if (!pdev)
-			return -ENODEV;
-
-		p = br_port_get_rtnl(pdev);
-		if (!p) {
-			NL_SET_ERR_MSG_MOD(extack, "Net device is not a bridge port");
-			return -EINVAL;
-		}
-		if (p->br != br) {
-			NL_SET_ERR_MSG_MOD(extack, "Port belongs to a different bridge device");
-			return -EINVAL;
-		}
-		vg = nbp_vlan_group(p);
-	} else {
+	if (entry->ifindex != br->dev->ifindex)
+		vg = nbp_vlan_group(cfg.p);
+	else
 		vg = br_vlan_group(br);
-	}
 
 	/* If vlan filtering is enabled and VLAN is not specified
 	 * delete mdb entry on all vlans configured on the port.
-- 
2.37.3

