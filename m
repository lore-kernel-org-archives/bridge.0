Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F71FDD
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283758; cv=none; b=U2TWZ5N5pZV0SCysM5ZB+sRyQ5iWNcbmj4mMpW7lpdiE0T79eaKvbsDqnUsXA06CoxHZfJCKUUDhisE4qNWCFr0b7+QGRornnW+ilzNi+QAkaofv3l1A4wcA1llkeRv38Ctt+yMeZst2XLW+uvp1kEpdL2/dwj47HtSGBt8NMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283758; c=relaxed/simple;
	bh=7S8+vO3ASy53c9/QMBRYjqmZUqwJy9+RRobBAyVghQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3gyHydg7SFF8fctcgwFKUqvYheM/krkSUjCLJ/AoM50wbcyNlrq/KAngT7D9ZssHgjZ8Ex3E4XEwCt+YiOOtJO8Ue0OQ4KGHcAQ3yjDZmeOpamPfqD97XCrkOed7DdWEmHgBjX6kgfEr6r+tO9crSPFq280P+yX7IT+Loxx9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp5xfvsG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp5xfvsG"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b70bee93dc4so359288766b.3
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 11:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762283755; x=1762888555; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QMyfynSbIJu4PvSuals8RhlA+Y6TdmVDUTrRaQq4u0=;
        b=Gp5xfvsGdmWrWmarTd0Z8/ixJrN/cugMSlukgt90O+50g77G1wNJVpTyDz7XLA89x6
         eV4ozP2PU9jTBrOYp1jXYRBQxAM0Aj3r5ajdwwAfGU9fT7OEm+ycEMDTuOSqxvmdE8QL
         8lwqC46wyjfqlg8q2F0Fke/6IxBZvEXVfl7PwjX1Yd6YvMOg47dr+dbEV+0sjiqbbJFC
         Dq0JrgfFFC3L5GfUwrqJcJG8fjv7HzkT5I3wn1wJq2EVESulshm1pQEGqELTqfq+pz5g
         A3giGteQ7vuHFNUdhHZmud/Sefreuajthaa4UzvP2eiEIJ6B3i0hOmLPX5tizFnJ4URx
         Owzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283755; x=1762888555;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QMyfynSbIJu4PvSuals8RhlA+Y6TdmVDUTrRaQq4u0=;
        b=r5RIzHEpibAwkxpu7flNnfwLLRauYodIKKwbM5GOOfE6Ooqm3GgQ6JEiRXKa50UDBJ
         pMeQZg87pzMMBc/fAUOaFmoDrhgLu6W5gil7dc6zSFZkKEICS9vBF0GflaBCIgtZryY8
         Iccj07WwIEWpvV13Iyt7QSEs+ohDjh3KrMBC/TnHksr/I3DWk+2hn4W69BlgkUWw4T9Q
         fVCs70FqPjl0ocGtTheun3bKomHnuO1zx2PrQqAmgxlvmkCmbNGLILRCxlEAQDDM/mbu
         qAOekHSBREE+ZhgklUp8RWl5A79TcjnV7lXjPJQKlbeVWu67WhsQ0t2NUnu6PgCDTByf
         vamw==
X-Forwarded-Encrypted: i=1; AJvYcCWXfDDtsYVVoLalZoWRmiOUXLjeu50TYn69vTI9LNnsvpaxpSOlJwxs86SBUlErNeEwxnK/iEY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYBCRb6gPVEqyU9q5GuR+/+iZbgBoHqqjX+0+3I0ab2GvbOnbt
	rnxo0mQiXqECwaonKNoxwf6AZaFvSm/ivnbWFqpYoW5g7cA41CBhKwB3
X-Gm-Gg: ASbGncuqKT2WO+IZ4J1/XLRbMVbWqN+wFt96UnUUeZaRAddWN52mtOqIYERK1SB62o5
	QWTyyX06QYpWN0dh1q+CiY3Gg2sVDtDWuR0cBYT2Hz4RKHGeK6fdofVq7ZPEV/H6dRWbFIGp7m8
	4XHpTdBaOIDFgXc7xpC+kIMQIhrP4vLZnSXPlSgMAmYQPQhtyL5Jt7ePePuTVuI+K0nu9ulcRn4
	3Xp0n97bwZeNMPb92qprmkZKJAWpyGLMB0qQazKoD6Rjl+Xz5OSgY/9X15sIjG8jzbFzuMeURK3
	cQ1/Zm9VSi/HvWKINEuXW4wU+4bqq50gao++5XMnF8K+q8Qt7ZLKCYp4fRN1HguM+/HPr+sCvyp
	+qQYaVASUOAwy+URH6JnXRuEjt6G/5f7uU23yivWqAKVR2JotDeoZR3DZH7SWUyCx3Av9KIOJaU
	dyF1FYY1GBur/vDl9g8OvrufEok8Z1KobFiL8+N3vwYQ6fQPSn7r61k1wD2BP0MprHr+rniAugU
	MQrsBisEgn8hw6piMUzcKC7LYHChu2gZtoTCRBzRBRYvhSTa1RUzw==
