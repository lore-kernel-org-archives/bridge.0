Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D21B4156
	for <bridge@lists.linux.dev>; Wed, 19 Mar 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411923; cv=none; b=NkhwQ5+WHbQZg4Q/bQLyzkCmltPLXEk/D2xb1ZUmI68gS/oPOzLfqbVG5GB0p8wkucoUr6dlyGs2ycU4KOH9DcCbLavY5WBZ45ScLuaz02+7SN37n2jucbrVcUnU3SM1UQa3qDBJTZYFRBirRKP+5gOs20jx7n4BTdFpQOA++Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411923; c=relaxed/simple;
	bh=fCd7elDZWM9TbF2caKdqFUMKsgXTTve7IgUD0O7aD7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4RCIJkDjWzC+njGXjvvkk8F66taeOHxo7cfUo7KGVOvzYtZBBL1cl30kG4x0VyTN/XHrcIkmQZKffHswKnY4WcXmN6evWkk74IR7umClEuJY4XnmM0yp/my0KW3jmDQFcFVg2WsEv7POFUQKtoGJgMHe0NIvDZInD+qZqsuMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCTnNuhv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCTnNuhv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac298c8fa50so8907166b.1
        for <bridge@lists.linux.dev>; Wed, 19 Mar 2025 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742411920; x=1743016720; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76rXdYGiosZcArDP+GPvRYX93rVBHSRF1s8ahqff0Xw=;
        b=GCTnNuhvBW/T7wwuxwqzSXRdgoDL92qcWQidLm1+I/wKrfuUckUQG+WYNpz9qm797M
         iAz+B/yjnvpVY8COO4RciAklnclkkbGd8UkcyXE5wjPQiIkCon0hJ++0Toci0xAEhETH
         ZV95c5mNximVmlxpeJTXFVvtuBtOnDmDZsmMOygYzh10hU2foCD6hnem1mSAwq4HVPyV
         pTViH84XZMkOjMUCOEva/fBZaD340QpyNrm4Yo6Ydp3S9p6jdHe84kdsO2nOhguWOFta
         LkCEwWWWjYqj9iZ9/dQW7DCEdk/2HAmWhf67Z4zBW8VxWD/8h6x9UbPDX3R84FDfHNB9
         V+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411920; x=1743016720;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76rXdYGiosZcArDP+GPvRYX93rVBHSRF1s8ahqff0Xw=;
        b=fTgE/AYXTWCf5hJxkPm61/DYJxikPh/Ln2D183DOxJza0KeR9Do/DojF7yTZnlQIXv
         YedaNWkrdJDmNmz9BM+m6iEbBUTAgEWp7T2v3ByP8DdvE6FCvgyrTeAj5Q4RWqoxbuey
         lRR1JBGAHUL3+MctzpWjzxZmiSd/Lpdg7LsyMC0+KsdRAFQEesIq9Kgss5JAprffsdrP
         eOwlEEPCwNV0BPdc45Vp3aWFzs9Cy5KYLcPXxBEzskgCSNDUjjJTz9FwzDvjrPXt/rLg
         tcwG/Hj9w5DfZ9q4FQnqZP1NfvINZf+XwGv6diilTyrkObLmCHDDvJrx9d9GE6vEZ3PH
         vkJw==
X-Forwarded-Encrypted: i=1; AJvYcCUXiKk5AJGtzPcJPTUqQJP9xUSmmDwbolih9y1vP5UgftNGfCQ5rALzoyko2bNUwVWNB26y6Z0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmnQE2XLiZe2AaF8s59fRDTs1iZK8GwN7IgG2/S4ilkNtIRfvV
	Roz090qWEHb4ConvUcWEWiNFX10/VeNEfe3D2hpwdHK6rnrqtjqT
