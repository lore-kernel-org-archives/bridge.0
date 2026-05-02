Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8A1EEA31
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701759; cv=none; b=YAeIKu8joMIGJPGTSEXD8g8p1G+VKL0xQAgZcKfl+kKEvF9MUaicS3h+f6uDcj6015Vu/5x2eUnxq/rqoT0h/WlRnf/k6RTEY19bDQW6fFk5dTu3+Ioqer/yQnk543Qit8d17rYGikqwVZAHH2ANjW2RJlGo5LPCEBHc0o92gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701759; c=relaxed/simple;
	bh=zuZtarl0HDSmqW/AZV+7RjZzgS4L7RDu6mlYvcegPuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJJ1K6tMK509SbqR/sWXGBj7L7tsdgRqm0CBrtXvAHYig/I2A5/Wsg9kRi1dQGx+zfcYcLgd1WPGAIlNqPCM47rjnjzMnB4C4lS0LvZcib4mJ9iPtjy7fMrz6N4chAX+iXUyUF1rNxlugHxyO7UjbnajwGZE2HqKpPSzlfAeAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bCcxOP2A; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bCcxOP2A"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso19688745e9.2
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701755; x=1778306555; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMTwyw43NAPsBdN0lEvEHduQcIRfAv5+dGrM1lniOAQ=;
        b=bCcxOP2AQM3VFrkmqat35uurz3m4Yt/CMxt1kOt8fFUS7cKunEsAmjhbfcs8NjPjT2
         7i/RV4wAQm2VRJGbDEzS8y2ls8hZwRCwoenP6pAUwHeFiGkEsDR3I06j/lq/Y6Yv7Nog
         4jD7pjMxFQhwBruTFMiOmavTF1O42+YtoAbQAGX3zs8YhfI8ZzF9WXYlAhYzJwpei6RN
         n72+xz9cMneGYTwwGx7iIDI0PyFo/qtQ/M8WmvglA7ZT7lhZk2uRLbY8zP1JwEKY7gGr
         1MOtg+4ZaARBAkBhpkP+fI2qiJNmzuK862vlwM+KcytZqS9fvLPq6l9xpYlGxYk8S6rs
         lNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701755; x=1778306555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMTwyw43NAPsBdN0lEvEHduQcIRfAv5+dGrM1lniOAQ=;
        b=kzbTU+7r3m02N1TmlMzAPA3iN/4Qa5SIgeJrnrekrAZIh0nxrK+LMR6wUK2InLIKXR
         EgDiVsejHNHFNCyxkGa45YSWATAQeMERM8P+wKvhftYIS1KKSt8Ut6El4kd0+LbQLqEA
         4tZleivDXLc7HwN5Y1+lhr/NMp5fDzRrnDRu2xxFPubnKo1P5UU+d6hb0PfuHdXEyecv
         wIJXq7bRAIUrNd3BZCwJdM+tdLNln80LCqt+NidBp5/Kaw0UzN5IMvKMCOULgvoTxbo7
         n25wRLWGmFPFLMV8t4nWr9SVlVbiF0jDfbWW/vfzgln8lhTpPGTo0kaqOPecBzF1TlbE
         XYjg==
X-Forwarded-Encrypted: i=1; AFNElJ9p7e1pOwP0dZYt88FHP6j5l8EUXIy53sQODDEhMtAvFRDWm8RqScQ0e91k1SWUlJ2zMNh3348=@lists.linux.dev
X-Gm-Message-State: AOJu0YzB8MiYK7Usdt4+F3f7mgv4aBDagAGaym9U8vPpZU+ON/VfOYgZ
	j57SsisTW5bxfqX2//lsB1TisbU25rftFQZLRVwDOo+rWcHfilUYnmDhrAbm+pose/o=
X-Gm-Gg: AeBDiesK0N9/BCtN2fN0J8zbXyAS2KdXFupQB3LkM5dkAukID1HqyukVpCnizbMUJTZ
	We1zvdu4HYv0xR4J0b+qQpaGqFVTDYxdzkR3C8Vb0w231lr30fEEYhRqJeAYg2cD0dR0NpkGg0E
	3WAgVsRuI733bDLvDPqPZor9iB8uaXhsCPmyX9BGAFhqslsrmKvGJkbgXGrs1hR6uiZwZLJM86B
	yuI4kJfI21xVQUgzhgNPv88jvY7ALoSZ+CFpn3AsrpFdEJqYKAa0uIuVguh+lqjAkrz94tGHjE0
	7+8FktbNQe7axhUforsYjUfiaxV96xMMeTnQxTn2ghMp6dfQqGd4siKhQ5m1Z1sG/zoK70HjV9s
	nS0G8Q0q6F+HQUrAsu3dYmF5YLuiZuSvz0j23cz+jR/AnnAZau/HnlBewoFM11icJ/916aX9I/e
	e4z6YTYcrvi4KcExY/BidEsOrBJ9nrjwKXqWwTJU6fmObxY+L6faUXSiAK83+hchH3
X-Received: by 2002:a05:600c:c058:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48a9866a998mr20975615e9.21.1777701754546;
        Fri, 01 May 2026 23:02:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aac01sm9113763f8f.31.2026.05.01.23.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:02:34 -0700 (PDT)
Message-ID: <dc11bf91-dace-4235-9055-223042067a23@blackwall.org>
Date: Sat, 2 May 2026 09:02:32 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC}
 and simplify calculation
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
 <20260501173130.3486-2-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-2-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2026 20:31, Ujjal Roy wrote:
> Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
> calculate the Max Resp Time from the Maximum Response Code.
> 
> Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
> the Querier's Query Interval from the QQIC field.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++----
>   net/bridge/br_multicast.c |  2 +-
>   net/ipv4/igmp.c           |  6 +--
>   3 files changed, 76 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

