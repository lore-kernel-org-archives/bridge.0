Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=iwioB0zpWgF7chqKmFOE30AI/AAuvwKlG2teFQxsnDQ=; 
	b=sbKdkvdbyhj250D+9ozYia77fiq36c5GXEr170hdHKR0TKBD2rVsRNvYd5vp0jvNveHnlGfxaTEr7FlzvF5xWKYsCgyuyG1LPru8O3lGhZVfOlHOZMTCT+4wPYuO5j4j2opJfKSmYISvO0vvvpRECmwSujixISGkeFdN/wuIryo=;
Date: Sat, 10 Mar 2018 17:38:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180310163838.GG29174@lunn.ch>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-3-igor.mitsyanko.os@quantenna.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310030308.12947-3-igor.mitsyanko.os@quantenna.com>
Subject: Re: [Bridge] [PATCH net-next 2/5] bridge: propagate BR_ flags
 updates through sysfs to switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On Fri, Mar 09, 2018 at 07:03:05PM -0800, Igor Mitsyanko wrote:
> sysfs interface to configure bridge flags only updates SW copy but does
> not notify hardware through switchdev interface. Make sure it is.
> 
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> ---
>  net/bridge/br_sysfs_if.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 126a8ea..9bdd177 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -51,6 +51,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
>  		      unsigned long mask)
>  {
>  	unsigned long flags;
> +	int err;
>  
>  	flags = p->flags;
>  
> @@ -59,10 +60,16 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
>  	else
>  		flags &= ~mask;
>  
> -	if (flags != p->flags) {
> -		p->flags = flags;
> -		br_port_flags_change(p, mask);
> -	}
> +	if (flags == p->flags)
> +		return 0;
> +
> +	err = br_switchdev_set_port_flag(p, flags, mask);
> +	if (err)
> +		return err;

You might want to consider the br_warn() in
br_switchdev_set_port_flag(). Do we want to spam the kernel log?  Or
should store_flag() do some validation before calling
br_switchdev_set_port_flag()?

	Andrew
