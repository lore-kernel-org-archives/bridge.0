Date: Tue, 29 Jun 2004 15:37:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040629153740.11e35bb1@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0dc91e5.046@EMAIL>
References: <s0dc91e5.046@EMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.4] Bridge STP message age
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Kishore A K <kishoreak@myw.ltindia.com>
Cc: davem@redhat.com, bridge@lists.osdl.org

This is the 2.4 version which incorporates the observations from Kishore
about 2.6. The existing 2.4 code set the age properly, but did not increment
correctly for HZ=1000 and could send a stale (expired) configuration.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_stp.c b/net/bridge/br_stp.c
--- a/net/bridge/br_stp.c	2004-06-29 15:30:32 -07:00
+++ b/net/bridge/br_stp.c	2004-06-29 15:30:32 -07:00
@@ -20,7 +20,10 @@
 #include "br_private.h"
 #include "br_private_stp.h"
 
-
+/* since time values in bpdu are in jiffies and then scaled (1/256)
+ * before sending, make sure that is at least one.
+ */
+#define MESSAGE_AGE_INCR	((HZ < 256) ? 1 : (HZ/256))
 
 /* called under ioctl_lock or bridge lock */
 int br_is_root_bridge(struct net_bridge *br)
@@ -160,24 +163,26 @@
 	bpdu.root_path_cost = br->root_path_cost;
 	bpdu.bridge_id = br->bridge_id;
 	bpdu.port_id = p->port_id;
-	bpdu.message_age = 0;
-	if (!br_is_root_bridge(br)) {
+	if (br_is_root_bridge(br)) 
+		bpdu.message_age = 0;
+	else {
 		struct net_bridge_port *root;
-		unsigned long age;
 
 		root = br_get_port(br, br->root_port);
-		age = br_timer_get_residue(&root->message_age_timer) + 1;
-		bpdu.message_age = age;
+		bpdu.message_age =  br_timer_get_residue(&root->message_age_timer)
+			+ MESSAGE_AGE_INCR;
 	}
 	bpdu.max_age = br->max_age;
 	bpdu.hello_time = br->hello_time;
 	bpdu.forward_delay = br->forward_delay;
 
-	br_send_config_bpdu(p, &bpdu);
+	if (bpdu.message_age < br->max_age) {
+		br_send_config_bpdu(p, &bpdu);
 
-	p->topology_change_ack = 0;
-	p->config_pending = 0;
-	br_timer_set(&p->hold_timer, jiffies);
+		p->topology_change_ack = 0;
+		p->config_pending = 0;
+		br_timer_set(&p->hold_timer, jiffies);
+	}
 }
 
 /* called under bridge lock */
