Date: Thu, 10 Mar 2005 15:44:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050310154432.1163ad2d@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] (2/4) bridge: get rid of unneeded include
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, bridge@lists.osdl.org

Get rid of unneeded include.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


diff -Nru a/net/bridge/br.c b/net/bridge/br.c
--- a/net/bridge/br.c	2005-03-10 15:06:38 -08:00
+++ b/net/bridge/br.c	2005-03-10 15:06:38 -08:00
@@ -16,7 +16,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/init.h>
