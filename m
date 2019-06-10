Return-Path: <pablo@netfilter.org>
Date: Mon, 10 Jun 2019 19:41:36 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190610174136.p3fbcbn33en5bb7f@salvia>
References: <20190609162304.3388-1-christian@brauner.io>
	<20190609162304.3388-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609162304.3388-2-christian@brauner.io>
Subject: Re: [Bridge] [PATCH net-next v1 1/1] br_netfilter: namespace bridge
 netfilter sysctls
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Brauner <christian@brauner.io>
Cc: ueberall@themenzentrisch.de, vapier@chromium.org, richardrose@google.com, bhthompson@google.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, joelhockey@chromium.org, tyhicks@canonical.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, smbarber@chromium.org, davem@davemloft.net

Thanks for updating this patch to use struct brnf_net.

A few comments below.

On Sun, Jun 09, 2019 at 06:23:04PM +0200, Christian Brauner wrote:
[...]
> diff --git a/include/net/netfilter/br_netfilter.h b/include/net/netfilter/br_netfilter.h
> index 89808ce293c4..302fcd3aade2 100644
> --- a/include/net/netfilter/br_netfilter.h
> +++ b/include/net/netfilter/br_netfilter.h
> @@ -85,17 +82,42 @@ static inline __be16 vlan_proto(const struct sk_buff *skb)
>  		return 0;
>  }
>  
> -#define IS_VLAN_IP(skb) \
> -	(vlan_proto(skb) == htons(ETH_P_IP) && \
> -	 brnf_filter_vlan_tagged)
> +static inline bool is_vlan_ip(const struct sk_buff *skb, const struct net *net)
> +{

I like this conversion from macro to static inline a lot.

But if you let me ask for one more change, would you split this in two
patches? One to replace #defines by static inline.

Then, second patch introduces the sysctl update you need.

It will make it easier for me to review.

[...]
> +static inline bool is_vlan_ipv6(const struct sk_buff *skb,
> +				const struct net *net)
> +{
> +#ifdef CONFIG_SYSCTL

Probably we can reduce #ifdef pollution a bit if you always add
'filter_vlan_tagged' and other fields to the brnf_net structure. No
matter if CONFIG_SYSCTL is set on or off. I think it's worth consuming
a bit more memory to simplify this code, so both CONFIG_SYSCTL=y and
CONFIG_SYSCTL=n run the same codepath.

Most vendors will just turn on to CONFIG_SYSCTL=y, and I don't think
it's worth the extra code for the CONFIG_SYSCTL=n case.

> +	struct brnf_net *brnet = net_generic(net, brnf_net_id);
> +
> +	return (vlan_proto(skb) == htons(ETH_P_IPV6) &&
> +		brnet->filter_vlan_tagged);
> +#else
> +	return (vlan_proto(skb) == htons(ETH_P_IPV6));

BTW, I think parens are not needed, ie.

	return vlan_proto(skb) == htons(ETH_P_IPV6);

should be fine?

Thanks!
