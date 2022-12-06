Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DA7C408F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64BA2408F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2UuOzLm+cUz3HNhxRPB+Jh5RI2DyHSGrhLikshtd8c=;
 b=tQ+f56NUmYJZ0viQdjupaatD1/nZswbEaRhH/swvOXfNj3VeAZlW3KHTOwaxZlGFtVficdlznWuMZT98iZ9QEAwurDrQGpf6Px6G4GDVxDWk2fR+JybMJxz3/g9lLZ8ge6vItxROAFrePb7krHvGh4seJi+1j7VoxsShMW8/M1yUHawyKX+7TAAJYKzk3l8oWn5S0PcN+dX5IXYvo+c9Nepf8yZv4R6V6XC2sBX266H2CwsRJdqcWe6T7UbmMwYExkcDNbyuZGQi8zDx1YQz/Vu5N/M4SBhB073c3VITmJm9Qd1bA4ZMZa2uVcs7O+UD7lErsIlVb6X2YBLL7BUhTw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  6 Dec 2022 12:58:05 +0200
Message-Id: <20221206105809.363767-6-idosch@nvidia.com>
In-Reply-To: <20221206105809.363767-1-idosch@nvidia.com>
References: <20221206105809.363767-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 5/9] bridge: mcast: Use MDB group key
	from configuration structure
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

The MDB group key (i.e., {source, destination, protocol, VID}) is
currently determined under the multicast lock from the netlink
attributes. Instead, use the group key from the MDB configuration
structure that was prepared before acquiring the lock.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v2:
    * Pass 'cfg' as 'const'.

 net/bridge/br_mdb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 6017bff8316a..b459886af675 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -855,20 +855,19 @@ __br_mdb_choose_context(struct net_bridge *br,
 
 static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 			    struct br_mdb_entry *entry,
-			    struct nlattr **mdb_attrs,
+			    const struct br_mdb_config *cfg,
 			    struct netlink_ext_ack *extack)
 {
 	struct net_bridge_mdb_entry *mp, *star_mp;
 	struct net_bridge_port_group __rcu **pp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_mcast *brmctx;
-	struct br_ip group, star_group;
+	struct br_ip group = cfg->group;
 	unsigned long now = jiffies;
 	unsigned char flags = 0;
+	struct br_ip star_group;
 	u8 filter_mode;
 
-	__mdb_entry_to_br_ip(entry, &group, mdb_attrs);
-
 	brmctx = __br_mdb_choose_context(br, entry, extack);
 	if (!brmctx)
 		return -EINVAL;
@@ -966,7 +965,7 @@ static int __br_mdb_add(const struct br_mdb_config *cfg,
 	int ret;
 
 	spin_lock_bh(&cfg->br->multicast_lock);
-	ret = br_mdb_add_group(cfg->br, cfg->p, cfg->entry, mdb_attrs, extack);
+	ret = br_mdb_add_group(cfg->br, cfg->p, cfg->entry, cfg, extack);
 	spin_unlock_bh(&cfg->br->multicast_lock);
 
 	return ret;
@@ -1118,6 +1117,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			cfg.entry->vid = v->vid;
+			cfg.group.vid = v->vid;
 			err = __br_mdb_add(&cfg, mdb_attrs, extack);
 			if (err)
 				break;
@@ -1137,11 +1137,9 @@ static int __br_mdb_del(const struct br_mdb_config *cfg,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 	struct net_bridge_port_group __rcu **pp;
-	struct br_ip ip;
+	struct br_ip ip = cfg->group;
 	int err = -EINVAL;
 
-	__mdb_entry_to_br_ip(entry, &ip, mdb_attrs);
-
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &ip);
 	if (!mp)
@@ -1204,6 +1202,7 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(cfg.br->dev) && vg && cfg.entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			cfg.entry->vid = v->vid;
+			cfg.group.vid = v->vid;
 			err = __br_mdb_del(&cfg, mdb_attrs);
 		}
 	} else {
-- 
2.37.3

