Message-ID: <40FBB78C.5070209@tv.debian.net>
Date: Mon, 19 Jul 2004 14:59:08 +0300
From: Tommi Virtanen <tv@tv.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] typo in br_stp.c: propgating -> propagating
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi. I'm not subscribed, so please Cc: me.

This trivial patch fixes a typo that irritates me every time I boot..

--- linux-2.5.orig/net/bridge/br_stp.c	2004-07-19 14:43:44.000000000 +0300
+++ linux-2.5/net/bridge/br_stp.c	2004-07-19 14:53:15.000000000 +0300
@@ -299,7 +299,7 @@
  	int isroot = br_is_root_bridge(br);

  	pr_info("%s: topology change detected, %s\n", br->dev->name,
-		isroot ? "propgating" : "sending tcn bpdu");
+		isroot ? "propagating" : "sending tcn bpdu");

  	if (isroot) {
  		br->topology_change = 1;
