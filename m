Message-Id: <s0daed1b.002@EMAIL>
Date: Thu, 24 Jun 2004 15:02:26 +0530
From: "Kishore A K" <kishoreak@myw.ltindia.com>
Subject: [Bridge] Re: [Patch] [2.6.7] Bridge - Fix BPDU message_age
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: davem@redhat.com, bridge@lists.osdl.org

Hi Stephen,

>>First, we shouldn't send out the config info if our info about the root is too old.

Thats why I had introduced the check "if (bpdu.message_age < br->max_age)".
The purpose of maintaining the message_age parameter is to enable a bridge to 
discard information whose age exceeds Max Age. So I think this would be the right 
way of doing it. You may refer the section "8.6.1.3.3 step 3" in the IEEE 802.1D spec. 
Above that I really did not get the logic behind doing "if (age < stp_t_to_jiffies(2))".
Pls clarify.

>>Second, since the time values in the BPDU are scaled from jiffies to 1/256 sec later
>>in the send process, need to increment age by the appropriate value.

I had completely forgotten about this. However, the purpose of doing the increment is to 
avoid underestimating the age, which is very unlikely to happen. Anyway this can be easily 
done by incrementing the age by a factor ( (1 * HZ)>>8) instead of 1.

>>+		long age = (long) root->message_age_timer.expires
>>+			- (long)jiffies;

"message_age_timer.expires - jiffies" does not give the message age. Instead it gives
the time left before the message age timer expires. Whereas Message age is the time
elapsed since the generation of the configuration BPDU by the root. So the right way
of getting the message age according to me would be 

message_age = max_age - (message_age_timer.expires - jiffies) + (HZ>>8)

Pls correct me if I am wrong here.

Hence the updated patch,

Signed-off-by: Kishore A K <KishoreAK@myw.ltindia.com>

Index: linux-2.6.7/net/bridge/br_stp.c
=============================================================

--- linux-2.6.7/net/bridge/br_stp.c.orig	2004-06-17 20:17:27.000000000 +0530
+++ linux-2.6.7/net/bridge/br_stp.c	2004-06-24 14:45:22.318961664 +0530
@@ -161,20 +161,19 @@ void br_transmit_config(struct net_bridg
 	if (!br_is_root_bridge(br)) {
 		struct net_bridge_port *root
 			= br_get_port(br, br->root_port);
-		bpdu.max_age = root->message_age_timer.expires - jiffies;
-
-		if (bpdu.max_age <= 0) bpdu.max_age = 1;
+		bpdu.message_age = br->max_age - 
+			(root->message_age_timer.expires - jiffies) + (HZ >> 8);
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

 




