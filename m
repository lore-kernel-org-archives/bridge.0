Message-ID: <40D1E993.3060801@siennax.com>
Date: Thu, 17 Jun 2004 20:57:23 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030504030106050001010708"
Subject: [Bridge] Bridge code enhancement (link state detection) and bug
 fix. (patches included).
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format.
--------------030504030106050001010708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


1. Link state monitoring added.
We discovered the following problem with the existing bridge code.
The code doesn't monitor the link state of the interfaces. When using
two cisco switches with two Linux bridging firewalls the following
problem exists. When the Cisco switch that has the blocking (stp) Linux
bridge attached dies, the Linux bridge no longer receives stp packets
and changes it's state from blocking to forwarding. As soon as the Cisco
switch comes back alive a loop is created in the network for a short but
long enough period of time. :-(

To fix this I added link state monitoring to the code. This is only
active when stp is turned on. When a link fails the bridge port goes to
blocked and then to the new 'nolink' status. The bridge-utils patch
makes it possible to see the status with brctl showstp.

I did encounter a second problem when writing the link monitoring code.
When you add a vlan interface like eth0.10 then it's not possible to
obtain link state information from this interface.

The fix I wrote is that brctl now allows you to specify the interface
that contains the link state.

Example : brctl addif NUM1 eth0.10 eth0

The old syntax: "brctl addif NUM1 eth0.10" still works but the link will
always appear to be up.

"brctl addif NUM1 eth0" works with link detection since this is a valid
'link state providing' device.

If anyone is wants to know how to use the linux bridges with Cisco 
switches running rstp feel free to ask. It involves a few tricks to get 
it running.....

I also discovered a small bug in de bridge code shipped in 2.6.6.

2. Bug fix...
Creating a bridge like this is no longer possible:

vconfig add eth0 10
vconfig add eth0 20
ifconfig eth0.10 0.0.0.0 up
ifconfig eth0.20 0.0.0.0 up
brctl addbr NUM1
brctl addif NUM1 eth0.10
brctl addif NUM1 eth0.20

The last command produces the following error:
br_add_interface: File exists

Older bridge code did accept this although it would log a warning.

I hope the code can make it to mainstream. Please let me know how you
feel about it.

Mark Ruijter.




--------------030504030106050001010708
Content-Type: text/x-patch;
 name="bridge-utils-1.0.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bridge-utils-1.0.4.patch"

diff -urN ./bridge-utils-1.0.4-old/brctl/brctl.c ./bridge-utils-1.0.4/brctl/brctl.c
--- ./bridge-utils-1.0.4-old/brctl/brctl.c	2004-05-21 19:41:49.000000000 +0200
+++ ./bridge-utils-1.0.4/brctl/brctl.c	2004-06-16 12:10:10.000000000 +0200
@@ -54,7 +54,7 @@
 		goto help;
 	}
 	
