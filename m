Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=d+cMLZ8Si3lJWATSwbd5LXqVkRDqcmlD4acDbAFO3Co=; 
	b=0PPaO47BV6tTFo56bvkU1WksmqAdnrm18CCD8Hxkg6Z5QyGi+pD75y7nEW7DSdbUM1fRegHG4K1YUI+l0fVozk1XYie+kWPe91rWDn0mbl/FAwJrj/KtCi460OupBbf8DhHx0rWmkOate0rQdSHIw0oSWsZeiLdwzqkAbcJEXYk=;
Date: Sat, 24 Nov 2018 17:10:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181124161041.GA24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124023422.13908-2-nikolay@cumulusnetworks.com>
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on,
> +		      struct netlink_ext_ack *extack)
> +{
> +	switch (opt) {
> +	default:
> +		/* shouldn't be called with unsupported options */
> +		WARN_ON(1);
> +		break;

So you return 0 here, meaning the br_debug() lower down will not
happen. Maybe return -EOPNOTSUPP?

> +	}
> +
> +	return 0;
> +}
> +

> +int br_boolopt_multi_toggle(struct net_bridge *br,
> +			    struct br_boolopt_multi *bm,
> +			    struct netlink_ext_ack *extack)
> +{
> +	unsigned long bitmap = bm->optmask;
> +	int err = 0;
> +	int opt_id;
> +
> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
> +		bool on = !!(bm->optval & BIT(opt_id));
> +
> +		err = br_boolopt_toggle(br, opt_id, on, extack);
> +		if (err) {
> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d new: %d error: %d\n",
> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
> +			break;
> +		}
> +	}

Does the semantics of extack allow you to return something even when
there is no error? If there are bits > BR_BOOLOPT_MAX you could return
0, but also add a warning in extack that some bits where not supported
by this kernel.

> +void br_boolopt_multi_get(const struct net_bridge *br,
> +			  struct br_boolopt_multi *bm)
> +{
> +	u32 optval = 0;
> +	int opt_id;
> +
> +	for (opt_id = 0; opt_id < BR_BOOLOPT_MAX; opt_id++)
> +		optval |= (br_boolopt_get(br, opt_id) << opt_id);
> +
> +	bm->optval = optval;
> +	bm->optmask = 0;

You liked the idea of setting optmask to indicate which bits this
kernel supports. Did you change your mind?

       Andrew
