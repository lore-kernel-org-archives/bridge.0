Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A4255E26
	for <bridge@lists.linux.dev>; Wed,  3 Sep 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894112; cv=none; b=of+uEEFJeizEcKA4ybJc13qWFrahVYIbhxHucGz7Kuv0bJBKnMzoHfYnBS9ps3L7N+KtYqZaeDOsoZkyqjiFEhHR+a8ZPLjD9zvYoAiIRV2gySYxnHwhHNuFA6MEQqt0P+yD6d5+IWYntHtcmdGuBwJr4gDYh/TYADIqwVVi0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894112; c=relaxed/simple;
	bh=qJtX9JrzHUfYr86Q6dN6NST8Wdm1ij9B+wmXyqKJpBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in/L0+Rq2HedsKq03Y5wZ+PgywuGKrhHBKsaelrzw5Ea/sp4ERB7XoFlqo2tg/Oyqmp0anr8EO85D5BqIL5+eU0RPkkCq0jaTRPiaP0lgVIxTdvVXPYOlJFHkOSMR6+lUSWHyzkuAwzC5eGFI6aoitV1DSWVKcKABhajZBlsfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZKlMRShh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZKlMRShh"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso5470241e87.0
        for <bridge@lists.linux.dev>; Wed, 03 Sep 2025 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756894108; x=1757498908; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgxSLuacOSiAliVBo9T6UoRFjla5an5sZrNTYabGCaM=;
        b=ZKlMRShhf8yHl97bIX038sMOXMFI9MWgQd+yAtPzh0/q0BIpiBvTORl1FcDz/b2ftJ
         xNIgMlaZDdSJp4G28QoSan7PiLHFdnrbsm2GQ2E5oEQNxD8Ulc5bwGyFBO+1rXVMEjp/
         4+693vLBKtBeUO2yplv8iJUPgmqp8bYmpHaXVyZINmyVUDsJM4gFF/x1Puzms5+Ck4RB
         Tg5h9Vd20pR/vZn1P+dsvYOKcolQWDnITE/kLF3UoUmBZCkPb/nmnXBhtuOdtGipDOJ2
         jTWdVDjxdyyeIX+ZxxRXXbBPrcOtIG/6JH2NKiRA9LUALdMkrR6nPvsp8mH67uUhy5F9
         Y5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894108; x=1757498908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgxSLuacOSiAliVBo9T6UoRFjla5an5sZrNTYabGCaM=;
        b=O+D7iu0PwtMk7jjNfLoPQvbQX9QmbQP+wbqSfw2Fmw7lMfPyO+Z19IQoxC/7RmXtyS
         6Dz9yfbh/Mi9wGXnD9286u417SNJ3eu3eXY6a4BA26CqEDTOZuobBNhpwZumrFGlT+OK
         bdArNpmVG92ja/YCywdiwXJvOKBCOo1w2vjP6BqmijXmWFqeXaCpDzHdF0Q7/o4DSDUv
         dgoOv6cXEz0q/lU5S8eKSk/C/iqenHMVdW4+LrTKQAnNLCxUlanqHzcKmwU+Ztpx0Uvb
         YrMHHHDzoeomNOzdpA8bB2+Fh4Sebfj7Ry2C28DC8Fqrqg7CumfWIIjbB0dOGP59/xto
         mgeA==
X-Forwarded-Encrypted: i=1; AJvYcCVuQzSZNDBhRFNzJFOYzrk/5029HWeDhN9uVEzSU1/QU5eTvituQit2da66Bd7GIKDbJumDVic=@lists.linux.dev
X-Gm-Message-State: AOJu0YxttF7rzxLZAqGp8kZtdtzaQfRaOcNJNfx3QyyMZl3m3sRgxtUV
	HWGSAZqqkf1TvHQw0Gp5wJES8D8xe03vNf4+KPxRSoEIPtIdoDnbiwNRaS0J/mBezYo=
X-Gm-Gg: ASbGnculxWg+jKmZp9ErloEENGhMrtovUHsKH0d8eu87jG7PMXtwwhzkeuo0SHRXzWJ
	RfM7sh5epZ9RMHAxmXJcLhEIALKGpI0eYRkTc0aW0h1J3GsuoG7UeJcWrhSGThH+ID5kFbZ6QHG
	JXV17uMzxLaiOU76QuEdWdtgOtsxSLwiOPyw3lnMX6mmFB0bT8ufO2oYroGy6TxHJz/o4ozTBeZ
	p4I6k8GuyBsCVy4QvriXS6BEtITyB80OjX5Fw7gLzSX+3t1ZGfHwSoNpDmH1skS+b3TkcYhvXO5
	VLIRlBvOAsEtGUSz9twTD75dE7lDHL0j6Ggn/Ff3WRvhBxLGuLk9Uv1yxewxZIA91Wnpp5poFvc
	8+0SS9ohUQt5Gtu7u97iUQTXyuSOTh83NdEu+EPGDWkjWUSZTpPfWJnXWwG8T7yeZbeY=
