Date: Thu, 13 May 2004 10:28:29 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
Message-Id: <20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
In-Reply-To: <1084467136.3083.27.camel@igno>
References: <1084467136.3083.27.camel@igno>
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
To: Diego Liziero <liziero.diego@unimore.it>
Cc: bridge@lists.osdl.org

2.6.6 got too picky about multiple interfaces with the same
address. This patch has been already integrated for later releases.

diff -Nru a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
--- a/net/bridge/br_fdb.c	Mon May 10 13:45:50 2004
+++ b/net/bridge/br_fdb.c	Mon May 10 13:45:50 2004
@@ -277,18 +277,18 @@
 		if (!memcmp(fdb->addr.addr, addr, ETH_ALEN)) {
 			/* attempt to update an entry for a local interface */
 			if (unlikely(fdb->is_local)) {
-				if (is_local) 
-					printk(KERN_INFO "%s: attempt to add"
-					       " interface with same source address.\n",
-					       source->dev->name);
-				else if (net_ratelimit()) 
-					printk(KERN_WARNING "%s: received packet with "
-					       " own address as source address\n",
-					       source->dev->name);
-				ret = -EEXIST;
+				/* it is okay to have multiple ports with same 
+				 * address, just don't allow to be spoofed.
+				 */
+				if (!is_local) {
+					if (net_ratelimit()) 
+						printk(KERN_WARNING "%s: received packet with "
+						       " own address as source address\n",
+						       source->dev->name);
+					ret = -EEXIST;
+				}
 				goto out;
 			}
-
 
 			if (likely(!fdb->is_static || is_local)) {
 				/* move to end of age list */
