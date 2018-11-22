Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=RF222CrkmatvfYKxZS2B21qO62SFOMTqP0SToYBytkQ=; 
	b=qyXb/3yzmGbJ6p39ah9NUc3AGYYZKEfApVVVEuQDu+8wunhSDaRKNUtDT4VlWxbNTgqqro0CmcKCc0F8qwSTW1ymRxCnOi3m7ZODw3DdxDp9VXJFsoTiSiG0UpBpAZE7xOzKaeHU6OjXqwOoQ+A0VQ5mQx4Aj3J9jJgwWkccIeg=;
Date: Thu, 22 Nov 2018 17:04:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181122160435.GI15403@lunn.ch>
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-3-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122042925.8878-3-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: add
 no_linklocal_learn bool option
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

>  int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
>  {
> -	int optval = 0;
> -
>  	switch (opt) {
> +	case BR_BOOLOPT_NO_LL_LEARN:
> +		return br_opt_get(br, BROPT_NO_LL_LEARN);
>  	default:
>  		break;
>  	}
>  
> -	return optval;
> +	return 0;
>  }

It seems like 1/2 of that change belongs in the previous patch.

> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -328,6 +328,27 @@ static ssize_t flush_store(struct device *d,
>  }
>  static DEVICE_ATTR_WO(flush);
>  
> +static ssize_t no_linklocal_learn_show(struct device *d,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct net_bridge *br = to_bridge(d);
> +	return sprintf(buf, "%d\n", br_boolopt_get(br, BR_BOOLOPT_NO_LL_LEARN));
> +}
> +
> +static int set_no_linklocal_learn(struct net_bridge *br, unsigned long val)
> +{
> +	return br_boolopt_toggle(br, BR_BOOLOPT_NO_LL_LEARN, !!val);
> +}
> +
> +static ssize_t no_linklocal_learn_store(struct device *d,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	return store_bridge_parm(d, buf, len, set_no_linklocal_learn);
> +}
> +static DEVICE_ATTR_RW(no_linklocal_learn);

I thought we where trying to move away from sysfs? Do we need to add
new options here? It seems like forcing people to use iproute2 for
newer options is a good way to get people to convert to iproute2.

	Andrew
