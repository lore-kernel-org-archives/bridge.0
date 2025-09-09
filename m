Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C6274B5D
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409667; cv=none; b=lQTUF8nWwSVeJtjJe9NmhZP9IhjDw7XXxafHT0zfXPurR07OJDGbTUNWs0DKHQGoUxadh0ijUt0jTNR7Zeogtew68VatfBOPh9C62zpNrgIkKQr4XIOtksnMOVZU3ZP31Q9fbdU5xpi6LjG42C9iszAjZ1ijwUSnWQoYQ5ihBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409667; c=relaxed/simple;
	bh=WuzPPifEQj9HHVMmiWcrGA+eJ4Bw5fBh6CnZszj0M4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a53kbGS0JVCT4UaRCHfGnCUlDGikaYJvVnM2WHVil1r27HeEsl3Qgt4lFwrjoLOP/eVXubJCIzi+0+z4acMrKbe88/x/ZiHQdREcW7YljdSwN+873IlXMODl4FYCpLWq5r6e2Fc9geD9VY62I/GKIDEYutCmS32vvYWQo5Fj0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgftYvy8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgftYvy8"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afeec747e60so1000225566b.0
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409664; x=1758014464; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2plwHTeZpARhSkuJ9Y2jpaZ80nzRFMhPMwl83KVZn8=;
        b=dgftYvy8HBPKcHlzG4P4tfTgOS0CwW8r24EHfr4REt7nJY26WiSFKd1M+y3q30XY82
         63isI8lRScLClyGzqHLv/pGC+TCvU8dFnFewIDiJwPfSGd3Q91htSPGkh+ZTSLv0fxg5
         vRqv+6tq7mI2TBQLps2fkZl/ZHewEFWijRPwa65dXa2bJjLiBiItIuT4z7mwIHu8tw3P
         Es1ksfTHHZ6wp9amOlssxpMdSLKuziFCMWiSUvwrTiwCSHGZemVNT0DKFwKeEgI2Pg4K
         nxFhIbETc/OMR/3EgIdGr5cRyqWYCmd1ztkTGx3pOOpndmnJokeYgT9sYYM96aZxTpqB
         5GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409664; x=1758014464;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2plwHTeZpARhSkuJ9Y2jpaZ80nzRFMhPMwl83KVZn8=;
        b=d2DVWQDpLmXqJ8Qsk7p9AdRZrxwRwigXxGxlLkr14YtcSZ6bPdbBZItpUrvj29IVmp
         E14KHcwDtnzvQpNqiNZzByzIngzG/nhk9WI6d9qRk8JFkmgFRDveJ4Zdo5arY6Br2nOu
         xq8MlYW/gqfxoIR+1YSwT8+0jnj0KVvWYsU/3IbX/XryX7hFxIrhQ2iq1q7QqcSsniON
         icfnrJUrAHkhRoRi6yE+Rps4rAckr3JSJyz6CFF9kEfB68eb2Z9QvL5I3oxTNwE3+tSH
         z0bhJBIolh8dazQzg6yXYVHYukZBWXX7M/Ys3UqI49H4URC6V6sOX/MG676d0+DMLP3n
         wMng==
X-Forwarded-Encrypted: i=1; AJvYcCW4UBfWkH5u1ajM+DFrhvBZSusZ1mkOmaDTtUL2x/kNqRNgUgRkobOoXuiTcRFvxL76fwo2j34=@lists.linux.dev
X-Gm-Message-State: AOJu0YxRe8vLUPqbHRnGRUvofNTSSkpkbcSqzL8xpjwiEoXyukn807Ne
	MP74cAvgy5Q7s+F75putEJEHwJm+gHGia2/1VJh09GwjIFFLWc+KVKb3
X-Gm-Gg: ASbGnctAbdzivHQdeJNp4hB9nvnqTpNTfu3bGMajYgun38P9OTMsr4VTDYak7dQkTnV
	ilfk8RcHNkcLj9xBWUMdKzy27CpzuGBWHSE3MZFFtq2VkOJjG4ItOM/5VLYZx6UkYaJ4Zue5a2C
	K5vBev7Ja4qRVGua4uhrL0eiHVTjjp8flMt8wcJ7CwcCo66lipqwxlwJCom+OJtuOjdghGmafwJ
	xwTlODuHFOiAJQSgleC1UlTb0xNs3jOwxqs29209CJYChbpl0wfp+A5ijlVNtP+1VmqrWXoKkAf
	Gf/DFVUBQXVb39K1o2k96rj+VGE8FkYP52I8wk8Y1lpzjke99rlZbn9LWUR2L5TL9ZWN4612qwP
	HHMLB5fE6EopGryp3UmDjlv7yWTX+eOal5aOp+l7yWxno0DYrkQm7XzHfjYZQHw9bDgraI9Ggi5
	s5kaUrlcxYftnr5Oc/6peKGp2na6h9p5+Mu5kOn5i6dkSt4dOl5L3rpr6LbclmeZyXSQ86Ih4lv
	O4cSRKF3J7F8O8MiuYF0KArMP77tlGGvUsZBj3HKLQ=
X-Google-Smtp-Source: AGHT+IGS/aJ996YKDZSFeqCFIy50lExzH/QqxhiTSTzJ51+0XLvp+rrAxwtXLJPKmlt+0wvatIZOCg==
X-Received: by 2002:a17:907:1c8c:b0:afe:ed71:80aa with SMTP id a640c23a62f3a-b04b16d6406mr1209586266b.57.1757409664029;
        Tue, 09 Sep 2025 02:21:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffcbsm904264a12.3.2025.09.09.02.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:21:03 -0700 (PDT)
Message-ID: <5334812c-37cb-42fa-9d53-402cf3d63786@gmail.com>
Date: Tue, 9 Sep 2025 11:21:02 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 nf-next 3/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250708151209.2006140-1-ericwouds@gmail.com>
 <20250708151209.2006140-4-ericwouds@gmail.com> <aLykN7EjcAzImNiT@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aLykN7EjcAzImNiT@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/25 11:14 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> +	__be16 outer_proto, proto = 0;
>>  	struct nft_pktinfo pkt;
>> +	int ret, offset = 0;
>>  
>>  	nft_set_pktinfo(&pkt, skb, state);
>>  
>>  	switch (eth_hdr(skb)->h_proto) {
>> +	case htons(ETH_P_PPP_SES): {
>> +		struct ppp_hdr {
>> +			struct pppoe_hdr hdr;
>> +			__be16 proto;
>> +		} *ph;
> 
> Maybe add nft_set_bridge_pktinfo() and place this
> entire switch/case there?
> 

Ok. At the end of nft_do_chain_bridge() I've added (after removing
skb->protocol munging):

	if (offset && ret == NF_ACCEPT)
		skb_reset_network_header(skb);

To reset the network header, only when it had been changed.

Do you want this helper to return the offset, so it can be used here?
Or do you think it is more clean to always reset the network header like so:

	if (ret == NF_ACCEPT)
		skb_reset_network_header(skb);

(Same question for nf_ct_bridge_pre())

>> +		skb_set_network_header(skb, offset);
> 
> I assume thats because the network header still points to
> the ethernet header at this stage?

That is correct.

