Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Thu, 18 Apr 2013 11:17:38 +0200
Message-ID: <1366276658-11938-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH] bridge: Add missing include for in6_addr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, Sven Eckelmann <sven@open-mesh.com>

ee07c6e7a6f8a25c18f0a6b18152fbd7499245f6 ("bridge: export multicast database
via netlink") added "struct br_mdb_entry" which includes an element using the
type "struct in6_addr". The file linux/if_bridge.h is part of the uapi and not
defining this type in this file or its includes causes build failures in
userspace applications.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 include/uapi/linux/if_bridge.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 2d70d79..8e3f287 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -14,6 +14,7 @@
 #define _UAPI_LINUX_IF_BRIDGE_H
 
 #include <linux/types.h>
+#include <linux/in6.h>
 
 #define SYSFS_BRIDGE_ATTR	"bridge"
 #define SYSFS_BRIDGE_FDB	"brforward"
-- 
1.8.2.1

