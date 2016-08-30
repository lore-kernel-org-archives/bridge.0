Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qOX3COHYXkmBsxbfjZpK8QbOuW2k4urIIWxueW7vgnI=;
	b=gadwA0LUuREBaPOZ3Q2OQkLp7wmBG2EeYyXEIJwr7SINYgQT5SUbh1Rsm7ErP/8t1b
	Kf6A1qQu2dREsEGFV9Q/KDDnxL4ntRzsrYf+a+l34XIhvc9tuvqFkMgi6ncCJZZOy9WF
	9d5N9HObvCJ+ugGhiTaMRKBC6QqHNuXDmJJfO9FwEVNMJU9j4z7n+abUY+oNZyeZZGWb
	tOxuDb9381/s5SROZbCajanegFxsdw2fwMBC8PsCQiyxu9DAHb4U9UtR1MjkLkA7VAPN
	ORqoFIN7VyzVm0t3XsqnnYxOaMsNKpa93kFehpio45YUVnEDvCYX0GY05e6FDnBx/H2E
	n9Ow==
Date: Tue, 30 Aug 2016 07:59:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160830075953.739291e1@xeon-e3>
In-Reply-To: <1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
References: <1472562539-23247-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472562539-23247-2-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: change unicast
 boolean to exact pkt_type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, davem@davemloft.net, bridge@lists.linux-foundation.org

On Tue, 30 Aug 2016 15:08:58 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> -	if (!is_broadcast_ether_addr(dest) && is_multicast_ether_addr(dest) &&
> -	    br_multicast_rcv(br, p, skb, vid))
> -		goto drop;
> +	local_rcv = !!(br->dev->flags & IFF_PROMISC);
local_rcv is needlessly initialized in existing code. Pls remove that.

> +	if (is_multicast_ether_addr(dest)) {
> +		/* by definition the broadcast is also a multicast address */
> +		if (is_broadcast_ether_addr(dest)) {
> +			pkt_type = BR_PKT_BROADCAST;
> +			local_rcv = true;
> +		} else {
> +			pkt_type = BR_PKT_MULTICAST;
> +			if (br_multicast_rcv(br, p, skb, vid))
> +				goto drop;
> +		}
> +	}
>


These could go after the BR_STATE_LEARNING check

>  	if (p->state == BR_STATE_LEARNING)
>  		goto drop;
>  
>  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
>  
> -	local_rcv = !!(br->dev->flags & IFF_PROMISC);
> -
>  	if (IS_ENABLED(CONFIG_INET) && skb->protocol == htons(ETH_P_ARP))
>  		br_do_proxy_arp(skb, br, vid, p);
>

can't proxy_arp change what was a broadcast packet into a unicast packet?
