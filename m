Date: Wed, 23 Jun 2004 14:22:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040623142238.43cfa58f@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0d894d5.034@EMAIL>
References: <s0d894d5.034@EMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [Patch] [2.6.7] Bridge - Fix BPDU message_age
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Kishore A K <kishoreak@myw.ltindia.com>
Cc: "David S. Miller" <davem@redhat.com>, bridge@lists.osdl.org

On Tue, 22 Jun 2004 20:21:24 +0530
"Kishore A K" <kishoreak@myw.ltindia.com> wrote:

> Fixes message_age field update in config BPDUs. Also checks whether the BPDU 
> message age has exceeded bridge max age before transmitting config BPDUs.
> 

The idea is correct, but there are a couple of other issues.
First, we shouldn't send out the config info if our info about the root is too old.
Second, since the time values in the BPDU are scaled from jiffies to 1/256 sec later
in the send process, need to increment age by the appropriate value.

Try this instead please. If it works, I'll send it to Dave.


diff -Nru a/net/bridge/br_private_stp.h b/net/bridge/br_private_stp.h
--- a/net/bridge/br_private_stp.h	2004-06-23 14:18:53 -07:00
+++ b/net/bridge/br_private_stp.h	2004-06-23 14:18:53 -07:00
@@ -26,7 +26,7 @@
 	int		root_path_cost;
 	bridge_id	bridge_id;
 	port_id		port_id;
-	int		message_age;
+	u16		message_age;
 	int		max_age;
 	int		hello_time;
 	int		forward_delay;
@@ -39,6 +39,17 @@
 		(p->designated_port == p->port_id);
 }
 
+
+/* convert system to ticks to 1/256 sec */
+static inline u16 jiffies_to_stp_t(unsigned long j)
+{
+	return (j * 256) / HZ;
+}
+
+static inline unsigned long stp_t_to_jiffies(u16 t)
+{
+	return ((unsigned long) t * HZ) / 256;
+}
 
 /* br_stp.c */
 extern void br_become_root_bridge(struct net_bridge *br);
diff -Nru a/net/bridge/br_stp.c b/net/bridge/br_stp.c
--- a/net/bridge/br_stp.c	2004-06-23 14:18:53 -07:00
+++ b/net/bridge/br_stp.c	2004-06-23 14:18:53 -07:00
@@ -157,14 +157,21 @@
 	bpdu.root_path_cost = br->root_path_cost;
 	bpdu.bridge_id = br->bridge_id;
 	bpdu.port_id = p->port_id;
-	bpdu.message_age = 0;
-	if (!br_is_root_bridge(br)) {
-		struct net_bridge_port *root
-			= br_get_port(br, br->root_port);
-		bpdu.max_age = root->message_age_timer.expires - jiffies;
 
-		if (bpdu.max_age <= 0) bpdu.max_age = 1;
+	if (br_is_root_bridge(br)) 
+		bpdu.message_age = 0;
+	else {
+		struct net_bridge_port *root = br_get_port(br, br->root_port);
+		long age = (long) root->message_age_timer.expires
+			- (long)jiffies;
+
+		/* our info about the root is stale */
+		if (age < stp_t_to_jiffies(2))
+			return;
+
+		bpdu.message_age = jiffies_to_stp_t(age) + 1;
 	}
+
 	bpdu.max_age = br->max_age;
 	bpdu.hello_time = br->hello_time;
 	bpdu.forward_delay = br->forward_delay;
diff -Nru a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
--- a/net/bridge/br_stp_bpdu.c	2004-06-23 14:18:53 -07:00
+++ b/net/bridge/br_stp_bpdu.c	2004-06-23 14:18:53 -07:00
@@ -19,9 +19,6 @@
 #include "br_private.h"
 #include "br_private_stp.h"
 
-#define JIFFIES_TO_TICKS(j) (((j) << 8) / HZ)
-#define TICKS_TO_JIFFIES(j) (((j) * HZ) >> 8)
-
 static void br_send_bpdu(struct net_bridge_port *p, unsigned char *data, int length)
 {
 	struct net_device *dev;
@@ -57,18 +54,17 @@
 		dev_queue_xmit);
 }
 
-static __inline__ void br_set_ticks(unsigned char *dest, int jiff)
+static inline void br_set_ticks(unsigned char *dest, int jiff)
 {
-	__u16 ticks;
+	__u16 ticks = jiffies_to_stp_t(jiff);
 
-	ticks = JIFFIES_TO_TICKS(jiff);
 	dest[0] = (ticks >> 8) & 0xFF;
 	dest[1] = ticks & 0xFF;
 }
 
-static __inline__ int br_get_ticks(unsigned char *dest)
+static inline int br_get_ticks(const unsigned char *dest)
 {
-	return TICKS_TO_JIFFIES((dest[0] << 8) | dest[1]);
+	return stp_t_to_jiffies((dest[0] << 8) | dest[1]);
 }
 
 /* called under bridge lock */
@@ -108,7 +104,9 @@
 	buf[28] = (bpdu->port_id >> 8) & 0xFF;
 	buf[29] = bpdu->port_id & 0xFF;
 
-	br_set_ticks(buf+30, bpdu->message_age);
+	buf[30] = (bpdu->message_age >> 8) & 0xFF;
+	buf[31] = bpdu->message_age & 0xFF;
+
 	br_set_ticks(buf+32, bpdu->max_age);
 	br_set_ticks(buf+34, bpdu->hello_time);
 	br_set_ticks(buf+36, bpdu->forward_delay);
