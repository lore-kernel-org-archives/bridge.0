Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QslpgAfoPSMyQTcwVuRxE/Clc9H3kQJwpSw0ATzzLfM=;
 b=A4WJgu5U1MfknRodQBGk03f9hDOevSNbW1whKJ8i/FJPs+k97L8+DNHp40FEaAc/plSBqKPPe+Mt/m5tPA+rCmHzwi3s9b5p5nPvMIcwgSA9Pu7a+tuYaJ1YwKcGM+er7MyNflDZn+wswSKbiv8//hy7qvzsrPe3XT3EXqOx+KnzOAqJFSkbZMA3qmxnn76d5qyp3ay1BBarD/5EXBpcZFEn0hXsb8+FdWblckMfzso9JADsDi6waJWjHrK5fQh5ZgruPOLG3yUYDPJ4DS15ct67dRSqDpDCP9TYDTvpEVIfxp+a+2W9KJWn/UuASqgylc/gB7I5ux0I9Y69Regulg==
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-12-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <7279c94e-a4ff-2fbb-290e-bdaf5844148c@nvidia.com>
Date: Tue, 11 May 2021 12:23:24 +0300
In-Reply-To: <20210509194509.10849-12-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 11/11] net: bridge: mcast: export
 multicast router presence adjacent to a port
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
> To properly support routable multicast addresses in batman-adv in a
> group-aware way, a batman-adv node needs to know if it serves multicast
> routers.
> 
> This adds a function to the bridge to export this so that batman-adv
> can then make full use of the Multicast Router Discovery capability of
> the bridge.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b625fd6..e963de5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4061,6 +4061,64 @@ unlock:
>  }
>  EXPORT_SYMBOL_GPL(br_multicast_has_querier_adjacent);
>  
> +/**
> + * br_multicast_has_router_adjacent - Checks for a router behind a bridge port
> + * @dev: The bridge port adjacent to which to check for a multicast router
> + * @proto: The protocol family to check for: IGMP -> ETH_P_IP, MLD -> ETH_P_IPV6
> + *
> + * Checks whether the given interface has a bridge on top and if so returns
> + * true if a multicast router is behind one of the other ports of this
> + * bridge. Otherwise returns false.
> + */
> +bool br_multicast_has_router_adjacent(struct net_device *dev, int proto)
> +{
> +	struct net_bridge_port *port, *p;
> +	bool ret = false;
> +
> +	rcu_read_lock();
> +	if (!netif_is_bridge_port(dev))
> +		goto unlock;
> +
> +	port = br_port_get_rcu(dev);

You can combine both of netif_is_bridge_port and br_port_get_rcu() checks and use
br_port_get_check_rcu(). Then you can also drop the port->br check.


> +	if (!port || !port->br)
> +		goto unlock;
> +
> +	switch (proto) {
> +	case ETH_P_IP:
> +		hlist_for_each_entry_rcu(p, &port->br->ip4_mc_router_list,
> +					 ip4_rlist) {
> +			if (p == port)
> +				continue;
> +
> +			ret = true;
> +			goto unlock;
> +		}
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:
> +		hlist_for_each_entry_rcu(p, &port->br->ip6_mc_router_list,
> +					 ip6_rlist) {
> +			if (p == port)
> +				continue;
> +
> +			ret = true;
> +			goto unlock;
> +		}
> +		break;
> +#endif
> +	default:
> +		/* when compiled without IPv6 support, be conservative and
> +		 * always assume presence of an IPv6 multicast router
> +		 */
> +		ret = true;
> +	}
> +
> +unlock:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(br_multicast_has_router_adjacent);
> +
>  static void br_mcast_stats_add(struct bridge_mcast_stats __percpu *stats,
>  			       const struct sk_buff *skb, u8 type, u8 dir)
>  {
> 

