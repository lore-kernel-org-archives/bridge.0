From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Sat, 13 Mar 2010 22:10:11 +0100
Message-Id: <1268514611-7930-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <[PATCH]: CONFIG_BRIDGE_IGMP_SNOOPING must depend on CONFIG_INET>
References: <[PATCH]: CONFIG_BRIDGE_IGMP_SNOOPING must depend on CONFIG_INET>
Subject: [Bridge] [PATCH] [PATCH]: CONFIG_BRIDGE_IGMP_SNOOPING must depend
	on CONFIG_INET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, Henrik Kretzschmar <henne@nachtwindheim.de>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Linking the kernel fails with the the following error message,
if CONFIG_BRIDGE_IGMP_SNOOPING is set and CONFIG_INET is not set.

net/built-in.o: In function `br_multicast_alloc_query':
br_multicast.c:(.text+0x52045): undefined reference to `ip_send_check'

This patch is tested.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---
 net/bridge/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 19a6b96..52ef2dc 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -34,7 +34,7 @@ config BRIDGE
 
 config BRIDGE_IGMP_SNOOPING
 	bool "IGMP snooping"
-	depends on BRIDGE
+	depends on BRIDGE && INET
 	default y
 	---help---
 	  If you say Y here, then the Ethernet bridge will be able selectively
-- 
1.6.3.3

