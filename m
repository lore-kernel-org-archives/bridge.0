Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7E1D5CDD
	for <bridge@lists.linux.dev>; Thu, 15 May 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323389; cv=none; b=e0SxMxfHBhGmKXRwmq4KSAE+618XXrsLe9+O10ENLexqcM9EzzIFhBmM6ciFK0OXSISHs5ZETZ8Vt26s8WLNtpBRE2tzTMb3ekLJYoQ6QH7rAgGxhUqS4jF6u3XmKjolCIQhhk2DDph8BgT8zJX2NrUwAzdMyd6WRV2CG0/AI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323389; c=relaxed/simple;
	bh=czKg2FsFT1Uwx+ZZLxsBMzwmQcMN+jJQWzv7DBrPeRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgp0I6Au4BVL8aT5mCCVWK0w4y/cXNSmP9j/v0abjzpdaChWmpe4QmatFicz6zdI3p/V2vNge244CD2nllwpQ+ciWgkho99mz1xCY+rUVJijMbTiUdUkXLImXoikgtVgcjFyAB/k8ZyOhc60LvgXfl/8bn3OKalXq1A2wcMp+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vWREP00u; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vWREP00u"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad243b49ef1so211215266b.0
        for <bridge@lists.linux.dev>; Thu, 15 May 2025 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747323384; x=1747928184; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9hm5OJVbBIj5FyioW9V7d0NGSFqie3wmW9PRCafSTw=;
        b=vWREP00uByj2F0eChKodz2QeeCaRtzbTCxlwoBQozi89jt4apCdPaHUkhIdAMFS70E
         /PJ7CmPorA4k9xl32AoyJLuG2CFG8nwkAapd8S6AwkLhOy5VaNn+niNaVynttGIHBd8g
         STfZeex9Hsgxrk3AJs0Rwc2ldUXA+ifdH7VJLrF6wuJ3t0OdcPy+6alEoZ+wH+zIN8Zm
         KzxlQmsEDrHy+PbA7Td+bYQhFCo3j7UOsHtRz2YVhTfD3iqNRKZmm1CWtbULSaF9S9bY
         emuHeKBacDVLZyOtvxuChpt3JNqRDwcaLRsF86fPAYQWluT4mYDnFQxAUggUPokyRK91
         4u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747323384; x=1747928184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9hm5OJVbBIj5FyioW9V7d0NGSFqie3wmW9PRCafSTw=;
        b=C0NLC+fyRd2aoaNAuLZHuv6RolKvSL6b78d+tACePXxiDEfN6t6bx/XnUpJVEvgIfT
         hY/HE2KKQLly9CWZm0yrDs0frhAA+v3bvHj0buG5qsGu6QRnho4D+xhuuvZQ6P5EFpRp
         bUjQwqLfkB77CkU4MSlUnabCaNKeqPReDcgLiKYAW69q4+D4RGt6Piplf/xdrY99X2wG
         8l/aLoyzhMtq91V4PYZX1kBcesI9MptYl8akgZurRT7vuIAjx/+7NNp+mVAgmN18jaHP
         6uucBA9jLLDWswx/DCodvxRsxfXICCEozsgKQ7oltkTbbjDzLn+6+8MJ5QH6Xbv2wXn+
         1TIA==
X-Forwarded-Encrypted: i=1; AJvYcCW4FRbf71OdZ8o+K2pB5+RA6Z3WFGF75jjrUYqtRntG8ek6143o0rlMOYqAKRDeMIBJm4+xQfs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfSHFgMC/XlUCWaBwbD6ZLaRhQrcnKHe3i4JF1Q8IcmAP+B1yQ
	sYVyc0dp9rxiaOOpysuJ1/MC5RY8nzTiGtCrQVQhohfhoNdnK/u/tcr67XuY0Y2x6Fc=
