Date: Mon, 10 May 2004 14:44:20 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040510144420.7c033086@dell_ss3.pdx.osdl.net>
In-Reply-To: <200405100816.i4A8Grhl020664@ns.bginfo.net>
References: <200405100816.i4A8Grhl020664@ns.bginfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge -- fix for multiple ports with same address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Krasiyan Andreev <krasiyan@bginfo.net>, "David S. Miller" <davem@redhat.com>
Cc: bridge@osdl.org

> hi 
> seems a bug due to changes in 2.6.6 in mcast and bridge infrastructure 
> under 2.6.5 same thing works 
> description 
> I want to add some vlans with same adress , in one bridge 
> for pppoe server access concentrator , and some clients with static ip adresses , but in
> different vlans

The bridge code was being to picky. The bridge will still work fine when
there are two interfaces with the same local address, because it is only
used for setting the source address on the outgoing bridge packets.

This should fix it.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1543  -> 1.1544 
#	 net/bridge/br_fdb.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/05/10	shemminger@osdl.org	1.1544
# Allow multiple interfaces with same address (necessary for VLAN's).
# --------------------------------------------
#
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
