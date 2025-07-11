Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6A1DFCB
	for <bridge@lists.linux.dev>; Fri, 11 Jul 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238525; cv=none; b=QscMIZq2pfHfB9fhkE0f+ucy6P5IcQtok/XO5uWw8myanKK72cm82qrdyfwaVol58wD42D2kXLCfwtjNhpX6MUPrAp52C23BFEJbv6XcRnFgyNKMhPFh1YAda2LUXamD9VHVW/q8Zh5yrwugy9EJHdI2i2HH/fGeE6TCLLFI2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238525; c=relaxed/simple;
	bh=AWYHOjXUBWsoijdTe5XjvSVN3q2c0/IUFuIvj0336tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz5pa1hTH9l1+NGJfPdBYRx64aKim0i0jz/vSzwNVZnO6stNdOVpwgsLwrbnhkt+ZC/4PZpuXX2NKcRrUdeFXcr89jCyekx/CYK2iD4qAoE9F/qr6sQTf74kCRAAw93Bwkcv9MkQEvIOrXJNb/8jeF30sQgLCY8EuX56ijxyv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKMlUpwl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKMlUpwl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so3352749a12.3
        for <bridge@lists.linux.dev>; Fri, 11 Jul 2025 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752238522; x=1752843322; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1kNo4Un3jL4ulQLE5GVMXMgYj71cxIyyrEQPeH9RHM=;
        b=fKMlUpwlmelaBRoqasTYsehBAtwLgXeYf8X/e0htSQT3PJCIMgS2Dw2YtupuFB/E8V
         F2JzJjxmyNTZUFdJ93QMyAN5Do8BDPCl0qxB5VO70gqfJjEob8qKs+RcOCbaZD+8Avks
         qWgubywPa818yfWxSuvh87vnvblt/GZzFqJ1sr0K0JoFCoxH9xNPPn33Lg7UHBtz15wA
         k4ejhE8j+psR2tKRDS05KZdzhy7ios2oA9z9YWmMRM9MOmvEGJr5BmcYTFDyKmIct+Fh
         CKh4HZ3TuMAWgJXC0EW6ft4mV87CKYiyVEKlkrGz40C+eYiGhPl5eDeHrUOxC72GRzua
         ad1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238522; x=1752843322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1kNo4Un3jL4ulQLE5GVMXMgYj71cxIyyrEQPeH9RHM=;
        b=GxD6zFeQglnXhU63V78KLLHAx4oS16b3MWtCoMEsW+S2uXWLuZLfRvFud3SpiWuwzc
         3jOsxMJUbBiWAi2OO3YLOsIyUVDAVgKZQJa98vUp3oN9eQM7J/MMw6eGffADJrPll/x1
         53AXgnd1cRDgldm+/hF3XNwYpExk4A8g2mlAscKiVNLMfGiQwKakAeXrhYI+Fc49DXzc
         cOY5CqLSpeTdsGb+QcQGVPuq2vC6cAlviWuas/0osdxwHexpfckTptLAWwcOu94sghri
         WYuFlO2VcJBN1G4P8yFFYdoq3zjwKRUglVQl8s5aHyAeCVkXD2jTtWtywInwmLANY3Gc
         1Rug==
X-Forwarded-Encrypted: i=1; AJvYcCXTCrNcNXD1VQKUJ8LMksSFz22UKQ7DJgrOb6jtjfwkZTNsshiD5VA9OJN7cZwwkFq//vgGAFE=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa5tND1ChOZlN8gc9b+E/fhUwrrDiFZr973ZBkwLpBNekdiBjW
	r44C3bc55W/jnxQfFFE4nMx/h+pfqJWBhjmAaW6QruNwGb7wxdb2jbjg
X-Gm-Gg: ASbGnct9rW8ytV0yRv3ry8F2n2+nBEPBqNyuZetjSbXod9J+PTE/Q+PoZB8mnYaLENH
	iq+Si8GxhkeUhqM383hJbe6a9ydZA1Nksjrd1q7nT1saOw/TO/iB8MXosPu6c1NCL9D4EgkygZf
	RG2uXjgxjS8Tm0su4Hu0u8kyfFfxuf7t0jvhEgd+CDASPbKWngOq//i6Qzpd2FyL/O/8b0jcBmQ
	jdFY4Mi1RlQA/TEtrRa2+JGRAZwkqg69+tTSX+8zJJ4eBhTWNa+gc8c/Tjt1fvIrwWl7pd7GIMr
	8OcT27TMZAwqAEhYZTZbpxdzOGu2CBZ/4pI9UGgSOxj5oJKgDUmaAoZ/rFGsOD4jMwOKjdljpw0
	2qLDj2Zb0Kfl53hRBbHRZNhEx3IfXgppAWwIFnnjLPwd91XjtZ0UP2ZTewWIDusxXFxKiid8gc0
	e9vHyABHks8yg4ofngsaN8sVUJDOiQNaGREYoJqFqj8cfrOtobagsVswr1W13TZVvSEyLAEhhsu
	dUPAN1I6fI=
X-Google-Smtp-Source: AGHT+IGFQaxrT7dzjizCciqU78HSGz6eRug0Ek+s0ytFx7ZsmssnCbtFFJ5dIA8PAbzHsdYn9MXgMw==
X-Received: by 2002:a17:907:3cc6:b0:ae3:a812:a780 with SMTP id a640c23a62f3a-ae6fc1c07a3mr310674266b.61.1752238521536;
        Fri, 11 Jul 2025 05:55:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82962acsm292076666b.139.2025.07.11.05.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:55:20 -0700 (PDT)
Message-ID: <6e12178f-e5f8-4202-948b-bdc421d5a361@gmail.com>
Date: Fri, 11 Jul 2025 14:55:19 +0200
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
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <aG2Vfqd779sIK1eL@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/9/25 12:02 AM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> +		if (!pskb_may_pull(skb, VLAN_HLEN))
>> +			break;
>> +		vhdr = (struct vlan_hdr *)(skb->data);
>> +		offset = VLAN_HLEN;
>> +		outer_proto = skb->protocol;
>> +		proto = vhdr->h_vlan_encapsulated_proto;
>> +		skb_set_network_header(skb, offset);
>> +		skb->protocol = proto;
> 
> Why is skb->protocol munged?  Also applies to the previous patch,
> I forgot to ask.

In the previous patch in nf_ct_bridge_pre(), indeed, no need to munge
skb->protocol. So I'll change that.

But in nft_do_chain_bridge() it is needed in the case of matching 'ip
saddr', 'ip daddr', 'ip6 saddr' or 'ip6 daddr'. I suspect all ip/ip6
matches are suffering.

So still matching is something like:

tcp dport 8080 counter name "check"

But no match when:

ip saddr 192.168.1.1 tcp dport 8080 counter name "check"

After munging skb->protocol, I do get the match.

I haven't found where yet, but It seems nft is checking skb->protocol,
before it tries to match the ip(6) saddr/daddr.


And to answer a question in the other patch: this issue is found by
using my script bridge_fastpath.sh. It first checks the connection,
conntrack and nft-chain are functional in all testcases. So, it tests
the functionality of the patches in this patch-set. I want to improve
the script on a few more issues and then send a non-rfc.