X-Google-Smtp-Source: AGHT+IHXf+8BRUc9VKztwBDE44uJbCq8HfDYm4XkzCGHzVKe8cY4jFi8CRi3pEVvkXEvbG51NW6TZg==
X-Received: by 2002:a05:6512:689:b0:55f:54a8:9ec with SMTP id 2adb3069b0e04-55f709b6857mr4930716e87.52.1756894106967;
        Wed, 03 Sep 2025 03:08:26 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad1351bsm411401e87.121.2025.09.03.03.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:08:26 -0700 (PDT)
Message-ID: <c1964582-a96a-4b46-afb7-0cdfa8208ef6@blackwall.org>
Date: Wed, 3 Sep 2025 13:08:24 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
 <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
 <aLdQhJoViBzxcWYE@sellars>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aLdQhJoViBzxcWYE@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/25 23:16, Linus Lüssing wrote:
> Hi Nik, thanks for the suggestions and review again!
> 
> 
> On Fri, Aug 29, 2025 at 07:23:24PM +0300, Nikolay Aleksandrov wrote:
>>
>> a few notes for v2:
>> - please use READ/WRTE_ONCE() for variables that are used without locking
> 
> Just to understand the issue, otherwise the data path would assume
> an old inactive or active state for a prolonged time after toggling?
> Or what would happen?
>
> 

It's more about marking these as used without locking so KCSAN won't flag them and also
to clearly show people that intent.

>> - please make locking symmetric, I saw that br_multicast_open() expects the lock to be already held, while
>>    __br_multicast_stop() takes it itself
> 
> I think that's what I tried before submitting. Initially wanted
> to have the locking inside, but then it would deadlock on
> br_multicast_toggle()->br_multicast_open()->... as this is the one
> place where br_multicast_open() is called with the multicast spinlock
> already held.
> 
> On the other hand, moving the spinlock out of / around
> __br_multicast_stop() would lead to a sleeping-while-atomic bug
> when calling timer_delete_sync() in there. And if I were to change
> these to a timer_delete() I guess there is no way to do the sync
> part after unlocking? There is no equivalent to something like the
> flush_workqueue() / drain_workqueue() for workqueues, but for
> simple timers instead, right?
> 
> I would also love to go for the first approach, taking the
> spinlock inside of __br_multicast_open(). But not quite sure how
> to best and safely change br_multicast_toggle() then.
> 
> 

Well, this is not an easy one to solve, would require more thought and
changes to get the proper locking, but it certainly shouldn't be left
asymmetric - having one take the lock, and expecting that it's already taken
for the other, that is definitely unacceptable. Please spend more time on this
and think about how it can be changed. Right now I don't have the time to dig
in and make a proper proposal, but I'm happy to review and discuss proposed
solutions.

>> - is the mcast lock really necessary, would atomic ops do for this tracking?
> 
> Hm, not sure. We'd be checking multiple variables before toggling
> the new brmctx->ip{4,6}_active. As the checked variables can
> change from multiple contexts couldn't the following happen then?
> 
> 
> Start: ip*_active = false, snooping_enabled = false,
>         vlan_snooping_enabled = true, vlan{id:42}->snooping_enabled = false
> 
> Thread A)                     Thread B)
> --------------------------------------------------------------------------
>                                br_multicast_toggle(br, 1, ...)
> 			      -> loads vlan{id:42}->snooping_enabled: false
> --------------------------------------------------------------------------
> br_multicast_toggle_one_vlan(vlan{id:42}, true)
> -> vlan->priv_flags: set per-vlan-mc-snooping to true
> -> br_multicast_update_active()
>     checks snooping_enabled: false
>     -> keeping vlan's ip*_active at false
> --------------------------------------------------------------------------
>                                -> sets snooping_enabled: true
>                                -> br_multicast_update_active()
> 			         -> checks vlan{id:42}->snooping_enabled:
> 				    false (from earlier load above)
>                                   -> keeping vlan's ip*_active at false
> 
> Result: vlan's ip*_active is still false even though it should be
> true now?
> 
> .o(Or were netlink and sysfs handlers somehow ensured to never run in
> parallel?)
> 

They are, netlink and sysfs are supposed to take the same locks so they
cannot run in parallel changing options.

> 
> I'm not that versed with atomic's and explicit memory barriers,
> could that prevent something like that even if multiple variables
> are involved? Only used lockless atomic_t's for atomic_inc()/_dec() so far.
> And otherwise used explicit locking.
> 
> 
> 
>> - can you provide the full view somewhere, how would this tracking be used? I fear
>>    there might still be races.
> 
> My original switchdev integration plan so far was roughly still the same
> as in the previous pull-request:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20250522195952.29265-5-linus.luessing@c0d3.blue/
> 
> And using it in rtl83xx in OpenWrt like this:
> https://github.com/openwrt/openwrt/pull/18780/commits/708bbc4b73bc90cd13839c613e6634aa5faeeace#diff-b5c9a9cc66e207d77fea5d063dca2cce20cf4ae3a28fc0a5d5eebd47a024d5c3
> 
> But haven't updated these yet onto this PR, will do that later.

Thanks.
