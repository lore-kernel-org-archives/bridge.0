Date: Tue, 29 Jun 2004 15:35:03 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040629153503.5d214fd0@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0daed1b.003@EMAIL>
References: <s0daed1b.003@EMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.6] Fix message age in bridge STP config packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Kishore A K <kishoreak@myw.ltindia.com>
Cc: davem@redhat.com, netdev@oss.sgi.com, bridge@lists.osdl.org

This is a revised version of Kishore's patch to set message age appropriately
in STP configuration packets.

Signed-off-by: Kishore A K <KishoreAK@myw.ltindia.com>
Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_stp.c b/net/bridge/br_stp.c
--- a/net/bridge/br_stp.c	2004-06-29 14:45:50 -07:00
+++ b/net/bridge/br_stp.c	2004-06-29 14:45:50 -07:00
@@ -18,6 +18,11 @@
 #include "br_private.h"
 #include "br_private_stp.h"
 
+/* since time values in bpdu are in jiffies and then scaled (1/256)
+ * before sending, make sure that is at least one.
+ */
+#define MESSAGE_AGE_INCR	((HZ < 256) ? 1 : (HZ/256))
+
 static const char *br_port_state_names[] = {
 	[BR_STATE_DISABLED] = "disabled", 
 	[BR_STATE_LISTENING] = "listening",
@@ -157,24 +162,25 @@
 	bpdu.root_path_cost = br->root_path_cost;
 	bpdu.bridge_id = br->bridge_id;
 	bpdu.port_id = p->port_id;
-	bpdu.message_age = 0;
-	if (!br_is_root_bridge(br)) {
+	if (br_is_root_bridge(br))
+		bpdu.message_age = 0;
+	else {
 		struct net_bridge_port *root
 			= br_get_port(br, br->root_port);
-		bpdu.max_age = root->message_age_timer.expires - jiffies;
-
-		if (bpdu.max_age <= 0) bpdu.max_age = 1;
+		bpdu.message_age = br->max_age
+			- (root->message_age_timer.expires - jiffies)
+			+ MESSAGE_AGE_INCR;
 	}
 	bpdu.max_age = br->max_age;
 	bpdu.hello_time = br->hello_time;
 	bpdu.forward_delay = br->forward_delay;
 
-	br_send_config_bpdu(p, &bpdu);
-
-	p->topology_change_ack = 0;
-	p->config_pending = 0;
-	
-	mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+	if (bpdu.message_age < br->max_age) {
+		br_send_config_bpdu(p, &bpdu);
+		p->topology_change_ack = 0;
+		p->config_pending = 0;
+		mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+	}
 }
 
 /* called under bridge lock */
