Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E343398A
	for <bridge@lists.linux.dev>; Sat, 19 Apr 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745044775; cv=none; b=uo2Z5ppcMzBNt3qjm7uRFA+sQ6OFzBz13JNSf1iJZaY9eLR3/FP+ic1EoN2QgyTXqYmSuqhigHEJ6f8gBGUq17JB4dCv4KGTLwn4geVvdzcdFlCG9y7n0Bhu1+eiGRpguLxeIg/S9ITctznVtkedgIKGCcE8qH3tdcvEw9ciZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745044775; c=relaxed/simple;
	bh=k2rR5KarQZasO0u4Q4TjiMQrjYBVmKSUaQZO38SN2K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0ydu6QZc1XYejT4vIWahSw1jIYzkTrdyJtltMi8IBFGcLWwjgiXYCrGxyM4r7HtPBIX8VWDGHFRDVoXmgVlziJ8BP3rllUIcHgKiZICXhWAb0ujTAmwt5pPAaCdUPGtH5DK34bfXUDw7yKfq+S49NsucqBdKeHYDCxNMDfxzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gtmQV4k+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gtmQV4k+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so448719666b.3
        for <bridge@lists.linux.dev>; Fri, 18 Apr 2025 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745044771; x=1745649571; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXGYD4tgpRd06ODhR+ALNi3ieSNvBMlzHey0SadsvCA=;
        b=gtmQV4k+7buBHwXQyshlUNa5fBnAhwTtbPxwqApkUF3U0f4E4na4LEXNYQ1qsawoOp
         WohikeCmNaYgXPoFzezn1em2B71F0Me/MnXqfgEXnVOpiuT/PbCmp7XiaLNRWcyEkUHM
         d4+v3qiAFuorkgdbOpRFLVGzJW0Uc09KMF1PAsGSjsAqeAmoDy8gPSuPCO6fzkCOv2W8
         wyu34Og5+oxDDGqjL3cUO7WKTjrXqcclt5bJN6NJUEkFChVwXuwf+3Kpb1SnJyiMYM3K
         Bbc/Bg4xnbT9+JMOtJRC5m6Ku/Ht6RZwlL+VFALUXNBCRfcW+mexkSIoJXCSpvUHgNto
         AZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745044771; x=1745649571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXGYD4tgpRd06ODhR+ALNi3ieSNvBMlzHey0SadsvCA=;
        b=JtXeTD8TSfiyfb5xbd/cSnp4OTAPdjIk/iLGJxZE/C8wFjJl2zcJsEA6hJmwxX2jWc
         YzBts+wAXeJl2yq4trQYMIDmpvIxZd09laCMcfCGuDuQH1OyDG+7GSsPTRTho4IE6mQu
         t+B/DwKMiHQCR27X6kgZgFeqIyqo5iL/U8EZMNHbhp/xclGaLItI5PG60cU2Run9tlXr
         DcAhUx210KkZCoeXuDcPxtz8ij8J+B8oEdFoN2K90Igb5QlmoMQfCqkIDiwAM94qchKo
         NmdAOYuiT1QHOi0EBKMUJCBiLjmQKQ5vzp6pz3zSPKIwXc53ZnQ5MT4lpbgOzErpm0eX
         MVFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6qyfjY/7MS2qVtvsBfk4yOxTJgNvKNtUAOEtkzaQHmEhoqfvN0oaLCPiKG8l4eO1Xfytv2nE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzA4pRd9xvT5BSqfZlLRWF+88CYfLsTEaCelxJdbUUxeJkMXfq/
	rLiWx3I+JjPAKnx34VzXS/dapzTVymEIruCGB4yuX7qvFavjC/MF+FH9sGAmI8g=
X-Gm-Gg: ASbGncvPZMP0FrxEBY/e4Ktd1qL03/fJ8eV0X6aIji76iqA2nK2dMqZRPv+niEssGr4
	CGjScX+aHlwBeQUZi7zSLotnmad+pSuoeFwDpF5jZf12Tb79dHqohzGKeGSyCRxbvoys+sOd7gG
	NU1LfV0tGPw8c2uMGeuBlz8Xl173PHtrN8uDsjP1kucQJISw9OG3WdtiWKg1sar6V/4adF8chbc
	aMYvnYMkCzZ3QlrmlmCDZlU2MQt6TRT+a1DiQEC8zr7uA29dkjjXV4PacChrY81BLre6OAYlBhm
	uIYvyDmAdYuqC/0pJ0z/Vsqyy05kCL+J/nXFCABBmlJpnBatI/I1m0gtuWUSCtrq0hx+DQa3
X-Google-Smtp-Source: AGHT+IHPazmJJv3uKjOz/01/dwMLL4OrLH6DEPsObLG2r1kva9q6UHsdC5yt7CaNvMPgwSPfedgp0w==
X-Received: by 2002:a17:907:6d15:b0:acb:107d:ef51 with SMTP id a640c23a62f3a-acb74ad7324mr427460466b.2.1745044771378;
        Fri, 18 Apr 2025 23:39:31 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec91353sm221305766b.78.2025.04.18.23.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:39:30 -0700 (PDT)
Message-ID: <9e714c8f-b890-4e89-88ae-d6d61772e0a3@blackwall.org>
Date: Sat, 19 Apr 2025 09:39:29 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bridge: mcast: update multicast contex
 when vlan state is changed
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 Yong Wang <yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1744896433.git.petrm@nvidia.com>
 <0b13864a33090fd1bd6bdee203256d775db0c35e.1744896433.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0b13864a33090fd1bd6bdee203256d775db0c35e.1744896433.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 16:43, Petr Machata wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> When the vlan STP state is changed, which could be manipulated by
> "bridge vlan" commands, similar to port STP state, this also impacts
> multicast behaviors such as igmp query. In the scenario of per-VLAN
> snooping, there's a need to update the corresponding multicast context
> to re-arm the port query timer when vlan state becomes "forwarding" etc.
> 
> Update br_vlan_set_state() function to enable vlan multicast context
> in such scenario.
> 
> Before the patch, the IGMP query does not happen in the last step of the
> following test sequence, i.e. no growth for tx counter:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # sleep 1
>  # bridge vlan set vid 1 dev swp1 state 4
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge vlan set vid 1 dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
> 
> After the patch, the IGMP query happens in the last step of the test:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # sleep 1
>  # bridge vlan set vid 1 dev swp1 state 4
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge vlan set vid 1 dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 3
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_mst.c       |  4 ++--
>  net/bridge/br_multicast.c | 26 ++++++++++++++++++++++++++
>  net/bridge/br_private.h   | 11 ++++++++++-
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

