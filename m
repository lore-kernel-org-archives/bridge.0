Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F18D60F9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 363FF60FA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXV2/wFaM/FmM2Zuy8SrSPKa4bOiS4GZJHNko+mi8r4=;
 b=jzb+uccxKMLjP6bGzbShWfUZa7568z0uVzVjGoGYG2jwAkVsVJH2mrn8tNB/gKBAwTXqRHendC+FBi9OeKMFxrRGRk9HyfHlR4tyJs4O2trRt7xtut2A/lb0OLh6VyBkYKpDR8xS5cMzfeTbQinPHHAG2yw5lDrB+xETW9jO0CpRF9IvcW2cUNUQF/StlFmxa+Hwx5uFdo3p5Uzvf2RM2dvhRxKmmOfonEy+1PkmzptW4s4DmgjY8GdwAk0sRi7CBDZUPisfQsqR9oq11MZ+GApQMFUIvnBqwYf0DTxzpceJNY4dLZAIFOfvpW3MKHO5vlmKTY/P8Z2lERzrkT5dzw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  6 Dec 2022 12:58:04 +0200
Message-Id: <20221206105809.363767-5-idosch@nvidia.com>
In-Reply-To: <20221206105809.363767-1-idosch@nvidia.com>
References: <20221206105809.363767-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 4/9] bridge: mcast: Propagate MDB
	configuration structure further
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

As an intermediate step towards only using the new MDB configuration
structure, pass it further in the control path instead of passing
individual attributes.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v2:
    * Pass 'cfg' as 'const'.

 net/bridge/br_mdb.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 080516a3ee9c..6017bff8316a 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -959,17 +959,15 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	return 0;
 }
 
-static int __br_mdb_add(struct net *net, struct net_bridge *br,
-			struct net_bridge_port *p,
-			struct br_mdb_entry *entry,
+static int __br_mdb_add(const struct br_mdb_config *cfg,
 			struct nlattr **mdb_attrs,
 			struct netlink_ext_ack *extack)
 {
 	int ret;
 
-	spin_lock_bh(&br->multicast_lock);
-	ret = br_mdb_add_group(br, p, entry, mdb_attrs, extack);
-	spin_unlock_bh(&br->multicast_lock);
+	spin_lock_bh(&cfg->br->multicast_lock);
+	ret = br_mdb_add_group(cfg->br, cfg->p, cfg->entry, mdb_attrs, extack);
+	spin_unlock_bh(&cfg->br->multicast_lock);
 
 	return ret;
 }
@@ -1120,22 +1118,22 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			cfg.entry->vid = v->vid;
-			err = __br_mdb_add(net, cfg.br, cfg.p, cfg.entry,
-					   mdb_attrs, extack);
+			err = __br_mdb_add(&cfg, mdb_attrs, extack);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_add(net, cfg.br, cfg.p, cfg.entry, mdb_attrs,
-				   extack);
+		err = __br_mdb_add(&cfg, mdb_attrs, extack);
 	}
 
 	return err;
 }
 
-static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry,
+static int __br_mdb_del(const struct br_mdb_config *cfg,
 			struct nlattr **mdb_attrs)
 {
+	struct br_mdb_entry *entry = cfg->entry;
+	struct net_bridge *br = cfg->br;
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
@@ -1206,10 +1204,10 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			cfg.entry->vid = v->vid;
-			err = __br_mdb_del(cfg.br, cfg.entry, mdb_attrs);
+			err = __br_mdb_del(&cfg, mdb_attrs);
 		}
 	} else {
-		err = __br_mdb_del(cfg.br, cfg.entry, mdb_attrs);
+		err = __br_mdb_del(&cfg, mdb_attrs);
 	}
 
 	return err;
-- 
2.37.3

