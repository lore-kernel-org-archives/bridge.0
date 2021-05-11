Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+rADTgXKtl+xV7sJI60a9rrH+kwgRJHnwjmjfxHhwg=;
 b=rq3fsThVd4R8XiZjG/RJzcNtwTIxXrTUlqK1MtwyeWQoNQSLW1IulVZD/jIS13D9UQlSY4Q74LWub6yCFM4Qsl2Y4Bbd0MGtpAV1ipRXYSZ+ulwbL39mv+fF0rnDXbCeA3X81x4rZtrA7Zt/uyMfCRhFcwpVHdwYFfdOVHCTlKQW7LWc+udQdWHpM9qaX/opplg74OyCgaOgpdBODdfcS3epCGqcogBuEPx8tQkZFMmI43qvpeK0xn4TcRJOsmVfz3FCq/7EB4aLtiGwPrfQcSUU3QTglA/ru1NJqZbC/JUoNlr+dCqefvcNVqpreajUfbjvOsuphSj/CQ9xGghwrQ==
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-4-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <5804d062-4b3d-9fab-50ba-e9dfa085f4f0@nvidia.com>
Date: Tue, 11 May 2021 12:13:17 +0300
In-Reply-To: <20210509194509.10849-4-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 03/11] net: bridge: mcast: prepare mdb
 netlink for mcast router split
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
> their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
> some inline functions for the protocol specific parts in the mdb router
> netlink code. Also the we need iterate over the port instead of router
> list to be able put one router port entry with both the IPv4 and IPv6
> multicast router info later.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_mdb.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index d61def8..6937d3b 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -16,29 +16,58 @@
>  
>  #include "br_private.h"
>  
> +static inline bool br_rports_have_mc_router(struct net_bridge *br)
> +{
> +	return !hlist_empty(&br->ip4_mc_router_list);
> +}
> +
> +static inline bool
> +br_ip4_rports_get_timer(struct net_bridge_port *port, unsigned long *timer)
> +{
> +	*timer = br_timer_value(&port->ip4_mc_router_timer);
> +	return !hlist_unhashed(&port->ip4_rlist);
> +}
> +
> +static inline bool
> +br_ip6_rports_get_timer(struct net_bridge_port *port, unsigned long *timer)
> +{
> +	*timer = 0;
> +	return false;
> +}
> +

Same comment about inlines in .c files, please move them to br_private.h

>  static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
>  			       struct net_device *dev)
>  {
>  	struct net_bridge *br = netdev_priv(dev);
> -	struct net_bridge_port *p;
> +	bool have_ip4_mc_rtr, have_ip6_mc_rtr;
> +	unsigned long ip4_timer, ip6_timer;
>  	struct nlattr *nest, *port_nest;
> +	struct net_bridge_port *p;
>  
> -	if (!br->multicast_router || hlist_empty(&br->ip4_mc_router_list))
> +	if (!br->multicast_router)
> +		return 0;
> +
> +	if (!br_rports_have_mc_router(br))
>  		return 0;
>  
>  	nest = nla_nest_start_noflag(skb, MDBA_ROUTER);
>  	if (nest == NULL)
>  		return -EMSGSIZE;
>  
> -	hlist_for_each_entry_rcu(p, &br->ip4_mc_router_list, ip4_rlist) {
> -		if (!p)
> +	list_for_each_entry_rcu(p, &br->port_list, list) {
> +		have_ip4_mc_rtr = br_ip4_rports_get_timer(p, &ip4_timer);
> +		have_ip6_mc_rtr = br_ip6_rports_get_timer(p, &ip6_timer);
> +
> +		if (!have_ip4_mc_rtr && !have_ip6_mc_rtr)
>  			continue;
> +
>  		port_nest = nla_nest_start_noflag(skb, MDBA_ROUTER_PORT);
>  		if (!port_nest)
>  			goto fail;
> +
>  		if (nla_put_nohdr(skb, sizeof(u32), &p->dev->ifindex) ||
>  		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
> -				br_timer_value(&p->ip4_mc_router_timer)) ||
> +				max(ip4_timer, ip6_timer)) ||
>  		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
>  			       p->multicast_router)) {
>  			nla_nest_cancel(skb, port_nest);
> 

