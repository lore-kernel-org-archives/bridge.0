Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 17 May 2017 17:27:07 -0400
Message-Id: <20170517212709.6473-5-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
References: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
Subject: [Bridge] [PATCH net-next 4/6] net: bridge: add __br_mdb_do
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

br_mdb_add and br_mdb_del call respectively __br_mdb_add and
__br_mdb_del and notify the message type on success.

Factorize this in a new __br_mdb_do function which add or delete a
br_mdb_entry depending on the message type, then notify it.

Note that the dev argument is p->br->dev, so no need to pass it twice.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 net/bridge/br_mdb.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 24eeeefb4179..a72d5e6f339f 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -556,6 +556,9 @@ static int __br_mdb_add(struct net_bridge_port *p, struct br_mdb_entry *entry)
 	return ret;
 }
 
+static int __br_mdb_do(struct net_bridge_port *p, struct br_mdb_entry *entry,
+		       int msgtype);
+
 static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
@@ -592,15 +595,12 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(br) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-			err = __br_mdb_add(p, entry);
+			err = __br_mdb_do(p, entry, RTM_NEWMDB);
 			if (err)
 				break;
-			__br_mdb_notify(dev, p, entry, RTM_NEWMDB);
 		}
 	} else {
-		err = __br_mdb_add(p, entry);
-		if (!err)
-			__br_mdb_notify(dev, p, entry, RTM_NEWMDB);
+		err = __br_mdb_do(p, entry, RTM_NEWMDB);
 	}
 
 	return err;
@@ -651,6 +651,22 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 	return err;
 }
 
+static int __br_mdb_do(struct net_bridge_port *p, struct br_mdb_entry *entry,
+		       int msgtype)
+{
+	int err = -EINVAL;
+
+	if (msgtype == RTM_NEWMDB)
+		err = __br_mdb_add(p, entry);
+	else if (msgtype == RTM_DELMDB)
+		err = __br_mdb_del(p->br, entry);
+
+	if (!err)
+		__br_mdb_notify(p->br->dev, p, entry, msgtype);
+
+	return err;
+}
+
 static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
@@ -687,15 +703,12 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (br_vlan_enabled(br) && vg && entry->vid == 0) {
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			entry->vid = v->vid;
-			err = __br_mdb_del(br, entry);
+			err = __br_mdb_do(p, entry, RTM_DELMDB);
 			if (err)
 				break;
-			__br_mdb_notify(dev, p, entry, RTM_DELMDB);
 		}
 	} else {
-		err = __br_mdb_del(br, entry);
-		if (!err)
-			__br_mdb_notify(dev, p, entry, RTM_DELMDB);
+		err = __br_mdb_do(p, entry, RTM_DELMDB);
 	}
 
 	return err;
-- 
2.13.0

