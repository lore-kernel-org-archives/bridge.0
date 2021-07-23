Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmrlvSnXkakUKZ93sT1RJo8+DwxzGtFpOoO1S2GBF0Y=;
 b=agu7M+GzO3q6bmGY2ZEQBUGDdw1EQ8KSpIPonHBhPzgWCoTzPUU0i6aMcs8UJ16P4wTEjU67Ms5mG35pJ9KugPuhy0ltqq0gFFEq3/jNb+WVFDU+TTyJ7bopRJ7DI175lB9OjaDYNuiPYsTEmRCFa3URnN2at20vZv4PwGOfiRQ=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 23 Jul 2021 23:49:11 +0300
Message-Id: <20210723204911.3884995-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next] net: bridge: fix build when setting
	skb->offload_fwd_mark with CONFIG_NET_SWITCHDEV=n
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, kernel test robot <lkp@intel.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Tobias Waldekranz <tobias@waldekranz.com>

Switchdev support can be disabled at compile time, and in that case,
struct sk_buff will not contain the offload_fwd_mark field.

To make the code in br_forward.c work in both cases, we do what is done
in other places and we create a helper function, with an empty shim
definition, that is implemented by the br_switchdev.o translation module.
This is always compiled if and only if CONFIG_NET_SWITCHDEV is y or m.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_forward.c   | 2 +-
 net/bridge/br_private.h   | 6 ++++++
 net/bridge/br_switchdev.c | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index bc14b1b384e9..ec646656dbf1 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -48,7 +48,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 		skb_set_network_header(skb, depth);
 	}
 
-	skb->offload_fwd_mark = br_switchdev_frame_uses_tx_fwd_offload(skb);
+	br_switchdev_frame_set_offload_fwd_mark(skb);
 
 	dev_queue_xmit(skb);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 86ca617fec7a..1c57877270f7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1881,6 +1881,8 @@ static inline void br_sysfs_delbr(struct net_device *dev) { return; }
 #ifdef CONFIG_NET_SWITCHDEV
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb);
 
+void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb);
+
 void nbp_switchdev_frame_mark_tx_fwd_offload(const struct net_bridge_port *p,
 					     struct sk_buff *skb);
 void nbp_switchdev_frame_mark_tx_fwd_to_hwdom(const struct net_bridge_port *p,
@@ -1910,6 +1912,10 @@ static inline bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
 	return false;
 }
 
+static inline void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb)
+{
+}
+
 static inline void
 nbp_switchdev_frame_mark_tx_fwd_offload(const struct net_bridge_port *p,
 					struct sk_buff *skb)
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 96ce069d0c8c..9cf9ab320c48 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -28,6 +28,11 @@ bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
 	return BR_INPUT_SKB_CB(skb)->tx_fwd_offload;
 }
 
+void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb)
+{
+	skb->offload_fwd_mark = br_switchdev_frame_uses_tx_fwd_offload(skb);
+}
+
 /* Mark the frame for TX forwarding offload if this egress port supports it */
 void nbp_switchdev_frame_mark_tx_fwd_offload(const struct net_bridge_port *p,
 					     struct sk_buff *skb)
-- 
2.25.1

