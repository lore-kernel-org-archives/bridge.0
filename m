Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=Z7C12GWm1JCiY+N72LQmwfnxl3+Dmtdt5Dk9OoD7GO8=; 
	b=1ZHRtlk95vHGJFQH4aTjUe3Iy88bFDn6zNKHKAlBMzj+gSNLhZswXsqmcpnZQ4whyVTYi2VEyrCX1aRPEiuhGUnlnvxjv/rK/edeUzyg54E8cW0wmPGCdDUT/2exgv4LNXUcy2rl/qyFv0jxD82Ga+lGf/bQwajNTrwSVWiPunI=;
Date: Thu, 22 Nov 2018 16:52:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181122155256.GH15403@lunn.ch>
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

Maybe set optmask to indicate which bits this kernel supports?

      Andrew
