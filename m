Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Aj4QKKJojEodXlG0rvLUNxVoPZ5Fr2yPYro2NiVUoeE=;
 b=ZCEEJ384Iu1DGQxnvlhX72M4mccDWl5ldcoVeiCEHr08wVI+D8Q5hSZH2B9pZ6bUcE
 ue6vH3qGR35NPbHd13201SO7tYLiwSm+t3EwJNAmINb0vvzEh2KSOlIlqNoPF6YXfpW+
 /C17pnz3hPkxbrQ96By5VAGCS0+66sxIVXvyM=
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-12-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <dd1e615d-6390-e521-28d3-98f01308df42@cumulusnetworks.com>
Date: Tue, 14 Jul 2020 16:24:56 +0300
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-12-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 11/12] bridge: mrp: Extend
	br_mrp_fill_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch extends the function br_mrp_fill_info to return also the
> status for the interconnect ring.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index a006e0771e8d3..2a2fdf3500c5b 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -474,6 +474,11 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
>  				     p->dev->ifindex))
>  			goto nla_put_failure;
>  
> +		p = rcu_dereference(mrp->i_port);
> +		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
> +				     p->dev->ifindex))
> +			goto nla_put_failure;
> +
>  		if (nla_put_u16(skb, IFLA_BRIDGE_MRP_INFO_PRIO,
>  				mrp->prio))
>  			goto nla_put_failure;
> @@ -493,6 +498,19 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
>  				mrp->test_monitor))
>  			goto nla_put_failure;
>  
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_STATE,
> +				mrp->in_state))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_ROLE,
> +				mrp->in_role))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
> +				mrp->in_test_interval))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
> +				mrp->in_test_max_miss))
> +			goto nla_put_failure;
> +
>  		nla_nest_end(skb, tb);
>  	}
>  	nla_nest_end(skb, mrp_tb);
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
