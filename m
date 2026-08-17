Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B3448388
	for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980317; cv=none; b=FPhzQVZV9AIweKYyKQYgMWfSQUcNN7E3jrPg8pHdwGwnAQOeXvcokftdhgB8gCIHPfyMu9klafViji+g6BIM8RXkFq3SoaFBsenno7hafhqYUejvaahQAAHKEAbJt298+miDfej7zSy6/jzizhiHps7q5RJsH9nAB4sTYCMwjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980317; c=relaxed/simple;
	bh=Hj/x1Qel+xVYtqxVygQXyYvIQBZxWWsmvNpRCmhYuB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH1YldZrwOEdx57bLCRTbmE2SYUB5Sc2svXdAzXCGjIKr4wd2U4to+qN3867dtOK3XtyoaygODu2NQrDSq/PF2dYsYSoMGaZh2jhcfElXDIpUUNZdpapY6aoaRhVovfStOnxkzXZ/XsKoKn5UfM85fuIxSYNje0lGAksnI+zA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KbrmPXcZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KbrmPXcZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f6609c657so1705830f8f.2
        for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786980314; x=1787585114; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S98fjURZckKHw3kQIeH1ci3sUDlJW1dlj7BkFC6FteM=;
        b=KbrmPXcZyYXFR3H+gdrPspu7wdXoiJBwX/arS+V0KTZhnb8gqRCERTAIXVdu7VAVNl
         fTbOBakF+o0bFYiJ10GhXJyX46uAySKGnYTp9JcdkXZSXe8crW1kT4IviWUFa2hYDK0U
         qCUmx0F2sg5udCJO1YyyH2FMp3b54S97Xe6y93xrpw7s8bNcLX/26lKz1i/glh3a/emb
         XpQVSscEFJkv0IFDmQmkl9X4Eh97BbsGF2j8Q/eE8YkDAeUexaL66NBrGQq0G/hRLXnr
         ZZWQJvPhXk9iZ9cqedonb+NviOpNVh7zcVYtqOSyTCMqaZufmaCqF/d53wcDL/auAsAT
         Sd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786980314; x=1787585114;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S98fjURZckKHw3kQIeH1ci3sUDlJW1dlj7BkFC6FteM=;
        b=mqrdr5skCiEKGNknpg/fO7wArqvZAQ2184+qlC4nx07HSPp2qi0v3IjMBHy8CwROmz
         OUZ1V6o76iZZdHicF35OQVeaF5Ni002zqQEoerTh3HHwUnML6yujWom8nIoCtoEFS+3V
         Eckl9rd/p0lArbBmTACXMMqRIaEiVlsYMErJ2oIMM+mqIEogVaC6Wx2ujTMT9ANs+hXw
         vfmXdPENJZIUUS4b1tM7RMSINEPjVkgCsUmduTJqTpzYtlqztPI3hJPT4qL/4OyQlvUL
         XltyUvlhQO1iqKeiX7l445pl+eBlikpkNyCW69Vi2SuD7+/r76ArkwmbWMjYXo9ASXgV
         YNkA==
X-Forwarded-Encrypted: i=1; AHgh+RoBnOjHuuLImUVe2brEOTpEOwuW6hECcFs82vECuaW1BghNqII/poeouRFQsnjAfpr2pKmgo4M=@lists.linux.dev
X-Gm-Message-State: AOJu0YxzudbpwIfcRbd3DIKoo98JHaJvNJL0qJmXtkwx+oX5/bO+kZqr
	L6PVeF+D7Mc6ikzjt+bIwFxAjgoJBVxxvM9rQlTVbupegcq1JTHB9wAyy7IuvlvDb/Y=
X-Gm-Gg: AR+sD11//rUpihpJIQ0Hgutc6qD1o6D4sbCIMC2nNRr98cGYdVjBVLcloUv3gvKbXL9
	swFKkuC7evwHHkH9nor98hh2jCKh7adyI/wgKbZWBvarD7if3eBPpNGtsJB3L92y69XWnkmx8lj
	JDrvkkFyhYtTZylOpOglUbBT/Sr7j4cc8WwqzyIn9nevr6JeXYy7f24hylALAyLESiKAtUCybT5
	iKk0XWaxYa0j8pgLPjxMNDK3XdcaQyW/qb59BIRPutPVXFQKS9tV0XXIr/msgt/Oer9CEFs0mu5
	27zHAH8BOuV91kneobuWHZ4zKKVY9ucpmEqCttju5Va7BEMj9dZLLGQkHgj3GQemtSou3RWYzh/
	+O8og01o9S+lWPmGadvVNNX0w+oGZ6I7nEjBNJt6sLUIjJF7S4fDQaRIcnyfHOtsL/qAn0YOudi
	CzrxgLJiU1lwyUbqIVPj1YaXB4vMK5yEf+OU5Fonb7I2HgfC6+wY5F/EWE6qZRLvFpejydDk4iN
	QQFSCQuA9lyNnbfS28=
X-Received: by 2002:a5d:51d0:0:b0:47f:f4b9:88b7 with SMTP id ffacd0b85a97d-48160723e00mr34560526f8f.1.1786980313693;
        Mon, 17 Aug 2026 08:25:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm5306739f8f.32.2026.08.17.08.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:25:13 -0700 (PDT)
Message-ID: <0543351c-2c7f-48db-891b-4d8a60776b3d@blackwall.org>
Date: Mon, 17 Aug 2026 18:25:12 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] bridge/vxlan: fix reading neigh ha without
 synchronization
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, andrew+netdev@lunn.ch
References: <20260817143613.685769-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260817143613.685769-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 17:36, Nikolay Aleksandrov wrote:
> Hi,
> Neigh ha address must be read using the seqlock to get a stable snapshot.
> Both the bridge and vxlan read it directly and can see partial updates.
> I reproduced both issues with running neigh updates and exercising these
> paths in parallel and saw partial addresses, e.g. updating between
> neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
> 02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
> in the bridge, then checked vxlan and its arp/neigh_reduce functions have
> the same bug, route_shortcircuit is doing the right thing already.
> 
> Cheers,
>   Nik
> 
> Nikolay Aleksandrov (2):
>    net: bridge: arp/nd proxy: fix reading neigh ha
>    vxlan: fix reading neigh ha
> 
>   drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
>   net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
>   2 files changed, 27 insertions(+), 17 deletions(-)
> 

(-CC bouncing emails)

Hmm perhaps it's better to use ETH_ALEN instead of MAX_ADDR_LEN to explicitly
show the expected len everywhere, it cannot be different anyway.
I'll do it for v2 after 24h.

Cheers,
  Nik



