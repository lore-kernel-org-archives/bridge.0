Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aocN83HuzwP32rnj53taPT09V0+IeF7AOLl2bmoJm7c=;
 b=slXROiDICI4p6PyLq89dot+pG9A3A0CccsSmVP15GD5+Ggl+f/GFmhJkzdK/6IUe9dFwuycrujpeYi4UzgOlZef7rpe+ZtNsFusIEUpwFHc8/823W+3b/YN70PZgLYdnb629Wc65Rn8idG/ZhxhSCyqaGAd4np2d5r+IojaAiMxqEL0AmrjWhnXe1ITjcJ5I+RoIEX/Kn5gvqXUR+OjBIpdJVrqi4LLlDaLsaccs7mbsGxOeic5Zi+pGrAcbo5FwOkgm27/5kmwRmY3tNlBBZZgbrXIm+AQfp/VHvIUCeCERV0SO4mBgz1svVyflYxaACjRtDUuZYL349Oe10Y+Ibg==
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-11-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <04761487-8abe-830e-7cf1-84a270d58ff5@nvidia.com>
Date: Tue, 11 May 2021 12:30:26 +0300
In-Reply-To: <20210509194509.10849-11-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 10/11] net: bridge: mcast: add ip4+ip6
 mcast router timers to mdb netlink
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
> Now that we have split the multicast router state into two, one for IPv4
> and one for IPv6, also add individual timers to the mdb netlink router
> port dump. Leaving the old timer attribute for backwards compatibility.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/if_bridge.h | 2 ++
>  net/bridge/br_mdb.c            | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 13d59c5..6b56a75 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -627,6 +627,8 @@ enum {
>  	MDBA_ROUTER_PATTR_UNSPEC,
>  	MDBA_ROUTER_PATTR_TIMER,
>  	MDBA_ROUTER_PATTR_TYPE,
> +	MDBA_ROUTER_PATTR_INET_TIMER,
> +	MDBA_ROUTER_PATTR_INET6_TIMER,
>  	__MDBA_ROUTER_PATTR_MAX
>  };
>  #define MDBA_ROUTER_PATTR_MAX (__MDBA_ROUTER_PATTR_MAX - 1)
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 3c608da..2cdd9b6 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -79,7 +79,13 @@ static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
>  		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
>  				max(ip4_timer, ip6_timer)) ||
>  		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
> -			       p->multicast_router)) {
> +			       p->multicast_router) ||
> +		    (have_ip4_mc_rtr &&
> +		     nla_put_u32(skb, MDBA_ROUTER_PATTR_INET_TIMER,
> +				 ip4_timer)) ||
> +		    (have_ip6_mc_rtr &&
> +		     nla_put_u32(skb, MDBA_ROUTER_PATTR_INET6_TIMER,
> +				 ip6_timer))) {
>  			nla_nest_cancel(skb, port_nest);
>  			goto fail;
>  		}
> 

