Return-Path: <sanagi.koki@jp.fujitsu.com>
Message-ID: <4ED5E9D6.3070404@jp.fujitsu.com>
Date: Wed, 30 Nov 2011 17:31:18 +0900
From: Koki Sanagi <sanagi.koki@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: Cannot communicate with brX when its MAC
 address is changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, davem@davemloft.net

When the MAC address of a bridge interface is changed, it cannot communicate
with others. Because Whether or not a packet should be transferred to bridge
interface depends on whether or not dst of a packet is in fdb and is_local=y.
If we change MAC address of a bridge interface, it isn't in fdb.

This patch adds an condition that dst of a packet matches MAC address of
a bridge interface to the conventional condition.

Signed-off-by: Koki Sanagi <sanagi.koki@jp.fujitsu.com>
---
 net/bridge/br_input.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5a31731..4e5c862 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -94,7 +94,8 @@ int br_handle_frame_finish(struct sk_buff *skb)
 			skb2 = skb;
 
 		br->dev->stats.multicast++;
-	} else if ((dst = __br_fdb_get(br, dest)) && dst->is_local) {
+	} else if ((dst = __br_fdb_get(br, dest) && dst->is_local) ||
+		   !compare_ether_addr(p->br->dev->dev_addr, dest)) {
 		skb2 = skb;
 		/* Do not forward the packet since it's local. */
 		skb = NULL;

