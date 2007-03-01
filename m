Message-ID: <45E62C29.7010203@candelatech.com>
Date: Wed, 28 Feb 2007 17:28:09 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <20070228171846.679d8733@dxpl.pdx.osdl.net>
In-Reply-To: <20070228171846.679d8733@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, David Miller <davem@davemloft.net>

Stephen Hemminger wrote:
> I was measuring bridging/routing performance and noticed this.
> 
> The current code runs the "all packet" type handlers before calling the
> bridge hook.  If an application (like some DHCP clients) is using AF_PACKET,
> this means that each received packet gets run through the Berkeley Packet Filter
> code in sk_run_filter (slow).
> 
> By moving the bridging hook to run first, the packets flowing through
> the bridge get filtered out there. This results in a 14%
> improvement in performance, but it does mean that some snooping applications
> would miss packets if being used on a bridge.  The correct way to see all
> packets on a bridge is to set the bridge pseudo-device to promiscuous
> mode.

Seems it would be better to fix these clients to be more selective as to
where they bind.

This breaks the case where you want to see packets on a particular interface,
not just the entire bridge, right?

Thanks,
Ben

> 
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
> ---
>  net/core/dev.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cf71614..dc2cda6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1792,6 +1792,10 @@ int netif_receive_skb(struct sk_buff *skb)
>  
>  	rcu_read_lock();
>  
> +	if (handle_bridge(&skb, &pt_prev, &ret, orig_dev))
> +		goto out;
> +
> +
>  #ifdef CONFIG_NET_CLS_ACT
>  	if (skb->tc_verd & TC_NCLS) {
>  		skb->tc_verd = CLR_TC_NCLS(skb->tc_verd);
> @@ -1826,9 +1830,6 @@ int netif_receive_skb(struct sk_buff *skb)
>  ncls:
>  #endif
>  
> -	if (handle_bridge(&skb, &pt_prev, &ret, orig_dev))
> -		goto out;
> -
>  	type = skb->protocol;
>  	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {
>  		if (ptype->type == type &&


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

