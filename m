Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7C273FD
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802940; cv=none; b=r3fmwR7W2UOVz7PAIPG9MR24KrY/6OOXbySgq0cVmtU6zvw+8DapvWMAoDipQVazG1q4psVu30QyNNbBH4eT7xdAFJcsK8tgVme4WIj8mxakEB7mQCamnxiwWN86CwZ/EOokHbtWdrTY8HFjhu6MkUc+w8CeNAh+lmdKQgtVTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802940; c=relaxed/simple;
	bh=2wVL7DUI0EjgOovlyJtaHodUa4Nb7PkMiJ+oBK/yrAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+cjIveC6fwZluZZf+JnWD1vJybUQAm0UIBAg0CoFgbceUVJ5mO1RHOreUzfLKdnMrH/Uqam7R4GaBbR/j+HIzjv7EGAXDvYQIiAdRp0Ml3seVrHvXrVdcQqVVQ5eh6qa7uBkjbbtPNHEF+tRSQbdrFLBgTkFpeAXnyoJberh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiLL9gQv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiLL9gQv"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so9032831a12.2
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802937; x=1757407737; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3u4DU53ZStZI8TtGH19n60e9se0poMcUbUdRTXQJkNU=;
        b=IiLL9gQvJeqG14C2FD33695TYmPmL5F9beO887vnLSRMeLMaGkxijOAXr/mW7iEV5v
         w5Az4HD2BRImAvhCZI+m4wCegSc4bG9TzBBsV9zn2qFbdVA5uSq/LiFFMEX0ppZA6Zgv
         +L+wYAMj/Vdczp+IznidlElCluACdu1O0J1YsR/YsSwpvZC1nuahxuWlBv+qeFDGF7t2
         WqVImMcKwIHtp1floZgbynXB0+I72CrS/t8wXtYpEG8FAzraPqNj4gqCIIAYFvtPC0oL
         DUwsbu6wttl83W4JK/6l6ii120W25nEvs0ipmVYCfJaP2a28IZjGgRRgfAVHD7Y3Emgz
         V2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802937; x=1757407737;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3u4DU53ZStZI8TtGH19n60e9se0poMcUbUdRTXQJkNU=;
        b=jPAo4/LM/87XKTXlfC6LYA3VuOTalg65gw6yEKhwi3lp82Oz2e79LtcDPcH6YlO2xc
         mWPX8wVhfl9Zv/sYpNccTY0gqBJyHIVZP5u4byDFtnMrMgZDN0EB+yy9XP10GrhPit5V
         Xh5m+tDVslNMlQv4Hp/QOWTq1KoEMMCfAzW+oJy4T7fKRX5fTXNgXV/fqbrhEXf1dDAc
         dj7a+RggdIaXw9gn82TX+kKG+Arn2rraezqfzJvf33Y9UPXJd9KPMUM92Ht/laeqX88x
         37BTbgzh2FgDKiHhGfbAgjzQD/ayAIuhklcR4VHf/LRsqZkpjpkjdms8PgaGGdwDi/8N
         hBkw==
X-Forwarded-Encrypted: i=1; AJvYcCUybdmd+Q+YI9/DBO/TZH4vZ1z1GX5obTJHZEl/EgJskzb4Q9kefh4OI+5tYfb/BFaKiCorygY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwoRTLkA9vFo0FQIc4jIsNzI+T2og4xn9/kXURcpz88b1v2Ca7Z
	FW3dDNgZlpeS3PaHwIGRqN/ZGaf6X2GVJswdiDhxAAlx4Cigc6rEEnN/
X-Gm-Gg: ASbGncspkipeE1NGQDNt64Ljb768EfgOCzrm0xxCmH/bKM/Gt/fSHd+SsdX6XGdligO
	p30baQafemH813ILUte9ucpmeT5LJglYrw3G8S3IIdqbUbSg7VvtBhSJnY90dVQjJwPyzYZpKAu
	Nnm3vyZX3spUT2VavnuPf7cRdajRXx2/6xOd2lbNmNdkUaFFXSaxyWxAv9xloDEOmp4LQfXOsbv
	VoETs9Ltcy1DVp0uZDcSrxNJOj5MYSIcZTBaVRFRRidIdUr8hLxoPOKKqNUAftVogmDt/zbQcSk
	YEYD/kFrrbGBwb8rScOhSfQ0IhrQcon6MTRafQKrwAivEOxfZpM0iK/xL11O82sLFvoUyRDExnH
	VuwIowcF6oAbDJmhqGWoMnflYuJz1ROGed08Sv4fpbBr1JJC1EI3FLOM2e1adgm9n1EaYXuWpr6
	Q5AwmsWNy2PRVyRztPlxOfXFHtzFeYI4/5PoqIE521dzql1TVT1bk2eQCDBBKCqBu14Kkbh6wGC
	/BvqhsD1IaqkEstE8P4AyEWT0Pii2eUi/luRyEoMbgLHUVALAO4DA==
X-Google-Smtp-Source: AGHT+IGnk+M6JtRt1++JxUrcqAy/3+2qIzpIG/SKfC/t/CmkS+op4CWifCvXgv07BmglGVSJS50K7g==
X-Received: by 2002:a05:6402:4414:b0:61d:3dad:228d with SMTP id 4fb4d7f45d1cf-61d3dad22c7mr8400226a12.13.1756802937232;
        Tue, 02 Sep 2025 01:48:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7dfesm9141306a12.7.2025.09.02.01.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:48:56 -0700 (PDT)
Message-ID: <2d207282-69da-401e-b637-c12f67552d8d@gmail.com>
Date: Tue, 2 Sep 2025 10:48:55 +0200
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
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
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
> 

Hi Florian,

Did you get any information on how to handle this issue?

>> I haven't found where yet, but It seems nft is checking skb->protocol,
>> before it tries to match the ip(6) saddr/daddr.
> 
> Yes, userspace inserts this, see 'nft --debug=netlink add rule bridge ..'

