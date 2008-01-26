Date: Sat, 26 Jan 2008 09:28:11 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Learning BPDU source MACs in BLOCKING state => loss of
	IP connectivity
Message-ID: <20080126092811.6b8aef48@deepthought>
In-Reply-To: <189835152.20080126225622@pinta.ws>
References: <189835152.20080126225622@pinta.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleg Serditov <zir@pinta.ws>
Cc: bridge@lists.linux-foundation.org

On Sat, 26 Jan 2008 22:56:22 +0600
Oleg Serditov <zir@pinta.ws> wrote:

> Hello to all.
> 
> I'm running 2.6.12, uClinux distribution for the Blackfin processor. I
> am experiencing a problem which prevents two boxes connected by a pair
> of links from being able to ping each other.
>

Fixed in 2.6.23.

commit df1c0b8468b34628ed12b103804a4576cd9af8bb
Author: Stephen Hemminger <shemminger@linux-foundation.org>
Date:   Thu Aug 30 22:15:35 2007 -0700

    [BRIDGE]: Packets leaking out of disabled/blocked ports.
    
    This patch fixes some packet leakage in bridge.  The bridging code was
    allowing forward table entries to be generated even if a device was
    being blocked. The fix is to not add forwarding database entries
    unless the port is active.
    
    The bug arose as part of the conversion to processing STP frames
    through normal receive path (in 2.6.17).
    
    Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
    Acked-by: John W. Linville <linville@tuxdriver.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 69b7097..eb57502 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -384,6 +384,11 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
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
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5c18595..6f468fc 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -101,9 +101,8 @@ static int br_handle_local_finish(struct sk_buff *skb)
 {
 	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
 
-	if (p && p->state != BR_STATE_DISABLED)
+	if (p)
 		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
-
 	return 0;	 /* process further */
 }
 



-- 
Stephen Hemminger <stephen.hemminger@vyatta.com>
