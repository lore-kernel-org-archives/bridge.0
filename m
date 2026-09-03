Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B846C83D
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426768; cv=none; b=mQpTMSe4If/c2ILwuTlIXyVwWkasUL/H38TuHrMO+dXmZuswcBtSR2ZPxH32clyNVAMSrKEzmhNvjvTLGPcQQyK511BN8KnU/dfyU4kgB3npILflMcQeSHPDpYQPlGBpbQmYfjOPxQ9bstprF0CIojz2bRLqKyxVNI6WHfYzmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426768; c=relaxed/simple;
	bh=8yRwhYp4T46Ioc2NqTAm466w7YfIjzlx6TzRz3cC4QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA5z0uIsJhIVYcipe/ry3V1dbDm0jF+n/sYh/hk905W19GaIiYhqz8gN4uRnpux8ZDdFeIJxMw+q5viael/NiJkDZXzCYhRtcDl6/2g/hlZpoM54YPj1SoMSrOyAay/mRzLNTTrSlzRfSnLTk3O0QKZRw/1Hq+93FeWo2GftOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bePrziZn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bePrziZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788426766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lmLINHHaQaNFXVLN7hTt2q7wBOhBTt6Ut2+Ns4748E=;
	b=bePrziZnL2ctZ5dbXOHFbh7HPo68LeNsb0im9d5lgvFhT/N971wOMSgdfk0XHpyxz78xCE
	4h/5TJQuuX4BnqDA/KTdnOlYBlRA3ixYf/UeumQ98BV01i6JNMptyLZqXmcdoF0dY+kusf
	8SQ8DyMRu6UMN93qYCJqo2WVpoI6Xz4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-6S2wDPXyNweMG1Dm2-IvpQ-1; Thu, 03 Sep 2026 05:12:42 -0400
X-MC-Unique: 6S2wDPXyNweMG1Dm2-IvpQ-1
X-Mimecast-MFC-AGG-ID: 6S2wDPXyNweMG1Dm2-IvpQ_1788426762
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cc9f5bee2so17717975e9.2
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 02:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426762; x=1789031562;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1lmLINHHaQaNFXVLN7hTt2q7wBOhBTt6Ut2+Ns4748E=;
        b=VmLSGiqwdDQI3/57VoLwt1YnvrXpD1HoWqTuk75E+OtqBB8JIFofJI7HdRYUgQSoAH
         BdPfQ0UlOg444XsNw8fiAoCC020xQAntZE9UeuCCMdFC4XG7nkU/wxt37tHQL+6a/ob8
         e3v8k/rAHIX1lQXkTwFzs14swST0YRwjLnGEOOl2xPygAwuahfgTLkI/6YzYeqmTkJUT
         dzdBbN7JwL2HuSQkwMHqpNpnMBNEm5GyxkTVdD79farKRA4A6cQGjPMkVxge4D+yQTTp
         psjTpeVScnBXll7nsX6UsWeU2ZRkeM5fqe3mvdR1cJeAhZ8fs85ZpyX8x/6+FkGgjeoc
         LplA==
X-Forwarded-Encrypted: i=1; AKwUvBychjmEvXBXlGVnzgWZaDJQC0U+SPKDqZderv2VExjXzqorP7GXGIpl5q5Z/mj4RNOOhyIA6WA=@lists.linux.dev
X-Gm-Message-State: AFuF++mbWbRg4nZIJYrlE7ZyFPSIPCqjOHMUndXiMnh95XxFAm/h9dpS
	t0sjsBjBLiEDQyUY7GSVUXvk+j+ex/85U8tYzJa5v0+K1sF3YvEQq7zTnYFe70gzYK4zQfPauWr
	xAxCiSuE9AJE1lT9EnZtqLSlqVmVPA90tJkddRYuF6r9B1xj0Cwy6xUGNY9G3U3by1w==
X-Gm-Gg: AYBFou3HLE1tAmHjZzf00wQm2Q0JwuHHeK4wqoPbKpI4NeSpGoy0iu/Met3w7AubIen
	LtlxQmqQedPsX7cjsdxCcj4v3QsLzOojGsYnaJhUNIOj86ZICHek5KeQ04HIyVuLJW5udyuOpBd
	5aqplVjH4sJBjA1dHAAVABXr2Q3rUGccdvgflFDT8rXB2D7V4nG2k4Bhl0JJBxrzmZ5zh2aPaGE
	kYAvC43O6Ge8v6sHu9osZ/wP57OoGVB4WFiEnsaUjS4ncOQfUKMqqzuTDkLjvxmnwig4bDVlvR+
	h28/93VHtbr1ICvUTSbNjsvtrg+KkrchmFPsOO1sq89R4F8BJkV9toedsDYLvoECYIll00JrQif
	QQcroC9n78g3faqLIECTqvx2pC1zk8gCYxgXIvroXiRlxLC+jdAt3GGef/TnTV0iQYKgT8Dtwlw
	==
