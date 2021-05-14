Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJd9CnnDvjbfsGiwpgEsiZ8jkYU1UNb88H593dfukS4=;
 b=Um1hYXOcdnLT6aerm5FVKRLziY5E6hNVjW7TzQ8zSqf0bRAxBNrUOu/0IMWwVwTA0ZReHItO4Vhuh36L3NOIG5Hr+xS4117zY7U3td7UJtFidLF6eNbSLCWrYMTjvwqR9SMZ4MVDw1o2xmio0uaDQGxjOUgZRwaX4HHlHy0e9SMRYKSFzgisqcM3inpLOvtQFXuoZTh5aRKllOzZh8y6TSBzq0OqdmELhIxBKB9DnrvJ+xoIJOHelFy80ESwXJKoc8rSUhunq2YxXIPypPwbyVe9Z9mhhdOPWuBHMy1VKLOrKVoR0aameqa2sPOBISSgALcQCZ5whjd1BHKS8SWYBg==
References: <20210514015348.15448-1-mcroce@linux.microsoft.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <8c5129a9-1589-289e-b4cc-65c911144634@nvidia.com>
Date: Fri, 14 May 2021 10:26:43 +0300
In-Reply-To: <20210514015348.15448-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] net: bridge: fix build when IPv6 is
	disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Matteo Croce <mcroce@linux.microsoft.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On 14/05/2021 04:53, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> The br_ip6_multicast_add_router() prototype is defined only when
> CONFIG_IPV6 is enabled, but the function is always referenced, so there
> is this build error with CONFIG_IPV6 not defined:
> 
> net/bridge/br_multicast.c: In function ‘__br_multicast_enable_port’:
> net/bridge/br_multicast.c:1743:3: error: implicit declaration of function ‘br_ip6_multicast_add_router’; did you mean ‘br_ip4_multicast_add_router’? [-Werror=implicit-function-declaration]
>  1743 |   br_ip6_multicast_add_router(br, port);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |   br_ip4_multicast_add_router
> net/bridge/br_multicast.c: At top level:
> net/bridge/br_multicast.c:2804:13: warning: conflicting types for ‘br_ip6_multicast_add_router’
>  2804 | static void br_ip6_multicast_add_router(struct net_bridge *br,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/bridge/br_multicast.c:2804:13: error: static declaration of ‘br_ip6_multicast_add_router’ follows non-static declaration
> net/bridge/br_multicast.c:1743:3: note: previous implicit declaration of ‘br_ip6_multicast_add_router’ was here
>  1743 |   br_ip6_multicast_add_router(br, port);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this build error by moving the definition out of the #ifdef.
> 
> Fixes: a3c02e769efe ("net: bridge: mcast: split multicast router state for IPv4 and IPv6")
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  net/bridge/br_multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 0703725527b3..53c3a9d80d9c 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -62,9 +62,9 @@ static void br_multicast_port_group_rexmit(struct timer_list *t);
>  
>  static void
>  br_multicast_rport_del_notify(struct net_bridge_port *p, bool deleted);
> -#if IS_ENABLED(CONFIG_IPV6)
>  static void br_ip6_multicast_add_router(struct net_bridge *br,
>  					struct net_bridge_port *port);
> +#if IS_ENABLED(CONFIG_IPV6)
>  static void br_ip6_multicast_leave_group(struct net_bridge *br,
>  					 struct net_bridge_port *port,
>  					 const struct in6_addr *group,
> 

There's one more issue from that patch-set, I'll send a fix in a minute.
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
