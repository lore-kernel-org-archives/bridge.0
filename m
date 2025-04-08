Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F623E339
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137227; cv=none; b=ltFBM/uO1OKlwhAMp6NZlYp3T7y05EY6XY0EnOdBdcYeKX2O5XagBaViMvRs7CYnw88VtDxxgR+8MUhfw0tkW2di0zOZmW1KY5yQvwxB59HvG9f+nmgMbV+OTDl5zOykt8BYOgoTbUlwHE2x/aSLIuVgYd8VOM4gaSR27PuyRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137227; c=relaxed/simple;
	bh=OkpfI8JKKBHKEkXG8a9cTHLMUwDLO39b4MBr8fj0v9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WidfGhfWT1ONiB+syvNQDIqmFIiuIXpcJF/f2TiiSc1ocROtC0sFO5eAj1elRcB+zmVA+lCP31wgVt81Oz1aLxD5q4unkOVXDhlfbyy7nXo5NTiW8+bDw4/v8ZrM2SS9vWVqmQS20vd6NkwjnLw73pHhckqCkwM/+mY1rv3S9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETe5v8bU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETe5v8bU"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so952253066b.1
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137224; x=1744742024; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbR+SDBjSlCanP57hiVBvuMAbFJp90QL/uZWZc8SqiQ=;
        b=ETe5v8bUbV1uc98O6DIZYTGLpv4pdUSdInrUjcOC+bIdyqAn3wSie3Xq43a8pNMOHH
         vfiPULKC+Q8U+a46/HV/0pLpQXumpXrXCzB5htWpl4pt9z9jdhkMCdUEzM6CmbCLvNms
         BYDZOfydjFaYEDToY52wX7w51TDNGF2qaYdxBdeAoNfTdElvU+0/MobWAOgEbg0Ono6p
         l4CLX9DUm1bWXqZUqoWSs/7eImBHW1OsEWGi1y+9RALbb65UqItBrDdomOzFGXn2Il5W
         WHBX0F1CKQCbEBauaC8Uc8SRoP6/y677W6L4ZNcZZlfGVHApJIlh6g49Xb1TlRwMaNaI
         mjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137224; x=1744742024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbR+SDBjSlCanP57hiVBvuMAbFJp90QL/uZWZc8SqiQ=;
        b=SWkMXI2xn2w3LLVyA/Pj8rMk4KfY3VC25dwVrLCVFxo7WV7htDQA6DVAyiNVW0yGAy
         fJuIRF9v2dusm17oLW4+19j79AJJqlA3ZcJui5oH6qfZolVBzpGEZqNjhqC0hrR9DQ2k
         whgCdbbq3QYSPz+/DjfHAeOoyOVGadw5gHoLLLG5E7wgUWGaRESgGQtGTKDKKEGQhypu
         XISKeDI2hveupQXLKm0NbmLiIcuhOHf+bBO9UKyinNJ/4LA8UBoQ+6kqlwFXYzPeHqyB
         W3Co4qBLYmc+Jtf2tdsHv7ITBuAeu9z0MqvaXstjUZyHYHLa9vD5ABj9sogLv3sgCJXX
         JmVA==
X-Forwarded-Encrypted: i=1; AJvYcCWAwP0JxWwVk1zB2K19XR0gIEdYtBOQB0azyBjgR8d4tdP1Vo9XVUq/uXyBCGOgM5b3hOTYXjs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8BGnIdeQLtQJnLFKQekf+QtuUGg7qbYujanNanupAitSM8ipI
	kDwi52MzNNvaFhFaKBkVetolcV4sZZcS4aFY4wHNlTJh91cQdPnO
X-Gm-Gg: ASbGncsy9rlnOQqTO82E7UsoZQUuouLO8x773Z2gd5JSJptG4pRgKUxj+jh+wn/+WBO
	PyfndQQyVYTq0topBFGaQQYwxjOBDluM8OIVAXWswV3a1FLPBy+XNC/xp1tWU1CbBVYaXhVzqjR
	n5XPnpURiOE5NanlJNc9LTg+/An0ncRyQU1Ur3UNwlMS9sFefrE7ioditAI4ZTpikpV6MbBvf+A
	ZYCJWy1fcMIE4VaTUJlms+dNrLmlVvhg3gFJOJFWBia3y6t+2oiT7JL+Dn4rxQcf3gU/UN169cQ
	9szJkYMCIzhuYl/7amJF7K4yP1sS7G9Lh68K6IpdotgSdJhOd1C2y8li02r4pa1OWa+sHjKEXWJ
	aY+I6gh8omygUaG8vxF9+pgRFPHRitaB2oPvFWJ6hZHSGu03GxiyZbfTtDdj7Bh64jSXC/wOW3/
	OJTWpyunYDCR/cOWKmMa8=
X-Google-Smtp-Source: AGHT+IHAAt6vPbKGMz1eXRWFE/FZ9F4uiX2LpnIYwTZUS8jCgcDQIcbdzzrkb6ANj1v8EAbdA8C1Tw==
X-Received: by 2002:a17:907:d93:b0:abf:4c82:22b1 with SMTP id a640c23a62f3a-aca9b695a43mr20164966b.32.1744137223553;
        Tue, 08 Apr 2025 11:33:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013fda7sm954327466b.117.2025.04.08.11.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 11:33:43 -0700 (PDT)
Message-ID: <fc34e774-e264-492c-9ecb-20eaf7bd87e8@gmail.com>
Date: Tue, 8 Apr 2025 20:33:42 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 nf-next 1/2] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250408142619.95619-1-ericwouds@gmail.com>
 <20250408142619.95619-2-ericwouds@gmail.com>
 <20250408163931.GA11581@breakpoint.cc>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20250408163931.GA11581@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 6:39 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
>> packets that are passing a bridge.
> 
> Conntrack is l2 agnostic, so this either requires distinct
> ip addresses in the vlans/pppoe tunneled traffic or users
> need to configure connection tracking zones manually to
> ensure there are no collisions or traffic merges (i.e.,
> packet x from PPPoE won't be merged with frag from a vlan).
> 
> Actually reading  nf_ct_br_defrag4/6 it seems existing
> code already has this bug :/
> 
> I currently don't see a fix for this problem.
> Can't add L2 addresses to conntrack since those aren't
> unique accross vlans/tunnels and they can change anyway
> even mid-stream, we can't add ifindexes into the mix
> as we'd miss all reply traffic, can't use the vlan tag
> since it can be vlan-in-vlan etc.
> 
> So likely, we have to live with this.
> 
> Maybe refuse to track (i.e. ACCEPT) vlan/8021ad qinq, etc.
> traffic if the skb has no template with a zone attached to it?
> 
> This would at least push 'address collisions' into the
> 'incorrect ruleset configuration' domain.

Thanks for the input. I will look in to it and see if I can also add it
to the test script.

The thing is, single vlan (802.1Q) can be conntracked without setting up
a zone. I've only added Q-in-Q, AD and PPPoE-in-Q. Since single Q (L2)
can be conntracked, I thought the same will apply to other L2 tags.

So would single Q also need this restriction added in your opinion?

