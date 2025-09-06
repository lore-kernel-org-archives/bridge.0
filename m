Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39523D7EC
	for <bridge@lists.linux.dev>; Sat,  6 Sep 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161610; cv=none; b=nJ9PDun7bu33ccMfn3S1SMYDWPSoXO3ln08TZNaIloKxsoqN2A22ldjJF3IikuJZH0w9YMHc92V98qvfD357nS9H063daVj5Xon11sM2ILvEwNYaw3JeDZs05NyafN1BAg+QwKRqYlz4OIzCa+pDYD1eiE2Pjat7EJRqgERSYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161610; c=relaxed/simple;
	bh=uyLHMnAZiaTBpdwrmMUjgQtsM/l0FVDb2WilloB6myE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAs/YNc9IGT6XXdynGCg/WBEDVuStdwx9MBkYc7ps51EGyRmm+/sjHdYCyr9CpT2DKwGHzlbGmASgoW1QExFMCPU624VfLFFH45wVVJrmFrKpAC4vo2YOzFWQVQf0ebMd5shhrppoeAd/yxYdFsCy4y/QpGjQmsm+LxqEPVySIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpRKStAb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpRKStAb"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so3766904a12.0
        for <bridge@lists.linux.dev>; Sat, 06 Sep 2025 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757161606; x=1757766406; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYPCD/NPkTxuL2mcgrjhRFxILZrrbtXYYqo86fwBS9I=;
        b=WpRKStAb5L+8BjpXbcd5sWKuxmVQ3qhejAt29yAppxGhzNpmufHA4A2LiHsArifFGN
         za5hMshDDua+eADvgGNR9ZoRT9nCBbPEDi1MazY/DkQl8xRfC2uTUL/89l/QsU6BQeoK
         vAvF5sbubTWjgdDyiX7Y03jFvf8mdQlFJMdtVGjXIuJQzvGoFgGW85X9Vw5WJwneurR8
         /clwqwuJ5fx4vUbWXxhwEeWx580LgPb3NHBDc9/lIWrvTfWZKrMwjx33Ct+fOBKK4DDf
         7NI9B9sfGQvwEKISTkW+klHIs+W4HE7T2nPHjXpGMZAatfRIDtEs8QJDzCB+KAWCXxZ5
         ImhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757161606; x=1757766406;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYPCD/NPkTxuL2mcgrjhRFxILZrrbtXYYqo86fwBS9I=;
        b=s2oZ9pjgaGEy9XP1PEXDDFz1DiaqX1zItmRL9JhoZSuEPx/UzbqoHZhy9YkCkcHb15
         WJ0lNTb9yLQWf9kwy5eDrkr4xkqOzbErwJU+7122HuwXZLmizp5boLGBM6eYOMZHMtr1
         DDmY6e1R6gsfh2/KCCIK/9tCC4hJJeZIcCJeUvahBe+d/aBIg7rIhmVLLxopD2n/MTUQ
         YDWQJe2Y3U8B52F5LAnIxBflSgt/cClQ3tsnkgwnwJG0kfNeHusU/9hplgxJktQAyqPd
         J6DSFkwN51JjrdQ+Xw0C3uZ1mXnsuAs5JgbblM3dQYzzyQeJVEyu3neLgXR475GFRrbY
         6b4A==
X-Forwarded-Encrypted: i=1; AJvYcCWOE8CQPmbb5HIzCcLjZseR0EDxpNv8Q78mjkFrmooy2uOogBga3IKsSkEJPDmmG/reHL2ERsQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0fZ3jCVBCJHW8B5Cm7Q5puy/BiVnIJf3tP2ThvUsJxufxLWqc
	w8twyv/RxVMx18AvTwFqfT2GCi71IKCRWMAnxNJhzRLxRKaqopP0dGiq
X-Gm-Gg: ASbGncsjwkQPoyxqa0p20V6wbiP+UAw4JMfSFcaQsbUz2rBK0/4SOT6hIO7waEhNqXG
	kuWEDLiezRC3zVLABwZpKUTs+lbZ+lgJnRvP/xYrApvc0NmNTmQRxYpjXvHO4kZaI1w4Knrqrt5
	kn6Yq+2QfN/V+vwkYg5nrmdfFLvpXsxmemN0OcC4lDLcBu3RFmsj7LDnoju66pGVk5XP2Id1xGW
	s4+DNW8yDMUQ0Pf8TFeLJbH/2Hl43dgrruCaYPCvrE/trS1Gxjq8Z5QmHbSvih4P4H3U0yUM9NA
	Wxr/Qd7c/sN554ZnmjMvHV+bfX2XkhkUnCuDKVEBIv4X2ZZlTMfw8xtloxaTl1zJgtz40LnLJdH
	hDxZV/K50EXUISqYjefnynNgj9dTDmB7uwa9bwqECZX3yf6JgJZFzy15o30iV5ukkkmiE7TXXiv
	RZBG0+QoI9RCN6ap789XQa3lOeCDL9S8VvK7CDvTjWBQfozKDfytyp64NQ9SifMvY9MDw7k5wmH
	ofK+d6ALj1I2VsJvyzAzMB1GMm6yd1oW5MtDLnt5kw=
