Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843963D994
	for <bridge@lists.linux.dev>; Sun, 25 Jan 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358348; cv=none; b=XAWA1iTIBIrqc0oMdgVIHwRsuBrurkwd7KCoK0HA+MDHk6jF+aZLCGXbNjNrz5Y2HKFnBw8kXFCtZaXDb5G1utzdrk4TWcTLUR3ztzo5X/OS3Q/Eq8PPOGx5UsQvzL8ngNiEVLLjA/NDZg2zBRlhWNuaECVQH41wQfa6ym29awQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358348; c=relaxed/simple;
	bh=QVtSTX/XLp16X/oXKfhKEuxOzQqk8ZSe4U/GC/FHDBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGe6GIzniFPV8Z0IFNKXBoY/Kd2LOrpjHl8GLLUZ5YIfLICrSoEL8T9iQfqz1BGGL1v/su8g3ZV0/WgbQnsvoopm1levAYNuFohEvpTjPD6N2to9Sisgc2vKWY0wLve1agqsONZdhKFLLJzSaoVUIT/gJXovShKz57CBKFcfdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLm/eQWS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLm/eQWS"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so6703965a12.1
        for <bridge@lists.linux.dev>; Sun, 25 Jan 2026 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769358344; x=1769963144; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v57Iy+bDz50Wo3pEiRxYhkqRNwfCJZJ1CeX2JqnHG4=;
        b=fLm/eQWSrUArM2M2Ml/1ijIgUZf11okKODlGD0rjEWqG8Y3ie0CNUlb3r37ld50ctZ
         NrTSoULnn5pc2ROLxHODN993eutV/xE76cTZULyYtKDJFwMPnNKJIF8pyYW2+Om7rLGA
         ZKbWIWbqAjC7JwButcN7emyrsnBhBHbs/FwbAak+1R/n768wOHXrktl7H3NOFflcBp+X
         OJRHb3MRkfDsnMwfZROQjhwYJSzLyoes23/1uwxNG6c+aL3zADJbpGRD5FsDDbrN3MJ/
         xsrFDtdRb6tmpDt7KpyY5DIDUoxjji/95DCQBvUy9CBH74XTG1hndwctvKO1k97ZKqQZ
         jknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769358344; x=1769963144;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v57Iy+bDz50Wo3pEiRxYhkqRNwfCJZJ1CeX2JqnHG4=;
        b=IGU2d0U4ow5Vt/MBJ+eCiWe0GY8oAqYtiiovFZ6yDMHkWGE78PQVsNdgipBfThTbyU
         PAGTabDlrlRJeaqy7A5/umJZpYpB9Omc3CgKwQZ6GdOLow5GHfCA6vPdIpGAUAPnkr0D
         QeK9ehaqUJmr1MNu3JDXyVFM/tIWP01l8f6h0wPtdNSwN12o1v9qExDc6pjAab7+vtaz
         uDOTvJIlWazsismJngYqReQm879ZyeLQMmf6jfpOt7y47/4LALxiLy/ISFrLGhmvW/7i
         kaFRaVZm9UZFo9EJNLq+GPEU5bQW20zsxAMQoc+Efh2JcRuAzP6K4xx2q9UewvzHHShW
         PX1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGe+UW81CQSGfva/6EbLQrFkEnWu+iOhiwEz15Jvd79aTmtIJeRC+R1Hp70Apu01LICAiYB38=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWdCuu3SGdmgiXMyTKd1oDkkxeppXdxFoFoVCiAJg7AGtL8r+L
	5BBCly5kzs+fYbMtHv3m9kVpVQHLmJOdismDvpwbVmuZDJpzRHPXU9f5
X-Gm-Gg: AZuq6aK4c204f+/8XYlUWCJzZ01RrafgtCx+bXbXdQNudPAaerVn6KengG8WA1W/ZyJ
	ywlcW/iEiM1nW8X2zFm5MNQ98YqcgCJGQMXk2KnswM8E7Kl5rhoyS8vkmFbtEi10H9cfUaJypZm
	2R3/p2TIxceqUysLAr+sx0yEgP/JY5lqBQw0mA1ROOFQD3eRxqfw+obnbHD0DTgJedIb7bJLcAZ
	5leR9cRrPkBdiLl+AiXsTDRCMLGovSHOTYpmkdQeTBusaJiaD0qq3vzfOZ5TpPoGPSpvpeaADgE
	20T5YfDZupAN9W8e5zb60UGfIYpSrvof9VOB6rAz3FkFfySsAuDBOoTmIeYSgPVSvdIO6R9YUsK
	htocbm3WISqqzWYdnl5tDxMXxF9fGK0qClkXN9AvX3u9nbdE7lOE1jaEwgaWnRQTbzyiOKmQUeM
	30Zb5EckBTFyELrCxbZ7nU8BWt2lq72h1RExLDthWZIQS6BI5Lfo4O8+ZJ0IBs5i19wntBmLBM4
	S1RRrI/NxEJFd48qyB3ZncLNbIDTgQLxnCN1m32U0+yqvcPkUtRb5dx45AUDrANPQ==
