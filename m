Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0632E1C4B
	for <bridge@lists.linux.dev>; Wed, 13 Aug 2025 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071355; cv=none; b=vDuju9EsGr5RbwG1gkfIqXV4xLb7pBje9TsrhbYMHg55zXLdslue6P0P1hFcMN214wqBkLDwA7TYgu5LqjubdekBtrVTkHBzgz+HxlBvWyhtteGSH0WMHr0Cw6CtmqfJbFK9QQrmHS3D+dktFrgbJvllpQ78wJr56InuBpAOOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071355; c=relaxed/simple;
	bh=21w+BvTt/gazVeuYwusahNoigrMUfHAFjc79A1kbxK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHBrmQ1HYrnYC4GzyudUguUXEIR9MP5UNx/nkPaTC5NosR7DKD9xaqQI9MPmevRsJFQ2UpifIWwZmBA7oMYFsq5Gu4EoBKPS+1aFmN6YRhlaJ52IEjldbnniTFV0suSNzklNcfenclTnUhH7IiNzT/x/gxC+nmhYa1KfFN0Woe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XOQ2xJVk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XOQ2xJVk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af925cbd73aso1147181666b.1
        for <bridge@lists.linux.dev>; Wed, 13 Aug 2025 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755071351; x=1755676151; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmFIylOVee1piWInjTQ1RjbJBz9Hanh5j6QyOwGDpxo=;
        b=XOQ2xJVkonuc+uBgfwdbvilPq/2JDZG3kkhpcJ6NDgnpjPMEy1Yun4QPLUMkDlWk9h
         YeMis5HbvJYGuam3anmYo0j+iU8u37DopzJ2K0h5BvHyE/Pu4yzBD5ROkWb+5WSmOqCa
         OLbNu40GciwvRWzs7HpTjIzbC+mGb9rZdH/DgihXo4TuY8r4zIdydO2sCt7qXtdv24ca
         9slv1qFoCeEcfAl3ogP/4R/RBgONGlbIgHW10Yqu5x+zx4hdzsphlejncz9W9nqpYrhp
         yvdqWVvNE9BV332+MAFQ1coaqH/ppx8G3SAXjLYJ8W3M0rkYMbWaFMsdJx/Du70xby3S
         PUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071351; x=1755676151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmFIylOVee1piWInjTQ1RjbJBz9Hanh5j6QyOwGDpxo=;
        b=mfeJ8XN1efXEnYzozcq2lpQ+Wd5rSFMgWF1UjWXpzx7NoLSTK07oF3s8Euug6MqJ1/
         vfo+Kub4iNLS6p+gcRrCdKs0nF8gMtDue1Kje0MnGQRCsDvrIpf5L1SnkqsqZ3wxLBkW
         zZuRAQTr9+BYZuwiNiDuMmqsQl9kI3HKe0KroL/B9fxIWFOCbAowWtBnh053b8Aw7gne
         E2eZ4XJBKBsFlsVPh35J7U+663ra4903UMh+gaxrPPxA4XWa4svseiZxAuoS8rtvSXTJ
         lXF5+MBIpYIlWm+TFtjBAktT7fEhjHSunTNHDFQPLthK6gG643iG/DBuS2C465v54AwG
         +TTw==
X-Gm-Message-State: AOJu0Yx/SNcB+YnekCUWZARkfJ3YvvXzzOA+XfkoyY7Vd8q1OkLYxyGz
	xFv9Lauls82ZJS/EPjX1Fn7OSNLmepY6lS3M+DyTj7fMYBuiKXuB3htT5euH+GxcbS0=
X-Gm-Gg: ASbGnctwaRaj5tv+GWs7jHnUodZVzoZlUX8FKokBHBMcSml919/5yxJyaJMHnVfevSQ
	sqic19ggTNXh53vFJmSvyjb1s29+b2lhTHyQ5xsue1XuyVHT3PbKLtT1k7BmSWksmOqhx4aTP8S
	OtyBex0IJX/icyXdbc3f1FL8xUqP/IdESvAhe7COck/UsAvZDsD4w9c0vWR6vTUEijZbLnVqd3X
	WpaCMkhs4jiA789+AF//FZTEYX+iQAaL7ZgRUuAyUS8TQCYTTqQYPdUpgnWodCxLIeXD8AqzFu/
	hiHSPwWhewM7AIEjn9u6exJF0RYZVZOVO7UE5+Xoq410FTE0o2FF8OOViEmeLmTiRwDi+ur0VNT
	2FMl0BrsaDZwEnJvc1dXXRCG243PU
X-Google-Smtp-Source: AGHT+IG7OQqQwH/e7BKLXt05IU5ZlDG7VA0XSSPKWCJkPKoysN9P3lttRT8vmaNa2qYFupqFnd6GGw==
X-Received: by 2002:a17:907:9408:b0:ae3:5e2a:493 with SMTP id a640c23a62f3a-afca4ea46c4mr196943466b.49.1755071351065;
        Wed, 13 Aug 2025 00:49:11 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fd00sm2334857566b.122.2025.08.13.00.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 00:49:10 -0700 (PDT)
Message-ID: <7641f60d-2d34-4e2c-a467-07cfaba970a9@blackwall.org>
Date: Wed, 13 Aug 2025 10:49:05 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250813021054.1643649-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250813021054.1643649-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 05:10, Wang Liang wrote:
> When set multicast_query_interval to a large value, the local variable
> 'time' in br_multicast_send_query() may overflow. If the time is smaller
> than jiffies, the timer will expire immediately, and then call mod_timer()
> again, which creates a loop and may trigger the following soft lockup
> issue.
> 
>    watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>    CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>    Call Trace:
>     <IRQ>
>     __netdev_alloc_skb+0x2e/0x3a0
>     br_ip6_multicast_alloc_query+0x212/0x1b70
>     __br_multicast_send_query+0x376/0xac0
>     br_multicast_send_query+0x299/0x510
>     br_multicast_query_expired.constprop.0+0x16d/0x1b0
>     call_timer_fn+0x3b/0x2a0
>     __run_timers+0x619/0x950
>     run_timer_softirq+0x11c/0x220
>     handle_softirqs+0x18e/0x560
>     __irq_exit_rcu+0x158/0x1a0
>     sysvec_apic_timer_interrupt+0x76/0x90
>     </IRQ>
> 
> This issue can be reproduced with:
>    ip link add br0 type bridge
>    echo 1 > /sys/class/net/br0/bridge/multicast_querier
>    echo 0xffffffffffffffff >
>    	/sys/class/net/br0/bridge/multicast_query_interval
>    ip link set dev br0 up
> 
> The multicast_startup_query_interval can also cause this issue. Similar to
> the commit 99b40610956a ("net: bridge: mcast: add and enforce query
> interval minimum"), add check for the query interval maximum to fix this
> issue.
> 
> Link: https://lore.kernel.org/netdev/20250806094941.1285944-1-wangliang74@huawei.com/
> Link: https://lore.kernel.org/netdev/20250812091818.542238-1-wangliang74@huawei.com/
> Fixes: d902eee43f19 ("bridge: Add multicast count/interval sysfs entries")
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   net/bridge/br_multicast.c | 16 ++++++++++++++++
>   net/bridge/br_private.h   |  2 ++
>   2 files changed, 18 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

