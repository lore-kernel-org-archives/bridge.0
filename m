Date: Mon, 21 Jun 2004 14:53:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040621145311.4dc54475@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.4] bridge - eliminate br_ioctl_mutex
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

The bridge code doesn't need a separate ioctl, mutex it can just
use the existing RTNL mechanism.  This avoids some races and deadlocks
on shutdown.

This is for 2.4; a similar mechanism has been in 2.6 for some time.

diff -Nru a/net/bridge/br.c b/net/bridge/br.c
--- a/net/bridge/br.c	2004-06-21 07:46:49 -07:00
+++ b/net/bridge/br.c	2004-06-21 07:46:49 -07:00
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/if_bridge.h>
 #include <linux/brlock.h>
+#include <linux/rtnetlink.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
@@ -54,15 +55,13 @@
 	return 0;
 }
 
-static void __br_clear_ioctl_hook(void)
-{
-	br_ioctl_hook = NULL;
-}
-
 static void __exit br_deinit(void)
 {
 	unregister_netdevice_notifier(&br_device_notifier);
-	br_call_ioctl_atomic(__br_clear_ioctl_hook);
+
+	rtnl_lock();
+	br_ioctl_hook = NULL;
+	rtnl_unlock();
 
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_handle_frame_hook = NULL;
diff -Nru a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
--- a/net/bridge/br_ioctl.c	2004-06-21 07:46:49 -07:00
+++ b/net/bridge/br_ioctl.c	2004-06-21 07:46:49 -07:00
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/if_bridge.h>
 #include <linux/inetdevice.h>
+#include <linux/rtnetlink.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
@@ -230,11 +231,8 @@
 	return -EOPNOTSUPP;
 }
 
-static DECLARE_MUTEX(ioctl_mutex);
-
 int br_ioctl_deviceless_stub(unsigned long arg)
 {
-	int err;
 	unsigned long i[3];
 
 	if (!capable(CAP_NET_ADMIN))
@@ -243,11 +241,8 @@
 	if (copy_from_user(i, (void *)arg, 3*sizeof(unsigned long)))
 		return -EFAULT;
 
-	down(&ioctl_mutex);
-	err = br_ioctl_deviceless(i[0], i[1], i[2]);
-	up(&ioctl_mutex);
-
-	return err;
+	ASSERT_RTNL();
+	return  br_ioctl_deviceless(i[0], i[1], i[2]);
 }
 
 int br_ioctl(struct net_bridge *br, unsigned int cmd, unsigned long arg0, unsigned long arg1, unsigned long arg2)
@@ -257,18 +252,9 @@
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	down(&ioctl_mutex);
+	ASSERT_RTNL();
 	err = br_ioctl_deviceless(cmd, arg0, arg1);
 	if (err == -EOPNOTSUPP)
 		err = br_ioctl_device(br, cmd, arg0, arg1, arg2);
-	up(&ioctl_mutex);
-
 	return err;
-}
-
-void br_call_ioctl_atomic(void (*fn)(void))
-{
-	down(&ioctl_mutex);
-	fn();
-	up(&ioctl_mutex);
 }
diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
--- a/net/bridge/br_private.h	2004-06-21 07:46:49 -07:00
+++ b/net/bridge/br_private.h	2004-06-21 07:46:49 -07:00
@@ -169,7 +169,6 @@
 extern void br_handle_frame(struct sk_buff *skb);
 
 /* br_ioctl.c */
-extern void br_call_ioctl_atomic(void (*fn)(void));
 extern int br_ioctl(struct net_bridge *br,
 	     unsigned int cmd,
 	     unsigned long arg0,
