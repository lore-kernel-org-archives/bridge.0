Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=aMVXK7GnYB8JQU0fHxsxpolHU0OIo1XCRaLkh5I7qRo=;
	b=etzxEqDbH6ToSEDdbivTxcmKRkmod1KscCHlvvNXIDgZjzl35OH2Sz5QrNswWWZBQMiII9Oee6cCORMj3V2y6C+qQlY4gAAwjKtS+nn+kbwyQCv3HnxRU2tDgVEqHZZ6jYu3wgkdC0QbmBIPVPvvAZIV+oSQZZD9VjmnALdP/SQ=
From: <idosch@mellanox.com>
Date: Sat, 8 Apr 2017 14:41:58 +0300
Message-ID: <20170408114159.12722-2-idosch@mellanox.com>
In-Reply-To: <20170408114159.12722-1-idosch@mellanox.com>
References: <20170408114159.12722-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2 1/2] bridge: implement missing ndo_uninit()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, cera@cera.cz, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, peter@svinota.eu, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

While the bridge driver implements an ndo_init(), it was missing a
symmetric ndo_uninit(), causing the different de-initialization
operations to be scattered around its dellink() and destructor().

Implement a symmetric ndo_uninit() and remove the overlapping operations
from its dellink() and destructor().

This is a prerequisite for the next patch, as it allows us to have a
proper cleanup upon changelink() failure during the bridge's newlink().

Fixes: b6677449dff6 ("bridge: netlink: call br_changelink() during br_dev_newlink()")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 net/bridge/br_device.c    | 13 ++++++++++---
 net/bridge/br_if.c        |  1 -
 net/bridge/br_multicast.c |  7 +++++--
 net/bridge/br_private.h   |  5 +++++
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ea71513..607210f 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -119,6 +119,15 @@ static int br_dev_init(struct net_device *dev)
 	return err;
 }
 
+static void br_dev_uninit(struct net_device *dev)
+{
+	struct net_bridge *br = netdev_priv(dev);
+
+	br_multicast_uninit_stats(br);
+	br_vlan_flush(br);
+	free_percpu(br->stats);
+}
+
 static int br_dev_open(struct net_device *dev)
 {
 	struct net_bridge *br = netdev_priv(dev);
@@ -332,6 +341,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_open		 = br_dev_open,
 	.ndo_stop		 = br_dev_stop,
 	.ndo_init		 = br_dev_init,
+	.ndo_uninit		 = br_dev_uninit,
 	.ndo_start_xmit		 = br_dev_xmit,
 	.ndo_get_stats64	 = br_get_stats64,
 	.ndo_set_mac_address	 = br_set_mac_address,
@@ -358,9 +368,6 @@ static const struct net_device_ops br_netdev_ops = {
 
 static void br_dev_free(struct net_device *dev)
 {
-	struct net_bridge *br = netdev_priv(dev);
-
-	free_percpu(br->stats);
 	free_netdev(dev);
 }
 
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 8ac1770..56a2a72 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -311,7 +311,6 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 
 	br_fdb_delete_by_port(br, NULL, 0, 1);
 
-	br_vlan_flush(br);
 	br_multicast_dev_del(br);
 	cancel_delayed_work_sync(&br->gc_work);
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b760f26..faa7261 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2031,8 +2031,6 @@ void br_multicast_dev_del(struct net_bridge *br)
 
 out:
 	spin_unlock_bh(&br->multicast_lock);
-
-	free_percpu(br->mcast_stats);
 }
 
 int br_multicast_set_router(struct net_bridge *br, unsigned long val)
@@ -2531,6 +2529,11 @@ int br_multicast_init_stats(struct net_bridge *br)
 	return 0;
 }
 
+void br_multicast_uninit_stats(struct net_bridge *br)
+{
+	free_percpu(br->mcast_stats);
+}
+
 static void mcast_stats_add_dir(u64 *dst, u64 *src)
 {
 	dst[BR_MCAST_DIR_RX] += src[BR_MCAST_DIR_RX];
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6136818..0d17728 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -620,6 +620,7 @@ void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
 void br_multicast_count(struct net_bridge *br, const struct net_bridge_port *p,
 			const struct sk_buff *skb, u8 type, u8 dir);
 int br_multicast_init_stats(struct net_bridge *br);
+void br_multicast_uninit_stats(struct net_bridge *br);
 void br_multicast_get_stats(const struct net_bridge *br,
 			    const struct net_bridge_port *p,
 			    struct br_mcast_stats *dest);
@@ -760,6 +761,10 @@ static inline int br_multicast_init_stats(struct net_bridge *br)
 	return 0;
 }
 
+static inline void br_multicast_uninit_stats(struct net_bridge *br)
+{
+}
+
 static inline int br_multicast_igmp_type(const struct sk_buff *skb)
 {
 	return 0;
-- 
2.9.3

