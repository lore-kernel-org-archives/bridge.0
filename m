Message-ID: <40FD00F4.5020008@siennax.com>
Date: Tue, 20 Jul 2004 13:24:36 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridge code enhancement (link state detection) and bug
	fix. (patches included).
References: <40D1E993.3060801@siennax.com>
	<20040716162855.52d91672@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040716162855.52d91672@dell_ss3.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="------------020802000500010902000306"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format.
--------------020802000500010902000306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:

> 
> Could you split out the link state monitoring, and look at bonding to see
> how they are doing it?
> 
> I have a fix for vlan code that passes MII and ethtool requests from the virtual
> to physical device, so the bridge code wouldn't need to the hack about root device.
> 

Stephen,

I've attached two patches that implement link state monitoring as 
described above.

De bridge-utils patch also fixes a small bug:

./brctl stp TEST
Segmentation fault

--
Mark Ruijter.
bridge@siennax.com

--------------020802000500010902000306
Content-Type: text/x-patch;
 name="linux-2.6.7-bridge_linkstate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.7-bridge_linkstate.patch"

diff -urN ./linux-2.6.7-old/include/linux/if_bridge.h linux-2.6.7/include/linux/if_bridge.h
--- ./linux-2.6.7-old/include/linux/if_bridge.h	2004-06-16 07:19:23.000000000 +0200
+++ linux-2.6.7/include/linux/if_bridge.h	2004-07-19 14:59:56.000000000 +0200
@@ -44,12 +44,14 @@
 #define BRCTL_SET_PORT_PRIORITY 16
 #define BRCTL_SET_PATH_COST 17
 #define BRCTL_GET_FDB_ENTRIES 18
+#define BRCTL_SET_BRIDGE_STP_CARRIER 19
 
 #define BR_STATE_DISABLED 0
 #define BR_STATE_LISTENING 1
 #define BR_STATE_LEARNING 2
 #define BR_STATE_FORWARDING 3
 #define BR_STATE_BLOCKING 4
+#define BR_STATE_NOLINK 5
 
 struct __bridge_info
 {
diff -urN ./linux-2.6.7-old/net/bridge/br_if.c linux-2.6.7/net/bridge/br_if.c
--- ./linux-2.6.7-old/net/bridge/br_if.c	2004-06-16 07:20:26.000000000 +0200
+++ linux-2.6.7/net/bridge/br_if.c	2004-07-19 17:04:54.000000000 +0200
@@ -148,7 +148,8 @@
 	br->bridge_id.prio[0] = 0x80;
 	br->bridge_id.prio[1] = 0x00;
 	memset(br->bridge_id.addr, 0, ETH_ALEN);
-
+        
+        br->stp_check_carrier = 0;
 	br->stp_enabled = 0;
 	br->designated_root = br->bridge_id;
 	br->root_path_cost = 0;
diff -urN ./linux-2.6.7-old/net/bridge/br_ioctl.c linux-2.6.7/net/bridge/br_ioctl.c
--- ./linux-2.6.7-old/net/bridge/br_ioctl.c	2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.7/net/bridge/br_ioctl.c	2004-07-20 12:09:50.000000000 +0200
@@ -246,6 +246,12 @@
 
 		return 0;
 	}
+        case BRCTL_SET_BRIDGE_STP_CARRIER:
+                if (!capable(CAP_NET_ADMIN))
+                        return -EPERM;
+                br->stp_check_carrier = args[1]?args[1]:0;
+                if ( ! br->stp_enabled && br->stp_check_carrier != 0 ) return -EOPNOTSUPP;
+                return 0;
 
 	case BRCTL_SET_BRIDGE_STP_STATE:
 		if (!capable(CAP_NET_ADMIN))
diff -urN ./linux-2.6.7-old/net/bridge/br_private.h linux-2.6.7/net/bridge/br_private.h
--- ./linux-2.6.7-old/net/bridge/br_private.h	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.7/net/bridge/br_private.h	2004-07-19 17:02:07.000000000 +0200
@@ -104,6 +104,7 @@
 
 	u16				root_port;
 	unsigned char			stp_enabled;
+	unsigned char			stp_check_carrier;
 	unsigned char			topology_change;
 	unsigned char			topology_change_detected;
 
@@ -187,6 +188,8 @@
 				    	   u16 port_no);
 extern void br_init_port(struct net_bridge_port *p);
 extern void br_become_designated_port(struct net_bridge_port *p);
+extern void check_link( struct net_bridge_port *p );
+extern int check_dev_link( struct net_device *netdev, int use_carrier );
 
 /* br_stp_if.c */
 extern void br_stp_enable_bridge(struct net_bridge *br);
