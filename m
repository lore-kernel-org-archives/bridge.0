Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2A7080E
	for <bridge@lists.linux.dev>; Sat, 19 Apr 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745044712; cv=none; b=YRHpUgEyFMKWY5VTRDKaN7dOZD2e5CVAf+FOnDico7njJ7y5wJ4/o8aEcOGbm58tV5+whilLTJ2YLKHFT41Hi0SsvemvGOo4Nns/y5nnZVYn6OVQ2fFNESs2WorOZKbQTelTG2vii7PWcoMb11M4NNyyWjhxsM0McG6AglLROZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745044712; c=relaxed/simple;
	bh=2bJApVbCqaYV1WOjfVu30MkD4jgODlLDUie7auLxSK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8wmzeliza9TYANDGa5aQjHGNgKSbC2E0jARbWfYgw9LAHWyjkGrjdf62K5/V5tqjvRLJe9/qVpQslMu3yy/wrIBb3ZZqgZFVckgG2cPs73w4aocxhf6QziVQ/8NUxL+7I0YNnRkdwvgFMfNPXci+AyOjXDonkFxvBWsbEhO+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=G0bm+9yt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="G0bm+9yt"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so4127443a12.2
        for <bridge@lists.linux.dev>; Fri, 18 Apr 2025 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745044709; x=1745649509; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQE1L+fCmAWDWTOVRBTsNUWoOyibF5s2FYSP946tumI=;
        b=G0bm+9ytZxoRTHpLoDODWyTdX+bkiqwselcSiKIDmWZjPl/VZivlvqigSLcfTkuXca
         za9CMSIIgxiSNXcc3PqLMn3A11wF1gnjiNpLcIldOiGF0n0E18MtKoxvbUaObMXAZtU9
         Qy2uHmFI8W0wM7rOLIvqAhA7F3kBaY9OmbYR63dcPqvjrtsWHlL9ZISJJ/If6j09SF8w
         RgFl/qHWWunW9FZ3bVJbGcNPQr0EcJkq2luObfypfEfRtGY7TddU08fwMz6UtVL2nrXz
         eKvCIJ6BDOjbQtEyZlk+5PFWnEVP6gHBtJiL5NbMdP0Pv39H2rK0kbCpnmsgAqOPpvaM
         UF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745044709; x=1745649509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQE1L+fCmAWDWTOVRBTsNUWoOyibF5s2FYSP946tumI=;
        b=sV8CyjNLuD0G8sZDT0/PKjlz4emUdbDSqnX+S//nIB1dQwIl+M+rTrA0PoBCwVDtzK
         CenYWOe1s/qxJ0SVz7ZHi3IzgubxTzNzc+t4xzLXP/fRUsfbuZw08RymX+CQCgtD8R89
         GrwQhquFp0rPl0QbeS+l2LXx5jCFZcoT3BoVktzd0ET3ffu9RsxU9gwPgSnVIHjUxjjz
         qVY/bQBCg5FUetxFXdN76W+K+l8BF/U5qkOeca6akHq+OC0lL52S8wNTug7UFu0TmQRD
         vvPao8XhqiyGFHmpOfCXSbliQi/L8wjGtkH0f/jrJ8o4zgzEcIu+QGgkhBPvRG73kLcL
         Ll3g==
X-Forwarded-Encrypted: i=1; AJvYcCVq37UT33Yw6Qrg0eRa0CfpILyZ+Njf1QhJxj759ngKF54cpHsZGVlqcjys7+nQrdukcVILSjc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGAVcDYJZGORNXpUBJSr+1SJeUR9KdkiBTZUx+zVuyqkxaYhhd
	0ibVVpZCGpBC0RtVB2zi9i7C+oqT+9M3vlhgln2VKcgjGtIzxAskjwTUZKDRRzY=
X-Gm-Gg: ASbGncsP6chfL2FZNn3ylBc1bYaO77YxXVyCFBXX5wiF8SOEavsLj3gYDWIzd9HVs9P
	VkWbx3y5wchDRpfgYu9nj8q0cYia2dOJ/x2XwCffJcKgzaX7Ixp/bBmPngQdZ4cdILkrF2M7eBb
	gEcRqkG6xH5gYO7ohaNaez462vHVcMfYU2HASohd/B/h5q3T6ZGNQLIV55zTVzoZb6aHhVXNGf5
	MYLPL+Gm36P0vD21NUUUtoFnWHqIY/pxDy4Zkn4hpr6/Rx8oR2rWwMz78bHDrEcAE/QgMQXsr5r
	MzcouUQ8xkUkx0ErWueA2rkernaKY42SPFCT/sDKmiFwNUrxbMNErMtVbqHqZfky+7rZDJLk
X-Google-Smtp-Source: AGHT+IHgTwNG+uupMJ5d55AJht1W7aNdWYqhfAfoFDuNA3b330lWIRmNkFOCjZP/rpXWYCpscpJW1w==
X-Received: by 2002:a05:6402:27cd:b0:5e6:1353:1319 with SMTP id 4fb4d7f45d1cf-5f6285296e4mr4213314a12.12.1745044708404;
        Fri, 18 Apr 2025 23:38:28 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62554bd3asm1844254a12.16.2025.04.18.23.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:38:27 -0700 (PDT)
Message-ID: <8af190ea-5b12-4393-95ac-2bc5cf682c65@blackwall.org>
Date: Sat, 19 Apr 2025 09:38:26 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bridge: mcast: re-implement
 br_multicast_{enable, disable}_port functions
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 Yong Wang <yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1744896433.git.petrm@nvidia.com>
 <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 16:43, Petr Machata wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> When a bridge port STP state is changed from BLOCKING/DISABLED to
> FORWARDING, the port's igmp query timer will NOT re-arm itself if the
> bridge has been configured as per-VLAN multicast snooping.
> 
> Solve this by choosing the correct multicast context(s) to enable/disable
> port multicast based on whether per-VLAN multicast snooping is enabled or
> not, i.e. using per-{port, VLAN} context in case of per-VLAN multicast
> snooping by re-implementing br_multicast_enable_port() and
> br_multicast_disable_port() functions.
> 
> Before the patch, the IGMP query does not happen in the last step of the
> following test sequence, i.e. no growth for tx counter:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # bridge link set dev swp1 state 0
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge link set dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
> 
> After the patch, the IGMP query happens in the last step of the test:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # bridge link set dev swp1 state 0
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge link set dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 3
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 77 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 8 deletions(-)
> 

I feel like I've seen a similar patch before. Are you sure this is not v2? :)
Anyway looks good to me. Thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

