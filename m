Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 17 May 2017 17:27:08 -0400
Message-Id: <20170517212709.6473-6-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
References: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
Subject: [Bridge] [PATCH net-next 5/6] net: bridge: get msgtype from
	nlmsghdr in mdb ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com, "David S. Miller" <davem@davemloft.net>

Retrieve the message type from the nlmsghdr structure instead of
hardcoding it in both br_mdb_add and br_mdb_del.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 net/bridge/br_mdb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a72d5e6f339f..d280b20587cb 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -569,6 +569,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_bridge_port *p;
 	struct net_bridge_vlan *v;
 	struct net_bridge *br;
+	int msgtype = nlh->nlmsg_type;
 	int err;
 
 	err = br_mdb_parse(skb, nlh, &dev, &entry);
@@ -595,12 +596,12 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(br) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-			err = __br_mdb_do(p, entry, RTM_NEWMDB);
+			err = __br_mdb_do(p, entry, msgtype);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_do(p, entry, RTM_NEWMDB);
+		err = __br_mdb_do(p, entry, msgtype);
 	}
 
 	return err;
@@ -677,6 +678,7 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_bridge_port *p;
 	struct net_bridge_vlan *v;
 	struct net_bridge *br;
+	int msgtype = nlh->nlmsg_type;
 	int err;
 
 	err = br_mdb_parse(skb, nlh, &dev, &entry);
@@ -703,12 +705,12 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(br) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-			err = __br_mdb_do(p, entry, RTM_DELMDB);
+			err = __br_mdb_do(p, entry, msgtype);
 			if (err)
 				break;
 		}
 	} else {
-		err = __br_mdb_do(p, entry, RTM_DELMDB);
+		err = __br_mdb_do(p, entry, msgtype);
 	}
 
 	return err;
-- 
2.13.0

