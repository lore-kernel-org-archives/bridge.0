Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 17 May 2017 17:27:05 -0400
Message-Id: <20170517212709.6473-3-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
References: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
Subject: [Bridge] [PATCH net-next 2/6] net: bridge: check multicast bridge
	only once
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

__br_mdb_add and __br_mdb_del both check that the bridge is up and
running and that multicast is enabled on it before doing any operation.

Since they can be called multiple times by br_mdb_add and br_mdb_del,
move the check in their caller functions so that it is done just once.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 net/bridge/br_mdb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index bef0331f46a4..d20a01622b20 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -548,9 +548,6 @@ static int __br_mdb_add(struct net_bridge_port *p, struct br_mdb_entry *entry)
 	struct br_ip ip;
 	int ret;
 
-	if (!netif_running(br->dev) || br->multicast_disabled)
-		return -EINVAL;
-
 	__mdb_entry_to_br_ip(entry, &ip);
 
 	spin_lock_bh(&br->multicast_lock);
@@ -577,6 +574,9 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
+	if (!netif_running(br->dev) || br->multicast_disabled)
+		return -EINVAL;
+
 	/* If vlan filtering is enabled and VLAN is not specified
 	 * install mdb entry on all vlans configured on the port.
 	 */
@@ -615,9 +615,6 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 	struct br_ip ip;
 	int err = -EINVAL;
 
-	if (!netif_running(br->dev) || br->multicast_disabled)
-		return -EINVAL;
-
 	__mdb_entry_to_br_ip(entry, &ip);
 
 	spin_lock_bh(&br->multicast_lock);
@@ -672,6 +669,9 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	br = netdev_priv(dev);
 
+	if (!netif_running(br->dev) || br->multicast_disabled)
+		return -EINVAL;
+
 	/* If vlan filtering is enabled and VLAN is not specified
 	 * delete mdb entry on all vlans configured on the port.
 	 */
-- 
2.13.0

