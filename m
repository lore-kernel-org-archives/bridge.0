Date: Thu, 24 Apr 2008 15:41:29 +0200
From: Jaime Medrano <jaime.medrano@gmail.com>
Message-ID: <20080424134129.GA27496@localhost>
References: <96CF49BD8B56384395D698BA99007FA32FA1E1@exchange.pacwire.local>
	<20080423104340.2416280e@extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080423104340.2416280e@extreme>
Subject: Re: [Bridge] Getting statistics from a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

On Wed, Apr 23, 2008 at 10:43:40AM -0700, Stephen Hemminger wrote:
> On Wed, 23 Apr 2008 10:53:12 +1000
> "Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:
> 
> >  Is there any way of getting detailed statistics from a bridge?
> > Specifically, I need to know how many frames may have been dropped
> > because they exceed the MTU of the underlying port. I'm having a few
> > issues with MTUs not agreeing.
> 
> It would not be hard to modify kernel to use one of the existing statistics on
> the bridge interface to keep track of the dropped packets. I'll look into it
> if no one else gets to it first (hint, hint)
> 

I think this change will do it.

Regards,
Jaime Medrano.

--- linux-2.6.25.orig/net/bridge/br_forward.c	2008-04-24 11:04:32.000000000 +0200
+++ linux-2.6.25/net/bridge/br_forward.c	2008-04-24 15:15:02.000000000 +0200
@@ -35,9 +35,10 @@
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
 	/* drop mtu oversized packets except gso */
-	if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
+	if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb)) {
+		rcu_dereference(skb->dev->br_port)->br->statistics.tx_dropped++;
 		kfree_skb(skb);
-	else {
+	} else {
 		/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
 		if (nf_bridge_maybe_copy_header(skb))
 			kfree_skb(skb);
