Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=vCqDWE2haJzHGsv6Lhf3qqtf8ld8CFod6RaRQ5zeeq4=; 
	b=u+AxoJ9/hGgik13B3ziecaY679+j4PHj6TcEkgUXdnniaaHPkYvyPd1pC94I1MzAjQ1Tcc+lCTZ/jUAh2GfxHsHr8RQ3f0dHNpnUBbHs5JDZaZ2gI1VMpG9jhaLn5kAK3MmF/VpvPtsHfRJvVt3NHYSa2lBWNZ9NUzrmS/tFsr4=;
Date: Sat, 24 Nov 2018 17:25:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181124162541.GC24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
	<20181124161041.GA24681@lunn.ch>
	<66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 1/3] net: bridge: add support for
 user-controlled bool options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Sat, Nov 24, 2018 at 06:18:33PM +0200, nikolay@cumulusnetworks.com wrote:
> On 24 November 2018 18:10:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:
> >> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt,
> >bool on,
> >> +		      struct netlink_ext_ack *extack)
> >> +{
> >> +	switch (opt) {
> >> +	default:
> >> +		/* shouldn't be called with unsupported options */
> >> +		WARN_ON(1);
> >> +		break;
> >
> >So you return 0 here, meaning the br_debug() lower down will not
> >happen. Maybe return -EOPNOTSUPP?
> >
> 
> No, the idea here is that some option in the future might return an error. 
> This function cannot be called with unsupported option thus the warn. 

O.K, i was trying to make it easier to see which option caused it to
happen.

> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >
> >> +int br_boolopt_multi_toggle(struct net_bridge *br,
> >> +			    struct br_boolopt_multi *bm,
> >> +			    struct netlink_ext_ack *extack)
> >> +{
> >> +	unsigned long bitmap = bm->optmask;
> >> +	int err = 0;
> >> +	int opt_id;
> >> +
> >> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
> >> +		bool on = !!(bm->optval & BIT(opt_id));
> >> +
> >> +		err = br_boolopt_toggle(br, opt_id, on, extack);
> >> +		if (err) {
> >> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d
> >new: %d error: %d\n",
> >> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
> >> +			break;
> >> +		}
> >> +	}
> >
> >Does the semantics of extack allow you to return something even when
> >there is no error? If there are bits > BR_BOOLOPT_MAX you could return
> >0, but also add a warning in extack that some bits where not supported
> >by this kernel.
> 
> If we return 0 there's no reason to check extack. 

Well, the caller can check to see if extack is present, even on
success. This is extack, not extnack after all...

	 Andrew
