Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F531618C
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426907; cv=none; b=nzT3bubG1742bRIrBV1lUG3GzKEgKCnQEz1xFsolkdq49MxGK2qsYnal/WC5u7wkkEIIR+oIOdVcO209QhjhQTe96P2tED2XjY8Nb0kjlwOf3SWFUR2S5p7v4dZKRaBqSwrdoh1HnivReLTwDtksRaUyEc221Sj4YmLsWJTJzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426907; c=relaxed/simple;
	bh=RqpgGZVtfB2J+h75TJKDrZC9zVQSgT4b2v2Xy0Jprh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IASHF30S+JWj/9+YWKa6cBJbYdUyl1bttDpqlWsyej9gXFyWT8ZbHn+lZ2JskX3Ye75fVZhk7ZoW8uKrUTfUt3BB2xwktmkxSeQ3OIahujRlNTc2q0KN4cNkKNTQezEzSLBtN5ub5SdU8GvDN5cu/Nx1mcbf+JkFMtobNj84U+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=k5xGcWhI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="k5xGcWhI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495437bb891so6011795e9.1
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788426904; x=1789031704; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wU9Z4QgDQQ63Lq/IIsJ44QGDy5mL0TGHF3RUnidQY+Q=;
        b=k5xGcWhIYeCgrQ7OZkooDW9dhk2zNCSmc5Adv2HTBZKKwnZP82PRKcJ4WrUQrfBk09
         cp4TO7GUhi7RSmpfwzW6tjVF4AmZI7/0HrgcW5mH1aNUZ/ziqdgeFiCJmyBU6WFvy5gU
         W27ac/Qe/t6QC3zeIN88vXxwBZKBqv+19dRfebS2pegWVJG7gLC3YayKtAWjB+NaCwpe
         ZZBia4YDQGYcWiwSPsEHeaAMkU0D2UAaPJi/hgUDCWDC6M60itnqHPeAFkk9onvHLMY5
         0yXq/c7qQQDYASz4QHTyOfoiMMcDzngMkYgITlk6xhsmQ6nlwM1EJEzsxWHCRryeGROy
         5/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426904; x=1789031704;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wU9Z4QgDQQ63Lq/IIsJ44QGDy5mL0TGHF3RUnidQY+Q=;
        b=lxwRKkvP4BeD8l9reqDZFOomg/nnk5776HT+Z9pR0g18bMdK6cybuBXb02RB7l2jk0
         apgLyE8Eh1r7MExY75p9fXncxB9mVOzlHU0cMU5ioIQYeqY0P6x6pKX7pbpDb+zlxLzI
         bdYPT6YKaMu5TW9hdzgbJAnFFR+Y+fORFCxNJYrgc3y0WURqC2+N28eUidfBIuvaSWlZ
         M4GbowMqh0HtFLXOHENkI47gJKd6uIoOfBQ6wCaKDlyLxT01dTHY38Be35WP7E47fs/P
         TpVtYVr5q3VuQvQHSEWCRVdcQsmGLwZg1wbLlEjKniWO6JKJRmshdQK/qyalr5TFLPKS
         5tXw==
X-Forwarded-Encrypted: i=1; AKwUvBwfT6vbZVWPdvWEpX2xe284ANHOEoQNeHF1i+75PkRw1sc+ZxT0hiD7ZhUGVU7v/2hbOJcYPPo=@lists.linux.dev
X-Gm-Message-State: AFuF++l4ilNVwaN9OtMLR31f8fxEl9gov2IYxG0ObLfcwJujzdkCa4Pc
	P9Dlxz54RPO5wXsNG5wAfDZg6Cr587k1EvkW1+83lNMBlIupJu0VdPeyLCFzPXTdCzwoEo3V/QS
	X4X/DL9I=
X-Gm-Gg: AYBFou05WTTUxyNee2IQSLaodZczYeJmMln2H69xGK7Sd24StTGfaBdjeMkpasiXKuN
	us8+3NxwekDKzj5SYBgtFiXOg48O2A/9gakveboqgX4TcTgCQW7r2MlARDKtSgfZ4dUVBM+jxdO
	qLk5fzBvVkYqL5s7KijNOx6Fek9VRw4liiMU1c19pJEbdy9qsFQhmD99i0M1XGFqDBNJfAgsZz0
	mMVGmOKns9uDgV0upONkiJOPWjCFDJrrSxpEQRn1Rr7LbTNGEBfuuUOvT/PyaJFCT++Kawsosld
	bWq8HL7dMkfJznh6coa1p7RKwfO2s/Z3vQEnEqE3ZPcmTiGPjxahyvGLs4xsFraKttinLDlDu9T
	rFI30oi4p2IhmQmdhmcYbSJR4Gx33WaUCXGbhCj2+QirOYW6cuPkShUXzyyQBzXFpgXu408cs0H
	hWdrSl58wYv4KG7A3mXU/QP74H9D70woCsHXa+Ha6oHHufl/va0s5HfRxK66bnad03Uwhm7Lrjs
	mN8A5rwP+ZaS8CzeRE=
