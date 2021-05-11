Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+/piBf48LlschlvzBayvAuu29lowlVonGdHNovQ5Jw=;
 b=iphiAwbP8srCqKteY6esNAUUhFwFKu/VTdpIRjNauBCZkaxBoYneDZpeoLYtMerJXN1659lL6XkUhwKXit+8Bs2a61XPOjHDg4E6aRiy003TXixxwe5l4a17k7qZcIRHNQM4Pd2pXaOtAyZTX3Sb0Thce4A2HMdK7MZyd+TpEgeIxDsdq+f+6lF2wK7CfD+gVFDEmgihY1AqMwubxPJAASBsbSwQJSVTaub1nYzxsuu4FrfZiXc0LN71krmSQg1y8tBg2E3MDsV9nlJ3aKSmENH9DOD5QJzr0bFHHU2ZfLRBtFo4qHOkeTnrvs3p9zhPcgmGs5vect84FW2SbE3j+Q==
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-7-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <0998c872-f18e-19a0-d137-9144dcb7b18d@nvidia.com>
Date: Tue, 11 May 2021 12:16:59 +0300
In-Reply-To: <20210509194509.10849-7-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 06/11] net: bridge: mcast: prepare expiry
 functions for mcast router split
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
> their IPv4 and IPv6 variants move the protocol specific timer access to
> an ip4 wrapper function.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 048b5b9..6c844b2 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1354,16 +1354,16 @@ static int br_ip6_multicast_add_group(struct net_bridge *br,
>  }
>  #endif
>  
> -static void br_multicast_router_expired(struct timer_list *t)
> +static void br_multicast_router_expired(struct net_bridge_port *port,
> +					struct timer_list *t,
> +					struct hlist_node *rlist)
>  {
> -	struct net_bridge_port *port =
> -			from_timer(port, t, ip4_mc_router_timer);
>  	struct net_bridge *br = port->br;
>  
>  	spin_lock(&br->multicast_lock);
>  	if (port->multicast_router == MDB_RTR_TYPE_DISABLED ||
>  	    port->multicast_router == MDB_RTR_TYPE_PERM ||
> -	    timer_pending(&port->ip4_mc_router_timer))
> +	    timer_pending(t))
>  		goto out;
>  
>  	__del_port_router(port);
> @@ -1371,6 +1371,13 @@ out:
>  	spin_unlock(&br->multicast_lock);
>  }
>  
> +static void br_ip4_multicast_router_expired(struct timer_list *t)
> +{
> +	struct net_bridge_port *port = from_timer(port, t, ip4_mc_router_timer);
> +
> +	br_multicast_router_expired(port, t, &port->ip4_rlist);
> +}
> +
>  static void br_mc_router_state_change(struct net_bridge *p,
>  				      bool is_mc_router)
>  {
> @@ -1384,10 +1391,9 @@ static void br_mc_router_state_change(struct net_bridge *p,
>  	switchdev_port_attr_set(p->dev, &attr, NULL);
>  }
>  
> -static void br_multicast_local_router_expired(struct timer_list *t)
> +static void br_multicast_local_router_expired(struct net_bridge *br,
> +					      struct timer_list *timer)
>  {
> -	struct net_bridge *br = from_timer(br, t, ip4_mc_router_timer);
> -
>  	spin_lock(&br->multicast_lock);
>  	if (br->multicast_router == MDB_RTR_TYPE_DISABLED ||
>  	    br->multicast_router == MDB_RTR_TYPE_PERM ||
> @@ -1400,6 +1406,13 @@ out:
>  	spin_unlock(&br->multicast_lock);
>  }
>  
> +static inline void br_ip4_multicast_local_router_expired(struct timer_list *t)
> +{
> +	struct net_bridge *br = from_timer(br, t, ip4_mc_router_timer);
> +
> +	br_multicast_local_router_expired(br, t);
> +}
> +

Same comment about inlines in .c files, please move them to br_private.h or drop the inline

>  static void br_multicast_querier_expired(struct net_bridge *br,
>  					 struct bridge_mcast_own_query *query)
>  {
> @@ -1615,7 +1628,7 @@ int br_multicast_add_port(struct net_bridge_port *port)
>  	port->multicast_eht_hosts_limit = BR_MCAST_DEFAULT_EHT_HOSTS_LIMIT;
>  
>  	timer_setup(&port->ip4_mc_router_timer,
> -		    br_multicast_router_expired, 0);
> +		    br_ip4_multicast_router_expired, 0);
>  	timer_setup(&port->ip4_own_query.timer,
>  		    br_ip4_multicast_port_query_expired, 0);
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -3319,7 +3332,7 @@ void br_multicast_init(struct net_bridge *br)
>  
>  	spin_lock_init(&br->multicast_lock);
>  	timer_setup(&br->ip4_mc_router_timer,
> -		    br_multicast_local_router_expired, 0);
> +		    br_ip4_multicast_local_router_expired, 0);
>  	timer_setup(&br->ip4_other_query.timer,
>  		    br_ip4_multicast_querier_expired, 0);
>  	timer_setup(&br->ip4_own_query.timer,
> 

