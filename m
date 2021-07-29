Return-Path: <pablo@netfilter.org>
Date: Thu, 29 Jul 2021 10:08:29 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20210729080829.GA16912@salvia>
References: <20210729074658.8538-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210729074658.8538-1-yajun.deng@linux.dev>
Subject: Re: [Bridge] [PATCH v2] netfilter: nf_conntrack_bridge: Fix memory
 leak when error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:46:58PM +0800, Yajun Deng wrote:
> It should be added kfree_skb_list() when err is not equal to zero
> in nf_br_ip_fragment().
> 
> v2: keep this aligned with IPv6.
> 
> Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
> index 8d033a75a766..3cf5457919c6 100644
> --- a/net/bridge/netfilter/nf_conntrack_bridge.c
> +++ b/net/bridge/netfilter/nf_conntrack_bridge.c
> @@ -88,6 +88,11 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
>  
>  			skb = ip_fraglist_next(&iter);
>  		}
> +
> +		if (!err)
> +			return 0;
> +
> +		kfree_skb_list(iter.frag_list);

Actually:
		kfree_skb_list(iter.frag);

I used frag_list instead of frag in my snippet.

>  		return err;
>  	}
>  slow_path:
> -- 
> 2.32.0
> 
