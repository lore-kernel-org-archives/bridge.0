Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90E201034
	for <bridge@lists.linux.dev>; Sat, 12 Jul 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752314935; cv=none; b=VYesOzDjGXA1XHF4xhyqAvlUP1AQrEa2/aRAe5asRvZT3ROeeJyKrASRDAw7RK7RDn4qCCZywFVY0zW8Ht78VVRJfJXmSSdTZsFDe7/cNkw3eY25GgvLR8nX4R01cqaoCQWlJT3urvlz5EysigThZHBqgWKAewhXePD8/Mn6S2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752314935; c=relaxed/simple;
	bh=/7FhxhUKRdXLcCpht0SasLliMovD6ZI97aLJBeweMEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8rGzj5TFBXgHXVZ2c5egGvzkUAYAc6a4RWSP2xyLoYwD2xJVVGtJpI8gyYNGP8MRsMwmSDBij+vwIZ6T65u0fieJnEAytVcC32t1Jax4yjR/MduEbPveY8O/Ph/5vYQkm3rk7AdGI6+t5xM0FPFGVt/kicHdPbEg1wfZv023GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G84Gdg3t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G84Gdg3t"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so496758266b.0
        for <bridge@lists.linux.dev>; Sat, 12 Jul 2025 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752314932; x=1752919732; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+eJO7lZ+aUO3GREvLxb2HdalOKZ6MnXGDlkmXm5ze4=;
        b=G84Gdg3tBbZ5tB8Ubo3DsFTxIxiRNiQ2zo3J2LR5O6xdudlZoip0wD9IjlIJvyTIsm
         Y0VFkC/tcojRuOlWa4zw2NpUTtVnzO+WI8zp3eWBrhhm1UkKuZXC83QSaG3dMcM9RGIC
         vDgsdpTrjLcY993ofnaS14jfY5Ei1MNQNYLnDjTsG289LhDZ4IFyyobInR+1Rlwg30PF
         cfulZ/9AnAlW/WEIDtBRpifMv1ygf+gSXh5dwlovPs2Gm6PjtIGqRhTIJc9JlpFMUA84
         fo0GJQhvV3XmFChXPn7nqYoP8unDvFlgmWXnL7lZ1Iu5tTZ6HCk/hr7tFSe3uCQArgd3
         cIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752314932; x=1752919732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+eJO7lZ+aUO3GREvLxb2HdalOKZ6MnXGDlkmXm5ze4=;
        b=OfiOBnuPL0UK7dxxf6EvqtTVl16dnacYsQ5msq1z+oijg+K+1sUUtOhwo/1bISNovz
         Uf70wuT0Zf/p8td/0Gi8EJkcx/hnSDuDV9OWGp3ompuP0Lv2LSVF6ceH6P1pzdwwZ1bQ
         ES8+JHSAayJshex93UPW61O+mG1dvzPZo2RqUw0HzlHYipMP++HLbE1IteeQXH+XrMJX
         xPFEOIII1+KlBEi4wxYOMzddS/xmnCf7iJJP00uZnimrcpRgMxgDw5eMHDk3fhU53xOt
         5BeI42eC0Wp/Y3mLgd0bDtfOttoEdid6OpnoowwcrBJQGZzsUms+jGlKl+Q4kmftKN0W
         3eVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwEGFx1yHpRFY80GtJyAJ0CzWhm6hfabyqHV7q/zTuaGS70Cpw09tqaVfL7a8lz+/iYeBzh/g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz39ajkTs9PFfoxcX2E5QXMxAQyHiS1WWJMDP27JozUQhc5gGzN
	UfpQPkg6JKyKrJr8ebNYhDmvMCiRCf1dJPGYAP9jNh7PGUrWnFs/38KU
