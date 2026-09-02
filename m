Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E32493637
	for <bridge@lists.linux.dev>; Wed,  2 Sep 2026 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353692; cv=none; b=lZVpGyRVJs+r4s2+HXzgz/4SAzhzPoKbHv5ZrhYPH+GhMcOErUxs/z5+DouIKaqvBMmwx8L3U854qf41IL7dglCNR31gqmUMZ7MQTEJ6/Qti7ZGENcZv3sdo2uKerUbFxx2ucQpIXnBIHxAaI3YEBGkX0YmEZ3GwUx+pVDjnREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353692; c=relaxed/simple;
	bh=o3f7EjLmAoeGMx7zQB99T6qT5He6SvTMRTAJ/kicI/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AqWzy6sgL6ufW5TMLBergvneCE/qC9NZ8pvBEqcTDerOOEQoyZj2beqlv5fRedjrGGN799GkbU94Ipea8vVDXjd2tFhXjEW9IlItQEI7LpAipGujGgBCENvAqfG68a4YGqU+s2rjmyoWoiSr8cPjpiCNqn8B4lAKtTilcLpWL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MXgbdLNr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MXgbdLNr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2533d83e3bso139898366b.2
        for <bridge@lists.linux.dev>; Wed, 02 Sep 2026 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788353689; x=1788958489; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DITijZ9Q92bPLBWXCNAyjT0FbcCXC7ezg5VUf3ZnRkQ=;
        b=MXgbdLNr/7dDVsjwZJFeXwHIeNhhQxU9mksTbTrRHwKlWNw3ZImOeVA/IGpakNo/Cj
         0WqJfGvI9lpU2XnolMSALYcl/2Uc2VAdLN4MeqJVz7OkhGNMnhdX01CcSxkdv2BvC27Y
         1hGqg/yqprVEK+vDGP2tKvjAeEqIQWhMy8LB7XaMkCyGlvrU7Uasq6DpMBKVn0RiGN54
         10dh8MoBy3gY1Wwoq9V1smKPANaxTthSfizgZgMUCNNeCbhVMiRAIZgo2PuAAmI/FPoc
         zGu0s1pAwGA0zJiLRIJkKXYsC6zwRL9rTjn6/1Y+5+5Fg/ESIte78gD+vc0WJY4wTj2J
         WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353689; x=1788958489;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DITijZ9Q92bPLBWXCNAyjT0FbcCXC7ezg5VUf3ZnRkQ=;
        b=QmhRd2WDUOqgtS2SskM8u3jR7oMrNeIaJPL/IftmCb3huj2Ivg3hbPjQ2KUy44b6w2
         NLqRF8iZvjYTh9d7aiX2JdbynBe28YIq65/+8vA8I8N4GSZhdp7bNqUWXyQ8Fg6mjyu6
         djaE04NOiGnqbqODWxgkp9Fuy1uH5/LY1R3WxIl+xIwvMVxbbaBu3cXfQoHMcc10Z+Zx
         EDm+fG3gryWqYvURr31VH2XY6Aw9vkFgOOMtgAttNh6GwNQWy6lCGZ07W2KrxUH5vfgI
         b2ESo0cuaulLJW+cCQr/SEI4MIzO+nNoXlehu8lUG4x11YsJbIZ2KJpC7pk0nP7A4eZS
         lKtw==
X-Forwarded-Encrypted: i=1; AKwUvBzQFzlmqMi4svpRRyL5go23sASVipeJkhWl4LTkvENcq3wO51nd13CCG2VvzqLGssalv9pmSA8=@lists.linux.dev
X-Gm-Message-State: AFuF++lAf/pT9B7MUz+5c+SpzUohWhmZNkcLKyFgCj+OBiEMBTYMC/JM
	7fWASy6JqRCz81pI+622nC5WhWlt28DR2k5TUzr72FSGAHnO1GGqfeWkCHEFYjtNEsE=
