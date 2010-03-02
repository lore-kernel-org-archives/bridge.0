Message-ID: <4B8D4607.8070603@xenotime.net>
Date: Tue, 02 Mar 2010 09:08:23 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <20100302180915.1388d3f3.sfr@canb.auug.org.au>
In-Reply-To: <20100302180915.1388d3f3.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH -next] bridge: depends on INET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: bridge@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

br_multicast calls ip_send_check(), so it should depend on INET.

built-in:
br_multicast.c:(.text+0x88cf4): undefined reference to `ip_send_check'

or modular:
ERROR: "ip_send_check" [net/bridge/bridge.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org
---
 net/bridge/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20100302.orig/net/bridge/Kconfig
+++ linux-next-20100302/net/bridge/Kconfig
@@ -35,6 +35,7 @@ config BRIDGE
 config BRIDGE_IGMP_SNOOPING
 	bool "IGMP snooping"
 	depends on BRIDGE
+	depends on INET
 	default y
 	---help---
 	  If you say Y here, then the Ethernet bridge will be able selectively
