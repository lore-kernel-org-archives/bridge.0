Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A3284662
	for <bridge@lists.linux.dev>; Wed,  3 Sep 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894316; cv=none; b=bmArORojuBaFogziSFhgCv0C8QUrmuSNG2+MmUY9jjOejVA1zrK9bIIktgial/xUC+kbWKcu0rhBMhlhhIfk6V5NgFzAOnFR6Lyig+r/I9p9jgnp1WnWDpyzBHSIZ/cwApQKQsFTSh9ynQEclaxwGdFhh800ivACuhWOLJ4WkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894316; c=relaxed/simple;
	bh=ZWM+I7gOKWzcFzvY+hdqKvup4xsslWjbk9vdkN+t2Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUBq3tKFLkcpJXIWWEZuccHXiHt5ZeIJBn5iRRZrEOkE317bfZy34fGB16ZiZd582NEftGUXek6C1pISG/apJeZVKRtJYnFKGox1KGCgOWjcT/cyBCK7XVb4uWa9W72zmw5bhLV2LSVWATon1zHMgx8lg394veApTMLFuC1yFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MJm2VemG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MJm2VemG"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6ad5146eso3891806e87.0
        for <bridge@lists.linux.dev>; Wed, 03 Sep 2025 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756894313; x=1757499113; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaEC72YkdU0dzg1YAuuKkN3WkhmBtHuuoh/1oBPlyDY=;
        b=MJm2VemGJ+c1Y9tMLvdIus98cHDjmSsQfbQg4Almkj4SqqjprMUfQeLocqaON1nVeD
         Ad+w5PjhrBnKCxJJ5Ai2Pzo8G9t6ldkHW/JAdwlxGcC5DOEZ8qUV0vlZz/CayzAY8RFg
         8iotmqsFXCPcd8kmRZ+BbrBc9VcY6mczVgKfTcs4QM36nrJkd0brlOAZWR6tIiTLS1ca
         FRupgAFbrmOe91LWT7dK0w7w372F/6hZDFjcKg3vNBqFlm9UD46KcvMTN0Q1DaL7jwax
         d0h1FUfQtnYy5LFcxH5bp08eG/aWP6Kot8ueTRhBzQL5iW/zrYI1Y+22qmZ8/Q//4DF8
         fH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894313; x=1757499113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaEC72YkdU0dzg1YAuuKkN3WkhmBtHuuoh/1oBPlyDY=;
        b=rSvFw2yb3XKVyoL1D9b1WKgMLm342oCIesC9rXbgKwU7ISw788/RTprC+5CIQ1hnkF
         KwOmOkgEiiv9QYuxU7kZNVJ4XqRibJJH5qpLZnvDmVTl90FAC1GYDVKVSjSgn1Fjz7MY
         yJezwfrLU+ilYmzIarQtKVVzySnROY1a0MEZNPc3CROOM14MtHDOm8vDC6lwiXH9NPsj
         p2kAPb2uX7zjM9Y27tAMjOzkeUhCtAv8/a0jOFH42z6m1/aBWwULOpebsj8uP3uUuBfm
         EE+lBPJFc9y+13EIFPcu6VSkycopv/tkQqk82ABZYCm57b5jlpmRPfkI70zoFJnEVNaU
         vcxg==
X-Forwarded-Encrypted: i=1; AJvYcCVA63jpilWsdg0WIY4OXyc2ZMtZpwhbzbfddju/CwP97resFdSbr9QVlSShVsIT1z+4XiZwBlU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzyXC93raxoC2KYMIL1BRR10J+jHHKYxfH0UBpSqOQNrZXwaYJ0
	nNwaH74DoG36AHmWcBYqgtd+BpBRNzDdMKumvYAjgFLXTA/91oy3vfCdEKC/BSut7c0=
X-Gm-Gg: ASbGncvfrdqQMOSZfIhbZHHNFCO5IJWlqTT4gm+NT3XXq+XQK7rlWDBXviy0afntJuq
	RBWiELlkj5M9R/AV7olm34WS+7R0/ObF0mwUnR76Wgur6F+gUZa6D7wiEJ53ciMR3zxc3GBOgQ6
	L7YBxjrwUCiU3OMo+lijSEVqoFpZSbsjX2mVEHVhASOLTNgX1dvcddFeUuMqEzBFcM4l+IO2lfp
	qLs07TsV8ybsPDz8wsrE8wzSIa552tApCkZ5/OrAkuE5JRHWsGq3BpKWHBM9uQvT95dwteSnfwX
	oFLjYysMmF0EGgFD881piGIUaN2jdF7//xhlOGibpQTiI2jCv1RRGXVQGDbQSXdp5LDqGSQkg44
	dH/IhDBvJMLp1zZz31Z+FLVuEQyr8i3gbenYgAtRs3qtgdx1x3GXERM9yLhZaT6tGSWaeU2E4cs
	LpzNpt7W00S6Ax
X-Google-Smtp-Source: AGHT+IHqbWry8xvL9J/n0nJMx7Sm8XKZqsiZtmb0vZ5EuUF59SiOy4XjuOBRm6SxlSbxf5fnxVNO0Q==
X-Received: by 2002:a05:6512:3b0d:b0:55f:5685:b5e9 with SMTP id 2adb3069b0e04-55f708b3332mr4752512e87.8.1756894312876;
        Wed, 03 Sep 2025 03:11:52 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acea03csm417484e87.90.2025.09.03.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:11:52 -0700 (PDT)
Message-ID: <fb8b827e-9aee-4aea-8291-30e5e4c539dc@blackwall.org>
Date: Wed, 3 Sep 2025 13:11:50 +0300
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
 <aLdQhJoViBzxcWYE@sellars> <aLd2_um-oWhS23Md@sellars>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aLd2_um-oWhS23Md@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 02:00, Linus Lüssing wrote:
> On Tue, Sep 02, 2025 at 10:16:04PM +0200, Linus Lüssing wrote:
>> On the other hand, moving the spinlock out of / around
>> __br_multicast_stop() would lead to a sleeping-while-atomic bug
>> when calling timer_delete_sync() in there. And if I were to change
>> these to a timer_delete() I guess there is no way to do the sync
>> part after unlocking? There is no equivalent to something like the
>> flush_workqueue() / drain_workqueue() for workqueues, but for
>> simple timers instead, right?
> 
> I'm wondering if it would be sufficient to use timer_del() on
> .ndo_stop->br_dev_stop()->br_multicast_stop().
> 
> And use timer_del_sync() only on
> .ndo_uninit->br_dev_uninit()-> br_multicast_dev_del()->
> br_multicast_ctx_deinit() and
> br_vlan_put_master()->br_multicast_ctx_deinit().
> 
> 
> So basically only sync / wait for timer callbacks to finish if
> their context is about to be free'd, on bridge or VLAN destruction?

You should make sure the state is sane if the callbacks can be executed after
br_multicast_stop(). There are many timers that can affect different aspects,
it might be doable but needs careful inspection and code ordering.

