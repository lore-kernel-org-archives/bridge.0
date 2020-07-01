Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=0kXRdSJAJ2w4NQlFklwwTlNh4niyvAaA7nq0nb1Nl9w=;
 b=TKjUYKLX6JQ1Vx3Tgm8MEFxB00Q/s6wjCbaTl6fB6p1083zS9fGrr4QNE60EbE+zh8
 pqjBvxntdr4CRSOS3SAQ5HMGPVXCmQICT0jLF8ETNh5N3vS88001cu6PLG5DhRuQDNFy
 uiPqZRC0HChlt9qzVlENXWvQ+YJJv3gw+PoCo=
References: <20200701072239.520807-1-horatiu.vultur@microchip.com>
 <20200701072239.520807-4-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a861340c-8d80-6cff-39ec-1a80ee578813@cumulusnetworks.com>
Date: Wed, 1 Jul 2020 12:51:32 +0300
MIME-Version: 1.0
In-Reply-To: <20200701072239.520807-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 3/3] bridge: Extend br_fill_ifinfo
 to return MPR status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com

On 01/07/2020 10:22, Horatiu Vultur wrote:
> This patch extends the function br_fill_ifinfo to return also the MRP
> status for each instance on a bridge. It also adds a new filter
> RTEXT_FILTER_MRP to return the MRP status only when this is set, not to
> interfer with the vlans. The MRP status is return only on the bridge
> interfaces.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/rtnetlink.h |  1 +
>  net/bridge/br_netlink.c        | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 879e64950a0a2..9b814c92de123 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -778,6 +778,7 @@ enum {
>  #define RTEXT_FILTER_BRVLAN	(1 << 1)
>  #define RTEXT_FILTER_BRVLAN_COMPRESSED	(1 << 2)
>  #define	RTEXT_FILTER_SKIP_STATS	(1 << 3)
> +#define RTEXT_FILTER_MRP	(1 << 4)
>  
>  /* End of information exported to user level */
>  
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 240e260e3461c..6ecb7c7453dcb 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -453,6 +453,32 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  		rcu_read_unlock();
>  		if (err)
>  			goto nla_put_failure;
> +
> +		nla_nest_end(skb, af);
> +	}
> +
> +	if (filter_mask & RTEXT_FILTER_MRP) {
> +		struct nlattr *af;
> +		int err;
> +
> +		/* RCU needed because of the VLAN locking rules (rcu || rtnl) */
> +		rcu_read_lock();

If you're using RCU, then in the previous patch (02) you should be using RCU primitives
to walk the list and deref the ports.
Alternatively if you rely on rtnl only then drop these RCU locks here as they're misleading.

I'd prefer to just use RCU for it in case we drop rtnl one day when dumping.

> +		if (!br_mrp_enabled(br) || port) {
> +			rcu_read_unlock();
> +			goto done;
> +		}
> +		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
> +		if (!af) {
> +			rcu_read_unlock();
> +			goto nla_put_failure;
> +		}
> +
> +		err = br_mrp_fill_info(skb, br);
> +
> +		rcu_read_unlock();
> +		if (err)
> +			goto nla_put_failure;
> +
>  		nla_nest_end(skb, af);
>  	}
>  
> @@ -516,7 +542,8 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  	struct net_bridge_port *port = br_port_get_rtnl(dev);
>  
>  	if (!port && !(filter_mask & RTEXT_FILTER_BRVLAN) &&
> -	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED))
> +	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED) &&
> +	    !(filter_mask & RTEXT_FILTER_MRP))
>  		return 0;
>  
>  	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> 

