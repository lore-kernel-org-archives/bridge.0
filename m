Date: Mon, 26 Nov 2007 09:01:54 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Conflict between net/if.h and linux/if.h
Message-ID: <20071126090154.10c8ec1e@freepuppy.rosehill.pdx.hemminger.net>
In-Reply-To: <81c11a560711220316n60921656md0aaefd95a82e63a@mail.gmail.com>
References: <81c11a560711220316n60921656md0aaefd95a82e63a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Edouard Thuleau <doudouyam@gmail.com>
Cc: bridge@lists.linux-foundation.org

I fixed the problem differently because I don't want more conditional
compilation.  The ideal fix would be to get glibc
to the headers fixed to be compatible.

 Use linux/if.h rather than net/if.h for compatiablity with
 other headers.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
---
 libbridge/libbridge.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/libbridge/libbridge.h b/libbridge/libbridge.h
index 20d5bb5..016acea 100644
--- a/libbridge/libbridge.h
+++ b/libbridge/libbridge.h
@@ -19,9 +19,15 @@
 #ifndef _LIBBRIDGE_H
 #define _LIBBRIDGE_H
 
-#include <net/if.h>
+#include <sys/socket.h>
+#include <linux/if.h>
 #include <linux/if_bridge.h>
 
+/* defined in net/if.h but that conflicts with linux/if.h... */
+extern unsigned int if_nametoindex (const char *__ifname);
+extern char *if_indextoname (unsigned int __ifindex, char *__ifname);
+
+
 struct bridge_id
 {
 	unsigned char prio[2];
-- 
1.5.3.4

