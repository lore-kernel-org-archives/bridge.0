Date: Wed, 14 Apr 2004 12:04:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040414120434.2029b567@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.6.5] bridge - replace CLEAR_BITMAP with memset
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org

It looks like a recent patch to 2.6.5 got rid of CLEAR_BITMAP.

diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	Wed Apr 14 12:01:21 2004
+++ b/net/bridge/br_if.c	Wed Apr 14 12:01:21 2004
@@ -175,7 +175,7 @@
 	if (!inuse)
 		return -ENOMEM;
 
-	CLEAR_BITMAP(inuse, BR_MAX_PORTS);
+	memset(inuse, 0, BITS_TO_LONGS(BR_MAX_PORTS)*sizeof(unsigned long));
 	set_bit(0, inuse);	/* zero is reserved */
 	list_for_each_entry(p, &br->port_list, list) {
 		set_bit(p->port_no, inuse);
