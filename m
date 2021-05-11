Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0k2TY0Csq3Ttf2PgdwRjxpN1/zgPzBYnPla7sPL/sY=;
 b=QWJlRWqnC7RRl9XDgupG8Rs/I2OQLZwjluz5WJ9lAVkliB7axvHsLRhQF6nKBkLj2l+vtMmaBvDvH8cxemcLFH851ygT11/8xVg+VGSOvpZi61Ycop5XSHqwtmBjOYO1cBufytglCJyZ9kKg21bUjnelUMSnG+1oyBhl0enZfd/iXWJNY8jP4KjarVzmFoDcDukimozkxzi0/9gTYD8DqkgQHgPFW5J2teytAHXz9LnZ0CNL0t/El4B+MxVf2x3/VGanQDfjYSDZATVuvFzcpbIhG0EXPBzqiarZlEnJybSQIqm153po3ULl89ThS9glFhOO7ncLPfEKyBPiIHrrfw==
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-5-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <02190208-f5b9-d761-abf5-1d85d0c62cd6@nvidia.com>
Date: Tue, 11 May 2021 12:13:45 +0300
In-Reply-To: <20210509194509.10849-5-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 04/11] net: bridge: mcast: prepare query
 reception for mcast router split
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On 09/05/2021 22:45, Linus Lüssing wrote:
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants and as the br_multicast_mark_router() will
> be split for that remove the select querier wrapper and instead add
> ip4 and ip6 variants for br_multicast_query_received().
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 53 ++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 6fe93a3..7edbbc9 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2615,22 +2615,6 @@ update:
>  }
>  #endif
>  
> -static bool br_multicast_select_querier(struct net_bridge *br,
> -					struct net_bridge_port *port,
> -					struct br_ip *saddr)
> -{
> -	switch (saddr->proto) {
> -	case htons(ETH_P_IP):
> -		return br_ip4_multicast_select_querier(br, port, saddr->src.ip4);
> -#if IS_ENABLED(CONFIG_IPV6)
> -	case htons(ETH_P_IPV6):
> -		return br_ip6_multicast_select_querier(br, port, &saddr->src.ip6);
> -#endif
> -	}
> -
> -	return false;
> -}
> -
>  static void
>  br_multicast_update_query_timer(struct net_bridge *br,
>  				struct bridge_mcast_other_query *query,
> @@ -2708,19 +2692,36 @@ static void br_multicast_mark_router(struct net_bridge *br,
>  		  now + br->multicast_querier_interval);
>  }
>  
> -static void br_multicast_query_received(struct net_bridge *br,
> -					struct net_bridge_port *port,
> -					struct bridge_mcast_other_query *query,
> -					struct br_ip *saddr,
> -					unsigned long max_delay)
> +static void
> +br_ip4_multicast_query_received(struct net_bridge *br,
> +				struct net_bridge_port *port,
> +				struct bridge_mcast_other_query *query,
> +				struct br_ip *saddr,
> +				unsigned long max_delay)
>  {
> -	if (!br_multicast_select_querier(br, port, saddr))
> +	if (!br_ip4_multicast_select_querier(br, port, saddr->src.ip4))
>  		return;
>  
>  	br_multicast_update_query_timer(br, query, max_delay);
>  	br_multicast_mark_router(br, port);
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +static void
> +br_ip6_multicast_query_received(struct net_bridge *br,
> +				struct net_bridge_port *port,
> +				struct bridge_mcast_other_query *query,
> +				struct br_ip *saddr,
> +				unsigned long max_delay)
> +{
> +	if (!br_ip6_multicast_select_querier(br, port, &saddr->src.ip6))
> +		return;
> +
> +	br_multicast_update_query_timer(br, query, max_delay);
> +	br_multicast_mark_router(br, port);
> +}
> +#endif
> +
>  static void br_ip4_multicast_query(struct net_bridge *br,
>  				   struct net_bridge_port *port,
>  				   struct sk_buff *skb,
> @@ -2768,8 +2769,8 @@ static void br_ip4_multicast_query(struct net_bridge *br,
>  		saddr.proto = htons(ETH_P_IP);
>  		saddr.src.ip4 = iph->saddr;
>  
> -		br_multicast_query_received(br, port, &br->ip4_other_query,
> -					    &saddr, max_delay);
> +		br_ip4_multicast_query_received(br, port, &br->ip4_other_query,
> +						&saddr, max_delay);
>  		goto out;
>  	}
>  
> @@ -2856,8 +2857,8 @@ static int br_ip6_multicast_query(struct net_bridge *br,
>  		saddr.proto = htons(ETH_P_IPV6);
>  		saddr.src.ip6 = ipv6_hdr(skb)->saddr;
>  
> -		br_multicast_query_received(br, port, &br->ip6_other_query,
> -					    &saddr, max_delay);
> +		br_ip6_multicast_query_received(br, port, &br->ip6_other_query,
> +						&saddr, max_delay);
>  		goto out;
>  	} else if (!group) {
>  		goto out;
> 

