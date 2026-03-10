Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4D18859B
	for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131826; cv=none; b=gbSB95XUOMDtBYPmsj5e6jKzrFdFGjztSvPNW1zGijwdy+PVVnDkguUsP6FNZ1Y4P0r/Xk6arzOtrnviUlRJnkpiEHTeSt2Y93h4fIeYckhVjyAAIHAjdtn+QNaRzJWQltRux/LPBmiKn1IU9thWSs7qzJUoQWtP0IgIsvmFdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131826; c=relaxed/simple;
	bh=SkOW0Me5Mei+6+811W8wfI40/OJEsEajTjQbZP2i/9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwGADJcOPJYqnEbhLTnS19pGcDG7AFDf2h6coqlNNhQxXuFFH4IN2bVZl0X5uw4hSiW5Sh/QMAubb2/RhNejGJ0R4OWuCnvoWX8XABziCLjnOWcEq4zgdIau9zksa4xqJjVgV62pJSgoTPpZTY/MqXAKQthNgzte6EuQRPIbVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFDVoQ1D; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFDVoQ1D"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so7853583a12.3
        for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773131824; x=1773736624; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nmp2C2LK1KcB7kS8d+inf4YkPeQ+OioLOT0ROrHIx4Q=;
        b=kFDVoQ1DCkz2RfqZ3VrR153ZtYIFLsmVqkRreZPyA6VOsnfSSAKMgh2opBZoNDZRLU
         oyz2jGNHy3o5yeN+kbRKPePKo9+wUgRVX//1B9uYvI6+2t3nONrcNAwy9ax+UsnR4BR6
         d1VdQ5gPXPZar95Oypzxk+fD8WIoBLGdB4X1gSQvOhyf7/mryeiptBsQ4/g1qCZPfFs9
         6zhngvG9fXkKvKr1i0dKJmImxkwmQuOTR1ntKX8/ZgnXGycgWVu7NhVhZIBlOL3Pxo/J
         6dNue0T6CXQHuTBWnWHxKcSzV98+Z5TcaiCgb9paVKrkd1xfQlbX2VtPMu8NfADBWniI
         DAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773131824; x=1773736624;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nmp2C2LK1KcB7kS8d+inf4YkPeQ+OioLOT0ROrHIx4Q=;
        b=ql34T1cAONb5oGIYH4aj3+sIanbLT+NfdEtRlPYy9Tw3stcKe7miqCV3AQfzAAlq8H
         wXuU34r+b/KtTtfNSw53srQa+iKlDc4NAS5Ms5iFFtFehEZJtWK7z+zv9rUHanxJJPgu
         /2hixC1Y9HQP9RN1B89FkIWTyGnra2Fb73isMAWQXXLdwXNHzxzIbjC0NDgU4uJqxiU0
         jSwGXg8hlzjv+aZgA9ciFrNf79o/GRaTsBEcy93+uc+wrTDUJIN8dTARfC0Z5Pq9uWnG
         /alFiZtDRffDsAnGZ64TF0ihGNLfjHCdXeSuWZFBBfXNF4T0ZQXh68Z3FF/nJqoZ7P4e
         MzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpxMcF9sedsCmF8Cc9yoE5jCDA1tpKvCPZig7hazwkh/RBNkkwI3NjUlt7VZFvqrWYqcwN1Z8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxnrc04TllawfSxqdnpz4JsZq8hkCxfcxMqddbbH4/RtDqoSfPB
	b41DAzZGec9bXeVnfxOtcr43D7nMeGjhLCMn9JX12cNy9krz2eQLRo5u
X-Gm-Gg: ATEYQzy7o7v527aOOZEQq+ew0n4ignhMNHzFKKf1ojd5wXx040yshwxJhkkxazm3lW2
	GNlAk0FxPhQk+BQqJCT1EqhYtLGYLWiBl1hp5XIom9FayRKWRhiDZSmP168+Eo7VZIB5t0cicNa
	jcRLPLF9cqQRBEl3lqlegp7bFQK/P6LBCrzg6GItdZ0yg6FBC15+s2p/9qhgPk9L8Pj/kXHoQFt
	/frU4ZGd0o3xN85RWqg9IwSYecQRyrTOexI6kMZbLBfSsVJTaApnzZnBs84NFVgrIyldSQX7dqC
	M+zDzuOGCp5NZvyyrROVxdFVFolXICur6jL3TnNUFf7MwQy46tqVYftoo/HivD+vQT92WgBDiNw
	mhWsIaep8ayX/5bCAEDyN4PEZxDYAfcXK0ZjQLLQGdgEYTNJ/449o2CX8btVYm2oKBx6/RX/XaE
	vZQ+XtwXBDOwN9QrfphYwZlEetDfvjQKO5HJt9mx1Nk5rKBOTM1VeY/vtCJ5fwd7ZG/4VQcRpSY
	0Zm57F5reOQZkk+psJQLN3fBc9Ia7zFdUBvPGcSzq1+CXQ7Dn1aWEVGjw6HbkcxdmXC0R1W5v5T
	BrKjHs29rJ8uiSjHvPDHrcqc3no+9acrRw==
X-Received: by 2002:a05:6402:13cb:b0:660:ce49:f6d1 with SMTP id 4fb4d7f45d1cf-6619d53ce70mr7697726a12.30.1773131823379;
        Tue, 10 Mar 2026 01:37:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a3e61eb6sm4096796a12.8.2026.03.10.01.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 01:37:02 -0700 (PDT)
Message-ID: <76b3546a-37c5-4dab-9074-4df0cbe48524@gmail.com>
Date: Tue, 10 Mar 2026 09:37:00 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 nf-next 5/5] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Phil Sutter <phil@nwl.cc>, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260224065307.120768-1-ericwouds@gmail.com>
 <20260224065307.120768-6-ericwouds@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20260224065307.120768-6-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 7:53 AM, Eric Woudstra wrote:
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
> index d4d5eadaba9c..66ef30c60e56 100644
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
> +		} *ph, _ph;
> +
> +		ph = skb_header_pointer(skb, 0, sizeof(_ph), &_ph);
> +		if (!ph) {
> +			*proto = 0;
> +			return -1;
> +		}
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
> +		struct vlan_hdr *vhdr, _vhdr;
> +
> +		vhdr = skb_header_pointer(skb, 0, sizeof(_vhdr), &_vhdr);
> +		if (!vhdr) {
> +			*proto = 0;
> +			return -1;
> +		}
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

Just in case, I'm sending a kind and small reminder, before it is too
late in the cycle.

Regards,

Eric

