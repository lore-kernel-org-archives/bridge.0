Date: Tue, 22 Jun 2004 16:30:23 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040622163023.29a1862a@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] turn off debug error message in bridge ioctl
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: bridge@osdl.org

Trivial patch to turn off a debug message.  It seems some SNMP daemons just
periodically trying to look at MII state.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

 
diff -Nru a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
--- a/net/bridge/br_ioctl.c	2004-06-22 16:28:20 -07:00
+++ b/net/bridge/br_ioctl.c	2004-06-22 16:28:20 -07:00
@@ -403,6 +403,6 @@
 
 	}
 
-	printk(KERN_DEBUG "Bridge does not support ioctl 0x%x\n", cmd);
+	pr_debug("Bridge does not support ioctl 0x%x\n", cmd);
 	return -EOPNOTSUPP;
 }
