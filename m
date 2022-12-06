Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42D7E81E56
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB2DD81E61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2WL7m/8ONJG969UU9V/sIbFR4k6LPwn/Nv7iM09AZg=;
 b=S7UnT85H5R5QvEgk0Yndi4uBq2XptzRHYXH8kxqXieZUHdaA9K3+4T3XZyp/hu6tArT4cevaVvjtduIn1T8x6Fxbp8fj8/skTGAAI99zk66ppoA3L0hspBRdI4YUDgcGaqtrfiTAuDqYrRK4kMLrjMa4lwO5n6GM5JHtYaw4Bn4yxjvC/MT6fjFnGKVRGtwHB+cwaTOUn7gClg9vR9vs354Wg19tz6uqwLRAVl6Wq3jKJyA0XxZ2VJsWxi2pAwc+gIkLI7/GS5MEldlWih00JfDRFc/nio5GKAApwEsvv/kCpQ41UVRQcw6NtpHbV0uYKcll2e7wrikV0dKECWhNlw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  6 Dec 2022 12:58:03 +0200
Message-Id: <20221206105809.363767-4-idosch@nvidia.com>
In-Reply-To: <20221206105809.363767-1-idosch@nvidia.com>
References: <20221206105809.363767-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 3/9] bridge: mcast: Use MDB
	configuration structure where possible
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

The MDB configuration structure (i.e., struct br_mdb_config) now
includes all the necessary information from the parsed RTM_{NEW,DEL}MDB
netlink messages, so use it.

This will later allow us to delete the calls to br_mdb_parse() from
br_mdb_add() and br_mdb_del().

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index c8d78e4ec94e..080516a3ee9c 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1094,7 +1094,6 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_bridge_vlan *v;
 	struct br_mdb_config cfg;
 	struct net_device *dev;
-	struct net_bridge *br;
 	int err;
 
 	err = br_mdb_config_init(net, nlh, &cfg, extack);
@@ -1105,30 +1104,30 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	br = netdev_priv(dev);
-
-	if (entry->ifindex != br->dev->ifindex) {
-		if (cfg.p->state == BR_STATE_DISABLED && entry->state != MDB_PERMANENT) {
+	if (cfg.p) {
+		if (cfg.p->state == BR_STATE_DISABLED && cfg.entry->state != MDB_PERMANENT) {
 			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
 			return -EINVAL;
 		}
 		vg = nbp_vlan_group(cfg.p);
 	} else {
-		vg = br_vlan_group(br);
+		vg = br_vlan_group(cfg.br);
 	}
 
 	/* If vlan filtering is enabled and VLAN is not specified
 	 * install mdb entry on all vlans configured on the port.
 	 */
-	if (br_vlan_enabled(br->dev) && vg && entry->vid == 0) {
+	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
-			entry->vid = v->vid;
-			err = __br_mdb_add(net, br, cfg.p, entry, mdb_attrs, extack);
+			cfg.entry->vid = v->vid;
+			err = __br_mdb_add(net, cfg.br, cfg.p, cfg.entry,
+					   mdb_attrs, extack);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_add(net, br, cfg.p, entry, mdb_attrs, extack);
+		err = __br_mdb_add(net, cfg.br, cfg.p, cfg.entry, mdb_attrs,
+				   extack);
 	}
 
 	return err;
@@ -1186,7 +1185,6 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_bridge_vlan *v;
 	struct br_mdb_config cfg;
 	struct net_device *dev;
-	struct net_bridge *br;
 	int err;
 
 	err = br_mdb_config_init(net, nlh, &cfg, extack);
@@ -1197,23 +1195,21 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	br = netdev_priv(dev);
-
-	if (entry->ifindex != br->dev->ifindex)
+	if (cfg.p)
 		vg = nbp_vlan_group(cfg.p);
 	else
-		vg = br_vlan_group(br);
+		vg = br_vlan_group(cfg.br);
 
 	/* If vlan filtering is enabled and VLAN is not specified
 	 * delete mdb entry on all vlans configured on the port.
 	 */
-	if (br_vlan_enabled(br->dev) && vg && entry->vid == 0) {
+	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
-			entry->vid = v->vid;
-			err = __br_mdb_del(br, entry, mdb_attrs);
+			cfg.entry->vid = v->vid;
+			err = __br_mdb_del(cfg.br, cfg.entry, mdb_attrs);
 		}
 	} else {
-		err = __br_mdb_del(br, entry, mdb_attrs);
+		err = __br_mdb_del(cfg.br, cfg.entry, mdb_attrs);
 	}
 
 	return err;
-- 
2.37.3

