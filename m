Return-Path: <igor.mitsyanko.os@quantenna.com>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Date: Fri,  9 Mar 2018 19:03:08 -0800
Message-Id: <20180310030308.12947-6-igor.mitsyanko.os@quantenna.com>
In-Reply-To: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: [Bridge] [RFC PATCH net-next 5/5] bridge: verify "HW only" flags
	can't be set without HW support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ivecera@redhat.com, igor.mitsyanko.os@quantenna.com, jiri@resnulli.us, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

Setting bridge flag BR_FLOOD_OFFLOAD only makes sense if underlying
port hardware advertises support for it. Make sure kernel checks that
condition before allowing to update the flag value.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 net/bridge/br_private.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a6d2f2b..6d2f8b1 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -50,6 +50,9 @@ enum {
 /* Path to usermode spanning tree program */
 #define BR_STP_PROG	"/sbin/bridge-stp"
 
+/* Flags that can only be set if HW supports it */
+#define BR_PORT_FLAGS_HW_ONLY	BR_FLOOD_OFFLOAD
+
 typedef struct bridge_id bridge_id;
 typedef struct mac_addr mac_addr;
 typedef __u16 port_id;
@@ -1150,7 +1153,7 @@ static inline int br_switchdev_set_port_flag(struct net_bridge_port *p,
 					     unsigned long flags,
 					     unsigned long mask)
 {
-	return 0;
+	return mask & BR_PORT_FLAGS_HW_ONLY ? -EOPNOTSUPP : 0;
 }
 
 static inline void
-- 
2.9.5

