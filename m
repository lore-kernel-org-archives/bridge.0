Message-Id: <s0d894d5.033@EMAIL>
Date: Tue, 22 Jun 2004 20:21:24 +0530
From: "Kishore A K" <kishoreak@myw.ltindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [Patch] [2.6.7] Bridge - Fix BPDU message_age
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@lists.osdl.org, linux-kernel@vger.kernel.org

Fixes message_age field update in config BPDUs. Also checks whether the BPDU 
message age has exceeded bridge max age before transmitting config BPDUs.

Signed-off-by: Kishore A K <KishoreAK@myw.ltindia.com>

Index: linux-2.6.7/net/bridge/br_stp.c
=============================================================

--- linux-2.6.7/net/bridge/br_stp.c.orig	2004-06-17 20:17:27.000000000 +0530
+++ linux-2.6.7/net/bridge/br_stp.c	2004-06-22 19:32:49.015908632 +0530
@@ -161,20 +161,19 @@ void br_transmit_config(struct net_bridg
 	if (!br_is_root_bridge(br)) {
 		struct net_bridge_port *root
 			= br_get_port(br, br->root_port);
-		bpdu.max_age = root->message_age_timer.expires - jiffies;
-
-		if (bpdu.max_age <= 0) bpdu.max_age = 1;
+		bpdu.message_age = br->max_age - 
+			(root->message_age_timer.expires - jiffies) + 1;
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



