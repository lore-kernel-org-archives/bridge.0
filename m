Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674EE21ADA4
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701892; cv=none; b=SkHHpv5KrAM642dwtNIFSM0sOteCx2VfgG/8TVh7jTbe+1SzfIszb63nnnMjim0uSC5F7aHeSQG552Fh3q1m0zX9Ci7BKiiJtH+P2clowOdOGjeiXqRFzsacun14fjUhbAHrT3eYkNbTSDwt6b355OY9b5HorJYy+gqesvCZ3+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701892; c=relaxed/simple;
	bh=5VSyqBvoid9uFXOUdR772I1+U0H44cOPYNrNocs56ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InUQpwSZZWk+c1BENKcBTenyPLw1AvN/9CyYRVUdKKS9aL6AkLWQVI3oFYYh+JehtwTFhn6Ypc7KlrF9DFpzY6H/vZ+XB1IcLPo3gCEO3kZstQSvk/R9T7VZxguP7PwPzpKW/1/q1Uhd8dfFScsPahwgnWVicoNJBCuk25Tfeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DJswennV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DJswennV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso31550395e9.1
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701890; x=1778306690; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePyFY9tU1bqBeZ/CDvqIuK5nLfvL0Jsqz80NzKwHDyY=;
        b=DJswennV0ocPqH8Nkark1NAV0KCDwRZraQMsiFvS9LwJk2I+LG6swN7fNHXj6VRbqr
         Ptkey4XUDDTpJ4YowX8+eU+RujxH30hk5HENACdxm0S4pORuhagg4tHkxHd0iMEzKl8u
         4mZAzcel7axYL4qCmoYJ3wVi6vuxT8ugiBWSUIRp/m8oLrXYSDf8UAGh0ESnClvjqPtr
         U/b8ib7+LFsNEp1+s09MdsmS1u52PwM7zEC8hVTYMLW7nHtsLdRY3NNnOSJnxWK+9+iN
         1kDTGqSGCSjBmBA8K+AGPoyR1d3iPweSKdOgVbDTbI5t0c6gGcBzqr+g40n84OjJsxgL
         3gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701890; x=1778306690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePyFY9tU1bqBeZ/CDvqIuK5nLfvL0Jsqz80NzKwHDyY=;
        b=a07rqrLojZCchxnx3r0s9wACSkCFjanKN1NN3o/kIAp+Q2adofPHIahypZy/JS8a66
         TsCHh1vBjt9xo6ouStR6OmgBbqs6sMObQVYCwCSgdP0PG9siGtvg/LA42DlkD9J6hvQT
         oXtcyoMX14RjTQFhvmbksA0pv9ZhlrpI3weHdV/AFGX+0R33d1rtSK6iTeJ4047ZzTqK
         KaD4qzsjC1di4F0GW0ltSTeVe0cAstjzgPBOnZqgq22hMTes9wFKGqR5MN9jx5D3Jdn1
         A7AbcHBFIivvB5l7ulx2XsyHuBHzzz/OL5Zt096KGgjSpAY3ZI7J5MPSauNCNqoreUBn
         eMpw==
X-Forwarded-Encrypted: i=1; AFNElJ8NmEJYDvnB3uWZzRouloMaGt4l6r13sCfoUyMPXXJmv5SkyMIKQRIw8sVAr5OXQjwiYTSk9FM=@lists.linux.dev
X-Gm-Message-State: AOJu0YymvP2m/yah9KLLaLVaf2soYI2FE0/R8mNT2z9i18CKGZhPVUEk
	RDoYWuZvNeZnX8fzSxmj8D5Cgg1PCqkZ0rAYOWwO9Pbr92gUoWMlfV5TWNTHBB9Dzr0=
X-Gm-Gg: AeBDieuDRP2olJSnJfc5pnjISqRj0xwp4XhAQcb0F2kfs+TdaJh2be3UYPMjJNYssAh
	u5w8lhUsTHDu/3EgDKHgyO91qRcns7Jy8dffSxkUe+ZBXOK7k6D/096F+1XuaNp1XiIVywdGMdr
	sXKij2PLIsM1bTj7ZKVGDchldb7po2fohZsrPgh+3jj46wcwSYd+Ani7RjiPckzoo4Jea0aQdK8
	7ypLS+/j0/sR2oGNzf4XcQpx1KxMRfgz+9zHmUtMob1iwcJGGmSkXw83dswsk9kJ1ppUIfD7AGq
	0Fbqd+WZKSKm2jkXHqvStlM3JCUEJIA+4j2yj6J9yoDkneMjZsAIRnCU/VPjjm6/839491bbqvR
	t9dk4HMmzOa+N8hhPF0KGWNQe2990dS/PInoCpDkNiHTCFyzSkqBD1vQ5CJ6VBnvNR3dlAKmfet
	69QdSQzFzMLp7CdSsV6itrCY1U8HtfACvVt1jNVjVy7AHZOT/WEIFbpPVM9aqC0QfnlNlB5rl+Q
	Js=
X-Received: by 2002:a05:600c:4450:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48a98639086mr24427625e9.9.1777701889840;
        Fri, 01 May 2026 23:04:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm185348695e9.1.2026.05.01.23.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:04:49 -0700 (PDT)
Message-ID: <b4d8277a-2a5b-49d4-a132-0f875e580fae@blackwall.org>
Date: Sat, 2 May 2026 09:04:48 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] ipv4: igmp: encode multicast exponential
 fields
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-4-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-4-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2026 20:31, Ujjal Roy wrote:
> In IGMP, MRC and QQIC fields are not correctly encoded
> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any value that exceeds the linear
> threshold is incorrectly parsed as an exponential value,
> leading to an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures MRC and QQIC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for MRT/QQI).
> 
> RFC3376: for both MRC and QQIC, values >= 128 represent
> the same floating-point encoding as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c | 14 +++----
>   2 files changed, 93 insertions(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