diff -urN ./linux-2.6.7-old/net/bridge/br_private_stp.h linux-2.6.7/net/bridge/br_private_stp.h
--- ./linux-2.6.7-old/net/bridge/br_private_stp.h	2004-06-16 07:19:36.000000000 +0200
+++ linux-2.6.7/net/bridge/br_private_stp.h	2004-07-19 22:33:08.000000000 +0200
@@ -55,4 +55,13 @@
 extern void br_send_config_bpdu(struct net_bridge_port *, struct br_config_bpdu *);
 extern void br_send_tcn_bpdu(struct net_bridge_port *);
 
+#define IOCTL(dev, arg, cmd) ({         \
+        int res = 0;                    \
+        mm_segment_t fs = get_fs();     \
+        set_fs(get_ds());               \
+        res = ioctl(dev, arg, cmd);     \
+        set_fs(fs);                     \
+        res; })
+
+
 #endif
diff -urN ./linux-2.6.7-old/net/bridge/br_stp.c linux-2.6.7/net/bridge/br_stp.c
--- ./linux-2.6.7-old/net/bridge/br_stp.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.7/net/bridge/br_stp.c	2004-07-20 09:36:41.000000000 +0200
@@ -14,6 +14,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
 
 #include "br_private.h"
 #include "br_private_stp.h"
@@ -24,6 +26,7 @@
 	[BR_STATE_LEARNING] = "learning", 
 	[BR_STATE_FORWARDING] = "forwarding", 
 	[BR_STATE_BLOCKING] = "blocking",
+        [BR_STATE_NOLINK] = "nolink",
 };
 
 void br_log_state(const struct net_bridge_port *p)
@@ -351,10 +354,11 @@
 	if (p->state != BR_STATE_DISABLED &&
 	    p->state != BR_STATE_BLOCKING) {
 		if (p->state == BR_STATE_FORWARDING ||
-		    p->state == BR_STATE_LEARNING)
+		    p->state == BR_STATE_LEARNING ||
+                    p->state == BR_STATE_NOLINK )
 			br_topology_change_detection(p->br);
 
-		p->state = BR_STATE_BLOCKING;
+                if ( p->state != BR_STATE_NOLINK ) p->state = BR_STATE_BLOCKING;
 		br_log_state(p);
 		del_timer(&p->forward_delay_timer);
 	}
@@ -451,3 +455,101 @@
 		br_topology_change_acknowledge(p);
 	}
 }
+
+extern void check_link( struct net_bridge_port *p )
+{
+   int link;
+
+   if ( p->br->stp_check_carrier == 1 ) 
+      link=check_dev_link(p->dev, 1);
+   else
+      link=check_dev_link(p->dev, 0);
+
+   if ( link == 2 ) {
+        pr_info("%s: port %i(%s) does not support link state monitoring with mii/ethtool.\n",
+		p->br->dev->name, p->port_no, p->dev->name);
+        pr_info("%s: Please use net_if_carrier ( nfc ) or disable link state monitoring.\n",
+                p->br->dev->name);
+        return;
+   }
+
+   if ( link == 0 ) {
+      if ( p->state != BR_STATE_NOLINK ) {
+         spin_lock_bh(&p->br->lock);
+         p->config_pending = 0;
+         p->topology_change_ack = 0;
+         br_make_blocking(p);
+         p->state=BR_STATE_NOLINK;
+         spin_unlock_bh(&p->br->lock);
+         br_log_state(p);
+      }
+      return;
+   }
+
+   if ( p->state == BR_STATE_NOLINK ) {
+      spin_lock_bh(&p->br->lock);
+      p->state=BR_STATE_BLOCKING;
+      p->config_pending = 0;
+      p->topology_change_ack = 0;
+      br_log_state(p);
+      br_make_forwarding(p);
+      spin_unlock_bh(&p->br->lock);
+   }
+}
+
+/* Check the linkstate of the port using either ETHTOOL,
+ * or check netif_carrier_ok(), depening upon the setting of the 
+ * use_carrier parameter.
+ *
+ * Return either BMSR_LSTATUS (4), meaning that the link is up (or we
+ * can't tell and just pretend it is), or 0, meaning that the link is
+ * down, or 2 meaning that link state check has failed.
+ *
+ * This code is shamelessly copied from the bonding driver.
+*/
+extern int check_dev_link(struct net_device *netdev, int use_carrier )
+{
+        static int (* ioctl)(struct net_device *, struct ifreq *, int);
+        struct ifreq ifr;
+        struct mii_ioctl_data *mii;
+        struct ethtool_value etool;
+
+        
+        if (use_carrier) {
+                return netif_carrier_ok(netdev) ? BMSR_LSTATUS : 0;
+        }
+
+        ioctl = netdev->do_ioctl;
+        if (ioctl) {
+           strncpy(ifr.ifr_name, netdev->name, IFNAMSIZ);
+           mii = (struct mii_ioctl_data *)&ifr.ifr_data;
+           if (IOCTL(netdev, &ifr, SIOCGMIIPHY) == 0) {
+              mii->reg_num = MII_BMSR;
+              if (IOCTL(netdev, &ifr, SIOCGMIIREG) == 0) {
+                 return (mii->val_out & BMSR_LSTATUS );
+              }
+           }
+        }
+
+        if (netdev->ethtool_ops) {
+                pr_info("Use get_link=%i\n",use_carrier);
+                if (netdev->ethtool_ops->get_link) {
+                        u32 link;
+                        link = netdev->ethtool_ops->get_link(netdev);
+                        return link ? BMSR_LSTATUS : 0;
+                }
+        }
+
+        if (ioctl) {
+           strncpy(ifr.ifr_name, netdev->name, IFNAMSIZ);
+           etool.cmd = ETHTOOL_GLINK;
+           ifr.ifr_data = (char*)&etool;
+           if (IOCTL(netdev, &ifr, SIOCETHTOOL) == 0) {
+              if (etool.data == 1 )
+                 return BMSR_LSTATUS;
+              else
+                 return 0;
+           }
+        }
+        return 2;
+}
diff -urN ./linux-2.6.7-old/net/bridge/br_stp_timer.c linux-2.6.7/net/bridge/br_stp_timer.c
--- ./linux-2.6.7-old/net/bridge/br_stp_timer.c	2004-06-16 07:19:23.000000000 +0200
+++ linux-2.6.7/net/bridge/br_stp_timer.c	2004-07-19 17:29:33.000000000 +0200
@@ -137,7 +137,9 @@
 
 	pr_debug("%s: %d(%s) hold timer expired\n", 
 		 p->br->dev->name,  p->port_no, p->dev->name);
