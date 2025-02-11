Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3624E4C3
	for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291744; cv=none; b=jlpGi39lMgsx7CuyCJ777W7wZLuRPH1LEH2hsZH2+AR25tG+q2+dfv+NrYWHqK+GxbFDoqkoiGuYHbNGCFEviD950xo3rdQXwTzg2lM35L1ZFSrDVsYRwuJEkDPngxngNHlmNjQIcg6jaJm1UY1QATZhxaQt7H8a+IZQfKUnx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291744; c=relaxed/simple;
	bh=b0ktKhICDViwNI9nds4vgA/sl9rP+Pr4YC+CAbIiiOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgCcgc38rwqq88N1QcqbmWNKRwntOLVgD8IqEbAbaeJXAm7rrXs8N1m7QXTbDUSdh1AXh40FJLkioEImpMEHLOq5EOIDhFrKNcbw1zqQVAiCEGJrk+vLI5kQSfk7mfNCK+WtwVmv/Lkc1SpXVj+Q61rjoOH1PYCty3L7AtchEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqZejfus; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqZejfus"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7c501bbecso364083566b.2
        for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739291741; x=1739896541; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIIV8i2tvb8tBK+tEU2BRevQmqyOqUAI4Z6TbcBV6q0=;
        b=CqZejfusTWvjRKCxFha6ZYaN7pDdeIQl4Z1aGYEWQwaD8kOTsoe7fact0ej/DKN5va
         x39ZIkB6f9NG5/MZ963sfmKJt1w3BpLngBZxapMN+1lXF7Xp4gF0PHqKMxmZRzhbjTGD
         IjItro/pAS8p6GzKYOgX85+z6HwhN9vBdczv9XlZf6Ii06n8LsOCFTX+0z9fLdNhnGNm
         vsNoxu+3V1IH4dyvuyAMpXXEBMk14d3JDajV1NS3NaQ3qpEmX4fik1kg4HVewGlrLtCb
         EOGvx+uSWD0JwbX34VAFtfmtAjbLR2GujwvxvmuOZmtnlNcO8hIU+ssS7IUnXVTUDgnC
         B2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291741; x=1739896541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIIV8i2tvb8tBK+tEU2BRevQmqyOqUAI4Z6TbcBV6q0=;
        b=iBfWSHY6ZELEj0om7W4dPghMQwoqcM93pyrcpos0TNXwHF+q5LXOW1Ck4oMd+CjGow
         nO7BxohywzVjqXRxG28Ua6plyzH8GBpLfZEQmrvAnZKFq5xhexx2vpwtudI+kwymQ8A4
         cZ2hI9cZJSmsMwrZ+QZhJggBKmL+KI26GE3hcg5r8ekwQfX7WywbvV1pLX5eLLek8e8+
         v/y6LgKPKX/8i5Grbn0kAH9ICBKeQTcrJ2QiS9Hnibsdh/Pi6WCGoWTfJsSQYxLWQfqP
         RHKVUw3zIPo72L/5ypa3qTiBysX/y/Abd5zIucNDZsVbEtFG33C/2geK2Io161AFFXxT
         b+8g==
X-Forwarded-Encrypted: i=1; AJvYcCVTAAC2SmMJWhGlHHqga6nUikVqypNScgQYKBKPHAif/U88ZYQocHJFvJC6qIHds7rxaXyoGs0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwKiirK72rq+adxZw4Z9KBQPFP2q6FiPkHu4e/hanR4+2bqK64h
	w6J2AiVMn7yAx3KDaiSTjZDEnEefB05P0QolBNphyEzH5/VBtVtn
X-Gm-Gg: ASbGncs2Qa0y9r5jlIkYIPKrl/AR8qNEjxUBQfUz/Ic3MyAQYhZkOtAaemzXk3pech2
	vW+J3XKdOL0lYv9g3ppKPdsRtJr/GNroUsqcFboORlFd8DUtCWhMoGYeyR9sePi4679r5QWVGKY
	7UhSOy7fTGj3tFUVMm3L6LtgyncNnPa4UoJW/3w+CYNq+vugCNF44bVd599hxwgK9FYr6hD8HRd
	8RfRO4tVjZaFTa4QE1GvGfT+L58+HQWJQRnZ2i+Jk0vvBwi/TFQH2Q1lTwupQ26BlsgyR+PIvXm
	cK6zqUYejK0fA9G3uucAFUA3vdRh+AdwCtr6gi2QH+zj7bbVqJ5dT6/cunmFCBiShUS4OIN0xkc
	6dhCstrPjp6sg6J19Bx5fFj33QjjaUE/HSBbYo6UJnTiLcSgWxCDHmeKD6K5uvH/NmQ==
X-Google-Smtp-Source: AGHT+IEaE5wrrlIY6nl8fC2Lf84LvPSm2KRFTGEbR5fKUB08K5dstyn+LuQpM8Wzz6vHlCpVh97tIA==
X-Received: by 2002:a17:907:72c5:b0:ab7:c284:7245 with SMTP id a640c23a62f3a-ab7c284dcb7mr766174866b.18.1739291740484;
        Tue, 11 Feb 2025 08:35:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bf9ae406sm445655466b.82.2025.02.11.08.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 08:35:40 -0800 (PST)
Message-ID: <1aa60578-ba4c-458b-b020-cff59b119bdc@gmail.com>
Date: Tue, 11 Feb 2025 17:35:38 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] bridge: Add filling forward path from
 port to port
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250209111034.241571-1-ericwouds@gmail.com>
 <20250209111034.241571-6-ericwouds@gmail.com>
 <20250211132832.aiy6ocvqppoqkd65@skbuf>
 <91d709aa-2414-4fb4-b3e1-94e0e330d33c@blackwall.org>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <91d709aa-2414-4fb4-b3e1-94e0e330d33c@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 5:00 PM, Nikolay Aleksandrov wrote:
> On 2/11/25 15:28, Vladimir Oltean wrote:
>> On Sun, Feb 09, 2025 at 12:10:25PM +0100, Eric Woudstra wrote:
>>> @@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
>>>  	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
>>>  		return;
>>>  
>>> -	vg = br_vlan_group(br);
>>> +	if (p)
>>> +		vg = nbp_vlan_group(p);
>>> +	else
>>> +		vg = br_vlan_group(br);
>>>  
>>>  	if (idx >= 0 &&
>>>  	    ctx->vlan[idx].proto == br->vlan_proto) {
>>
>> I think the original usage of br_vlan_group() here was incorrect, and so
>> is the new usage of nbp_vlan_group(). They should be br_vlan_group_rcu()
>> and nbp_vlan_group_rcu().
>>
> 
> Oops, right. Nice catch!
> 

Hi Nikolay,

I gather that I can include your Acked-by also in the corrected patch.

