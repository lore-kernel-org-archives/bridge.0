From: Bart De Schuymer <bdschuym@pandora.be>
Subject: [PATCH][BRIDGE] br.c depends on CONFIG_BRIDGE_NETFILTER,
	not CONFIG_NETFILTER
Date: Wed, 26 Nov 2003 00:30:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311260030.21197.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S.Miller" <davem@redhat.com>
Cc: Michal Janusz Miroslaw <M.Miroslaw@elka.pw.edu.pl>, bridge <bridge@osdl.org>, Stephen Hemminger <shemminger@osdl.org>

Hi Dave,

The patch below lets the bridge compile when CONFIG_BRIDGE_NETFILTER
isn't enabled.
This patch is an update of M.J. Miroslaw's patch that arrived through
private mail.

cheers,
Bart

--- linux-2.6.0-test10/net/bridge/br.c.old	Wed Nov 26 01:28:16 2003
+++ linux-2.6.0-test10/net/bridge/br.c	Wed Nov 26 01:31:54 2003
@@ -32,7 +32,7 @@ int (*br_should_route_hook) (struct sk_b
 
 static int __init br_init(void)
 {
-#if defined(CONFIG_INET) && defined(CONFIG_NETFILTER)
+#ifdef CONFIG_BRIDGE_NETFILTER
 	if (br_netfilter_init())
 		return 1;
 #endif
@@ -50,7 +50,7 @@ static int __init br_init(void)
 
 static void __exit br_deinit(void)
 {
-#if defined(CONFIG_INET) && defined(CONFIG_NETFILTER)
+#ifdef CONFIG_BRIDGE_NETFILTER
 	br_netfilter_fini();
 #endif
 	unregister_netdevice_notifier(&br_device_notifier);

