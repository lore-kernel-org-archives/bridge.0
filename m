From: Dylan Hall <dylan@citylink.co.nz>
Content-Type: multipart/mixed; boundary="=-bLRd2+RIuR1hT5bvRUN+"
Date: Mon, 16 Apr 2007 10:29:31 +1200
Message-Id: <1176676171.3713.16.camel@collymore.citylink.co.nz>
Mime-Version: 1.0
Subject: [Bridge] Feature enhancement - Disable unicast flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

--=-bLRd2+RIuR1hT5bvRUN+
Content-Type: multipart/alternative;
	boundary="----------=_1176676185-15622-199"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1176676185-15622-199
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

For the project I'm working on I require that the bridging code not
flood unicast frames when the destination mac address is unknown,
similar to Cisco's "switchport block unicast" feature
(http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814).

I have produced a small patch (against 2.6.20.4) to control this feature
per bridge (rather than per port like a Cisco).

Have I gone about implementing this correctly?

Is this something other people may find useful, and hence worth
incorporating into the mainstream code?

Is it worth the effort of taking this one step further, and controlling
the behaviour per port rather than per bridge?

Thanks,

Dylan




------------=_1176676185-15622-199
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.1">
</HEAD>
<BODY>
For the project I'm working on I require that the bridging code not flood unicast frames when the destination mac address is unknown, similar to Cisco's &quot;switchport block unicast&quot; feature (<A HREF="http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814).">http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814).</A><BR>
<BR>
I have produced a small patch (against 2.6.20.4) to control this feature per bridge (rather than per port like a Cisco).<BR>
<BR>
Have I gone about implementing this correctly?<BR>
<BR>
Is this something other people may find useful, and hence worth incorporating into the mainstream code?<BR>
<BR>
Is it worth the effort of taking this one step further, and controlling the behaviour per port rather than per bridge?<BR>
<BR>
Thanks,<BR>
<BR>
Dylan<BR>
<BR>
<BR>
<BR>
</BODY>
</HTML>

------------=_1176676185-15622-199--

--=-bLRd2+RIuR1hT5bvRUN+
Content-Disposition: attachment; filename="unicast-flooding-2.6.20.4.patch"
Content-Type: text/x-patch; name=unicast-flooding-2.6.20.4.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.20.4/net/bridge/br_device.c linux-2.6.20.4-dodgy-bridge/net/bridge/br_device.c
--- linux-2.6.20.4/net/bridge/br_device.c	2007-03-24 07:52:51.000000000 +1200
+++ linux-2.6.20.4-dodgy-bridge/net/bridge/br_device.c	2007-04-12 22:55:18.000000000 +1200
@@ -44,9 +44,12 @@
 		br_flood_deliver(br, skb, 0);
 	else if ((dst = __br_fdb_get(br, dest)) != NULL)
 		br_deliver(dst->dst, skb);
+	else if (br->flood_unknown_unicast)
+	        br_flood_deliver(br, skb, 0);
 	else
-		br_flood_deliver(br, skb, 0);
-
+	  kfree_skb(skb);
+	  
+	
 	return 0;
 }
 
diff -Naur linux-2.6.20.4/net/bridge/br_if.c linux-2.6.20.4-dodgy-bridge/net/bridge/br_if.c
--- linux-2.6.20.4/net/bridge/br_if.c	2007-03-24 07:52:51.000000000 +1200
+++ linux-2.6.20.4-dodgy-bridge/net/bridge/br_if.c	2007-04-12 22:39:58.000000000 +1200
@@ -230,6 +230,8 @@
 	br->ageing_time = 300 * HZ;
 	INIT_LIST_HEAD(&br->age_list);
 
+	br->flood_unknown_unicast = 1;
+
 	br_stp_timer_init(br);
 
 	return dev;
diff -Naur linux-2.6.20.4/net/bridge/br_input.c linux-2.6.20.4-dodgy-bridge/net/bridge/br_input.c
--- linux-2.6.20.4/net/bridge/br_input.c	2007-03-24 07:52:51.000000000 +1200
+++ linux-2.6.20.4-dodgy-bridge/net/bridge/br_input.c	2007-04-12 22:56:38.000000000 +1200
@@ -87,7 +87,12 @@
 		goto out;
 	}
 
-	br_flood_forward(br, skb, 0);
+	if (br->flood_unknown_unicast) {
+	        br_flood_forward(br, skb, 0);
+		goto out;
+	}
+
+	goto drop;
 
 out:
 	return 0;
diff -Naur linux-2.6.20.4/net/bridge/br_private.h linux-2.6.20.4-dodgy-bridge/net/bridge/br_private.h
--- linux-2.6.20.4/net/bridge/br_private.h	2007-03-24 07:52:51.000000000 +1200
+++ linux-2.6.20.4-dodgy-bridge/net/bridge/br_private.h	2007-04-12 22:23:37.000000000 +1200
@@ -120,6 +120,8 @@
 	struct timer_list		topology_change_timer;
 	struct timer_list		gc_timer;
 	struct kobject			ifobj;
+
+        unsigned char                   flood_unknown_unicast;
 };
 
 extern struct notifier_block br_device_notifier;
diff -Naur linux-2.6.20.4/net/bridge/br_sysfs_br.c linux-2.6.20.4-dodgy-bridge/net/bridge/br_sysfs_br.c
--- linux-2.6.20.4/net/bridge/br_sysfs_br.c	2007-03-24 07:52:51.000000000 +1200
+++ linux-2.6.20.4-dodgy-bridge/net/bridge/br_sysfs_br.c	2007-04-12 23:32:22.000000000 +1200
@@ -290,6 +290,28 @@
 			 show_group_addr, store_group_addr);
 
 
+
+static ssize_t show_flood_unknown_unicast_state(struct class_device *cd, char *buf)
+{
+	struct net_bridge *br = to_bridge(cd);
+	return sprintf(buf, "%d\n", br->flood_unknown_unicast);
+}
+
+static void set_flood_unknown_unicast_state(struct net_bridge *br, unsigned long val)
+{
+	br->flood_unknown_unicast = val;
+}
+
+static ssize_t store_flood_unknown_unicast_state(struct class_device *cd,
+			       const char *buf, size_t len)
+{
+	return store_bridge_parm(cd, buf, len, set_flood_unknown_unicast_state);
+}
+
+static CLASS_DEVICE_ATTR(flood_unknown_unicast, S_IRUGO | S_IWUSR, show_flood_unknown_unicast_state,
+			 store_flood_unknown_unicast_state);
+
+
 static struct attribute *bridge_attrs[] = {
 	&class_device_attr_forward_delay.attr,
 	&class_device_attr_hello_time.attr,
@@ -308,6 +330,7 @@
 	&class_device_attr_topology_change_timer.attr,
 	&class_device_attr_gc_timer.attr,
 	&class_device_attr_group_addr.attr,
+	&class_device_attr_flood_unknown_unicast.attr,
 	NULL
 };
 

--=-bLRd2+RIuR1hT5bvRUN+--
