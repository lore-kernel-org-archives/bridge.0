Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XGAZ/H
 Ub1ggaRYimKsJOVdJMZycWod7347H73fuhCGY=; b=D1N5qqeiHaEaEHhEL6jiu3
 P2uWIqjr3JjFcPYiEWhGcBB1JNfiecYZ9VQCVuiWLasYA+oHBAwkRbcdDVgK3O03
 SIlP5iPe9TQ30STXOA3auIpgr+GCw9p1Feye6FiqDkMh7RnL3PeTdy3aRYzZeLiB
 nqLvUOS5a6tLdULj9C31IJMF3ckKKWRw9Vt2o9WHuEgH1EU9XvMxedPjg1DUVxLC
 oerpeLFfd5rFAgYhj8QsB8HKysyzQJ0+42fq74EhgGyox6a+iZASx/D5fVFq9ANw
 /xqpZk9jSFoPIDSTEFMP6RXkV+217vJpcmnn4fyCgENncJL9lkrlA3OtsCekKEfA
 ==
Date: Wed, 5 May 2021 10:39:58 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YJJLzr5sJ2FYZRZ4@shredder.lan>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-3-tobias@waldekranz.com>
 <YI6+kQxjCcnYmwkx@shredder> <87h7jknqwn.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7jknqwn.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 2/9] net: bridge: Disambiguate
	offload_fwd_mark
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, olteanv@gmail.com, davem@davemloft.net

On Mon, May 03, 2021 at 10:49:12AM +0200, Tobias Waldekranz wrote:
> On Sun, May 02, 2021 at 18:00, Ido Schimmel <idosch@idosch.org> wrote:
> > On Mon, Apr 26, 2021 at 07:04:04PM +0200, Tobias Waldekranz wrote:
> >> - skb->cb->offload_fwd_mark becomes skb->cb->src_hwdom. There is a
> >>   slight change here: Whereas previously this was only set for
> >>   offloaded packets, we now always track the incoming hwdom. As all
> >>   uses where already gated behind checks of skb->offload_fwd_mark,
> >>   this will not introduce any functional change, but it paves the way
> >>   for future changes where the ingressing hwdom must be known both for
> >>   offloaded and non-offloaded frames.
> >
> > [...]
> >
> >> @@ -43,15 +43,15 @@ int nbp_switchdev_mark_set(struct net_bridge_port *p)
> >>  void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
> >>  			      struct sk_buff *skb)
> >>  {
> >> -	if (skb->offload_fwd_mark && !WARN_ON_ONCE(!p->offload_fwd_mark))
> >> -		BR_INPUT_SKB_CB(skb)->offload_fwd_mark = p->offload_fwd_mark;
> >> +	if (p->hwdom)
> >> +		BR_INPUT_SKB_CB(skb)->src_hwdom = p->hwdom;
> >>  }
> >
> > I assume you are referring to this change? "src_hwdom" sounds weird if
> > it's expected to be valid for non-offloaded frames.
> 
> Perhaps "non-offloaded" was a sloppy description on my part. I was
> trying to describe frames that originate from a switchdev, but have not
> been forwarded by hardware; e.g. STP BPDUs, IGMP reports, etc. So
> nbp_switchdev_frame_mark now basically says: "If this skb came in from a
> switchdev, make sure to note which one".
> 
> > Can you elaborate about "future changes where the ingressing hwdom must
> > be known both for offloaded and non-offloaded frames"?
> 
> Typical example: The switchdev has a fixed configuration to trap STP
> BPDUs, but STP is not running on the bridge and the group_fwd_mask
> allows them to be forwarded. Say we have this setup:
> 
>       br0
>     /  |  \
> swp0 swp1 swp2
> 
> A BPDU comes in on swp0 and is trapped to the CPU; the driver does not
> set skb->offload_fwd_mark. The bridge determines that the frame should
> be forwarded to swp{1,2}. It is imperative that forward offloading is
> _not_ allowed in this case, as the source hwdom is already "poisoned".
> 
> Recording the source hwdom allows this case to be handled properly.

OK, thanks for the explanation. If it is allowed, then the packet will
be transmitted from swp0, from which it was received.

> 
> > Probably best to split this change to a different patch given the rest
> > of the changes are mechanical.
> 
> Right, but I think the change in name to warrants a change in
> semantics. It is being renamed to src_hwdom because it now holds just
> that information. Again, there is no functional change introduced by
> this since nbp_switchdev_allowed_egress always checks for the presence
> of skb->offload_fwd_mark anyway. But if you feel strongly about it, I
> will split it up.

If you put the explanation above in the changelog, then it should be
fine to keep it as one patch.

> 
> >>  
> >>  bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
> >>  				  const struct sk_buff *skb)
> >>  {
> >>  	return !skb->offload_fwd_mark ||
> >> -	       BR_INPUT_SKB_CB(skb)->offload_fwd_mark != p->offload_fwd_mark;
> >> +	       BR_INPUT_SKB_CB(skb)->src_hwdom != p->hwdom;
> >>  }
> >>  
> >>  /* Flags that can be offloaded to hardware */
> >> -- 
> >> 2.25.1
> >> 
