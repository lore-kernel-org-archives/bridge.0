Date: Mon, 2 Aug 2004 15:25:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge not bridging NFS fragments?
Message-Id: <20040802152516.7a76bb63@dell_ss3.pdx.osdl.net>
In-Reply-To: <200408022322.00768.bdschuym@pandora.be>
References: <20040801124629.GA11603@merlin.emma.line.org>
	<200408022322.00768.bdschuym@pandora.be>
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
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Matthias Andree <matthias.andree@gmx.de>, bridge@osdl.org

On Mon, 2 Aug 2004 23:22:00 +0200
Bart De Schuymer <bdschuym@pandora.be> wrote:

> On Sunday 01 August 2004 14:46, Matthias Andree wrote:
> > Hi,
> >
> > please Cc: all replies, I'm not subscribed
> >
> > I seem to have troubles with my Linux bridge (2.6.8-rc2), which is
> > apparently not bridging UDP fragments (NFS) when passing packets through
> > iptables, but I do not see in the iptables stats where the packets are
> > dropped. Policies for INPUT, FORWARD, OUTPUT are all "ACCEPT", and I
> > grepped for all REJECT and DROP rules in iptables -nvL, their counters
> > are constant, i. e. they aren't rejecting or dropping packets.
> 
> The patch below fixes this.
> I'm not sure if removing this test, which was recently added, doesn't cause
> problems elsewhere. AFAIK if a too large packet arrives at that place in the
> code, there is a bug somewhere else.
> Stephen, please apply the patch below, except if you think it can cause
> problems, in which case we'll need a different approach.
> The problem occurs when connection tracking is enabled in the kernel.
> Packets are then first defragmented, making skb->len bigger than the mtu.
> 
> cheers,
> Bart
> 
> --- linux-2.6.8-rc2-bk9/net/bridge/br_forward.c.old	2004-08-02 23:15:42.000000000 +0200
> +++ linux-2.6.8-rc2-bk9/net/bridge/br_forward.c	2004-08-02 23:15:55.000000000 +0200
> @@ -23,7 +23,6 @@ static inline int should_deliver(const s
>  				 const struct sk_buff *skb)
>  {
>  	if (skb->dev == p->dev ||
> -	    skb->len > p->dev->mtu ||
>  	    p->state != BR_STATE_FORWARDING)
>  		return 0;
> 


I am worried what happens if you bridge a 4K mtu lan to a 1500 mtu lan..
It is likely that the ethernet driver of the smaller mtu lan will oops or
hang while trying to send the huge skb. No other code path would hand
a huge mtu to a device.
