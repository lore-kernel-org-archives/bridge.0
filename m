Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f/WAbEOG/tptLifB9LgbWD1+/CHIVuvFFHIVIWW5SbY=;
 b=kpw9UYVl+IwL1va1X+QsxMLUZdovpBIuRhu0so4e6ZXtvUMYHDmISR0yC6PQmchjr4
 2Qe+el83U3tB8LkaWW+NhNDv+h9nRVCVVHH9eqG7eDcg8fErviCcMTYmKiFJ9ap42OXx
 GSmfDUyD0vyvV2POZnyJtUEa1kbwlQtYrFpRBll0K7vHj9k4e6pX0wsi0iQ3VgDp/kLp
 /9WhId3hAugDy9T5YQqOxMA5Fw0hEuPvCmGN0hO7G1wYpUUpsnCEYcdqWK69u0rqURhK
 DiuGofmhD/Mbpy8Ikm36/kdZ8GMIkzXbbbmQvLNu8oB4A+BcWeR3BtS5BzdP8w9ZmkVA
 /peA==
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-3-git-send-email-komachi.yoshiki@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <5970d82b-3bb9-c78f-c53a-8a1c95a1fad7@gmail.com>
Date: Fri, 31 Jul 2020 11:15:19 -0600
MIME-Version: 1.0
In-Reply-To: <1596170660-5582-3-git-send-email-komachi.yoshiki@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH bpf-next 2/3] bpf: Add helper to do
 forwarding lookups in kernel FDB table
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yoshiki Komachi <komachi.yoshiki@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, KP Singh <kpsingh@chromium.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bridge@lists.linux-foundation.org

On 7/30/20 10:44 PM, Yoshiki Komachi wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 654c346b7d91..68800d1b8cd5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5084,6 +5085,46 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
>  	.arg4_type	= ARG_ANYTHING,
>  };
>  
> +#if IS_ENABLED(CONFIG_BRIDGE)
> +BPF_CALL_4(bpf_xdp_fdb_lookup, struct xdp_buff *, ctx,
> +	   struct bpf_fdb_lookup *, params, int, plen, u32, flags)
> +{
> +	struct net_device *src, *dst;
> +	struct net *net;
> +
> +	if (plen < sizeof(*params))
> +		return -EINVAL;

I need to look at the details more closely, but on first reading 2
things caught me eye:
1. you need to make sure flags is 0 since there are no supported flags
at the moment, and

> +
> +	net = dev_net(ctx->rxq->dev);
> +
> +	if (is_multicast_ether_addr(params->addr) ||
> +	    is_broadcast_ether_addr(params->addr))
> +		return BPF_FDB_LKUP_RET_NOENT;
> +
> +	src = dev_get_by_index_rcu(net, params->ifindex);
> +	if (unlikely(!src))
> +		return -ENODEV;
> +
> +	dst = br_fdb_find_port_xdp(src, params->addr, params->vlan_id);

2. this needs to be done via netdev ops to avoid referencing bridge code
which can be compiled as a module. I suspect the build robots will id
this part soon.

