Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70D3EB103
	for <bridge@lists.linux.dev>; Mon, 27 Jul 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143847; cv=none; b=XJ4rjV+SWmpmlnSs31Er/DZ1iugbg1Tp/r5XqdAgBOKYoyr5F0kqaoPU03U1TlBpuRHFkcgzOTc4s0BIu7zwVTdkX71VdG5TV7+mripbu0CdZ14xS4VWYQIglQH/IkyJJC8h6fVgp9d7ALh+aSsQiqEHlKDnxeek+0DTToMRcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143847; c=relaxed/simple;
	bh=2t8+f3IJxQKqHq8pkD2sMr87CLhwqbX7d9WNPaal7YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csR4zD/lnhQPX975DDYGY0oe+UPdhu/gEIym8UTKgHgjTMJluZvwlO7V7AaQtRVSGIM6SOZra2dSt6OMgMRHun7M50ooxsrdyQ9pHAhhqKeJbyBklg3ZvJ1We7iZV1MMIUIcLkqq2Mjmi08Q7krC2H+0SG0yFglBhhqea6678Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oNPmfC94; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oNPmfC94"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472326ca506so1613993f8f.2
        for <bridge@lists.linux.dev>; Mon, 27 Jul 2026 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785143844; x=1785748644; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ocErKRhaJjo4lzi/wGI6E8uXFqRDLnbYSUhaKxO4VCs=;
        b=oNPmfC94hsYtmHvwhu7UMYVgqN6PSRMphG7VrEUqUn9A8Sbnfx90cCmW/hpz6IyJqT
         sE00nTRdzsnEtMMxPbpAWlYgrtU2S3d+UXW18w50PyvdB2aXg996S/p6Y0RCrdsGh+dg
         xbA32ntGWsUvD0dooFq9nF45xuoCUv0oUd/bF7eJ5SGmj0A24oLq+iFS7tdaOOmZnaHM
         i2Xu3IS8gtyLOfWZX4LtLcOeaj1IE5WNZWd/iVM05lumieQENVvxrQY3HVcayISy+RYp
         HDODbvwoGjwNPBqz9yWJPIS5sxLZWi4PtNVEWMkRQj2uF2yqO25LpD2F43nkLDi2wtB1
         r1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143844; x=1785748644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ocErKRhaJjo4lzi/wGI6E8uXFqRDLnbYSUhaKxO4VCs=;
        b=azoY5R2rM4dYB0RO/ZFkYMhxNVNAtaT2nUbR1N//L41beiO9kJtrnEIg5/5kA1BLC0
         rWFhbZ8zX9c4NJFkZCLUb+6uTti+GFjKFTu2lNgGnxn09KR+DD1pDI2ru6fiW/HgTAbX
         1BYR785wzirSRMXefWxVhVPNy6lu7acgJcDNBUm2R4+8KdSnHt01np79Xo9Rj9ybJQLf
         KA0YG9n9Kbgs5Fj1H8jFxU7wOlTaUDZ99QyMRDnv9qY+5LVxIn1b+XXdWFcdxZ8vH5H+
         +FUgCE/0Hh4jZ7EpIjS6NV6MQe8YSDc6SgS2ni/kpg/qBz6idGzbJWLZHOnBUNk85GS+
         8HzA==
X-Forwarded-Encrypted: i=1; AHgh+RoVM6Rda2UdYyhYuWLBzQXAys09WvagLL6+sZQzNkeE7fDqtckNoQQhUER/gd3Jy19DSVuHUVA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ1S7gtRDZza3xdu2uzsGxYN+DIEmyppHeBC3fprdq1N39K3Gk
	hXV6ZSCUXvXNjQchufa07KPWj8zos2jmK/w1t0qIHQx+I4TzHWgbuuwMfGdfOrWpYr0=
X-Gm-Gg: AR+sD12NjdYYMic/I/l27re/ij5Z2YBZ/La8emY+kvLNJ71caEOJf3pWtvSiTwwYlXt
	uRK1DofdMa8ZKNRQ0LOCj9BShiZcRuTRGY0b2BWc30mmBQaO3uLul5Tqllp7Ed9VCl7/W2KR3sC
	P2vQpsIa+VRay8d7DCC+TjCPzkQFsr2m/Q875Zs3ZF5JMsZnIm2sBUK69PpEHSmid+hBw/6o3BC
	zeW/lmzMVptK0Bc0orVQRT4XfqJ8dwGIQfjw9x4Qrkm2+R/GVEtv2A5V0O4kQizsxfWovgRuv6S
	w6JeeBnK84/G1DO0BAyMq0aHpn7SgKjW8pJ4oW9XEsBT1Zr6YJENslIwGIAmMz9ZX8LojWxfBjV
	/jfgQ3vCb34Xq6/9vC+VCQjDDGhDqB+kq7qKYIFM5go4rlKVJ/vnzdpJJUmEarDAhQ0xPOj1EVA
	==
X-Received: by 2002:a05:6000:2381:b0:47f:8802:c182 with SMTP id ffacd0b85a97d-47f9fe97babmr9245974f8f.29.1785143844041;
        Mon, 27 Jul 2026 02:17:24 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm47287920f8f.2.2026.07.27.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:17:23 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:17:17 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ja@ssi.bg" <ja@ssi.bg>,
	Petr Machata <petrm@nvidia.com>, "fw@strlen.de" <fw@strlen.de>,
	"kuniyu@google.com" <kuniyu@google.com>,
	"bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] bridge: Linearize skb once the ND message
 type is validated
