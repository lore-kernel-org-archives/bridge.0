Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC5194C9D
	for <bridge@lists.linux.dev>; Thu, 19 Sep 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742009; cv=none; b=fAfbvlYbIbSgG41tFuOErE8cfrtlMRLEjlMfEQr9wlIiN60sqKuMWHEHEOonVJZPVHeLuRq0Tg7JMcT2rdKkOS7tV+nxve6T9jaiQwqoSI83v8J+8TkuzQG2oM71cWcjGSmK+FlOKRMfeHEvPlKVN1yZUv1wAqRl9QvPlO+vo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742009; c=relaxed/simple;
	bh=V1YPdfqmajIEnriwvuftpiMyY/DSrs4cUIhXE5P3RNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyIgOz9aj40OxBySt//b/YdbkfNj6r5UYcHGqAhjo9dj3GWMr+ko4bSueZuj3E9gn3gTKh89GodoBCw5hvXJ0FGJQYCuTTV7X9z/wkUVEIG0x/FApBdsyHGzQEEmH+WieJpgqS7vgh0lYVY9FLyE1+CPR+JmXnbkO098BxE2Mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3OHAg2wT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3OHAg2wT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so81568566b.2
        for <bridge@lists.linux.dev>; Thu, 19 Sep 2024 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726742005; x=1727346805; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ElPw2rkqJxy3GrSWwEzcQxJQL1TZQOW7P03usn2dqU=;
        b=3OHAg2wT0+5FsmeoyZIDmk5TE4QRuhZaHdyB6Xto9hjv9uHxgg2tHYYNEpzWxgTh4Z
         qngxJv4TpVj9DY/fRRNyn7gRoicYI1Z2Tkk383Df0y80a79zV4DGVSM4/w/qgIMgswa/
         5vDvdmBxTG6DNEfc1UwvLiHuf87+wXLlbmtRtATeWADO4vfzMZCEHzCaJSRavG+sQ+IZ
         pLU/hvrhAN4mpPAHAJ6GNwmFaI6am6ACo7MzXwnuMgPJ7Yj499siaabdyOo4CalNcwio
         gAowqIQrZ9uV63HWT9X9AxRcG+OHLGzyytgAjgz6EGvqd5pvh1zh/aDENtsAoS6Mxu6P
         xR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726742005; x=1727346805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ElPw2rkqJxy3GrSWwEzcQxJQL1TZQOW7P03usn2dqU=;
        b=Mnyqwyi+R3ymdvUVP75vYN56IQYAZ+6OFFELflv3zmTSjU5OF6fRqH+KSrU8OSRxoc
         2PqgCwVVQlhNVd4mYsCgFbhJp87R9NQTC4spVCOsGnADaQxYkxBZv+8hrBFD3MghHmgQ
         Qg528wW3Ka6uzl/Xr9TMN4HdXZY3RncajLt/iLwNg4e5ycCvrvXkTDnQzwj3hc4IFR4z
         KHzzKkotItaT8zpYfBYV74PgjvwULY1nnTIVuzoR8KF+DbzPA7lYmle30LlW421JxkxH
         2+g1z3WkHekzotguAAd+gdgbhYK1vPsIu9XBQkw4iAMXrEn+hntadfnKL5U7Je9CakGu
         loRw==
X-Forwarded-Encrypted: i=1; AJvYcCVbrX6K8blf0k1CdujU/eYcspNyxmBW3n6q2zCAbP43nMX96rDrh37iQEUyroiqii5WairQUp8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp+RGvEC6fMy6ssfnVrtlDWw2s2HjmsvgewcGS6TCzgHWJvvg6
	UzYC6sBSwHHghZ8SlbejJuu5gqLtusDCyYUnINnSs4581+gjfYSImxrmuVSitM0=
X-Google-Smtp-Source: AGHT+IH5FaHwIy/HpPwgYVmO7IWOIFZ4wz7dkZfK70jhdOMRpGV6GaHoSjwhSDN9QfGUWFQLWu83lA==
X-Received: by 2002:a17:907:efde:b0:a8a:8d81:97a8 with SMTP id a640c23a62f3a-a902941ff90mr2191026166b.1.1726742004941;
        Thu, 19 Sep 2024 03:33:24 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5696sm710812966b.172.2024.09.19.03.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 03:33:24 -0700 (PDT)
Message-ID: <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
Date: Thu, 19 Sep 2024 13:33:22 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: 20240911125820.471469-1-tmartitz-oss@avm.de,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 Thomas Martitz <tmartitz-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240919085803.105430-1-tmartitz-oss@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 11:58, Thomas Martitz wrote:
> Currently, there is only a warning if a packet enters the bridge
> that has the bridge's or one port's MAC address as source.
> 
> Clearly this indicates a network loop (or even spoofing) so we
> generally do not want to process the packet. Therefore, move the check
> already done for 802.1x scenarios up and do it unconditionally.
> 
> For example, a common scenario we see in the field:
> In a accidental network loop scenario, if an IGMP join
> loops back to us, it would cause mdb entries to stay indefinitely
> even if there's no actual join from the outside. Therefore
> this change can effectively prevent multicast storms, at least
> for simple loops.
> 
> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
> ---
>   net/bridge/br_fdb.c   |  4 +---
>   net/bridge/br_input.c | 17 ++++++++++-------
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 

Absolutely not, I'm sorry but we're not all going to take a performance hit
of an additional lookup because you want to filter src address. You can filter
it in many ways that won't affect others and don't require kernel changes
(ebpf, netfilter etc). To a lesser extent there is also the issue where we might
break some (admittedly weird) setup.

Cheers,
  Nik

