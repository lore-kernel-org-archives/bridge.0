Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cr2F1hwHZmWBwnGRKpFa6pvacft3AfXnIGQrbOXQTvU=;
	b=fHSO0yBjRGXVI4U8CZkjkAsHd+G0me47cHVVHqa4KKKpClhGjlmz+i/QxgIGzGpViX
	zbXBwiu6evblF0xvIaN3Jci6INSKXeLxjokbBFawwZ3IIjuoxerWI18awfnkqkLBdE+F
	5LdCXmNsYly7K3ZKuXqRSLORmw2ltOr6mveNk=
References: <1540520923-17589-1-git-send-email-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cad7acda-8c9e-0698-a901-cfb5d7b1debf@cumulusnetworks.com>
Date: Fri, 26 Oct 2018 10:27:23 +0300
MIME-Version: 1.0
In-Reply-To: <1540520923-17589-1-git-send-email-liuhangbin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: do not add port to router list
 when receives query with source 0.0.0.0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@mellanox.com>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@cumulusnetworks.com>, "David S. Miller" <davem@davemloft.net>

On 26/10/2018 05:28, Hangbin Liu wrote:
> Based on RFC 4541, 2.1.1.  IGMP Forwarding Rules
> 
>   The switch supporting IGMP snooping must maintain a list of
>   multicast routers and the ports on which they are attached.  This
>   list can be constructed in any combination of the following ways:
> 
>   a) This list should be built by the snooping switch sending
>      Multicast Router Solicitation messages as described in IGMP
>      Multicast Router Discovery [MRDISC].  It may also snoop
>      Multicast Router Advertisement messages sent by and to other
>      nodes.
> 
>   b) The arrival port for IGMP Queries (sent by multicast routers)
>      where the source address is not 0.0.0.0.
> 
> We should not add the port to router list when receives query with source
> 0.0.0.0.
> 
> Reported-by: Ying Xu <yinxu@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br_multicast.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 024139b..41cdafb 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1422,7 +1422,15 @@ static void br_multicast_query_received(struct net_bridge *br,
>  		return;
>  
>  	br_multicast_update_query_timer(br, query, max_delay);
> -	br_multicast_mark_router(br, port);
> +
> +	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
> +	 * the arrival port for IGMP Queries where the source address
> +	 * is 0.0.0.0 should not be added to router port list.
> +	 */
> +	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
> +	    (saddr->proto == htons(ETH_P_IPV6) &&
> +	     !ipv6_addr_any(&saddr->u.ip6)))
> +		br_multicast_mark_router(br, port);
>  }
>  
>  static void br_ip4_multicast_query(struct net_bridge *br,
> 

+CC Roopa & bridge@lists.linux-foundation.org