X-Google-Smtp-Source: AGHT+IGKnATGAMZLZ7BfrzK+rb/mjrrF2BjsXgKd9+vxecCJZWw7vzWEChRRFBgO1QfKEyIV7kI6LA==
X-Received: by 2002:a17:907:6d0c:b0:b3f:5049:9e81 with SMTP id a640c23a62f3a-b726554c6fbmr23752866b.47.1762283754795;
        Tue, 04 Nov 2025 11:15:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a336asm290222766b.7.2025.11.04.11.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:15:54 -0800 (PST)
Message-ID: <114f0b33-2c5f-4ae8-8ed8-e8bc7ef3dd2c@gmail.com>
Date: Tue, 4 Nov 2025 20:15:51 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 nf-next 3/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20251104145728.517197-1-ericwouds@gmail.com>
 <20251104145728.517197-4-ericwouds@gmail.com> <aQohjDYORamn7Gya@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aQohjDYORamn7Gya@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 4:53 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> +	switch (*proto) {
>> +	case htons(ETH_P_PPP_SES): {
>> +		struct ppp_hdr {
>> +			struct pppoe_hdr hdr;
>> +			__be16 proto;
>> +		} *ph;
>> +
>> +		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
>> +			return -1;
>> +		ph = (struct ppp_hdr *)(skb->data);
>> +		switch (ph->proto) {
>> +		case htons(PPP_IP):
>> +			*proto = htons(ETH_P_IP);
>> +			skb_set_network_header(skb, PPPOE_SES_HLEN);
>> +			return PPPOE_SES_HLEN;
>> +		case htons(PPP_IPV6):
>> +			*proto = htons(ETH_P_IPV6);
>> +			skb_set_network_header(skb, PPPOE_SES_HLEN);
>> +			return PPPOE_SES_HLEN;
>> +		}
>> +		break;
>> +	}
>> +	case htons(ETH_P_8021Q): {
>> +		struct vlan_hdr *vhdr;
>> +
>> +		if (!pskb_may_pull(skb, VLAN_HLEN))
>> +			return -1;
>> +		vhdr = (struct vlan_hdr *)(skb->data);
>> +		*proto = vhdr->h_vlan_encapsulated_proto;
>> +		skb_set_network_header(skb, VLAN_HLEN);
>> +		return VLAN_HLEN;
>> +	}
>> +	}
>> +	return 0;
>> +}
>> +
>>  static unsigned int
>>  nft_do_chain_bridge(void *priv,
>>  		    struct sk_buff *skb,
>>  		    const struct nf_hook_state *state)
>>  {
>>  	struct nft_pktinfo pkt;
>> +	__be16 proto;
>> +	int offset;
>>  
>> -	nft_set_pktinfo(&pkt, skb, state);
>> +	proto = eth_hdr(skb)->h_proto;
>>  
>> -	switch (eth_hdr(skb)->h_proto) {
>> +	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
>> +	if (offset < 0)
>> +		return NF_ACCEPT;
> 
> 
> Hmm.  I'm not sure, I think this should either drop them right away
> OR pass them to do_chain without any changes (i.e. retain existing
> behavior and have this be same as nft_set_pktinfo_unspec()).
> 
> but please wait until resend.
> 
> I hope to finish a larger set i've been working on by tomorrow.
> Then I can give this a more thorough review (and also make a summary +
> suggestion wrt. the bridge match semantics wrt.  vlan + pppoe etc.
> 
> My hunch is that your approach is pretty much the way to go
> but I need to complete related homework to make sure I did not
> miss/forget anything.

I understand. I've send this, because from v5 to v15 it moved towards
matching in the rule, but it all started with the fact that
nft_flow_offload_eval() uses nft_thoff().

At a bare minimum I need to address having pkt->thoff set correctly to
implement the software bridge-fastpath.

The fact that it also makes possible to match L3/L4 data in the rule is
also nice to have.

Hopefully you can take this in consideration during your review.

