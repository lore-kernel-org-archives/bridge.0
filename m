Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=zMsNZPgG1h/gk8iP3BIALAS6VnOFS8kzvEAWQ1MBsZg=;
	b=CHH1omBqOPi6U3LqSz9XFqLi7lP+MV2oshT2YuNoDzXouyWYREEgdPzEn1mp3X/cpc
	nYQT1BC0/rEbf36R5XsAubuizp3A5Z/yCK13JiDmq15VNRRaxCj7/epuAU46LXeMEbtC
	cCCEsjJfeeUzFYZZJN6u1qO/3r4KlJqhdhL6red4j1Mkxde7a1jjib/G1pBX0E4fe43w
	tBb7KfQvUwWtw0wIV5yX7PUhaGung4lGni1PAg3U3650Q+0Ky2/Cd1mfqEKgRgKHmnBS
	KGrZw/DAykfnmcp6ZCHKSG3WwgYnCljD5qJoePOEg+wa5YVydjdsxGs1/V4Ho3skWkF4
	QPqA==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Thu, 8 Aug 2019 10:04:29 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
Message-ID: <20190808080428.o2eqqfdscl274sr5@tycho>
References: <20190805153740.29627-1-zahari.doychev@linux.com>
	<20190805153740.29627-2-zahari.doychev@linux.com>
	<48058179-9690-54e2-f60c-c372446bfde9@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48058179-9690-54e2-f60c-c372446bfde9@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH v2 1/1] net: bridge: use mac_len in bridge
	forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: makita.toshiaki@lab.ntt.co.jp, dsahern@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jhs@mojatatu.com, simon.horman@netronome.com, xiyou.wangcong@gmail.com, johannes@sipsolutions.net, alexei.starovoitov@gmail.com, ast@plumgrid.com

On Wed, Aug 07, 2019 at 12:17:43PM +0300, Nikolay Aleksandrov wrote:
> Hi Zahari,
> On 05/08/2019 18:37, Zahari Doychev wrote:
> > The bridge code cannot forward packets from various paths that set up the
> > SKBs in different ways. Some of these packets get corrupted during the
> > forwarding as not always is just ETH_HLEN pulled at the front. This happens
> > e.g. when VLAN tags are pushed bu using tc act_vlan on ingress.
> Overall the patch looks good, I think it shouldn't introduce any regressions
> at least from the codepaths I was able to inspect, but please include more
> details in here from the cover letter, in fact you don't need it just add all of
> the details here so we have them, especially the test setup. Also please provide
> some details how this patch was tested. It'd be great if you could provide a
> selftest for it so we can make sure it's considered when doing future changes.

Hi Nik,

Thanks for the reply. I will do the suggested corrections and try creating a
selftest. I assume it should go to the net/forwarding together with the other
bridge tests as a separate patch.

Regards,
Zahari

> 
> Thank you,
>  Nik
> 
> > 
> > The problem is fixed by using skb->mac_len instead of ETH_HLEN, which makes
> > sure that the skb headers are correctly restored. This usually does not
> > change anything, execpt the local bridge transmits which now need to set
> > the skb->mac_len correctly in br_dev_xmit, as well as the broken case noted
> > above.
> > 
> > Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> > ---
> >  net/bridge/br_device.c  | 3 ++-
> >  net/bridge/br_forward.c | 4 ++--
> >  net/bridge/br_vlan.c    | 3 ++-
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> > index 681b72862c16..aeb77ff60311 100644
> > --- a/net/bridge/br_device.c
> > +++ b/net/bridge/br_device.c
> > @@ -55,8 +55,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	BR_INPUT_SKB_CB(skb)->frag_max_size = 0;
> >  
> >  	skb_reset_mac_header(skb);
> > +	skb_reset_mac_len(skb);
> >  	eth = eth_hdr(skb);
> > -	skb_pull(skb, ETH_HLEN);
> > +	skb_pull(skb, skb->mac_len);
> >  
> >  	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid))
> >  		goto out;
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index 86637000f275..edb4f3533f05 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -32,7 +32,7 @@ static inline int should_deliver(const struct net_bridge_port *p,
> >  
> >  int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
> >  {
> > -	skb_push(skb, ETH_HLEN);
> > +	skb_push(skb, skb->mac_len);
> >  	if (!is_skb_forwardable(skb->dev, skb))
> >  		goto drop;
> >  
> > @@ -94,7 +94,7 @@ static void __br_forward(const struct net_bridge_port *to,
> >  		net = dev_net(indev);
> >  	} else {
> >  		if (unlikely(netpoll_tx_running(to->br->dev))) {
> > -			skb_push(skb, ETH_HLEN);
> > +			skb_push(skb, skb->mac_len);
> >  			if (!is_skb_forwardable(skb->dev, skb))
> >  				kfree_skb(skb);
> >  			else
> > diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> > index 021cc9f66804..88244c9cc653 100644
> > --- a/net/bridge/br_vlan.c
> > +++ b/net/bridge/br_vlan.c
> > @@ -466,13 +466,14 @@ static bool __allowed_ingress(const struct net_bridge *br,
> >  		/* Tagged frame */
> >  		if (skb->vlan_proto != br->vlan_proto) {
> >  			/* Protocol-mismatch, empty out vlan_tci for new tag */
> > -			skb_push(skb, ETH_HLEN);
> > +			skb_push(skb, skb->mac_len);
> >  			skb = vlan_insert_tag_set_proto(skb, skb->vlan_proto,
> >  							skb_vlan_tag_get(skb));
> >  			if (unlikely(!skb))
> >  				return false;
> >  
> >  			skb_pull(skb, ETH_HLEN);
> > +			skb_reset_network_header(skb);
> >  			skb_reset_mac_len(skb);
> >  			*vid = 0;
> >  			tagged = false;
> > 
> 