X-Received: by 2002:a05:600c:5653:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49ceb17cff4mr103012635e9.8.1788426761564;
        Thu, 03 Sep 2026 02:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:5653:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49ceb17cff4mr103011865e9.8.1788426761041;
        Thu, 03 Sep 2026 02:12:41 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm54720075e9.6.2026.09.03.02.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:12:40 -0700 (PDT)
Message-ID: <b7ca242f-e381-4cf4-993f-a151dcc0cc8f@redhat.com>
Date: Thu, 3 Sep 2026 11:12:38 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
 <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
 <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bv_aiBBLb01v_DC96ubLLeAylpv2tCp8jBFiudxgLYk_1788426762
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 2:54 PM, Nikolay Aleksandrov wrote:
> On 02/09/2026 15:51, Nikolay Aleksandrov wrote:
>> On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>> issue(s) to consider:
>>>
>>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>>
>>> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>>>    performs the entire per-port mglist walk, including one…
>>>
>>> -- 
>>>
>>> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
>>>
>>> The patch converts the mglist walk in br_multicast_list_adjacent() from an
>>> RCU walk to one done under the bridge's multicast_lock, since mglist was
>>> never converted to RCU.  It also makes the function return -ENOMEM on
>>> allocation failure and documents that in the kdoc.
>>>
>>> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
>>>
>>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>>> index 3ef5d8bbf552e..97686984de6d5 100644
>>>> --- a/net/bridge/br_multicast.c
>>>> +++ b/net/bridge/br_multicast.c
>>>
>>> [ ... ]
>>>
>>>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>>>           if (!port->dev || port->dev == dev)
>>>>               continue;
>>>> -        hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>>>> +        spin_lock_bh(&br->multicast_lock);
>>>> +        hlist_for_each_entry(group, &port->mglist, mglist) {
>>>>               entry = kmalloc_obj(*entry, GFP_ATOMIC);
>>>> -            if (!entry)
>>>> +            if (!entry) {
>>>> +                spin_unlock_bh(&br->multicast_lock);
>>>> +                count = -ENOMEM;
>>>>                   goto unlock;
>>>> +            }
>>>>               entry->addr = group->key.addr;
>>>>               list_add(&entry->list, br_ip_list);
>>>>               count++;
>>>>           }
>>>> +        spin_unlock_bh(&br->multicast_lock);
>>>>       }
>>>
>>> [Severity: Medium]
>>> How long can this critical section get?  The whole per-port mglist walk,
>>> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
>>> br->multicast_lock held and bottom halves disabled.
>>>
>>> The number of allocations inside the section equals the length of
>>> port->mglist, which is only bounded by br->hash_max in
>>> br_multicast_new_group():
>>>
>>> net/bridge/br_multicast.c:br_multicast_new_group() {
>>>     ...
>>>     if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
>>>     ...
>>> }
>>>
>>> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
>>> any u32 without validation via netlink
>>> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
>>> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
>>> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
>>>
>>> While the lock is held, every other CPU that needs br->multicast_lock spins
>>> for it, including the br_multicast_rcv() receive path, the group and query
>>> expiry timers and br_multicast_port_group_rexmit().  Before this change the
>>> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
>>> not block bridge multicast processing.
>>>
>>> The caller is periodic, so this is not a one-off:
>>>
>>> batadv_mcast_mla_update()
>>>    __batadv_mcast_mla_update()
>>>      batadv_mcast_mla_bridge_get()
>>>        br_multicast_list_adjacent()
>>>
>>> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
>>> workqueue.
>>>
>>> Would it be preferable to bound the section, for example by pre-allocating
>>> the entries outside the lock, or by dropping and re-taking the lock in
>>> batches, rather than holding a bh-disabling spinlock across up to hash_max
>>> slab allocations?
>>>
>>
>> Oh please, enough with this shit. This is taking way too much time for a function
>> that is largely useless.
>>
>> I will just convert it properly to RCU in -net and be done with this.
>>
> 
> and just to be clear - IMO only bots and llm "security" researchers would be trying
> to do what is suggested above, I doubt there is any real-world case where it would
> actually happen.
I understand your frustration. Unfortunately ignoring this kind of
reports will lead to at least one security report, possibly with
unbelievably high impact due to unexpected chaining. That is, we can't
ignore them.

/P

