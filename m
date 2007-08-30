Date: Thu, 30 Aug 2007 12:22:58 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070830122258.1c606516@freepuppy.rosehill.hemminger.net>
In-Reply-To: <426497.88154.qm@web51910.mail.re2.yahoo.com>
References: <20070829150515.54dd7ecf@freepuppy.rosehill.hemminger.net>
	<426497.88154.qm@web51910.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: packets leaking out of disabled/blocked
	ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wang dengyi <dy_wang@yahoo.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

This patch fixes some packet leakage in bridge.  The bridging code
was allowing forward table entries to be generated even if a device
was being blocked. The fix is to not add forwarding database entries
unless the port is active.

The bug arose as part of the conversion to processing STP frames
through normal receive path (in 2.6.17).

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/net/bridge/br_fdb.c	2007-08-30 07:49:01.000000000 -0700
+++ b/net/bridge/br_fdb.c	2007-08-30 11:40:36.000000000 -0700
@@ -384,6 +384,11 @@ void br_fdb_update(struct net_bridge *br
 	if (hold_time(br) == 0)
 		return;
 
+	/* ignore packets unless we are using this port */
+	if (!(source->state == BR_STATE_LEARNING ||
+	      source->state == BR_STATE_FORWARDING))
+		return;
+
 	fdb = fdb_find(head, addr);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
--- a/net/bridge/br_input.c	2007-08-30 07:49:01.000000000 -0700
+++ b/net/bridge/br_input.c	2007-08-30 12:19:57.000000000 -0700
@@ -101,9 +101,8 @@ static int br_handle_local_finish(struct
 {
 	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
 
-	if (p && p->state != BR_STATE_DISABLED)
+	if (p)
 		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
-
 	return 0;	 /* process further */
 }
 
