Message-Id: <20051220232155.044138000@localhost.localdomain>
References: <20051220231949.772360000@localhost.localdomain>
Date: Tue, 20 Dec 2005 15:19:54 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Content-Disposition: inline; filename=br-version.patch
Subject: [Bridge] [PATCH 5/5] bridge: add version number
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@osdl.org

Add version info to bridge module.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- br-2.6.16.orig/net/bridge/br.c
+++ br-2.6.16/net/bridge/br.c
@@ -67,3 +67,4 @@ EXPORT_SYMBOL(br_should_route_hook);
 module_init(br_init)
 module_exit(br_deinit)
 MODULE_LICENSE("GPL");
+MODULE_VERSION(BR_VERSION);
--- br-2.6.16.orig/net/bridge/br_private.h
+++ br-2.6.16/net/bridge/br_private.h
@@ -29,6 +29,8 @@
 
 #define BR_PORT_DEBOUNCE (HZ/10)
 
+#define BR_VERSION	"2.1"
+
 typedef struct bridge_id bridge_id;
 typedef struct mac_addr mac_addr;
 typedef __u16 port_id;

--
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger

