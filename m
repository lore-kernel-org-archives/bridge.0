Return-Path: <wharms@bfs.de>
Message-ID: <5992A239.5080600@bfs.de>
Date: Tue, 15 Aug 2017 09:26:49 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
References: <20170815065025.18471-1-colin.king@canonical.com>
In-Reply-To: <20170815065025.18471-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: fix indent on in statements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>



Am 15.08.2017 08:50, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The returns on some if statements are not indented correctly,
> add in the missing tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/bridge/netfilter/ebt_ip.c  | 4 ++--
>  net/bridge/netfilter/ebt_ip6.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/netfilter/ebt_ip.c b/net/bridge/netfilter/ebt_ip.c
> index d06968bdf5ec..2b46c50abce0 100644
> --- a/net/bridge/netfilter/ebt_ip.c
> +++ b/net/bridge/netfilter/ebt_ip.c
> @@ -64,14 +64,14 @@ ebt_ip_mt(const struct sk_buff *skb, struct xt_action_param *par)
>  			if (NF_INVF(info, EBT_IP_DPORT,
>  				    dst < info->dport[0] ||
>  				    dst > info->dport[1]))
> -			return false;
> +				return false;


This is hard to read, perhaps it gets better when the result is stored in a tmp-var.
something like:
	int isbetween=dst < info->dport[0] ||dst > info->dport[1] ;
	int state=NF_INVF(info, EBT_IP_DPORT, isbetween );

	if ( state )
		return false;

just my 2 cents,
re,
 wh

>  		}
>  		if (info->bitmask & EBT_IP_SPORT) {
>  			u32 src = ntohs(pptr->src);
>  			if (NF_INVF(info, EBT_IP_SPORT,
>  				    src < info->sport[0] ||
>  				    src > info->sport[1]))
> -			return false;
> +				return false;
>  		}
>  	}
>  	return true;
> diff --git a/net/bridge/netfilter/ebt_ip6.c b/net/bridge/netfilter/ebt_ip6.c
> index 4617491be41e..2a5a52a53ec4 100644
> --- a/net/bridge/netfilter/ebt_ip6.c
> +++ b/net/bridge/netfilter/ebt_ip6.c
> @@ -89,7 +89,7 @@ ebt_ip6_mt(const struct sk_buff *skb, struct xt_action_param *par)
>  			if (NF_INVF(info, EBT_IP6_SPORT,
>  				    src < info->sport[0] ||
>  				    src > info->sport[1]))
> -			return false;
> +				return false;
>  		}
>  		if ((info->bitmask & EBT_IP6_ICMP6) &&
>  		    NF_INVF(info, EBT_IP6_ICMP6,
