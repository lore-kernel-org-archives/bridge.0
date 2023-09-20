Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02DE24016C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32A3240127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695207629; x=1695812429;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEvvL7wq7MhG98C7oNkHR86nxOx9QCzBZgqGLXsj1BY=;
 b=poI7+H4wX4Lt4YsboLU8Pe1L+XonfeayQE5FrrVP0idxORYOAjLRr54UWYY7dmHO3R
 p5S/oXDCqvEeiNTpCxfDXWfKJ862Mc6lEJY/FrnPJ/ZnD/kER6NILZYYJJYBoDqp08Fm
 KncOdwvzrci0RUPKLcGRGhDMSiX+SuU9BH2VnbUniANNl4KU5rvXzWNezBoWLoma69Ez
 NNajah9UUDlovWvGhv2JEAbKPy03aHXffwSBN2Op8DP35MuFgA1W9rZsyCru7HqIACvq
 JTJwO+4mtjGRW783wVtse4FM0XeIJF0VQ46YyrjZVS/7VyQhNGrHXJYpQkcXBw/nV8oj
 5D3Q==
Message-ID: <cc14cd4a-f3bb-3d6f-5b38-ec73cad32570@blackwall.org>
Date: Wed, 20 Sep 2023 14:00:27 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 5/6] net: bridge: Add a
 configurable default FDB learning limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Add a Kconfig option to configure a default FDB learning limit system
> wide, so a distributor building a special purpose kernel can limit all
> created bridges by default.
> 
> The limit is only a soft default setting and overrideable on a per bridge
> basis using netlink.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/Kconfig     | 13 +++++++++++++
>   net/bridge/br_device.c |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index 3c8ded7d3e84..c0d9c08088c4 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -84,3 +84,16 @@ config BRIDGE_CFM
>   	  Say N to exclude this support and reduce the binary size.
>   
>   	  If unsure, say N.
> +
> +config BRIDGE_DEFAULT_FDB_MAX_LEARNED
> +	int "Default FDB learning limit"
> +	default 0
> +	depends on BRIDGE
> +	help
> +	  Sets a default limit on the number of learned FDB entries on
> +	  new bridges. This limit can be overwritten via netlink on a
> +	  per bridge basis.
> +
> +	  The default of 0 disables the limit.
> +
> +	  If unsure, say 0.
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 9a5ea06236bd..3214391c15a0 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -531,6 +531,8 @@ void br_dev_setup(struct net_device *dev)
>   	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
>   	dev->max_mtu = ETH_MAX_MTU;
>   
> +	br->fdb_max_learned = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
> +
>   	br_netfilter_rtable_init(br);
>   	br_stp_timer_init(br);
>   	br_multicast_init(br);
> 

This one I'm not sure about at all. Distributions can just create the 
bridge with a predefined limit. This is not flexible and just adds
one more kconfig option that is rather unnecessary. Why having a kconfig
knob is better than bridge creation time limit setting? You still have
to create the bridge, so why not set the limit then?
