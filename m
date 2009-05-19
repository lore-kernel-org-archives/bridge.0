Date: Tue, 19 May 2009 15:18:02 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090519151802.22debf54@nehalam>
In-Reply-To: <20090511125350.555985895@openvz.org>
References: <20090511114639.440944109@openvz.org>
	<20090511125350.555985895@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 1/5] net: bridge - use is_multicast_ether_addr
	helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

On Mon, 11 May 2009 15:46:40 +0400
Cyrill Gorcunov <gorcunov@openvz.org> wrote:

> Instead of handwritten constrcution it's better 
> to use is_multicast_ether_addr.
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
> ---
>  net/bridge/br_device.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.git/net/bridge/br_device.c
> =====================================================================
> --- linux-2.6.git.orig/net/bridge/br_device.c
> +++ linux-2.6.git/net/bridge/br_device.c
> @@ -32,7 +32,7 @@ int br_dev_xmit(struct sk_buff *skb, str
>  	skb_reset_mac_header(skb);
>  	skb_pull(skb, ETH_HLEN);
>  
> -	if (dest[0] & 1)
> +	if (is_multicast_ether_addr(dest))
>  		br_flood_deliver(br, skb);
>  	else if ((dst = __br_fdb_get(br, dest)) != NULL)
>  		br_deliver(dst->dst, skb);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


This is trivial and fine.
Acked-by: Stephen Hemminger <shemminger@vyatta.com>
