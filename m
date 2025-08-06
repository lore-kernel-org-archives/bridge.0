Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC33CA5E
	for <bridge@lists.linux.dev>; Wed,  6 Aug 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474921; cv=none; b=X8uTNV7AJct921ondpv3KgadrqhT7gCpCEAS6aEE1SGgcLkRdd8AXc35z6rprk1mBy9LobqGNqnGZP77IsLDohZxiAffe57IlFqCI134xCSt4LCQpfmkQDB7P8wKZJZBhCktF5+XnG7xJSZItt7w0ROCaU92cD4IGgan8aWD4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474921; c=relaxed/simple;
	bh=U2JrnGb9Xf2jRF2IOWpWZy0sZRe4JnvPHaey0BJseeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7qgdaomF9D0xRWc0mw53w4BsGw05B6q96OAVnC9yDT6uLRPdGkaMzy1r7AP0BeBxaltHb3f76zFqQI7DbiOjw/OTfQT3o2gWwgw2M547h7N+Z8TK7dCPIJZBIYxHwjvIMzbH/j5IkqY3bryeGB05nOJuK/GJX1fn9jflt2YDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0GDHjcNU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0GDHjcNU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11773671a12.2
        for <bridge@lists.linux.dev>; Wed, 06 Aug 2025 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754474918; x=1755079718; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PY6/G7pBaRSasiyeewCuatLBOeurRAH6HZiC5wn0WeE=;
        b=0GDHjcNUAVt4haEHrQ6ZOHwOVvhAY9tGrMT1OYjZ0hGb5bCmraWIY6yG3b6rLf4IFS
         2kOjAS7jq/LE+5XNLsf0P7BNuotGThte09WCq2pzsYnjOfdyvw76W7EZmbLM7NnEaUmv
         qgMWWjA1CiL82Yi6BnPlfqTIsU4Mh98IQX1ETfgtRUV9Su6ygvy9zf7Q3FcDezqxYol8
         Heiob2IJlWNoZuWI5448Blg9jqZ0ym7jZ66mJmlrY74fE3tXDWPPFELY+Yc7ez7HwSQt
         pasAm/ybZhmqFMtIbD+PjSfXHtYXs+1LzoICRqOg9s2XZ6vJoY0eeRYf6kNgncr+aRq2
         1RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474918; x=1755079718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PY6/G7pBaRSasiyeewCuatLBOeurRAH6HZiC5wn0WeE=;
        b=aG3pkXy0hFBcCi3a3bQbm3u3idkWWd4W1Sg4lcD3vAu+cHhmxd177pqOZqpRKiyLe8
         IghmAu85TijH5q04HSH3j9bRKvuUiMmbbV7A0wWU1nyLUm+NQ/EF7/PMi2v/bEV8sIYP
         0CkPcpdPq6UElCcrC4k1pQkXhdaoh3P5qCaM4lkeUTDLxGLV+H/ttoLnbEc5xeiPPPcV
         x/UlRAjB4H+Zg4Hj1IsJd6niJ7uQeVhx08dTaafEEuqP0l+3HZkfaBs8jEzUT+MAmdhI
         UCz0yLpkzSKYQMdSLplminVbzSvOovMkHWfNjwRN7nzESBUuUJNJTNQjxAy0nczSm/fQ
         hoiw==
X-Gm-Message-State: AOJu0YycYbyX2B+eQt5xlmrGSzXvvHNrCB7B1Dd/Yqr7sLe1sxRTe8e8
	Red4xHufW91wd+uvtk331DAnd8B9MF0YGA/q2RIkKa4HfC+eVx9rtRqRY/xhK8fCjss=
