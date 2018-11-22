Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=jE+kGk0laC86CivlLAA6SHpPEeGEvAJg8rpOscHKXGI=; 
	b=ljKzDFku/lm8zPdaqrhTRa/maBbIu5k08u7QPr+Km6GnvkHDIE01cM8MtX1rK7IM7sV98D4DglVYJOOfkFT60LsD+069GHYI6clngpu3UXo0q/QwqGj0RqLNuknd1caLCa3K1AP7NWJV4XcAQpPdpUPEJri33zTBIgSFDclvHP0=;
Date: Thu, 22 Nov 2018 16:49:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181122154951.GG15403@lunn.ch>
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-2-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122042925.8878-2-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for
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

> +/* br_boolopt_toggle - change user-controlled boolean option
> + *
> + * @br: bridge device
> + * @opt: id of the option to change
> + * @on: new option value
> + *
> + * Changes the value of the respective boolean option to @on taking care of
> + * any internal option value mapping and configuration.
> + */
> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on)
> +{
> +	int err = -ENOENT;
> +
> +	switch (opt) {
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +


> +int br_boolopt_multi_toggle(struct net_bridge *br,
> +			    struct br_boolopt_multi *bm)
> +{
> +	unsigned long bitmap = bm->optmask;
> +	int err = 0;
> +	int opt_id;
> +
> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
> +		bool on = !!(bm->optval & BIT(opt_id));
> +
> +		err = br_boolopt_toggle(br, opt_id, on);
> +		if (err) {
> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d new: %d error: %d\n",
> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
> +			break;
> +		}

An old kernel with a new iproute2 might partially succeed in toggling
some low bits, but then silently ignore a high bit that is not
supported by the kernel. As a user, i want to know the kernel does not
support an option i'm trying to toggle.

Can you walk all the bits in the u32 from the MSB to the LSB? That
should avoid this problem.

	Andrew
