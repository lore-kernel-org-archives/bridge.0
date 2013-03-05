Return-Path: <russell@personaltelco.net>
References: <8638w91lft.fsf@coulee.tdb.com>
From: Russell Senior <russell@personaltelco.net>
Date: Tue, 05 Mar 2013 15:33:10 -0800
In-Reply-To: <8638w91lft.fsf@coulee.tdb.com> (Russell Senior's message of
	"Tue\, 05 Mar 2013 15\:22\:30 -0800")
Message-ID: <86ip55zakp.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] [PATCH] bridge-utils: Fix compile against linux-3.8.x
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Linux 3.8 has a header, include/uapi/linux/if_bridge.h that uses a
struct in6_addr but doesn't define it.  The trivial seeming fix of
including the header that does define it causes more problems.  The
problem was discussed on mailing lists in January 2013.  The final
suggestion I found was here:

      http://www.redhat.com/archives/libvir-list/2013-January/msg01253.html

This is intended to implement that suggestion.

Signed-off-by: Russell Senior <russell@personaltelco.net>
---
 libbridge/libbridge.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/libbridge/libbridge.h b/libbridge/libbridge.h
index 39964f2..dd14bae 100644
--- a/libbridge/libbridge.h
+++ b/libbridge/libbridge.h
@@ -20,6 +20,7 @@
 #define _LIBBRIDGE_H
 
 #include <sys/socket.h>
+#include <netinet/in.h>
 #include <linux/if.h>
 #include <linux/if_bridge.h>
 
-- 
1.7.10.4


-- 
Russell Senior, President
russell@personaltelco.net