X-Gm-Gg: AYBFou0lRQRFPvHsT4nB8nmO/FwttHSUALaXB8iBVvSAZPRyC0qSNC7m6lM/uUiUvZ7
	ihfkLlESSAtXCjxjNFZWn8iojf4nZht3eZSa15ALIWxAaSWmAF1UMmNPYTnSehXZ7ROxqdJix1M
	Tc9bb60ZTBc5HupriyWa/eIjiFusrF6n75vUb3Mz6lWXQC5XbypgiW19fVAa6gYpJcqxz8QiwAe
	Z0xW7IHuKSwt3Ou+mUwusFELAEGVrCcBp5eUMrWwyVEfatNCRrzdI7ahrvnn+AU9kIpgPn89XoI
	iz8e/Yy+EFBzwKtRNya10Yu+aJCHBcq1vwszsZ2PDfksZqe1dr3KC77pLxERxt0U/QkEe1fSdwP
	qFWtO45XVCdabFYz0xeUyQTxge6s7Q87HilCiw3KwAu1DkXmFYpbx6zVjlJ4VHqmo2t6ISyO97l
	Nk29VuKwqw/XWvZfdvQrkQbCJlxL+cD5QlUrpx+GiamkKjn3L8L9IZYaU/P8PjFv5A/w4Ae8cIX
	qwHv5LH1YXJACx/O3WFRtHVymeNkQ==
X-Received: by 2002:a17:906:478a:b0:c25:938a:754c with SMTP id a640c23a62f3a-c25d54f6ddamr285434866b.20.1788353688997;
        Wed, 02 Sep 2026 05:54:48 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d043e6bcsm129669266b.61.2026.09.02.05.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:54:48 -0700 (PDT)
Message-ID: <30c1e3c4-71cb-426b-9949-d336b8824f95@blackwall.org>
Date: Wed, 2 Sep 2026 15:54:47 +0300
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
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
 <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
In-Reply-To: <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2026 15:51, Nikolay Aleksandrov wrote:
> On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>>    performs the entire per-port mglist walk, including one…
>>
>> -- 
>>
>> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
>>
>> The patch converts the mglist walk in br_multicast_list_adjacent() from an
>> RCU walk to one done under the bridge's multicast_lock, since mglist was
>> never converted to RCU.  It also makes the function return -ENOMEM on
>> allocation failure and documents that in the kdoc.
>>
>> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
>>
>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>> index 3ef5d8bbf552e..97686984de6d5 100644
>>> --- a/net/bridge/br_multicast.c
>>> +++ b/net/bridge/br_multicast.c
>>
>> [ ... ]
>>
>>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>>           if (!port->dev || port->dev == dev)
>>>               continue;
>>> -        hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>>> +        spin_lock_bh(&br->multicast_lock);
>>> +        hlist_for_each_entry(group, &port->mglist, mglist) {
>>>               entry = kmalloc_obj(*entry, GFP_ATOMIC);
>>> -            if (!entry)
>>> +            if (!entry) {
>>> +                spin_unlock_bh(&br->multicast_lock);
>>> +                count = -ENOMEM;
>>>                   goto unlock;
>>> +            }
>>>               entry->addr = group->key.addr;
>>>               list_add(&entry->list, br_ip_list);
>>>               count++;
>>>           }
>>> +        spin_unlock_bh(&br->multicast_lock);
>>>       }
>>
>> [Severity: Medium]
>> How long can this critical section get?  The whole per-port mglist walk,
>> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
>> br->multicast_lock held and bottom halves disabled.
>>
>> The number of allocations inside the section equals the length of
>> port->mglist, which is only bounded by br->hash_max in
>> br_multicast_new_group():
>>
>> net/bridge/br_multicast.c:br_multicast_new_group() {
>>     ...
>>     if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
>>     ...
>> }
>>
>> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
>> any u32 without validation via netlink
>> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
>> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
>> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
>>
>> While the lock is held, every other CPU that needs br->multicast_lock spins
>> for it, including the br_multicast_rcv() receive path, the group and query
>> expiry timers and br_multicast_port_group_rexmit().  Before this change the
>> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
>> not block bridge multicast processing.
>>
>> The caller is periodic, so this is not a one-off:
>>
>> batadv_mcast_mla_update()
>>    __batadv_mcast_mla_update()
>>      batadv_mcast_mla_bridge_get()
>>        br_multicast_list_adjacent()
>>
>> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
>> workqueue.
>>
>> Would it be preferable to bound the section, for example by pre-allocating
>> the entries outside the lock, or by dropping and re-taking the lock in
>> batches, rather than holding a bh-disabling spinlock across up to hash_max
>> slab allocations?
>>
> 
> Oh please, enough with this shit. This is taking way too much time for a function
> that is largely useless.
> 
> I will just convert it properly to RCU in -net and be done with this.
> 

and just to be clear - IMO only bots and llm "security" researchers would be trying
to do what is suggested above, I doubt there is any real-world case where it would
actually happen.