-	if (argc < cmd->nargs + 2) {
+	if (argc < cmd->nargs + 2  ) {
 		fprintf(stderr, "incorrect number of arguments for command\n");
 		goto help;
 	}
diff -urN ./bridge-utils-1.0.4-old/brctl/brctl_cmd.c ./bridge-utils-1.0.4/brctl/brctl_cmd.c
--- ./bridge-utils-1.0.4-old/brctl/brctl_cmd.c	2004-06-04 20:03:40.000000000 +0200
+++ ./bridge-utils-1.0.4/brctl/brctl_cmd.c	2004-06-16 00:17:21.000000000 +0200
@@ -83,7 +83,7 @@
 {
 	int err;
 
-	switch (err = br_add_interface(argv[1], argv[2])) {
+	switch (err = br_add_interface(argv[1], argv[2], argv[3])) {
 	case 0:
 		return 0;
 	case ENODEV:
@@ -369,33 +369,33 @@
 }
 
 static const struct command commands[] = {
-	{ 1, "addbr", br_cmd_addbr, "<bridge>\t\tadd bridge" },
-	{ 1, "delbr", br_cmd_delbr, "<bridge>\t\tdelete bridge" },
+	{ 1, "addbr", br_cmd_addbr, "<bridge>\t\t\tadd bridge" },
+	{ 1, "delbr", br_cmd_delbr, "<bridge>\t\t\tdelete bridge" },
 	{ 2, "addif", br_cmd_addif, 
-	  "<bridge> <device>\tadd interface to bridge" },
+	  "<bridge> <dev> [<realdev>]\tadd interface to bridge, <dev> is the bridge device,\n\t\t\t\t\t\t\trealdev (optional) is the device with link information\n\t\t\t\t\t\t\tExample : brctl addif eth0.10 eth0" },
 	{ 2, "delif", br_cmd_delif,
-	  "<bridge> <device>\tdelete interface from bridge" },
+	  "<bridge> <device>\t\tdelete interface from bridge" },
 	{ 2, "setageing", br_cmd_setageing,
-	  "<bridge> <time>\t\tset ageing time" },
+	  "<bridge> <time>\t\t\tset ageing time" },
 	{ 2, "setbridgeprio", br_cmd_setbridgeprio,
-	  "<bridge> <prio>\t\tset bridge priority" },
+	  "<bridge> <prio>\t\t\tset bridge priority" },
 	{ 2, "setfd", br_cmd_setfd,
-	  "<bridge> <time>\t\tset bridge forward delay" },
+	  "<bridge> <time>\t\t\tset bridge forward delay" },
 	{ 2, "sethello", br_cmd_sethello,
-	  "<bridge> <time>\t\tset hello time" },
+	  "<bridge> <time>\t\t\tset hello time" },
 	{ 2, "setmaxage", br_cmd_setmaxage,
-	  "<bridge> <time>\t\tset max message age" },
+	  "<bridge> <time>\t\t\tset max message age" },
 	{ 3, "setpathcost", br_cmd_setpathcost, 
-	  "<bridge> <port> <cost>\tset path cost" },
+	  "<bridge> <port> <cost>\t\tset path cost" },
 	{ 3, "setportprio", br_cmd_setportprio,
-	  "<bridge> <port> <prio>\tset port priority" },
-	{ 0, "show", br_cmd_show, "\t\t\tshow a list of bridges" },
+	  "<bridge> <port> <prio>\t\tset port priority" },
+	{ 0, "show", br_cmd_show, "\t\t\t\tshow a list of bridges" },
 	{ 1, "showmacs", br_cmd_showmacs, 
-	  "<bridge>\t\tshow a list of mac addrs"},
+	  "<bridge>\t\t\tshow a list of mac addrs"},
 	{ 1, "showstp", br_cmd_showstp, 
-	  "<bridge>\t\tshow bridge stp info"},
+	  "<bridge>\t\t\tshow bridge stp info"},
 	{ 1, "stp", br_cmd_stp,
-	  "<bridge> <state>\tturn stp on/off" },
+	  "<bridge> <state>\t\tturn stp on/off" },
 };
 
 const struct command *command_lookup(const char *cmd)
diff -urN ./bridge-utils-1.0.4-old/libbridge/libbridge.h ./bridge-utils-1.0.4/libbridge/libbridge.h
--- ./bridge-utils-1.0.4-old/libbridge/libbridge.h	2004-06-08 17:57:49.000000000 +0200
+++ ./bridge-utils-1.0.4/libbridge/libbridge.h	2004-06-15 23:50:23.000000000 +0200
@@ -93,7 +93,7 @@
 			    struct port_info *info);
 extern int br_add_bridge(const char *brname);
 extern int br_del_bridge(const char *brname);
-extern int br_add_interface(const char *br, const char *dev);
+extern int br_add_interface(const char *br, const char *dev, const char *rdev);
 extern int br_del_interface(const char *br, const char *dev);
 extern int br_set_bridge_forward_delay(const char *br, struct timeval *tv);
 extern int br_set_bridge_hello_time(const char *br, struct timeval *tv);
diff -urN ./bridge-utils-1.0.4-old/libbridge/libbridge_if.c ./bridge-utils-1.0.4/libbridge/libbridge_if.c
--- ./bridge-utils-1.0.4-old/libbridge/libbridge_if.c	2004-06-04 20:03:42.000000000 +0200
+++ ./bridge-utils-1.0.4/libbridge/libbridge_if.c	2004-06-15 23:49:47.000000000 +0200
@@ -66,14 +66,16 @@
 	return  ret < 0 ? errno : 0;
 }
 
