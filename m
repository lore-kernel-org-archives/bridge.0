Message-Id: <20070221224255.581096490@linux-foundation.org>
References: <20070221224107.741532037@linux-foundation.org>
Date: Wed, 21 Feb 2007 14:41:08 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Content-Disposition: inline; filename=bridge-get-rid-miscdevice
Subject: [Bridge] [PATCH 1/4] bridge: get rid of miscdevice include
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

The bridge hasn't used miscdevice for a long long time.

Signed-off-by: StephenHemminger <shemminger@linux-foundtion.org>

---
 net/bridge/br_private.h |    1 -
 1 file changed, 1 deletion(-)

--- bridge.orig/net/bridge/br_private.h	2007-02-21 10:57:26.000000000 -0800
+++ bridge/net/bridge/br_private.h	2007-02-21 10:57:30.000000000 -0800
@@ -16,7 +16,6 @@
 #define _BR_PRIVATE_H
 
 #include <linux/netdevice.h>
-#include <linux/miscdevice.h>
 #include <linux/if_bridge.h>
 
 #define BR_HASH_BITS 8

--
Stephen Hemminger <shemminger@linux-foundation.org>

