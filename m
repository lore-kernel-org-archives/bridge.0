Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=rj5thdQHso4WkcZJ5rv88vw6SlcMQ1DZZi7hsWXkILc=;
	b=Fb9x9pJdQ9j01cbaQOhMqM8TEIu6Zndl7l/OzHHIvsyf0EpmThB4V2/14dhBD2+vcW
	9weLbRWo351gGbYThrrtLV0M08rBaHgBvY5wddB/zLWigEkaYIxOmZMIjEH2Qw6tK49u
	pRV3YGCkvZ0DBVllD2XxCBXXNf/pNJggZ130IYlfMdN5Dm4Y/wLklgm2clVRm5xsUqli
	6iDLc1qb3FDh8XhSn1VRFmBbFODSFALC5MZm1pp9p6ANF4G0sACZrOBV/CSCnSpqZ0h1
	OaserkEYmKi2Xh/lo77gebWav3AbpeiuvrQE8+WxHrQxqgh+hIghWixq7feMUZ8Ha5wA
	vYSg==
Date: Sat, 15 Jun 2019 08:19:14 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Message-ID: <20190615151913.cgrfyflwwnhym4u2@ast-mbp.dhcp.thefacebook.com>
References: <68c99662210c8e9e37f198ddf8cb00bccf301c4b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c99662210c8e9e37f198ddf8cb00bccf301c4b.camel@sipsolutions.net>
Subject: Re: [Bridge] VLAN tags in mac_len
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, Jiri Pirko <jiri@mellanox.com>, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Zahari Doychev <zahari.doychev@linux.com>, jhs@mojatatu.com, Simon Horman <simon.horman@netronome.com>, David Ahern <dsahern@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>, Alexei Starovoitov <ast@plumgrid.com>

On Fri, Jun 14, 2019 at 12:18:41PM +0200, Johannes Berg wrote:
> 
> Possible solutions?
> 
> So far, Zahari tried three different ways of fixing this:
> 
>  1) Make the bridge code use skb->mac_len instead of ETH_HLEN. This
>     works for this particular case, but breaks some other cases;
>     evidently some places exist where skb->mac_len isn't even set to
>     ETH_HLEN when a packet gets to the bridge. I don't know right now
>     what that was, I think probably somebody who's CC'ed reported that.
> 
>  2) Let tc_act_vlan() just pull ETH_HLEN instead of skb->mac_len, but
>     this is rather asymmetric and strange, and while it works for this
>     case it may cause confusion elsewhere.
> 
>  2b) Toshiaki said it might be better to make that code *remember*
>      mac_len and then use it to push and pull (so not caring about the
>      change made by skb_vlan_push()), but that ultimately leads to
>      confusion and if you have TC push/pop combinations things just get
>      completely out of sync and die
> 
>  3) Make skb_vlan_push()/_pop() just not change mac_len at all. So far
>     this also addresses the issue, but it's likely that this will break
>     OVS, and I don't know how it'd affect BPF. Quite possibly like TC
>     does and is broken, but perhaps not.
> 
> 
> But now we're stuck. Depending on how you look at it, all of these seem
> sort of reasonable, or not.
> 
> Ultimately, the issue seems to be that we couldn't really decide whether
> VLAN tags (and probably MPLS tags, for that matter) are covered by
> mac_len or not. At least not consistently on ingress and egress.
> eth_type_trans() doesn't take them into account, so of course on simple
> ingress mac_len will only cover the ETH_HLEN.
> 
> If you have an accelerated tag and then push it into the SKB, it will
> *not* be taken into account in mac_len. OTOH, if you have a new tag and
> use skb_vlan_push() then it *will* be taken into account.
> 
> 
> I'm trending towards solution (3), because if we consider other
> combinations of VLAN push/pop in TC, I think we can end up in a very
> messy situation today. For example, POP/PUSH seems like it should be a
> no-op, but it isn't due to the mac_len, *unless* it can use the HW accel
> only (i.e. only a single tag).
> 
> I think then to propose such a patch though we'd have to figure out
> where the BPF case is, and to keep OVS working probably either add an
> argument ("bool adjust_mac_len") to the function signatures, or just do
> the adjustments in OVS code after calling them?
> 
> 
> Any other thoughts?

imo skb_vlan_push() should still change mac_len.
tc, ovs, bpf use it and expect vlan to be part of L2.
There is nothing between L2 and L3 :)
Hence we cannot say that vlan is not part of L2.
Hence push/pop vlan must change mac_len, since skb->mac_len
is kernel's definition of the length of L2 header.

Now as far as bridge... I think it's unfortunate that linux
adopted 'vlan' as a netdevice model and that's where I think
the problem is.
Typical bridge in the networking industry is a device that
does forwarding based on L2. Which includes vlans.
And imo that's the most appropriate way of configuring and thinking
about bridge functionality.
Whereas in the kernel there is a 'vlan' netdevice that 'eats'
vlan tag and pretends that the rest is the same.
So linux bridge kinda doesn't need to be vlan aware.
CONFIG_BRIDGE_VLAN_FILTERING was the right step, but I haven't
seen it being used and I'm not sure about state of things there.

So your option 1 above is imo the best. The bridge needs to deal
with skb->mac_len and full L2 header.