-int br_add_interface(const char *bridge, const char *dev)
+int br_add_interface(const char *bridge, const char *dev, const char *rdev )
 {
 	struct ifreq ifr;
 	int err;
 	int ifindex = if_nametoindex(dev);
+        int master_ifindex = if_nametoindex(rdev);
 
 	if (ifindex == 0) 
 		return ENODEV;
+        if (master_ifindex == 0 ) master_ifindex=ifindex;
 	
 	strncpy(ifr.ifr_name, bridge, IFNAMSIZ);
 #ifdef SIOCBRADDIF
@@ -82,7 +84,7 @@
 	if (err < 0)
 #endif
 	{
-		unsigned long args[4] = { BRCTL_ADD_IF, ifindex, 0, 0 };
+		unsigned long args[4] = { BRCTL_ADD_IF, ifindex, master_ifindex, 0 };
 					  
 		ifr.ifr_data = (char *) args;
 		err = ioctl(br_socket_fd, SIOCDEVPRIVATE, &ifr);
diff -urN ./bridge-utils-1.0.4-old/libbridge/libbridge_misc.c ./bridge-utils-1.0.4/libbridge/libbridge_misc.c
--- ./bridge-utils-1.0.4-old/libbridge/libbridge_misc.c	2004-05-21 19:41:49.000000000 +0200
+++ ./bridge-utils-1.0.4/libbridge/libbridge_misc.c	2004-06-15 23:33:30.000000000 +0200
@@ -25,17 +25,18 @@
 #include "libbridge_private.h"
 
 
-static const char *state_names[5] = {
+static const char *state_names[6] = {
 	[BR_STATE_DISABLED] = "disabled", 
 	[BR_STATE_LISTENING] = "listening", 
 	[BR_STATE_LEARNING] = "learning", 
 	[BR_STATE_FORWARDING] = "forwarding", 
 	[BR_STATE_BLOCKING] ="blocking",
+	[BR_STATE_NOLINK] ="nolink",
 };
 
 const char *br_get_state_name(int state)
 {
-	if (state >= 0 && state <= 4)
+	if (state >= 0 && state <= 5)
 		return state_names[state];
 
 	return "<INVALID STATE>";


--------------030504030106050001010708
Content-Type: text/x-patch;
 name="linux-2.6.6-bridge_linkstate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-bridge_linkstate.patch"

diff -urN ./linux-2.6.6-old/include/linux/if_bridge.h ./linux-2.6.6/include/linux/if_bridge.h
--- ./linux-2.6.6-old/include/linux/if_bridge.h	2004-05-10 04:32:37.000000000 +0200
+++ ./linux-2.6.6/include/linux/if_bridge.h	2004-06-15 22:55:46.000000000 +0200
@@ -44,6 +44,7 @@
 #define BR_STATE_LEARNING 2
 #define BR_STATE_FORWARDING 3
 #define BR_STATE_BLOCKING 4
+#define BR_STATE_NOLINK 5
 
 struct __bridge_info
 {
diff -urN ./linux-2.6.6-old/net/bridge/br_fdb.c ./linux-2.6.6/net/bridge/br_fdb.c
--- ./linux-2.6.6-old/net/bridge/br_fdb.c	2004-05-10 04:32:00.000000000 +0200
+++ ./linux-2.6.6/net/bridge/br_fdb.c	2004-06-15 22:17:16.000000000 +0200
@@ -281,12 +281,13 @@
 					printk(KERN_INFO "%s: attempt to add"
 					       " interface with same source address.\n",
 					       source->dev->name);
-				else if (net_ratelimit()) 
+				else if (net_ratelimit()) {
 					printk(KERN_WARNING "%s: received packet with "
 					       " own address as source address\n",
 					       source->dev->name);
-				ret = -EEXIST;
-				goto out;
+				        ret = -EEXIST;
+				        goto out;
+                                }
 			}
 
 
diff -urN ./linux-2.6.6-old/net/bridge/br_if.c ./linux-2.6.6/net/bridge/br_if.c
--- ./linux-2.6.6-old/net/bridge/br_if.c	2004-05-10 04:33:21.000000000 +0200
+++ ./linux-2.6.6/net/bridge/br_if.c	2004-06-15 23:12:30.000000000 +0200
@@ -189,6 +189,7 @@
 /* called under bridge lock */
 static struct net_bridge_port *new_nbp(struct net_bridge *br, 
 				       struct net_device *dev,
+                                       struct net_device *rdev,
 				       unsigned long cost)
 {
 	int index;
@@ -206,6 +207,7 @@
 	p->br = br;
 	dev_hold(dev);
 	p->dev = dev;
+        p->rdev = rdev;
 	p->path_cost = cost;
  	p->priority = 0x8000 >> BR_PORT_BITS;
 	dev->br_port = p;
@@ -257,7 +259,7 @@
 	return ret;
 }
 
-int br_add_if(struct net_bridge *br, struct net_device *dev)
+int br_add_if(struct net_bridge *br, struct net_device *dev , struct net_device *rdev)
 {
 	struct net_bridge_port *p;
 	unsigned long cost;
@@ -275,7 +277,7 @@
 	if (dev->br_port != NULL)
 		err = -EBUSY;
 
-	else if (IS_ERR(p = new_nbp(br, dev, cost)))
+	else if (IS_ERR(p = new_nbp(br, dev, rdev, cost)))
 		err = PTR_ERR(p);
 
  	else if ((err = br_fdb_insert(br, p, dev->dev_addr, 1)))
diff -urN ./linux-2.6.6-old/net/bridge/br_ioctl.c ./linux-2.6.6/net/bridge/br_ioctl.c
--- ./linux-2.6.6-old/net/bridge/br_ioctl.c	2004-05-10 04:32:01.000000000 +0200
+++ ./linux-2.6.6/net/bridge/br_ioctl.c	2004-06-15 22:36:32.000000000 +0200
@@ -39,17 +39,19 @@
 	case BRCTL_DEL_IF:
 	{
 		struct net_device *dev;
+                struct net_device *rdev;
 		int ret;
 
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
 		dev = dev_get_by_index(arg0);
+                rdev = dev_get_by_index(arg1);
 		if (dev == NULL)
 			return -EINVAL;
 
 		if (cmd == BRCTL_ADD_IF)
-			ret = br_add_if(br, dev);
+			ret = br_add_if(br, dev, rdev);
 		else
 			ret = br_del_if(br, dev);
 
diff -urN ./linux-2.6.6-old/net/bridge/br_private.h ./linux-2.6.6/net/bridge/br_private.h
--- ./linux-2.6.6-old/net/bridge/br_private.h	2004-05-10 04:32:26.000000000 +0200
+++ ./linux-2.6.6/net/bridge/br_private.h	2004-06-15 22:47:18.000000000 +0200
@@ -58,6 +58,7 @@
 {
 	struct net_bridge		*br;
 	struct net_device		*dev;
+	struct net_device		*rdev;
 	struct list_head		list;
 
 	/* STP */
@@ -84,6 +85,7 @@
 	spinlock_t			lock;
 	struct list_head		port_list;
 	struct net_device		*dev;
+	struct net_device		*rdev;
 	struct net_device_stats		statistics;
 	rwlock_t			hash_lock;
 	struct hlist_head		hash[BR_HASH_SIZE];
@@ -165,7 +167,7 @@
 extern int br_del_bridge(const char *name);
 extern void br_cleanup_bridges(void);
 extern int br_add_if(struct net_bridge *br,
-	      struct net_device *dev);
+	      struct net_device *dev, struct net_device *rdev);
 extern int br_del_if(struct net_bridge *br,
 	      struct net_device *dev);
 extern int br_get_bridge_ifindices(int *indices,
@@ -195,6 +197,7 @@
 				    	   u16 port_no);
 extern void br_init_port(struct net_bridge_port *p);
 extern void br_become_designated_port(struct net_bridge_port *p);
+void check_link( struct net_bridge_port *p );
 
 /* br_stp_if.c */
 extern void br_stp_enable_bridge(struct net_bridge *br);
diff -urN ./linux-2.6.6-old/net/bridge/br_stp.c ./linux-2.6.6/net/bridge/br_stp.c
--- ./linux-2.6.6-old/net/bridge/br_stp.c	2004-05-10 04:32:25.000000000 +0200
+++ ./linux-2.6.6/net/bridge/br_stp.c	2004-06-16 12:29:25.000000000 +0200
@@ -14,6 +14,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/ethtool.h>
 
 #include "br_private.h"
 #include "br_private_stp.h"
@@ -24,6 +25,7 @@
 	[BR_STATE_LEARNING] = "learning", 
 	[BR_STATE_FORWARDING] = "forwarding", 
 	[BR_STATE_BLOCKING] = "blocking",
+        [BR_STATE_NOLINK] = "nolink",
 };
 
 void br_log_state(const struct net_bridge_port *p)
@@ -351,10 +353,11 @@
 	if (p->state != BR_STATE_DISABLED &&
 	    p->state != BR_STATE_BLOCKING) {
 		if (p->state == BR_STATE_FORWARDING ||
-		    p->state == BR_STATE_LEARNING)
+		    p->state == BR_STATE_LEARNING || 
+                    p->state == BR_STATE_NOLINK )
 			br_topology_change_detection(p->br);
 
-		p->state = BR_STATE_BLOCKING;
+		if ( p->state != BR_STATE_NOLINK ) p->state = BR_STATE_BLOCKING;
 		br_log_state(p);
 		del_timer(&p->forward_delay_timer);
 	}
@@ -363,14 +366,55 @@
 /* called under bridge lock */
 static void br_make_forwarding(struct net_bridge_port *p)
 {
-	if (p->state == BR_STATE_BLOCKING) {
-		if (p->br->stp_enabled) {
-			p->state = BR_STATE_LISTENING;
-		} else {
-			p->state = BR_STATE_LEARNING;
-		}
-		br_log_state(p);
-		mod_timer(&p->forward_delay_timer, jiffies + p->br->forward_delay);	}
+        if (p->state == BR_STATE_BLOCKING  ) {
+                if (p->br->stp_enabled) {
+                        p->state = BR_STATE_LISTENING;
+                } else {
+                        p->state = BR_STATE_LEARNING;
+                }
+                br_log_state(p);
+                mod_timer(&p->forward_delay_timer, jiffies + p->br->forward_delay);     }
+}
+
+void check_link( struct net_bridge_port *p )
+{
+        if ( p->rdev != NULL ) {
+            if ( ethtool_op_get_link( p->rdev ) ) {
+                if ( p->state == BR_STATE_NOLINK ) {
+                     spin_lock_bh(&p->br->lock);
+                     p->state=BR_STATE_BLOCKING;
+                     p->config_pending = 0;
+                     p->topology_change_ack = 0;
+		     br_log_state(p);
+	             br_make_forwarding(p);
+                     spin_unlock_bh(&p->br->lock);
+                }
+                return;
+            }
+        } else {
+           if ( ethtool_op_get_link( p->dev ) ) {
+                if ( p->state == BR_STATE_NOLINK ) {
+                     spin_lock_bh(&p->br->lock);
+                     p->state=BR_STATE_BLOCKING;
+                     p->config_pending = 0;
+                     p->topology_change_ack = 0;
+		     br_log_state(p);
+	             br_make_forwarding(p);
+                     spin_unlock_bh(&p->br->lock);
+                }
+                return;
+           }
+        }
+        if ( p->state != BR_STATE_NOLINK ) {
+           spin_lock_bh(&p->br->lock);
+           p->config_pending = 0;
+           p->topology_change_ack = 0;
+   	   br_make_blocking(p);
+           p->state=BR_STATE_NOLINK;
+           spin_unlock_bh(&p->br->lock);
+           br_log_state(p);
+        }
+        return; 
 }
 
 /* called under bridge lock */
@@ -379,11 +423,11 @@
 	struct net_bridge_port *p;
 
 	list_for_each_entry(p, &br->port_list, list) {
-		if (p->state != BR_STATE_DISABLED) {
+		if (p->state != BR_STATE_DISABLED ) {
 			if (p->port_no == br->root_port) {
 				p->config_pending = 0;
 				p->topology_change_ack = 0;
-				br_make_forwarding(p);
+                                br_make_forwarding(p);
 			} else if (br_is_designated_port(p)) {
 				del_timer(&p->message_age_timer);
 				br_make_forwarding(p);
diff -urN ./linux-2.6.6-old/net/bridge/br_stp_timer.c ./linux-2.6.6/net/bridge/br_stp_timer.c
--- ./linux-2.6.6-old/net/bridge/br_stp_timer.c	2004-05-10 04:32:37.000000000 +0200
+++ ./linux-2.6.6/net/bridge/br_stp_timer.c	2004-06-16 13:42:00.000000000 +0200
@@ -136,7 +136,9 @@
 
 	pr_debug("%s: %d(%s) hold timer expired\n", 
 		 p->br->dev->name,  p->port_no, p->dev->name);
-
+        if (p->br->stp_enabled) {
+            check_link(p);
+        }
 	spin_lock_bh(&p->br->lock);
 	if (p->config_pending)
 		br_transmit_config(p);


--------------030504030106050001010708--