X-Gm-Gg: ASbGncvx0u1G3gxN/iuzCkx+pNizNXRZqzr/HCqkwjymgl8K6SQiLlKEnmc+CUCp3ds
	2/hPdDxupU6dksCQ2tjua4p47GhvpZskSIIa52Kn4BhVhHF5wEf0evAhTUWmmoA/RUFE2CWSUhM
	Jh91gbDjKNQ3y+0x2UjXW1OmI2sbuk+EjNGYACH8SBXI6Pg00vKG0z6u0pin2mQ1oFtzauC4FVT
	MKb550hGR0HWtiC+9Bob7ubJSg3VizWAvDQixm8jVIHvWKIMGEgyyomDxTwjf900IRWEr3BWelT
	x4cuYCxsEzEZBNRF4QxqmjMX4SxaLOMdYN8uqO1RKYI/cL4TlZ5E6F4rZSxv6VAM8PZaLcokOYk
	Y1hSYNszMCcb+GzBrGSzh5yI3a0n1RMzMQHh7QVClob+RgYevEj8aUHu3HSeW02/wAwnzOzOcGE
	o87qwXpbf6Z+3wxrNrSa1u8LJuvKL2zWgl0yFAy7PxsvmIxnt972ITHru1NaGebxpNKFkXViNP
X-Google-Smtp-Source: AGHT+IFIOLuDKv6c9RfzlcBDtf/CyOztjAQJPRECB+fyUnEIdhY9dn3XgfrqLeSDdWwQTsjQTwhhrQ==
X-Received: by 2002:a17:907:6d0f:b0:ae3:c968:370 with SMTP id a640c23a62f3a-ae6fcb67267mr675808666b.59.1752314931597;
        Sat, 12 Jul 2025 03:08:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df594sm458235066b.159.2025.07.12.03.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 03:08:51 -0700 (PDT)
Message-ID: <5db98a41-37b5-41f9-8a57-f143cc0eb39b@gmail.com>
Date: Sat, 12 Jul 2025 12:08:50 +0200
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
 <20250708151209.2006140-4-ericwouds@gmail.com> <aG2Vfqd779sIK1eL@strlen.de>
 <6e12178f-e5f8-4202-948b-bdc421d5a361@gmail.com> <aHEcYTQ2hK1GWlpG@strlen.de>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <aHEcYTQ2hK1GWlpG@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/25 4:14 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
> 
> [ skb->protocl munging ]
> 
>> But in nft_do_chain_bridge() it is needed in the case of matching 'ip
>> saddr', 'ip daddr', 'ip6 saddr' or 'ip6 daddr'. I suspect all ip/ip6
>> matches are suffering.
> 
> Thats because of implicit dependency insertion on userspace side:
> # ip saddr 1.2.3.4 counter ip daddr 3.4.5.6
> bridge test-bridge input
>   [ meta load protocol => reg 1 ]
>   [ cmp eq reg 1 0x00000008 ]
>   [ payload load 4b @ network header + 12 => reg 1 ]
>   ...
> 
> So, if userspace would NOT do that it would 'just work'.
> 
> Pablo, whats your take on this?
> We currently don't have a 'nhproto' field in nft_pktinfo
> and there is no space to add one.
> 
> We could say that things work as expected, and that
>  ip saddr 1.2.3.4
> 
> should not magically match packets in e.g. pppoe encap.
> I suspect it will start to work if you force it to match in pppoe, e.g.
> ether type 0x8864 ip saddr ...
> 
> so nft won't silently add the skb->protocol dependency.
> 
> Its not a technical issue but about how matching is supposed to work
> in a bridge.
> 
> If its supposed to work automatically we need to either:
> 1. munge skb->protocol in kernel, even tough its wrong (we don't strip
>    the l2 headers).
> 2. record the real l3 protocol somewhere and make it accessible, then
>    fix the dependency generation in userspace to use the 'new way' (meta
>    l3proto)?
> 3. change the dependency generation to something else.
>    But what? 'ether type ip' won't work either for 8021ad etc.
>    'ip version' can't be used for arp.

Is using 'meta nfproto ipv4' instead an option? This looks at
pkt->state->pf, which holds the correct value, not at skb->protcol.

> 
>> I haven't found where yet, but It seems nft is checking skb->protocol,
>> before it tries to match the ip(6) saddr/daddr.
> 
> Yes, userspace inserts this, see 'nft --debug=netlink add rule bridge ..'

