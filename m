Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=zR26Xhy2G+eY0HqU3wMJ0rmUDSZXWCuQzZljZslDQZc=;
 b=YlQ9pF7ADm8jiiTkcapeL+FYckkTO+KJpnPdbVSBoYaiBvOUHfZAx9CodOizdKgsNc
 a2FIWapk4J0D/kJogR20vITg9TwvrDUyZkE2F7pOEHaCg11+3y8dmdFIwZt6EZQfLfV2
 N7AX34BsMO+vxLb2ThbB57hpkMRlEuuzprGrM=
References: <20200702081307.933471-1-horatiu.vultur@microchip.com>
 <20200702081307.933471-3-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <64dd72f9-2b81-335a-e6ae-85376c72aa47@cumulusnetworks.com>
Date: Thu, 2 Jul 2020 13:01:53 +0300
MIME-Version: 1.0
In-Reply-To: <20200702081307.933471-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 2/3] bridge: mrp: Add
	br_mrp_fill_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com

On 02/07/2020 11:13, Horatiu Vultur wrote:
> Add the function br_mrp_fill_info which populates the MRP attributes
> regarding the status of each MRP instance.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 64 +++++++++++++++++++++++++++++++++++++
>  net/bridge/br_private.h     |  7 ++++
>  2 files changed, 71 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index 34b3a8776991f..c4f5c356811f3 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -304,6 +304,70 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  	return 0;
>  }
>  
> +int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
> +{
> +	struct nlattr *tb, *mrp_tb;
> +	struct br_mrp *mrp;
> +
> +	mrp_tb = nla_nest_start_noflag(skb, IFLA_BRIDGE_MRP);
> +	if (!mrp_tb)
> +		return -EMSGSIZE;
> +
> +	list_for_each_entry_rcu(mrp, &br->mrp_list, list) {
> +		struct net_bridge_port *p;
> +
> +		tb = nla_nest_start_noflag(skb, IFLA_BRIDGE_MRP_INFO);
> +		if (!tb)
> +			goto nla_info_failure;
> +
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_RING_ID,
> +				mrp->ring_id))
> +			goto nla_put_failure;
> +
> +		p = rcu_dereference(mrp->p_port);
> +		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_P_IFINDEX,
> +				     p->dev->ifindex))
> +			goto nla_put_failure;
> +
> +		p = rcu_dereference(mrp->s_port);
> +		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_S_IFINDEX,
> +				     p->dev->ifindex))
> +			goto nla_put_failure;
> +
> +		if (nla_put_u16(skb, IFLA_BRIDGE_MRP_INFO_PRIO,
> +				mrp->prio))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_RING_STATE,
> +				mrp->ring_state))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_RING_ROLE,
> +				mrp->ring_role))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
> +				mrp->test_interval))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
> +				mrp->test_max_miss))
> +			goto nla_put_failure;
> +		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
> +				mrp->test_monitor))
> +			goto nla_put_failure;
> +
> +		nla_nest_end(skb, tb);
> +	}
> +	nla_nest_end(skb, mrp_tb);
> +
> +	return 0;
> +
> +nla_put_failure:
> +	nla_nest_cancel(skb, tb);
> +
> +nla_info_failure:
> +	nla_nest_cancel(skb, mrp_tb);
> +
> +	return -EMSGSIZE;
> +}
> +
>  int br_mrp_port_open(struct net_device *dev, u8 loc)
>  {
>  	struct net_bridge_port *p;
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 6a7d8e218ae7e..65d2c163a24ab 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1317,6 +1317,7 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
>  bool br_mrp_enabled(struct net_bridge *br);
>  void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
> +int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
>  #else
>  static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  			       struct nlattr *attr, int cmd,
> @@ -1339,6 +1340,12 @@ static inline void br_mrp_port_del(struct net_bridge *br,
>  				   struct net_bridge_port *p)
>  {
>  }
> +
> +static inline int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
> +{
> +	return 0;
> +}
> +
>  #endif
>  
>  /* br_netlink.c */
> 

