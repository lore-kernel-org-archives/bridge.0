Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=6JLKSldc/2w8wSkGE6E7ekIq5myR9p+S2U3JdNqd/yM=;
	b=eP2FFPoO/+jkvRjeXz+Zz3ACAPRSpnFmzkPLfQBYFjf7ZWZXVqadtwh6gI3K5J4Dis
	BCMe0IrGKvAYqXCWe/j4ecT0h37kXtNA+KVtEzNQoxsW2kjE8VZHUWdp5EQLBsDNRFMu
	q2vpLWVpY3uveOD8uvjaq4j36rTu4IkAdl6Q2QQrnxq3uAw7Iaq8Vyyi/fvnWZNMkO9S
	Npv3NvHk5wsbHjxCmMVhuRTRrM6R4knxLkgTJbSbFE0quZneel9Vh036hhlDSwBRMqRy
	c99AqWy636lVY5uj8DbuDObSVbe4QitkBeHmjkAXRtHOgCOTtQf2AJXp2Vkzdl3erPvS
	Rwbg==
Date: Mon, 29 Oct 2018 09:33:16 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20181029013316.GK24677@leo.usersys.redhat.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027090747.22104-1-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, yinxu@redhat.com

On Sat, Oct 27, 2018 at 12:07:47PM +0300, Nikolay Aleksandrov wrote:
> Recently a check was added which prevents marking of routers with zero
> source address, but for IPv6 that cannot happen as the relevant RFCs
> actually forbid such packets:
> RFC 2710 (MLDv1):
> "To be valid, the Query message MUST
>  come from a link-local IPv6 Source Address, be at least 24 octets
>  long, and have a correct MLD checksum."
> 
> Same goes for RFC 3810.
> 
> And also it can be seen as a requirement in ipv6_mc_check_mld_query()
> which is used by the bridge to validate the message before processing
> it. Thus any queries with :: source address won't be processed anyway.
> So just remove the check for zero IPv6 source address from the query
> processing function.
> 
> Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Opps.. Sorry for the mistake and thank you for your fix.

Regards
Hangbin

> ---
>  net/bridge/br_multicast.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 41cdafbf2ebe..6bac0d6b7b94 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1428,8 +1428,7 @@ static void br_multicast_query_received(struct net_bridge *br,
>  	 * is 0.0.0.0 should not be added to router port list.
>  	 */
>  	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
> -	    (saddr->proto == htons(ETH_P_IPV6) &&
> -	     !ipv6_addr_any(&saddr->u.ip6)))
> +	    saddr->proto == htons(ETH_P_IPV6))
>  		br_multicast_mark_router(br, port);
>  }
>  
> -- 
> 2.17.2
> 
