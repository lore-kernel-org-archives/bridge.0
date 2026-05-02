Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F22DCF4C
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701945; cv=none; b=HUnWokgI9X7mOaxYRG5ORCuViFPOSWdmky/JAdyGNRmmyPnbjojgvilfjYFBhjF2tZ+l9b6ZcsJ+31C/08u4z6IhrG1Ho/NS+oznruFTdSRKNRUSK0es9EsHOVMQT71R8m7OApQTgh6k6ujCCUYSQN9SazvBbEN1+Ua518XtGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701945; c=relaxed/simple;
	bh=X/hZCb0jhWMLtO0yzfJTyu1aVwl+6kQirfxui/Burbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUZykWGdUHGAlUGJecmlR6kqud14HHfG1diWw0ORtJ2VaG77Y/xmEaOHuXfDQCB7KKE9AHtBLj+irB2K3gWct77mIHW8Ur8YLKA4oNcIJszJbBZFZMXRyM4lTeI4AhODTiph6kJID5viEmFMBjP/TG0iSmg1c6/WEeFAp7gmhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CdwejVey; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="CdwejVey"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so25809475e9.0
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701942; x=1778306742; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hb311y/HjKGqfYjiqwo0iWKOc8y7rqDPGTnOkcrspE8=;
        b=CdwejVey1a4e8fN9cdsn7J90RlbUF6D/0UYC5vCUlAd0Xbi7Dy96GEYRSOroJA5Nqq
         zfSq7p3bkgvS34e/97AQyBardJG8dHcGmY/mUn8YoYU3a8rPwhxuNmp10q7krvOnfWxN
         js/fRq2tkT/B095Rc6OZXc4pZxs6BIK3cvSRdLLThY/neo3utJ5MEg1r53FVLWRLcJP5
         JqPyQIH4W0+hqTfWTvt9q6jp+a/HMHVPX4rwtneNp5Q2PtiqEgkvwdUbkxrWWciMhI7l
         8dQOnTJbpvBV0iPgBuXUYYDvCw3WN4s3qYgMa8q0zMGqj0xUJXuw3+WTc3jRq1KGgCne
         0fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701942; x=1778306742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb311y/HjKGqfYjiqwo0iWKOc8y7rqDPGTnOkcrspE8=;
        b=TrdsTlNn47peGBV/kRqaTwTbbbIcpB6xPWk2OEsf7JtdruVO3T5Mrg2YAyKuYdNsuS
         TlUvlchL4mOp0Q6OqZwAhRQPhiPEIbgxL2pSOr5NjF4xMCvK15JOjqWeyEQm1blbtWdG
         ZonJZZ9N5xkIyncNQpZrL8NN3QTrZAptiRRh69NvDOydFJuOHn+i6Xj7n+WlWmMZN04L
         UwWuVC2XzwfFEtuSJ8mzRJsx7kagml7MjlSPhXTM3bTkrrcrjxICetxGxzvrfA0EHfsX
         l648gsQcFCPdplkHTriu3CiRavCu5SI00qbivg0Lww7O5KEuRwuJICwIKjhy+W4wO+Yc
         N0mg==
X-Forwarded-Encrypted: i=1; AFNElJ9qBNW17ccCWiOdSVPW13aQ4yYiqdYRaG09TY0Akm2qAGtCaeEO/aDXAyPIkGOrsM7t4WjbfpU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy20Y7s8GOdWSMs7PNBKsTHddFeaXt/OOC+uFTGMAMYa7I16dn+
	uupaNtevVfQkb7JbV/3pruQcN3RetUfqHrqS6YQaDi0xuY3z/CXCRwXYBB3ZsqYJMak=
X-Gm-Gg: AeBDiespHzhqyOTzDmcmgS5VOfnP0GuegAx+h3ioGUMvUsuHaHiw7sOxVvXSrJYPZeG
	nnwoG+EtB1hiihEjLfkrLB1QE3jbRLeatUSpa7A1w1n+vQMUK0Vwl1NOmLZ7Rr6hgmVW1K5a1wM
	euj4weaJPwUES2+5ty5Qnxn+X5twIIjS0EkryjZ7VknSNlwPxyLfCNfphD35eWT0w8YBqHRC+PP
	plfNX1OI0AwfsaluT46A9yeMTahkHfTFUbYQPMruG8JZ2aLQF3d9V6CsZuVQfP8gppMMEtWi/vj
	XTtgXCLZv8bIVs923gv53eqdVHRnNlJLYXrmos2HqAn9pjB59IpYlmyYBZ3NuAr7ZSo8nrYSYhS
	PyGPCqlJvZgUha6fk0EYKk0r8gMy9V0thon9fdPULF+LYddXAteApHjpBj8McPr33gb9aZTX9jI
	lSw8ksCY0s6UE1xS+ZgBdH94kpjTJwWnOV/N2sYrdglcdvxA/nKjDOhHpc2Y+cOLtZ
X-Received: by 2002:a05:600c:4f13:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48a970fda7bmr29905755e9.12.1777701942442;
        Fri, 01 May 2026 23:05:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c3422sm157004635e9.8.2026.05.01.23.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:05:41 -0700 (PDT)
Message-ID: <60fd2cc4-1c04-4db6-97cd-bc3bb9710a04@blackwall.org>
Date: Sat, 2 May 2026 09:05:40 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] ipv6: mld: encode multicast exponential
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
 <20260501173130.3486-5-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-5-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2026 20:31, Ujjal Roy wrote:
> In MLD, MRC and QQIC fields are not correctly encoded when
> generating query packets. Since the receiver of the query
> interprets these fields using the MLDv2 floating-point
> decoding logic, any value that exceeds the linear threshold
> is incorrectly parsed as an exponential value, leading to
> an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures MRC (16-bit) and QQIC (8-bit) fields are
> properly encoded when transmitting query packets with
> intervals that exceed their respective linear thresholds
> (32768 for MRD; 128 for QQI).
> 
> RFC3810: If Maximum Response Code >= 32768, the Maximum
> Response Code field represents a floating-point value as
> follows:
>       0 1 2 3 4 5 6 7 8 9 A B C D E F
>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>      |1| exp |          mant         |
>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> 
> RFC3810: If QQIC >= 128, the QQIC field represents a
> floating-point value as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/net/mld.h         | 119 ++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c |   4 +-
>   2 files changed, 121 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

