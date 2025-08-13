Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB7BA42
	for <bridge@lists.linux.dev>; Wed, 13 Aug 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047396; cv=none; b=a8/Wfgy8mO4GIfype1yi5u9aME2DnV3V8H6P+jl2v9wYLtvVw4tSFGJuc9AW+S26fO1goB2qaA/qgaZs60hfwkraTZ4Py1xXnOxsGUYfHSjN9vlEsZa8SAx71G1h6tG6iIWy4JsdBvnblJf98XLuamyOz06s4hNGycq+e7VVt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047396; c=relaxed/simple;
	bh=Dp2TFP6knBwgB8NLhqQXcsYqaD8uvln3PQSjEoxzmkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XFp5yR6mjDBf8u+pwITneerCljpc2WvLTPke1uf7f9r3z9hh4AGnhfqVTEc1a1PS68+cJNcQCvxzXH/SzNtB+dCzSdLnkVbaabi9nG6MGNawH7BT2AMQbzX3dFwJZnZ7CgYAiQJ5K5so04BPeqo3BddflA13lmU2jreKzWMqyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1qvP6d1gz13N3g;
	Wed, 13 Aug 2025 09:06:25 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id AA91814027A;
	Wed, 13 Aug 2025 09:09:49 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 09:09:48 +0800
Message-ID: <3a6a930b-8d5d-4323-a71d-d7b0883a7527@huawei.com>
Date: Wed, 13 Aug 2025 09:09:46 +0800
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Ido Schimmel <idosch@nvidia.com>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20250812091818.542238-1-wangliang74@huawei.com>
 <aJra548HB7zGcA6K@shredder>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aJra548HB7zGcA6K@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/8/12 14:10, Ido Schimmel 写道:
> On Tue, Aug 12, 2025 at 05:18:18PM +0800, Wang Liang wrote:
>> When set multicast_query_interval to a large value, the local variable
>> 'time' in br_multicast_send_query() may overflow. If the time is smaller
>> than jiffies, the timer will expire immediately, and then call mod_timer()
>> again, which creates a loop and may trigger the following soft lockup
>> issue.
>>
>>    watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>>    CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>>    Call Trace:
>>     <IRQ>
>>     __netdev_alloc_skb+0x2e/0x3a0
>>     br_ip6_multicast_alloc_query+0x212/0x1b70
>>     __br_multicast_send_query+0x376/0xac0
>>     br_multicast_send_query+0x299/0x510
>>     br_multicast_query_expired.constprop.0+0x16d/0x1b0
>>     call_timer_fn+0x3b/0x2a0
>>     __run_timers+0x619/0x950
>>     run_timer_softirq+0x11c/0x220
>>     handle_softirqs+0x18e/0x560
>>     __irq_exit_rcu+0x158/0x1a0
>>     sysvec_apic_timer_interrupt+0x76/0x90
>>     </IRQ>
>>
>> This issue can be reproduced with:
>>    ip link add br0 type bridge
>>    echo 1 > /sys/class/net/br0/bridge/multicast_querier
>>    echo 0xffffffffffffffff >
>>    	/sys/class/net/br0/bridge/multicast_query_interval
>>    ip link set dev br0 up
>>
>> The multicast_startup_query_interval can also cause this issue. Similar to
>> the commit 99b40610956a("net: bridge: mcast: add and enforce query interval
>                           ^ missing space
>
>> minimum"), add check for the query interval maximum to fix this issue.
>>
>> Link: https://lore.kernel.org/netdev/20250806094941.1285944-1-wangliang74@huawei.com/
>> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
> Probably doesn't matter in practice given how old both commits are, but
> I think you should blame d902eee43f19 ("bridge: Add multicast
> count/interval sysfs entries") instead. The commit message also uses the
> sysfs path and not the netlink one.


Thanks for your suggestions!

The bug fix tag is really important. I will correct it and send a new 
patch later.

>> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> Code looks fine to me.
