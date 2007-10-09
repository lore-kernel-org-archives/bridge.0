Date: Tue, 9 Oct 2007 16:28:50 +0200
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
Message-ID: <20071009142850.GA29180@fd.sysnet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] stp timer fix, linux version 2.4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

In kernel 2.4, br_record_config_information update message_age_timer
with jiffies in the past. In 2.6 is already fixed and a similar fix
appeared in v2.4.35.3.

sorry if you receive this twice, I had problem sending to the list (I
think my previous mail got filtered)


Signed-off-by: Francesco Dolcini <fdolcini@sysnetsistemi.it>

--- /a/net/bridge/br_stp.c
+++ /b/net/bridge/br_stp.c
@@ -186,9 +186,11 @@
 	p->designated_cost = bpdu->root_path_cost;
 	p->designated_bridge = bpdu->bridge_id;
 	p->designated_port = bpdu->port_id;
 
-	br_timer_set(&p->message_age_timer, jiffies - bpdu->message_age);
+	br_timer_set(&p->message_age_timer, jiffies +
+		     (p->br->max_age - bpdu->message_age));
+
 }
 
 /* called under bridge lock */
 static void br_record_config_timeout_values(struct net_bridge *br, struct br_config_bpdu *bpdu)