-
+        if (p->br->stp_enabled && p->br->stp_check_carrier != 0 ) {
+            check_link(p);
+        }
 	spin_lock_bh(&p->br->lock);
 	if (p->config_pending)
 		br_transmit_config(p);
diff -urN ./linux-2.6.7-old/net/bridge/stp_enabled linux-2.6.7/net/bridge/stp_enabled
--- ./linux-2.6.7-old/net/bridge/stp_enabled	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7/net/bridge/stp_enabled	2004-07-19 14:47:20.000000000 +0200
@@ -0,0 +1,2 @@
+br_private.h:	return !memcmp(&br->bridge_id, &br->designated_root, 8);
+br_private_stp.h:	return !memcmp(&p->designated_bridge, &p->br->bridge_id, 8) &&

--------------020802000500010902000306
Content-Type: text/x-patch;
 name="bridge-utils-1.0.4-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bridge-utils-1.0.4-2.patch"

diff -urN ./bridge-utils-1.0.4-old/brctl/brctl_cmd.c bridge-utils-1.0.4/brctl/brctl_cmd.c
--- ./bridge-utils-1.0.4-old/brctl/brctl_cmd.c	2004-06-04 20:03:40.000000000 +0200
+++ bridge-utils-1.0.4/brctl/brctl_cmd.c	2004-07-20 12:23:55.000000000 +0200
@@ -257,13 +257,16 @@
 {
 	int stp, err;
 
-	if (!strcmp(argv[2], "on") || !strcmp(argv[2], "yes") 
-	    || !strcmp(argv[2], "1"))
-		stp = 1;
-	else if (!strcmp(argv[2], "off") || !strcmp(argv[2], "no") 
-		 || !strcmp(argv[2], "0"))
-		stp = 0;
-	else {
+        stp=-1;
+        if ( argv[1] && argv[2] ){
+           if (!strcmp(argv[2], "on") || !strcmp(argv[2], "yes") 
+              || !strcmp(argv[2], "1"))
+              stp = 1;
+           else if (!strcmp(argv[2], "off") || !strcmp(argv[2], "no") 
+              || !strcmp(argv[2], "0"))
+              stp = 0;
+        }
+        if ( stp == -1 ){
 		fprintf(stderr, "expect on/off for argument\n");
 		return 1;
 	}
@@ -275,6 +278,36 @@
 	return err != 0;
 }
 
+static int br_cmd_stp_carrier(char** argv)
+{
+	int carrier, err;
+
+        carrier=-1;
+        if ( argv[2] && argv[1] ) {
+	   if (!strcmp(argv[2], "nfc"))
+	   	carrier = 1;
+	   else if (!strcmp(argv[2], "off"))
+	   	carrier = 0;
+           else if (!strcmp(argv[2], "mii"))
+                   carrier = 2;
+        }
+
+        if ( carrier == -1 ) {
+		fprintf(stderr, "expect off to disable, nfc for net_if_carrier (recommended), mii for mii/ethtool linkstate detection\n");
+		return 1;
+	}
+
+	err = br_set_stp_carrier(argv[1], carrier);
+        if (err){
+            if ( err == EOPNOTSUPP ) 
+               fprintf(stderr,"Don't forget to enable stp.\n");
+	    else
+               fprintf(stderr, "set linkstate detection failed: %s\n", 
+                  strerror(errno));
+        }
+	return err != 0;
+}
+
 static int br_cmd_showstp(char** argv)
 {
 	struct bridge_info info;
@@ -396,6 +429,8 @@
 	  "<bridge>\t\tshow bridge stp info"},
 	{ 1, "stp", br_cmd_stp,
 	  "<bridge> <state>\tturn stp on/off" },
+	{ 1, "linkstate", br_cmd_stp_carrier,
+	  "<bridge> <method>\tturn linkstate detection off / nfc (recommended) / mii" },
 };
 
 const struct command *command_lookup(const char *cmd)