X-Received: by 2002:a05:600c:6303:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49cf1581370mr23239015e9.4.1788426903342;
        Thu, 03 Sep 2026 02:15:03 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d2019sm54930775e9.2.2026.09.03.02.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:15:02 -0700 (PDT)
Message-ID: <4adcf116-66a5-4895-9b87-bbad9cba3a4c@blackwall.org>
Date: Thu, 3 Sep 2026 12:15:01 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
Content-Language: en-US, bg
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
 <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
 <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
 <b7ca242f-e381-4cf4-993f-a151dcc0cc8f@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b7ca242f-e381-4cf4-993f-a151dcc0cc8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2026 12:12, Paolo Abeni wrote:
> On 9/2/26 2:54 PM, Nikolay Aleksandrov wrote:
>> On 02/09/2026 15:51, Nikolay Aleksandrov wrote:
>>> On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>>> issue(s) to consider:
>>>>
>>>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>>>
>>>> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>>>>     performs the entire per-port mglist walk, including one…
>>>>
>>>> -- 
>>>>
>>>> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
>>>>
>>>> The patch converts the mglist walk in br_multicast_list_adjacent() from an
>>>> RCU walk to one done under the bridge's multicast_lock, since mglist was
>>>> never converted to RCU.  It also makes the function return -ENOMEM on
>>>> allocation failure and documents that in the kdoc.
>>>>
>>>> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
>>>>
>>>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>>>> index 3ef5d8bbf552e..97686984de6d5 100644
>>>>> --- a/net/bridge/br_multicast.c
>>>>> +++ b/net/bridge/br_multicast.c
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>>>>            if (!port->dev || port->dev == dev)
>>>>>                continue;
>>>>> -        hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>>>>> +        spin_lock_bh(&br->multicast_lock);
>>>>> +        hlist_for_each_entry(group, &port->mglist, mglist) {
>>>>>                entry = kmalloc_obj(*entry, GFP_ATOMIC);
>>>>> -            if (!entry)
>>>>> +            if (!entry) {
>>>>> +                spin_unlock_bh(&br->multicast_lock);
>>>>> +                count = -ENOMEM;
>>>>>                    goto unlock;
>>>>> +            }
>>>>>                entry->addr = group->key.addr;
>>>>>                list_add(&entry->list, br_ip_list);
>>>>>                count++;
>>>>>            }
>>>>> +        spin_unlock_bh(&br->multicast_lock);
>>>>>        }
>>>>
>>>> [Severity: Medium]
>>>> How long can this critical section get?  The whole per-port mglist walk,
>>>> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
>>>> br->multicast_lock held and bottom halves disabled.
>>>>
>>>> The number of allocations inside the section equals the length of
>>>> port->mglist, which is only bounded by br->hash_max in
>>>> br_multicast_new_group():
>>>>
>>>> net/bridge/br_multicast.c:br_multicast_new_group() {
>>>>      ...
>>>>      if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
>>>>      ...
>>>> }
>>>>
>>>> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
>>>> any u32 without validation via netlink
>>>> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
>>>> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
>>>> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
>>>>
>>>> While the lock is held, every other CPU that needs br->multicast_lock spins
>>>> for it, including the br_multicast_rcv() receive path, the group and query
>>>> expiry timers and br_multicast_port_group_rexmit().  Before this change the
>>>> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
>>>> not block bridge multicast processing.
>>>>
>>>> The caller is periodic, so this is not a one-off:
>>>>
>>>> batadv_mcast_mla_update()
>>>>     __batadv_mcast_mla_update()
>>>>       batadv_mcast_mla_bridge_get()
>>>>         br_multicast_list_adjacent()
>>>>
>>>> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
>>>> workqueue.
>>>>
>>>> Would it be preferable to bound the section, for example by pre-allocating
>>>> the entries outside the lock, or by dropping and re-taking the lock in
>>>> batches, rather than holding a bh-disabling spinlock across up to hash_max
>>>> slab allocations?
>>>>
>>>
>>> Oh please, enough with this shit. This is taking way too much time for a function
>>> that is largely useless.
>>>
>>> I will just convert it properly to RCU in -net and be done with this.
>>>
>>
>> and just to be clear - IMO only bots and llm "security" researchers would be trying
>> to do what is suggested above, I doubt there is any real-world case where it would
>> actually happen.
> I understand your frustration. Unfortunately ignoring this kind of
> reports will lead to at least one security report, possibly with
> unbelievably high impact due to unexpected chaining. That is, we can't
> ignore them.
> 
> /P
> 

Sure, I know. :) Sorry about the noise, I guess frustration got the best of me. I've
already prepared the proper fix that converts mglist to use RCU and we don't need
the spinlock at all. I'll send it out after running a few tests.

Cheers,
  Nik