X-Gm-Gg: ASbGncu7wMHgdvhNL/ztK7KLfmw1o//C4JlnIYBXk+lhEeb9HVzK5qttZOV8CxAb8Zk
	YM5GDcyJ6jpd9UeYfWbhj81+k786jTykSmH0WEz2qt/pfB7MqSvLSoMUK4kIPF4oBVj46d8SBqV
	4yKWRGAayoFTywJiyJwradr2CyUnwuUsLxHpBenWbHK8PBri5utEjm5ZqqkT8veAs1Hba+jMmir
	2e4EmamUWIsoXHga9Og3Is/FUvPIbkS6fJSzsstPEMOWnY/bZJ1o7JdyVMzku+o6EInxCzSXicn
	TQ+zmQUhG4wAJRA+9oDgD8KGK8uZKp8Wnf7fo+Rfgnxx38iXS3v68cE0wtwOjlTvFYAmYRYGeSm
	d391wYvmcNpuv75ZwAJLFD5hplZcTCpSLm5c4ilSTvhhedWcWqspruQ==
X-Google-Smtp-Source: AGHT+IElrfPbH/2D55e2rlcv5FQ2+nV/avO3uQbNHxygYaj/il5iaACu/FDGxguffGR+FDFOFBDWOQ==
X-Received: by 2002:a05:6402:1d4a:b0:615:dc48:1e9 with SMTP id 4fb4d7f45d1cf-6179da2be8cmr919460a12.15.1754474917669;
        Wed, 06 Aug 2025 03:08:37 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f16062sm9845241a12.18.2025.08.06.03.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:08:37 -0700 (PDT)
Message-ID: <9071898b-ad70-45f1-a671-89448ea168df@blackwall.org>
Date: Wed, 6 Aug 2025 13:08:35 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250806094941.1285944-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250806094941.1285944-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 12:49, Wang Liang wrote:
> When set multicast_query_interval to a large value, the local variable
> 'time' in br_multicast_send_query() may overflow. If the time is smaller
> than jiffies, the timer will expire immediately, and then call mod_timer()
> again, which creates a loop and may trigger the following soft lockup
> issue:
> 
>   watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>   CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>   Call Trace:
>    <IRQ>
>    __netdev_alloc_skb+0x2e/0x3a0
>    br_ip6_multicast_alloc_query+0x212/0x1b70
>    __br_multicast_send_query+0x376/0xac0
>    br_multicast_send_query+0x299/0x510
>    br_multicast_query_expired.constprop.0+0x16d/0x1b0
>    call_timer_fn+0x3b/0x2a0
>    __run_timers+0x619/0x950
>    run_timer_softirq+0x11c/0x220
>    handle_softirqs+0x18e/0x560
>    __irq_exit_rcu+0x158/0x1a0
>    sysvec_apic_timer_interrupt+0x76/0x90
>    </IRQ>
> 
> This issue can be reproduced with:
>   ip link add br0 type bridge
>   echo 1 > /sys/class/net/br0/bridge/multicast_querier
>   echo 0xffffffffffffffff >
>   	/sys/class/net/br0/bridge/multicast_query_interval
>   ip link set dev br0 up
> 
> Fix this by comparing expire time with jiffies, to avoid the timer loop.
> 
> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/bridge/br_multicast.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1377f31b719c..631ae3b4c45d 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1892,7 +1892,8 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
>  	time += own_query->startup_sent < brmctx->multicast_startup_query_count ?
>  		brmctx->multicast_startup_query_interval :
>  		brmctx->multicast_query_interval;
> -	mod_timer(&own_query->timer, time);
> +	if (time_is_after_jiffies(time))
> +		mod_timer(&own_query->timer, time);
>  }
>  
>  static void

This is the wrong way to fix it, it is a configuration issue, so we could either
cap the value at something that noone uses, e.g. 24 hours, or we could make sure time
is at least 1s (that is BR_MULTICAST_QUERY_INTVL_MIN).

The simple fix would be to do a min(time, BR_MULTICAST_QUERY_INTVL_MIN), but I'd go
for something similar to:
 commit 99b40610956a
 Author: Nikolay Aleksandrov <razor@blackwall.org>
 Date:   Mon Dec 27 19:21:15 2021 +0200

     net: bridge: mcast: add and enforce query interval minimum

for the maximum to avoid the overflow altogether. By the way multicast_startup_query_interval 
would also cause the same issue, so you'd have to cap it.

Cheers,
 Nik

