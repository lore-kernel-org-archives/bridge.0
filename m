Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AWRbE0SqFuV4wqzStVfSF+dwgpeyvmT951OzMpXt1TM=;
 b=GOxJ4n+XZnHOfmX6RhO0J0yhAZB3qFAqYS0ZkPj3UhB7tV95b9G5aJkNP9II9UeXsc
 TjtS9FFQ7sJTO+DjyEwOA7VCcrRExK10UaGSOmo2UcHwbmVRv8KXwN5yPauEx2B6iEaS
 SzgtTyAP4OpMsRy11YqQHQrPGfHzJg3K3AT9/ttb+KYo6Deu7rGHSl9fY9hWxfSY1umu
 GDRuIjVG81XQd6M54gm2aPcvAWgghVgwWake3ZxRvBm2JiNPt+AX8BjM/jgM6Ujgiuvl
 v1PXZ5SK0nWZVRs9orxXyBqf3qiQPCO7+fqjguw548b7vDXA94yqJ/ruUVb1ZmSBcDZf
 7piA==
Date: Tue, 15 Mar 2022 18:33:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220315163349.k2rmfdzrd3jvzbor@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-10-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315002543.190587-10-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v4 net-next 09/15] net: dsa: Never offload FDB
 entries on standalone ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:25:37AM +0100, Tobias Waldekranz wrote:
> If a port joins a bridge that it can't offload, it will fallback to
> standalone mode and software bridging. In this case, we never want to
> offload any FDB entries to hardware either.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

When you resend, please send this patch separately, unless something
breaks really ugly with your MST series in place.

>  net/dsa/slave.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index a61a7c54af20..647adee97f7f 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -2624,6 +2624,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>  	if (ctx && ctx != dp)
>  		return 0;
>  
> +	if (!dp->bridge)
> +		return 0;
> +
>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
>  			return 0;
> -- 
> 2.25.1
> 