diff -urN ./bridge-utils-1.0.4-old/doc/brctl.8 bridge-utils-1.0.4/doc/brctl.8
--- ./bridge-utils-1.0.4-old/doc/brctl.8	2001-11-07 18:16:20.000000000 +0100
+++ bridge-utils-1.0.4/doc/brctl.8	2004-07-20 11:23:45.000000000 +0200
@@ -159,6 +159,18 @@
 dimension. This metric is used in the designated port and root port
 selection algorithms.
 
+.B brctl linkstate <bridge> <method>
+enables link state monitoring of the bridge ports. We support two
+types of link state monitoring. The first type <nfc> uses the
+net_if_carrier_ok() call to determine interface status. 
+
+The second type <mii> uses MII or ETHTOOL ioctls that
+are less efficient and utilize a deprecated calling sequence within the kernel.
+The netif_carrier_ok() relies on the device driver to maintain its state and 
+most, but not all, device drivers support this facility. The netif_carrier_ok()
+call returns that the link is up when the state is unknown. So if brctl showstp
+insists that a link is up when it should not be then switch to <mii>. The <mii>
+code will log errors when it does not support the hardware.
 
 .SH NOTES
 .BR brctl(8)
diff -urN ./bridge-utils-1.0.4-old/libbridge/libbridge.h bridge-utils-1.0.4/libbridge/libbridge.h
--- ./bridge-utils-1.0.4-old/libbridge/libbridge.h	2004-06-08 17:57:49.000000000 +0200
+++ bridge-utils-1.0.4/libbridge/libbridge.h	2004-07-20 12:03:10.000000000 +0200
@@ -100,6 +100,7 @@
 extern int br_set_bridge_max_age(const char *br, struct timeval *tv);
 extern int br_set_ageing_time(const char *br, struct timeval *tv);
 extern int br_set_stp_state(const char *br, int stp_state);
+extern int br_set_stp_carrier(const char *br, int stp_state);
 extern int br_set_bridge_priority(const char *br, int bridge_priority);
 extern int br_set_port_priority(const char *br, const char *p, 
 				int port_priority);
diff -urN ./bridge-utils-1.0.4-old/libbridge/libbridge_devif.c bridge-utils-1.0.4/libbridge/libbridge_devif.c
--- ./bridge-utils-1.0.4-old/libbridge/libbridge_devif.c	2004-06-08 17:57:49.000000000 +0200
+++ bridge-utils-1.0.4/libbridge/libbridge_devif.c	2004-07-19 15:28:07.000000000 +0200
@@ -390,6 +390,11 @@
 	return br_set(br, "stp_state", stp_state, BRCTL_SET_BRIDGE_STP_STATE);
 }
 
+int br_set_stp_carrier(const char *br, int stp_state)
+{
+	return br_set(br, "stp_state", stp_state, BRCTL_SET_BRIDGE_STP_CARRIER);
+}
+
 int br_set_bridge_priority(const char *br, int bridge_priority)
 {
 	return br_set(br, "priority", bridge_priority, 
diff -urN ./bridge-utils-1.0.4-old/libbridge/libbridge_misc.c bridge-utils-1.0.4/libbridge/libbridge_misc.c
--- ./bridge-utils-1.0.4-old/libbridge/libbridge_misc.c	2004-05-21 19:41:49.000000000 +0200
+++ bridge-utils-1.0.4/libbridge/libbridge_misc.c	2004-07-20 09:51:58.000000000 +0200
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
diff -urN ./bridge-utils-1.0.4-old/libbridge/stamp-h1 bridge-utils-1.0.4/libbridge/stamp-h1
--- ./bridge-utils-1.0.4-old/libbridge/stamp-h1	1970-01-01 01:00:00.000000000 +0100
+++ bridge-utils-1.0.4/libbridge/stamp-h1	2004-07-19 16:04:59.000000000 +0200
@@ -0,0 +1 @@
+timestamp for libbridge/config.h

--------------020802000500010902000306--