X-Gm-Gg: ASbGnctKBogdEtpkBvxMZPp+kksMxZ93xHpwqJ4t8FRuWcTSc3HsXZYqRM7u2JT949D
	ra1GpEYTCGttmucuTUHOeW29GjCFLa+P+oXb4+VPrYsd4HXPl6VKZag9iCjEELb76RPfE0rLa9J
	dOuLuMbcl93caeDarj05nCYjWFFy/iS64unsWQo7wUd58rpcJwe3jVr3Wh4fGPdOL/xR7eidWWB
	oOSscxLNBAUZTrrMmhxM6gyrdLb7F4wygFgSGL6P/iNKyBMQCxBi4oTnrIbiefxFeFoVLezuOVy
	430SrEVTECVSbYyjJwgoNJnmoiNoZQTPztpeR072T4Z+ZTNMLQjX1PGUL8JfAU1NK+2Fjb2VPQB
	+VRtLbRLvcaYbCMz1Y0EaTu+ekJLQaIGQQ7qYJyoSpv59H2qz6tkukCHKU9H+W73ruZ9U9smxgt
	zGs4++plBCSyI+xiuMsUA=
X-Google-Smtp-Source: AGHT+IFsH9Vg/8XWJJyAcoTa3h82RYSbCaCHm7YY/12jziTpQuEDgAGkZsZYd7f8xxPAv4Yo7aJb1g==
X-Received: by 2002:a17:907:bb4c:b0:ac1:fbf8:6ae7 with SMTP id a640c23a62f3a-ac3b7c02376mr489571266b.13.1742411919425;
        Wed, 19 Mar 2025 12:18:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe26bsm9467228a12.72.2025.03.19.12.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:18:38 -0700 (PDT)
Message-ID: <8a30aec8-fcc0-4d5f-b4e8-4cb60fe36725@gmail.com>
Date: Wed, 19 Mar 2025 20:18:36 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 nf-next 2/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250315200033.17820-1-ericwouds@gmail.com>
 <20250315200033.17820-3-ericwouds@gmail.com> <Z9n8GHYfuhTFZB3p@calendula>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z9n8GHYfuhTFZB3p@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/25 12:04 AM, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Sat, Mar 15, 2025 at 09:00:32PM +0100, Eric Woudstra wrote:
>> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
>> packets in the bridge filter chain.
>>
>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
>> index 19a553550c76..7c7080c1a67d 100644
>> --- a/net/netfilter/nft_chain_filter.c
>> +++ b/net/netfilter/nft_chain_filter.c
>> @@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
>>  		    struct sk_buff *skb,
>>  		    const struct nf_hook_state *state)
>>  {
>> +	struct ethhdr *ethh = eth_hdr(skb);
>>  	struct nft_pktinfo pkt;
>> +	int thoff;
>>  
>>  	nft_set_pktinfo(&pkt, skb, state);
>>  
>> -	switch (eth_hdr(skb)->h_proto) {
>> +	switch (ethh->h_proto) {
>> +	case htons(ETH_P_PPP_SES):
>> +		thoff = PPPOE_SES_HLEN;
>> +		ethh += thoff;
> 
> This pointer arithmetics does not look correct, ethh is struct ethhdr,
> neither void nor char.
> 
>> +		break;
>> +	case htons(ETH_P_8021Q):
>> +		thoff = VLAN_HLEN;
>> +		ethh += thoff;
> 
> Same here.
> 
>> +		break;
>> +	default:
>> +		thoff = 0;
>> +		break;
>> +	}
>> +
>> +	switch (ethh->h_proto) {
> 
> This switch will match on the wrong offset.
> 
>>  	case htons(ETH_P_IP):
>>  		nft_set_pktinfo_ipv4_validate(&pkt);
>>  		break;
>> @@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
>>  		break;
>>  	}
>>  
>> +	pkt.thoff += thoff;
> 
> And only transport offset is adjusted here.
> 
>>  	return nft_do_chain(&pkt, priv);
>>  }
>>  
>> -- 
>> 2.47.1
>>

I will sort this out and send a new version after the merge window.
