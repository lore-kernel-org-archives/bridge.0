Message-ID: <4C72CD1C.7020901@pandora.be>
Date: Mon, 23 Aug 2010 21:33:48 +0200
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <1282539806-25496-1-git-send-email-xiaosuo@gmail.com>
In-Reply-To: <1282539806-25496-1-git-send-email-xiaosuo@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2] bridge: netfilter: fix a memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Changli Gao <xiaosuo@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

Looks correct to me.

Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>

Changli Gao schreef:
> nf_bridge_alloc() always reset the skb->nf_bridge, so we should always
> put the old one.
>
> Signed-off-by: Changli Gao <xiaosuo@gmail.com>
> ---
> v2: Should init tmp->use again because memcpy() overwrite it.
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
> index 2c911c0..5ed00bd 100644
> --- a/net/bridge/br_netfilter.c
> +++ b/net/bridge/br_netfilter.c
> @@ -162,8 +162,8 @@ static inline struct nf_bridge_info *nf_bridge_unshare(struct sk_buff *skb)
>  		if (tmp) {
>  			memcpy(tmp, nf_bridge, sizeof(struct nf_bridge_info));
>  			atomic_set(&tmp->use, 1);
> -			nf_bridge_put(nf_bridge);
>  		}
> +		nf_bridge_put(nf_bridge);
>  		nf_bridge = tmp;
>  	}
>  	return nf_bridge;
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>   


-- 
Bart De Schuymer
www.artinalgorithms.be

