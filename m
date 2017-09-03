Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=zvFr6XYKFu1ur/cPNB+YU8UJH7e8TKClWVAWooocbzc=;
	b=byceVerJ5LZTr5Tn3l2TZEesBR7YwIlMRZ3YWTjCySYjteKcKfTsL+yiF//jtvkLgBI81fXOA4VwNLJOuZbtwVYhyBJpB2gZPZLVYVLcDupfDk+RknKMVd6FrU8xzAEKRXTd5zwPtE14qSzBJNOgWsToYVSUroM0tkiYGWlHrbo=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun,  3 Sep 2017 17:44:13 +0300
Message-Id: <20170903144413.21946-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] bridge: switchdev: Use an helper to clear
	forward mark
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, yotamg@mellanox.com, nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Instead of using ifdef in the C file.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Suggested-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Tested-by: Yotam Gigi <yotamg@mellanox.com>
---
 net/bridge/br_device.c  | 4 +---
 net/bridge/br_private.h | 9 +++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 5a7be3bddfa9..f6b6a92f1c48 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -53,9 +53,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	brstats->tx_bytes += skb->len;
 	u64_stats_update_end(&brstats->syncp);
 
-#ifdef CONFIG_NET_SWITCHDEV
-	skb->offload_fwd_mark = 0;
-#endif
+	br_switchdev_frame_unmark(skb);
 	BR_INPUT_SKB_CB(skb)->brdev = dev;
 
 	skb_reset_mac_header(skb);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index fd9ee73e0a6d..e870cfc85b14 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1091,6 +1091,11 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long mask);
 void br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb,
 			     int type);
+
+static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
+{
+	skb->offload_fwd_mark = 0;
+}
 #else
 static inline int nbp_switchdev_mark_set(struct net_bridge_port *p)
 {
@@ -1119,6 +1124,10 @@ static inline void
 br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 {
 }
+
+static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
+{
+}
 #endif /* CONFIG_NET_SWITCHDEV */
 
 #endif
-- 
2.13.5