X-Gm-Gg: ASbGnctd+ldPj3fwO0lrcmWNZjPdHVWI/+24aPTJQYubdeNvTxciW962ewH4qlItdbH
	xqhY4ZD2NEFInuQnSVf7V55z5UM9Z9V58GxBB7sGnNAmSkK8TbuK4FKku9GNQru8UJgDGefmcD1
	OF/nWMtigy7YhOiDpkbJ6FWvQYQnSQ3ZhNxgB5BPNfG+Q2C8FG3qJLXi2/NcC6q4ECXQQKUmIvq
	0nhsHoHB5JPHf1xLtRf8vySUem5fkXlK6XtD2VNv60ZQB1xy9sxJaJyP1Sd7zxT9i3pcZIrqVWg
	pzMb9AVeGHKrD/wpnPS6BsxskZryrLb4rkiJbsT4OjA5gF0WWyVxVoK8yf0=
X-Google-Smtp-Source: AGHT+IEPjbaCSAbzc2xrFZQp3EVHuzfnNM2s5oxAFnC2rwIBxm63qHEQgetTL+T7uEvlpJXarMIjwQ==
X-Received: by 2002:a17:906:f594:b0:ad2:2ba6:2012 with SMTP id a640c23a62f3a-ad52d45ac6bmr19710866b.11.1747323384165;
        Thu, 15 May 2025 08:36:24 -0700 (PDT)
Received: from [100.115.92.205] ([212.180.210.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d490794sm4518466b.131.2025.05.15.08.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 08:36:23 -0700 (PDT)
Message-ID: <7855995f-6908-4684-b5be-dbff8415843e@blackwall.org>
Date: Thu, 15 May 2025 17:36:22 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: netfilter: Fix forwarding of fragmented
 packets
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, venkat.x.venkatsubra@oracle.com, horms@kernel.org,
 pablo@netfilter.org, fw@strlen.de
References: <20250515084848.727706-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250515084848.727706-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 10:48, Ido Schimmel wrote:
> When netfilter defrag hooks are loaded (due to the presence of conntrack
> rules, for example), fragmented packets entering the bridge will be
> defragged by the bridge's pre-routing hook (br_nf_pre_routing() ->
> ipv4_conntrack_defrag()).
> 
> Later on, in the bridge's post-routing hook, the defragged packet will
> be fragmented again. If the size of the largest fragment is larger than
> what the kernel has determined as the destination MTU (using
> ip_skb_dst_mtu()), the defragged packet will be dropped.
> 
> Before commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
> ip_dst_mtu_maybe_forward"), ip_skb_dst_mtu() would return dst_mtu() as
> the destination MTU. Assuming the dst entry attached to the packet is
> the bridge's fake rtable one, this would simply be the bridge's MTU (see
> fake_mtu()).
> 
> However, after above mentioned commit, ip_skb_dst_mtu() ends up
> returning the route's MTU stored in the dst entry's metrics. Ideally, in
> case the dst entry is the bridge's fake rtable one, this should be the
> bridge's MTU as the bridge takes care of updating this metric when its
> MTU changes (see br_change_mtu()).
> 
> Unfortunately, the last operation is a no-op given the metrics attached
> to the fake rtable entry are marked as read-only. Therefore,
> ip_skb_dst_mtu() ends up returning 1500 (the initial MTU value) and
> defragged packets are dropped during fragmentation when dealing with
> large fragments and high MTU (e.g., 9k).
> 
> Fix by moving the fake rtable entry's metrics to be per-bridge (in a
> similar fashion to the fake rtable entry itself) and marking them as
> writable, thereby allowing MTU changes to be reflected.
> 
> Fixes: 62fa8a846d7d ("net: Implement read-only protection and COW'ing of metrics.")
> Fixes: 33eb9873a283 ("bridge: initialize fake_rtable metrics")
> Reported-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Closes: https://lore.kernel.org/netdev/PH0PR10MB4504888284FF4CBA648197D0ACB82@PH0PR10MB4504.namprd10.prod.outlook.com/
> Tested-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_nf_core.c | 7 ++-----
>   net/bridge/br_private.h | 1 +
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

