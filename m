Date: Thu, 30 Sep 2004 09:23:52 -0400 (EDT)
From: Dan Eble <dane@aiinet.com>
Message-ID: <Pine.LNX.4.44.0409300921430.13917-100000@dane-linux.ai.aiinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bridge] [PATCH] netlink message on bridge address change
Reply-To: dane@aiinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Is this an acceptable way to notify a daemon when a bridge address 
changes?

-- 
Dan Eble <dane@aiinet.com>  _____  .
Software Engineer          |  _  |/|
Applied Innovation Inc.    | |_| | |
http://www.aiinet.com/     |__/|_|_|

diff -9 -urN Old/net/bridge/br_ioctl.c New/net/bridge/br_ioctl.c
--- Old/net/bridge/br_ioctl.c	2004-09-27 16:19:12.000000000 -0400
+++ New/net/bridge/br_ioctl.c	2004-09-27 16:19:12.000000000 -0400
@@ -10,47 +10,59 @@
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  */
 
 #include <linux/kernel.h>
 #include <linux/if_bridge.h>
 #include <linux/inetdevice.h>
+#include <linux/rtnetlink.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
 static int br_ioctl_device(struct net_bridge *br,
 			   unsigned int cmd,
 			   unsigned long arg0,
 			   unsigned long arg1,
 			   unsigned long arg2)
 {
 	if (br == NULL)
 		return -EINVAL;
 
 	switch (cmd)
 	{
 	case BRCTL_ADD_IF:
 	case BRCTL_DEL_IF:
 	{
+		unsigned char oldaddr[ETH_ALEN];
+
 		struct net_device *dev;
 		int ret;
 
 		dev = dev_get_by_index(arg0);
 		if (dev == NULL)
 			return -EINVAL;
 
+		read_lock(&br->lock);
+		memcpy(oldaddr, br->bridge_id.addr, ETH_ALEN);
+		read_unlock(&br->lock);
+
 		if (cmd == BRCTL_ADD_IF)
 			ret = br_add_if(br, dev);
 		else
 			ret = br_del_if(br, dev);
 
+		read_lock(&br->lock);
+		if (0 != memcmp(oldaddr, br->bridge_id.addr, ETH_ALEN))
+			rtmsg_ifinfo(RTM_NEWLINK, &br->dev, 0);
+		read_unlock(&br->lock);
+
 		dev_put(dev);
 		return ret;
 	}
 
 	case BRCTL_GET_BRIDGE_INFO:
 	{
 		struct __bridge_info b;
 
 		memset(&b, 0, sizeof(struct __bridge_info));

