Return-Path: <tanxiaojun@huawei.com>
Message-ID: <52AF00FE.4090607@huawei.com>
From: Tan Xiaojun <tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next] bridge: spelling fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 16 Dec 2013 13:33:07 -0000
To: stephen@networkplumber.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Fix spelling errors in bridge driver.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 net/bridge/br_forward.c | 2 +-
 net/bridge/br_if.c      | 2 +-
 net/bridge/br_vlan.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 4b81b14..96866aa 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -26,7 +26,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 			 void (*__packet_hook)(const struct net_bridge_port *p,
 					       struct sk_buff *skb));
 
-/* Don't forward packets to originating port or forwarding diasabled */
+/* Don't forward packets to originating port or forwarding disabled */
 static inline int should_deliver(const struct net_bridge_port *p,
 				 const struct sk_buff *skb)
 {
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 4bf02ad..1f6bd1e 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -61,7 +61,7 @@ static int port_cost(struct net_device *dev)
 }
 
 
-/* Check for port carrier transistions. */
+/* Check for port carrier transitions. */
 void br_port_carrier_check(struct net_bridge_port *p)
 {
 	struct net_device *dev = p->dev;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index af5ebd1..7ffc801 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -146,7 +146,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 
 	/* At this point, we know that the frame was filtered and contains
 	 * a valid vlan id.  If the vlan id is set in the untagged bitmap,
-	 * send untagged; otherwise, send taged.
+	 * send untagged; otherwise, send tagged.
 	 */
 	br_vlan_get_tag(skb, &vid);
 	if (test_bit(vid, pv->untagged_bitmap))
-- 
1.8.0


.


