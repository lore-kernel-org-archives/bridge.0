Return-Path: <casper.casan@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:organization:mime-version
 :content-disposition;
 bh=bpDA/8HCyR0vlKavnt82QPftLcL/p7VlaeF5k8zFxxw=;
 b=oiiHx6OuWWPJTptM7WTl7D12y0ojPdv+Ylb/8ZRdPrKZV0w2Q3NXUKzJMQ+02qN18a
 C4w3qi7sdYGr7ynXOBQNhZVxAAmJTc5GaODcpQSZDzwHurEVihCtN9HgbHFjrrLFJAqY
 6lfN5TxfnV0OWgBJGuiOrTdYhaPQpilPGjJCNUj44vju1yz6P+GhnbULYscFNKVPIZj7
 F385jYEjg9pjHvDs/cMRI8Z9uxAlIHE5x2goiXSiG2u1Yl1XtpLxzvDEaw9xDx5ZbMw4
 ulYnyYyVrvfGE61+rPNvH+f6dPI12AGFVHJeBSzKdobqrVG9s4vPXcSfwsNVH+znf/O5
 CJ5A==
Date: Tue, 14 Jun 2022 08:32:23 +0200
From: Casper Andersson <casper.casan@gmail.com>
Message-ID: <20220614063223.zvtrdrh7pbkv3b4v@wse-c0155>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH net-next] net: bridge: allow add/remove permanent
 mdb entries on disabled ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Joachim Wiberg <troglobit@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Adding mdb entries on disabled ports allows you to do setup before
accepting any traffic, avoiding any time where the port is not in the
multicast group.

Signed-off-by: Casper Andersson <casper.casan@gmail.com>
---
 net/bridge/br_mdb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index fdcc641fc89a..589ff497d50c 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1025,8 +1025,8 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			NL_SET_ERR_MSG_MOD(extack, "Port belongs to a different bridge device");
 			return -EINVAL;
 		}
-		if (p->state == BR_STATE_DISABLED) {
-			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state");
+		if (p->state == BR_STATE_DISABLED && entry->state != MDB_PERMANENT) {
+			NL_SET_ERR_MSG_MOD(extack, "Port is in disabled state and entry is not permanent");
 			return -EINVAL;
 		}
 		vg = nbp_vlan_group(p);
@@ -1086,9 +1086,6 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry,
 		if (!p->key.port || p->key.port->dev->ifindex != entry->ifindex)
 			continue;
 
-		if (p->key.port->state == BR_STATE_DISABLED)
-			goto unlock;
-
 		br_multicast_del_pg(mp, p, pp);
 		err = 0;
 		break;
@@ -1124,8 +1121,14 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return -ENODEV;
 
 		p = br_port_get_rtnl(pdev);
-		if (!p || p->br != br || p->state == BR_STATE_DISABLED)
+		if (!p) {
+			NL_SET_ERR_MSG_MOD(extack, "Net device is not a bridge port");
+			return -EINVAL;
+		}
+		if (p->br != br) {
+			NL_SET_ERR_MSG_MOD(extack, "Port belongs to a different bridge device");
 			return -EINVAL;
+		}
 		vg = nbp_vlan_group(p);
 	} else {
 		vg = br_vlan_group(br);
-- 
2.30.2

