Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wM1rb/gmdPeOZ6FJpFaplJnOYR4K1cm0jlU1hEXr38s=;
 b=KATtogEFo9OqXImI3C/eS7sxD8mDnUTjCyBuXvJf6hjAcSw+ClT4A2jfaGzJExvEPp
 SzsnIyRLX58g9zPXkg5SRLHfmX0az2cusXDoadf4JjBO93QCysHE2fFHzUg90FYYH80S
 j3arLrmaGV9xPRfxLXrRGFYicOQK6CB4urRCjocPJtIxPg4BfteRRJUn7B4pWxKZHE4/
 w6+I7NY3l+7BbbNv0Xx7gvKXp5GWgjhP1xVShzFsHkrJnum3z7Ral5ARsnCTByYXFhni
 hSl0dPxMls/gKvT1cTeTOAtDEdFMdk008bEQNBDnvtLhfn9mS5VCuOX49Xh4t02Jkzdk
 l52g==
Date: Mon, 19 Jul 2021 10:22:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210719072251.encyen5fbln6z6je@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-12-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718214434.3938850-12-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v4 net-next 11/15] net: bridge: switchdev:
 allow the TX data plane forwarding to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 19, 2021 at 12:44:30AM +0300, Vladimir Oltean wrote:
>  static int nbp_switchdev_add(struct net_bridge_port *p,
>  			     struct netdev_phys_item_id ppid,
> +			     bool tx_fwd_offload,
>  			     struct netlink_ext_ack *extack)
>  {
> +	int err;
> +
>  	if (p->offload_count) {
>  		/* Prevent unsupported configurations such as a bridge port
>  		 * which is a bonding interface, and the member ports are from
> @@ -189,7 +228,16 @@ static int nbp_switchdev_add(struct net_bridge_port *p,
>  	p->ppid = ppid;
>  	p->offload_count = 1;
>  
> -	return nbp_switchdev_hwdom_set(p);
> +	err = nbp_switchdev_hwdom_set(p);
> +	if (err)
> +		return err;
> +
> +	if (tx_fwd_offload) {
> +		p->flags |= BR_TX_FWD_OFFLOAD;
> +		static_branch_inc(&br_switchdev_fwd_offload_used);
> +	}
> +
> +	return 0;
>  }
>  
>  static void nbp_switchdev_del(struct net_bridge_port *p,
> @@ -210,6 +258,8 @@ static void nbp_switchdev_del(struct net_bridge_port *p,
>  
>  	if (p->hwdom)
>  		nbp_switchdev_hwdom_put(p);
> +
> +	p->flags &= ~BR_TX_FWD_OFFLOAD;
>  }

Not the end of the world, but the static_branch_dec(&br_switchdev_fwd_offload_used)
was lost here in a rebase. Not a functional issue per se, but it is on
my list of things I would like to fix when I resend.