Message-ID: <amciHRD1fvLO_ZWi@penguin>
References: <cover.1784463131.git.danieller@nvidia.com>
 <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
 <27d8e26e-3498-4741-949a-742d057bbcde@blackwall.org>
 <SJ2PR12MB9008AD38B9DA4AE6CF0A3998D8CD2@SJ2PR12MB9008.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR12MB9008AD38B9DA4AE6CF0A3998D8CD2@SJ2PR12MB9008.namprd12.prod.outlook.com>

On Sun, Jul 26, 2026 at 11:03:54AM +0000, Danielle Ratson wrote:
> > -----Original Message-----
> > From: Nikolay Aleksandrov <razor@blackwall.org>
> > Sent: Monday, 20 July 2026 12:26
> > To: Danielle Ratson <danieller@nvidia.com>; netdev@vger.kernel.org
> > Cc: dsahern@kernel.org; Ido Schimmel <idosch@nvidia.com>;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; ja@ssi.bg; Petr Machata
> > <petrm@nvidia.com>; fw@strlen.de; kuniyu@google.com;
> > bridge@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next 4/5] bridge: Linearize skb once the ND message
> > type is validated
> > 
> > On 19/07/2026 16:34, Danielle Ratson wrote:
> > > br_nd_send() parses ND options from ns->opt[] and therefore needs the
> > > skb to be linear. Commit a01aee7cafc5 ("bridge: br_nd_send: linearize
> > > skb before parsing ND options") ensured that by linearizing inside
> > > br_nd_send() itself.
> > >
> > > Move the linearization up into br_is_nd_neigh_msg(), right after
> > > ndisc_check_ns_na() has validated the message as an NS/NA. This makes
> > > a linear buffer a property of every recognized ND message, so that
> > > this and any future ND message handling operate on a linear skb and
> > > cannot reintroduce that class of bug by forgetting to linearize.
> > >
> > > Since the skb is now linear by the time br_nd_send() runs, drop the
> > > linearization there and derive ns from the transport header set by
> > > ndisc_check_ns_na(), instead of recomputing it from the network header.
> > >
> > > If linearization fails under memory pressure, br_is_nd_neigh_msg()
> > > returns NULL and the packet falls back to normal forwarding rather
> > > than being suppressed.
> > >
> > > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > > Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> > > ---
> > >   net/bridge/br_arp_nd_proxy.c | 8 +++++---
> > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/bridge/br_arp_nd_proxy.c
> > > b/net/bridge/br_arp_nd_proxy.c index 445c930ed59b..46779d9fad61
> > 100644
> > > --- a/net/bridge/br_arp_nd_proxy.c
> > > +++ b/net/bridge/br_arp_nd_proxy.c
> > > @@ -240,6 +240,9 @@ struct nd_msg *br_is_nd_neigh_msg(struct sk_buff
> > *skb)
> > >   	if (ndisc_check_ns_na(skb))
> > >   		return NULL;
> > >
> > > +	if (skb_linearize(skb))
> > > +		return NULL;
> > > +
> > >   	return (struct nd_msg *)skb_transport_header(skb);
> > >   }
> > 
> > This one is a bit weird - I wouldn't expect the check and validation to also
> > linearize the skb. I'd rename this helper to show that it also linearizes the skb.
> > Other than that the patch looks good.
> 
> I agree it's not obvious from the name. But, I think it might be better to add a short comment than rename.
> The name captures the intent, while linearizing is just prep for the option parsing in br_nd_send().
> This also follows ipv6_mc_check_mld(), which is also a "check" that sets the transport header and documents its skb side effects in text rather than the name.
> 

Yeah, I'm not a fan of check functions having side effects at all, but
it's not that big of a deal and more of a personal preference.

> No other function here has a kdoc, so I'd keep it a plain comment:
> 
> /* Validate skb as an NS/NA and linearize it for br_nd_send()'s ND
>   * option parsing; returns the nd_msg, or NULL on failure.
>   */
>   
> Would that work, or do you feel strongly about the rename?
> 

That is ok.

Thanks,
 Nik

> > 
> > >
> > > @@ -259,7 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct
> > net_bridge_port *p,
> > >   	bool dad;
> > >   	u16 pvid;
> > >
> > > -	if (!dev || skb_linearize(request))
> > > +	if (!dev)
> > >   		return;
> > >
> > >   	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) + @@ -276,8
> > > +279,7 @@ static void br_nd_send(struct net_bridge *br, struct
> > net_bridge_port *p,
> > >   	skb_set_mac_header(reply, 0);
> > >
> > >   	daddr = eth_hdr(request)->h_source;
> > > -	ns = (struct nd_msg *)(skb_network_header(request) +
> > > -			       sizeof(struct ipv6hdr));
> > > +	ns = (struct nd_msg *)skb_transport_header(request);
> > >
> > >   	/* Do we need option processing ? */
> > >   	ns_olen = request->len - (skb_network_offset(request) +
> 
