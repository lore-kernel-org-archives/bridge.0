Date: Thu, 24 Jun 2004 09:54:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: [Patch] [2.6.7] Bridge - Fix BPDU message_age
Message-Id: <20040624095443.527babe2@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0daed1b.003@EMAIL>
References: <s0daed1b.003@EMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 24 Jun 2004 15:02:26 +0530
"Kishore A K" <kishoreak@myw.ltindia.com> wrote:

> Hi Stephen,
> 
> >>First, we shouldn't send out the config info if our info about the root is too old.
> 
> Thats why I had introduced the check "if (bpdu.message_age < br->max_age)".
> The purpose of maintaining the message_age parameter is to enable a bridge to 
> discard information whose age exceeds Max Age. So I think this would be the right 
> way of doing it. You may refer the section "8.6.1.3.3 step 3" in the IEEE 802.1D spec. 
> Above that I really did not get the logic behind doing "if (age < stp_t_to_jiffies(2))".
> Pls clarify.
> 
> >>Second, since the time values in the BPDU are scaled from jiffies to 1/256 sec later
> >>in the send process, need to increment age by the appropriate value.
> 
> I had completely forgotten about this. However, the purpose of doing the increment is to 
> avoid underestimating the age, which is very unlikely to happen. Anyway this can be easily 
> done by incrementing the age by a factor ( (1 * HZ)>>8) instead of 1.
> 
> >>+		long age = (long) root->message_age_timer.expires
> >>+			- (long)jiffies;

> "message_age_timer.expires - jiffies" does not give the message age. Instead it gives
> the time left before the message age timer expires. Whereas Message age is the time
> elapsed since the generation of the configuration BPDU by the root. So the right way
> of getting the message age according to me would be 
> 
> message_age = max_age - (message_age_timer.expires - jiffies) + (HZ>>8)
> 
> Pls correct me if I am wrong here.

Doesn't work if HZ == 100 because then 100 >> 8 = 0.  

Here is an alternative that pushes the increment and message_age < max_age
check down into the send_config_bpdu routine where the conversion to (1/256) ticks
has already taken place.

diff -Nru a/net/bridge/br_private_stp.h b/net/bridge/br_private_stp.h
--- a/net/bridge/br_private_stp.h	2004-06-24 09:52:25 -07:00
+++ b/net/bridge/br_private_stp.h	2004-06-24 09:52:25 -07:00
@@ -52,7 +52,7 @@
 extern void br_topology_change_detection(struct net_bridge *br);
 
 /* br_stp_bpdu.c */
-extern void br_send_config_bpdu(struct net_bridge_port *, struct br_config_bpdu *);
+extern int br_send_config_bpdu(struct net_bridge_port *, struct br_config_bpdu *);
 extern void br_send_tcn_bpdu(struct net_bridge_port *);
 
 #endif
diff -Nru a/net/bridge/br_stp.c b/net/bridge/br_stp.c
--- a/net/bridge/br_stp.c	2004-06-24 09:52:25 -07:00
+++ b/net/bridge/br_stp.c	2004-06-24 09:52:25 -07:00
@@ -157,24 +157,25 @@
 	bpdu.root_path_cost = br->root_path_cost;
 	bpdu.bridge_id = br->bridge_id;
 	bpdu.port_id = p->port_id;
-	bpdu.message_age = 0;
-	if (!br_is_root_bridge(br)) {
+
+	if (br_is_root_bridge(br)) 
+		bpdu.message_age = 0;
+	else {
 		struct net_bridge_port *root
 			= br_get_port(br, br->root_port);
-		bpdu.max_age = root->message_age_timer.expires - jiffies;
-
-		if (bpdu.max_age <= 0) bpdu.max_age = 1;
+		bpdu.message_age = br->max_age 
+			- (root->message_age_timer.expires - jiffies);
 	}
+
 	bpdu.max_age = br->max_age;
 	bpdu.hello_time = br->hello_time;
 	bpdu.forward_delay = br->forward_delay;
 
-	br_send_config_bpdu(p, &bpdu);
-
-	p->topology_change_ack = 0;
-	p->config_pending = 0;
-	
-	mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+	if (br_send_config_bpdu(p, &bpdu)) {
+		p->topology_change_ack = 0;
+		p->config_pending = 0;
+		mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+	}
 }
 
 /* called under bridge lock */
diff -Nru a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
--- a/net/bridge/br_stp_bpdu.c	2004-06-24 09:52:25 -07:00
+++ b/net/bridge/br_stp_bpdu.c	2004-06-24 09:52:25 -07:00
@@ -72,9 +72,10 @@
 }
 
 /* called under bridge lock */
-void br_send_config_bpdu(struct net_bridge_port *p, struct br_config_bpdu *bpdu)
+int br_send_config_bpdu(struct net_bridge_port *p, struct br_config_bpdu *bpdu)
 {
 	unsigned char buf[38];
+	u16 max_age;
 
 	buf[0] = 0x42;
 	buf[1] = 0x42;
@@ -108,12 +109,26 @@
 	buf[28] = (bpdu->port_id >> 8) & 0xFF;
 	buf[29] = bpdu->port_id & 0xFF;
 
-	br_set_ticks(buf+30, bpdu->message_age);
-	br_set_ticks(buf+32, bpdu->max_age);
+	max_age = JIFFIES_TO_TICKS(bpdu->max_age);
+	if (bpdu->message_age) {
+		u16 age = JIFFIES_TO_TICKS(bpdu->message_age)+1;
+		if (age >= max_age)
+			return 0;
+		buf[30] = (age >> 8) & 0xFF;
+		buf[31] = age & 0xFF;
+	} else {
+		buf[30] = 0;
+		buf[31] = 0;
+	}
+
+	buf[32] = (max_age >> 8) & 0xFF;
+	buf[33] = max_age & 0xFF;
+
 	br_set_ticks(buf+34, bpdu->hello_time);
 	br_set_ticks(buf+36, bpdu->forward_delay);
 
 	br_send_bpdu(p, buf, 38);
+	return 0;
 }
 
 /* called under bridge lock */
