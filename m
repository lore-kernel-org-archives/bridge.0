Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zvdN0KlmX3wZK+orI8fawnIsdS+O3fazG4GsTX6VAMw=;
 b=glDPvZpDBHShxX0NxVM/DL3zWnixukRAJ0kclV+fg9UWRYFG+l0sxSBJB4ZQn5X42z
 qF2wNbjf8pi++voupgIx2DSHBGUbwIvEg7cFR2RSvhagj5UHYQxjWVASO4JYMnfLjVg5
 ZdMuu+rbpSI7t6EoSbHeama679hQyfITJMGtU=
References: <20200601125855.1751343-1-idosch@idosch.org>
 <20200601125855.1751343-2-idosch@idosch.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <7e2ffbf7-b756-04ee-1210-a11fd26d1237@cumulusnetworks.com>
Date: Mon, 1 Jun 2020 16:02:16 +0300
MIME-Version: 1.0
In-Reply-To: <20200601125855.1751343-2-idosch@idosch.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 1/2] bridge: Avoid infinite loop when
 suppressing NS messages with invalid options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, roopa@cumulusnetworks.com, dlstevens@us.ibm.com, Ido Schimmel <idosch@mellanox.com>, allas@mellanox.com, kuba@kernel.org, davem@davemloft.net

On 01/06/2020 15:58, Ido Schimmel wrote:
> From: Ido Schimmel <idosch@mellanox.com>
> 
> When neighbor suppression is enabled the bridge device might reply to
> Neighbor Solicitation (NS) messages on behalf of remote hosts.
> 
> In case the NS message includes the "Source link-layer address" option
> [1], the bridge device will use the specified address as the link-layer
> destination address in its reply.
> 
> To avoid an infinite loop, break out of the options parsing loop when
> encountering an option with length zero and disregard the NS message.
> 
> This is consistent with the IPv6 ndisc code and RFC 4886 which states
> that "Nodes MUST silently discard an ND packet that contains an option
> with length zero" [2].
> 
> [1] https://tools.ietf.org/html/rfc4861#section-4.3
> [2] https://tools.ietf.org/html/rfc4861#section-4.6
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Reported-by: Alla Segal <allas@mellanox.com>
> Tested-by: Alla Segal <allas@mellanox.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 37908561a64b..b18cdf03edb3 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -276,6 +276,10 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>  	ns_olen = request->len - (skb_network_offset(request) +
>  				  sizeof(struct ipv6hdr)) - sizeof(*ns);
>  	for (i = 0; i < ns_olen - 1; i += (ns->opt[i + 1] << 3)) {
> +		if (!ns->opt[i + 1]) {
> +			kfree_skb(reply);
> +			return;
> +		}
>  		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
>  			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
>  			break;
> 

Good catch!
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
