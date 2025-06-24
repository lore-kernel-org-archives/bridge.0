Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4D2777F1
	for <bridge@lists.linux.dev>; Tue, 24 Jun 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759752; cv=none; b=qrhfZ4dT6fZ5kMmwc4g6yiWjGGaiveMCiBf0pEMUljGKLfOTKzudixUf2uyKpHcKQzjhKFnq6YkNl7YVaxKnaY53foOQ9en0vcIRxO+Lyu71qZDCwTaxhMddSoMpMiJEEic8LfNSlOckSH8wPpS3RtSQA6pI/xCEBt7msKFSR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759752; c=relaxed/simple;
	bh=PNPhwM4paJwVQbDov+E9J9ZuC0PmxKIu8t8tgfnv7ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJbitUVpVh5X1Ebet4YfV3dPXNLTgZ8mkk+Aw+1hbQdyy+QMnEuzdpCiACUtEr4yx1dNPHaIEvfSrbLGjLehE/IXh2ZChcLRhiifGbWMI8pjfbZi6jNbuGYDgX3+YccB9jwQqb3mmDfSLKoe0cnweaS8J6J9cGlmaWfvRl+eFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxE5q3w7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxE5q3w7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so7816173a12.2
        for <bridge@lists.linux.dev>; Tue, 24 Jun 2025 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750759749; x=1751364549; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR4ge6rguxSsc/ORqRy8r5vdeL5F2ATOq1gnAzeqSHI=;
        b=OxE5q3w7AgyARdmDk5vbIdjrTFR7lGHs4TO6Tug1HSfyXR0ASGzNdE6+WDtIA1fCso
         3Vbb7pCVDH0QBg5Uwx0YyxrCjoRmUaaP+fD80wmmKXeoD6bOR6a7kdgHNzuwKK2+clLT
         n3rsNzPbQ3VwM3Ywmj4zovsI4B/bELSJO7FbnCEHEe6ZxGxf+pcpsF2+iEZn+uxWw/Wy
         BbB4xjPNwFgrXd8xHakgN1/XbMA+brK6VuywpceLw1og8IlniTzQUE7Sy9kySDhwfixr
         U3xcQ5EctJZySapLLWRPOjDanVjjlMSi2tOW+iXpUhssJkx5rL3Iaixu/H0GsrmU3oJZ
         uoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750759749; x=1751364549;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR4ge6rguxSsc/ORqRy8r5vdeL5F2ATOq1gnAzeqSHI=;
        b=U4/hUmItVTpsQQxPVV77HM8O8qEZo/VHJJ2IsukCPfQmtHb1Z1ssIf1huzZ6tPEPD2
         y1HWhnWPi6pKNrZ6fZE6+ycCb3kSwMWvUrXZvBVFavpmE1coh2dV7iWXz+ij7COKc6w2
         +TSvp9aMZbmaA/usePXJAUSACKk3lNPTJyVBjkXTIyNHr6dSEkTfGrn4s217nsujMZ3Y
         QePhOzzOOApeOlQwnfhLuMOULRoCpHvHn7kzu7RbV7qiq4erPHh0ILFBOLLjUcBaKK9+
         kFf5nErJ5nrQgep3Iivu/Inew4iyuje+9k6QOtsgCm1+9WEdrbuGgvn+UZRsGofhg8NX
         9EJg==
X-Forwarded-Encrypted: i=1; AJvYcCVKWn9dO9PapuHVIpDBo4MfcwgUqN+rpSn14ckxsjktx+0Brit7OP9p6QP8oDN8LCNzaryLSsQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzaQGZscN5wfVAIaJVWREP5ONVkmSxCYMuJUQSoErVIIoziITzT
	EbrJ2LWodI29BeOoCVkAH3Y3o6OVpXOXeMzmvK7dPY8HIsRsUj9uPwECWgROjQ==
X-Gm-Gg: ASbGncuVY6/zD8s3Ff/ynmsGO//FqK69tC7DLcCEz6C/oGuI7T14w/KhnEG71/ZJBtI
	OPqDTtRHIUOv0NUBA1y7avcXqJF7rDJBFdOoLcZmg/PmulZpRCkLAK39BkUceSurExJCDvR+cEo
	LfgMsVEdpApBc6JSDAs50NkGqN4qNvNOgjsKQ0/1zB3ZraYiNnks5Idmweb+EXRY3UNeKXJTsPz
	8s1fTdE1GGjYba6LMrLc2PQl2+ENlLq1Y0/wkDSlYYrszxY5RRpA+D7/FyEtHReHv+/1uHozpo9
	W22MJEhKXOKrwwFZ1Uf1dNrMqnrr/VJAGN8MyFwuQs43HEFIkrdRY9jpc8K/lDCIFdAGfPXcNaX
	gU7SUc17pEldNJvZtHMDaCzgF4QYP8gwvK/3V7GaZ9I7ApZSAPtYKivpTmOOymZlbugk0Wodppr
	NBdMdHH+NQRojewZpblq+ZcbeMs0FYTrW9IvR5S+/qolx8Do4=
X-Google-Smtp-Source: AGHT+IHKFAxaROdqfcGg3d6rDQqJLaE/SJ+Wkg9OhXhAmcXdrKyaPKmVMih7cR0ERStNXIIWPfDKeA==
X-Received: by 2002:a05:6402:2550:b0:607:3344:6ef1 with SMTP id 4fb4d7f45d1cf-60a1cf2e082mr12192488a12.29.1750759748906;
        Tue, 24 Jun 2025 03:09:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4857e0sm791758a12.65.2025.06.24.03.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:09:08 -0700 (PDT)
Message-ID: <4434d7fc-429f-40b4-8b98-6cd52a985fc3@gmail.com>
Date: Tue, 24 Jun 2025 12:09:07 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 2/2] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250617065835.23428-1-ericwouds@gmail.com>
 <20250617065835.23428-3-ericwouds@gmail.com> <aFhqUosjt2ptnlOZ@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aFhqUosjt2ptnlOZ@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/25 10:40 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> -	return nft_do_chain(&pkt, priv);
>> +	ret = nft_do_chain(&pkt, priv);
>> +
>> +	if (offset) {
>> +		__skb_push(skb, offset);
>> +		skb_reset_network_header(skb);
>> +		skb->protocol = outer_proto;
>> +	}
> 
> I don't think its a good idea to do this.
> 
> nft_do_chain() can mangle packet in arbitrary ways,
> including making a duplicate, sending icmp/tcp resets in response
> to packet. forwarding the packet to another interface, dropping
> the packet, etc.
> 
> Wouldn't it be enough to set the skb network header if its not
> set yet, without pull (and a need to push later)?

If I replace the pull + skb_reset_network_header with
skb_set_network_header and remove the push, this also works.
I'll change it in the next version of this patch.

However, if I do the same in nf_ct_bridge_pre() (the other patch in this
patch-set), then packets get dropped. I'll need to look into that furter.

