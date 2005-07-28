Message-ID: <42E968FF.6000607@metaloft.com>
Date: Thu, 28 Jul 2005 16:23:43 -0700
From: Dirk Morris <dmorris@metaloft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040005000906070502070105"
Subject: [Bridge] mac table updates
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format.
--------------040005000906070502070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think the new mac ageing (sometime since 2.6.8.1) may be too aggressive.
Now it updates the table at a much later time, with a comment in the 
code that leads me to believe
this is to prevent counting spoofed packets and a DOS.

My problem is that the update occurs after the netfilter hooks which may 
do weird things to change the course of the packet so that it does not 
get counted.
(in my case, redirecting, queueing to userspace, nonlocally bound 
sockets, etc).
For me this causes packets to go spewing out on the wrong interface when 
the timer expires.

I used the attached patch to revert back to the old method.

-Dirk

--------------040005000906070502070105
Content-Type: text/x-patch;
 name="bridge-mac-ageing-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bridge-mac-ageing-fix.patch"

diff -urN linux-2.6.12.3/net/bridge/br_input.c linux-2.6.12.3-bridgefix/net/bridge/br_input.c
--- linux-2.6.12.3/net/bridge/br_input.c	2005-07-15 14:18:57.000000000 -0700
+++ linux-2.6.12.3-bridgefix/net/bridge/br_input.c	2005-07-25 23:19:30.903355408 -0700
@@ -111,7 +111,8 @@
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
 		goto err;
 
-	if (p->state == BR_STATE_LEARNING)
+	if (p->state == BR_STATE_LEARNING ||
+        p->state == BR_STATE_FORWARDING)
 		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
 
 	if (p->br->stp_enabled &&

--------------040005000906070502070105--