X-Received: by 2002:a05:6402:f23:b0:658:7a1:fbe7 with SMTP id 4fb4d7f45d1cf-658706ecd1amr811921a12.23.1769358343678;
        Sun, 25 Jan 2026 08:25:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3e07cbsm3860622a12.1.2026.01.25.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 08:25:43 -0800 (PST)
Message-ID: <e9c7fa63-6c9b-48c2-97c9-2d73e1029f20@gmail.com>
Date: Sun, 25 Jan 2026 17:25:41 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 nf-next 4/4] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev
References: <20251109192427.617142-1-ericwouds@gmail.com>
 <20251109192427.617142-5-ericwouds@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20251109192427.617142-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/25 8:24 PM, Eric Woudstra wrote:
> In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
> and packets encapsulated in single 802.1q or 802.1ad.
> 
> When implementing the software bridge-fastpath and testing all possible
> encapulations, there can be more encapsulations:
> 
> The packet could (also) be encapsulated in PPPoE, or the packet could be
> encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
> encapsulation.
> 
> nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
> known from the conntrack-tuplehash. To access the header it uses
> nft_thoff(), but for these packets it returns zero.
> 
> Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
> offsets.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
> index d4d5eadaba9c..082b10e9e853 100644
> --- a/net/netfilter/nft_chain_filter.c
> +++ b/net/netfilter/nft_chain_filter.c
> @@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
>  #endif /* CONFIG_NF_TABLES_IPV6 */
>  
>  #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
> +static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
> +				  const struct nf_hook_state *state,
> +				  __be16 *proto)
> +{
> +	nft_set_pktinfo(pkt, skb, state);
> +
> +	switch (*proto) {
> +	case htons(ETH_P_PPP_SES): {
> +		struct ppp_hdr {
> +			struct pppoe_hdr hdr;
> +			__be16 proto;
> +		} *ph;
> +
> +		if (!pskb_may_pull(skb, PPPOE_SES_HLEN)) {
> +			*proto = 0;
> +			return -1;
> +		}
> +		ph = (struct ppp_hdr *)(skb->data);
> +		switch (ph->proto) {
> +		case htons(PPP_IP):
> +			*proto = htons(ETH_P_IP);
> +			return PPPOE_SES_HLEN;
> +		case htons(PPP_IPV6):
> +			*proto = htons(ETH_P_IPV6);
> +			return PPPOE_SES_HLEN;
> +		}
> +		break;
> +	}
> +	case htons(ETH_P_8021Q): {
> +		struct vlan_hdr *vhdr;
> +
> +		if (!pskb_may_pull(skb, VLAN_HLEN)) {
> +			*proto = 0;
> +			return -1;
> +		}
> +		vhdr = (struct vlan_hdr *)(skb->data);
> +		*proto = vhdr->h_vlan_encapsulated_proto;
> +		return VLAN_HLEN;
> +	}
> +	}
> +	return 0;
> +}
> +
>  static unsigned int
>  nft_do_chain_bridge(void *priv,
>  		    struct sk_buff *skb,
>  		    const struct nf_hook_state *state)
>  {
>  	struct nft_pktinfo pkt;
> +	__be16 proto;
> +	int offset;
>  
> -	nft_set_pktinfo(&pkt, skb, state);
> +	proto = eth_hdr(skb)->h_proto;
> +
> +	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
>  
> -	switch (eth_hdr(skb)->h_proto) {
> +	switch (proto) {
>  	case htons(ETH_P_IP):
> -		nft_set_pktinfo_ipv4_validate(&pkt, 0);
> +		nft_set_pktinfo_ipv4_validate(&pkt, offset);
>  		break;
>  	case htons(ETH_P_IPV6):
> -		nft_set_pktinfo_ipv6_validate(&pkt, 0);
> +		nft_set_pktinfo_ipv6_validate(&pkt, offset);
>  		break;
>  	default:
>  		nft_set_pktinfo_unspec(&pkt);

I've also tried asking on the cover letter 0/4, but no response.

Can I ask what is the status of this patchset? Quite some time has
passed by now...