X-Google-Smtp-Source: AGHT+IGlmLdeGtuKvTH0MqCFaPfDo0A7tkqYM1S1rxpawOca3ZnjsfsapUwJICz2nhbV/8xz+LeIZw==
X-Received: by 2002:a17:907:3cc9:b0:b04:6e60:4df1 with SMTP id a640c23a62f3a-b04b17672femr212961366b.53.1757161605812;
        Sat, 06 Sep 2025 05:26:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042fcae867sm1397299366b.58.2025.09.06.05.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 05:26:45 -0700 (PDT)
Message-ID: <4398dc1f-5454-4e06-806e-34ee02108ce2@gmail.com>
Date: Sat, 6 Sep 2025 14:26:43 +0200
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
 <2d207282-69da-401e-b637-c12f67552d8d@gmail.com> <aLbuokOe9zcN27sd@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aLbuokOe9zcN27sd@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/25 3:18 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>>> Thats because of implicit dependency insertion on userspace side:
>>> # ip saddr 1.2.3.4 counter ip daddr 3.4.5.6
>>> bridge test-bridge input
>>>   [ meta load protocol => reg 1 ]
>>>   [ cmp eq reg 1 0x00000008 ]
>>>   [ payload load 4b @ network header + 12 => reg 1 ]
>>>   ...
>>>
>>> So, if userspace would NOT do that it would 'just work'.
>>>
>>> Pablo, whats your take on this?
>>> We currently don't have a 'nhproto' field in nft_pktinfo
>>> and there is no space to add one.
>>>
>>> We could say that things work as expected, and that
>>>  ip saddr 1.2.3.4
>>>
>>> should not magically match packets in e.g. pppoe encap.
> 
> FTR, I think 'ip saddr 1.2.3.4' (standalone with no other info),
> should NOT match inside a random l2 tunnel.
> 
>>> I suspect it will start to work if you force it to match in pppoe, e.g.
>>> ether type 0x8864 ip saddr ...
>>>
>>> so nft won't silently add the skb->protocol dependency.
>>>
>>> Its not a technical issue but about how matching is supposed to work
>>> in a bridge.
>>>
>>> If its supposed to work automatically we need to either:
>>> 1. munge skb->protocol in kernel, even tough its wrong (we don't strip
>>>    the l2 headers).
>>> 2. record the real l3 protocol somewhere and make it accessible, then
>>>    fix the dependency generation in userspace to use the 'new way' (meta
>>>    l3proto)?
>>> 3. change the dependency generation to something else.
>>>    But what? 'ether type ip' won't work either for 8021ad etc.
>>>    'ip version' can't be used for arp.
>>>
>>
>> Hi Florian,
>>
>> Did you get any information on how to handle this issue?
> 
> Did you check if you can get it to match if you add the relevant
> l3 dependency in the rule?
> 
> I don't think we should (or can) change how the rules get evaluated by
> making 'ip saddr' match on other l2 tunnel protocols by default.
> 
> It is even incompatible with any exiting rulesets, consider e.g.
> "ip daddr 1.2.3.4 drop" on a bridge, now this address becomes
> unreachable but it works before your patch (if the address is found in
> e.g. pppoe header).
> 
> 'ip/ip6' should work as expected as long as userspace provides
> the correct ether type and dependencies.
> 
> I.e., what this patch adds as C code should work if being provided
> as part of the rule.
> 
> What might make sense is to add the ppp(oe) header to src/proto.c
> in nftables so users that want to match the header following ppp
> one don't have to use raw payload match syntax.
> 
> What might also make sense is to either add a way to force a call
> to nft_set_pktinfo_ipv4_validate() from the ruleset, or take your
> patch but WITHOUT the skb->protocol munging.
> 
> However, due to the number of possible l2 header chain combinations
> I'm not sure we should bother with trying to add all of them.
> 
> I worry we would end up turning nft_do_chain_bridge() preamble or
> nft_set_pktinfo() into some kind of l2 packet dissector.
> 
> Maybe one way forward is to introduce
> 
> 	NFT_META_BRI_INET_VALIDATE
> 
> nft add rule ... meta inet validate ...
> (just an idea, come up with better names...)
> 
> We'd have to add NFT_PKTINFO_L3PROTO flag to
> include/net/netfilter/nf_tables.h.
> (or, alternatively NFT_PKTINFO_UNSPEC).
> 
> Then, set this flag in struct nft_pktinfo, from
> nft_set_pktinfo_ipv4|6_validate (or from nft_set_pktinfo_unspec).
> 
> NFT_META_BRI_INET_VALIDATE, would call nft_set_pktinfo_ipv4_validate
> or nft_set_pktinfo_ipv6_validate depending on iph->version and set
> NFT_BREAK verdict if the flag is still absent.
> 
> **USERSPACE IS RESPONSIBLE** to prevent arp packets from entering
> this expression. If they do, then header validation should fail
> but there would be an off-chance that the garbage is also a valid
> ipv4 or ipv6 packet.

I'll try to recap what this would mean for this patch, correct me if I
am wrong.

'ip saddr 1.2.3.4' should NOT match inside a random l2 tunnel. That
makes the 'issue' expected behavior. If the user must need to match
ip(v6) address, it must be solved from userspace, modifying the rule.

This patch (3/3) can be applied as-is, with only one change: remove
munging skb->protocol.

