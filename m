Message-ID: <20040803032754.16047.qmail@web13902.mail.yahoo.com>
Date: Mon, 2 Aug 2004 20:27:54 -0700 (PDT)
From: Scott MacKay <scottmackay@yahoo.com>
Subject: Re: [Bridge] Bridge not bridging NFS fragments?
In-Reply-To: <200408022322.00768.bdschuym@pandora.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Actually, I think I saw this very same thing when I
was testing FC2.  I have a QUEUE iptables target. 
When I got packets larger than the MTU (cannot
remember the exact number it has problems with) my
packets were useless.  I have conntrack enabled,
needed because I want the packets reassembled (to
obviously get fragmented later in the process).  It
worked perfectly fine under 2.4.26 but did not under
2.6.  I think I may have posted on the netfilter list
to no avail so had to revert to 2.4.26....


--- Bart De Schuymer <bdschuym@pandora.be> wrote:

> On Sunday 01 August 2004 14:46, Matthias Andree
> wrote:
> > Hi,
> >
> > please Cc: all replies, I'm not subscribed
> >
> > I seem to have troubles with my Linux bridge
> (2.6.8-rc2), which is
> > apparently not bridging UDP fragments (NFS) when
> passing packets through
> > iptables, but I do not see in the iptables stats
> where the packets are
> > dropped. Policies for INPUT, FORWARD, OUTPUT are
> all "ACCEPT", and I
> > grepped for all REJECT and DROP rules in iptables
> -nvL, their counters
> > are constant, i. e. they aren't rejecting or
> dropping packets.
> 
> The patch below fixes this.
> I'm not sure if removing this test, which was
> recently added, doesn't cause
> problems elsewhere. AFAIK if a too large packet
> arrives at that place in the
> code, there is a bug somewhere else.
> Stephen, please apply the patch below, except if you
> think it can cause
> problems, in which case we'll need a different
> approach.
> The problem occurs when connection tracking is
> enabled in the kernel.
> Packets are then first defragmented, making skb->len
> bigger than the mtu.
> 
> cheers,
> Bart
> 
> --- linux-2.6.8-rc2-bk9/net/bridge/br_forward.c.old
> 2004-08-02 23:15:42.000000000 +0200
> +++ linux-2.6.8-rc2-bk9/net/bridge/br_forward.c
> 2004-08-02 23:15:55.000000000 +0200
> @@ -23,7 +23,6 @@ static inline int
> should_deliver(const s
>  				 const struct sk_buff *skb)
>  {
>  	if (skb->dev == p->dev ||
> -	    skb->len > p->dev->mtu ||
>  	    p->state != BR_STATE_FORWARDING)
>  		return 0;
>  
> 
> > _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
