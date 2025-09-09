Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409129E11E
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409599; cv=none; b=Ei5+b9eT7D+eOq0EZhYTjcwtEc3vOAo1LZqYNWS3VrM7NW2MllHLe8czQ3IZBb2cbkMx3hujQ2bgMvu0nvbEX+8qpEfumaS11OnJAp7tBJr/sVZPtAiKtNoU381zDbxiJ76KvLY3isHPXuI5yNhQxqb4eu9G3vxQbP9wDndnA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409599; c=relaxed/simple;
	bh=PZ0Fgxr1V6+9ghg4MKas+B5ujQdsZmxWeDfhsHJYHds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YLKAYzGOxwZ4wfZXGQwYcBfVGJb2iuXYPYrVlU1rQG8sQ5X/BsT7Vbkfrg9QD1y69+rodAwy5iR1r6uxsoOOMyWujLirWANwveIvFn6/ecmcfKF4lYOnpMKJz7hSmReW/ypvCM/taJkE1TlYEv5dvYEmHwDiDOhOWVMjR/QSbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ig67pvNP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ig67pvNP"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5608b619cd8so6408277e87.2
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757409596; x=1758014396; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brw5dOQ5UUDO/Fh89VIdK0n0tzjKtkES6VDBwZFpE38=;
        b=ig67pvNP6nsbAWC1UvojKbl17TeFtl5Oo/o/6Ae8ouv4+Ocz7oAg1MRC+S7QZqLlDC
         qz1kTtKL79hoRL8fLeV8iZEy5oRzPZbvGNkbR9l8ZNYO8mSYbgepM2mEwkF8A+S8sbF3
         AldLtzUG/qKD0PPZ78wzrRxT3tnZ46jB+k0hiABX6fcU71lXz2kVigMwtH9rMIrn+7Gi
         ac9z7vy1YF7jhZkM921P4ZIeW0ygfe5WsVcQB8hbDUaoeuMad5KCHXwzMngHN96CyiWK
         tt+myhD8zWuDsSY8mu7dL08g8dHLI/JMXZLLhY99h5jx2IfeYNWujQ83cXzLhgxpKG8f
         71Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409596; x=1758014396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brw5dOQ5UUDO/Fh89VIdK0n0tzjKtkES6VDBwZFpE38=;
        b=wtTiwUe55nTH91tkLA4EtAdR3Xkh2b3CauATkdkX+QAP0RVtstKRSJMSsTvpY8RA3m
         Bu+dtVlGc+y2FmW4tSUtPsa17RHzIxllii9aY8S55a2ftAfn6VPlWJAQydH0WorHflGE
         99+uRGal3VvOvsWSKTRnotrhfF5lwwRAJSYXnFjMXPX9ykDmW7oYpw8jY2dHTnuV83w6
         +XuZhO2ReFOWW4LOJsDmPiIzXjj5ZASvWfumD4qpQDXdutldDq+42SM5vcYYDpTjKd+v
         Ovpeeq23ay06gSCnc5BOO613DdoRIQxdt1hE8z047MBMavrz96RJf/Q72Mp1wnECG3OT
         jH5w==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZJPKAyoAiS+amWh/r2aJLgQdtilAu2Ddvr2lkyH+DAwSQD3MfGjgk2HoYLMCbx1zvU9xkU0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8tgdn58eH9OZBLtpUNAYQ5xraAKbU5lqrL54T206T/6fLQxxz
	sJyOzYIVveXydaPidLPKY6Mk2XQBambK3PayXGeSaJJ7v89X1H63e6rdQsUeTWTLaEw=
X-Gm-Gg: ASbGnctiWQdf3I70bQGEI8FUj3nDUkxCPfPVyggnc7B0DWIL9bwmapntNf11jucm8SI
	BKbKPVh8hON8zB0dPxLyvLspSXB8XM4eSBfhkiVVBRt5AtQfR4DseuWWP1tCtTTpFqm8UBdAlS3
	N4XJOE+uDd2iFVl1oQe12Uw+VNgaZ/qbcgw8ZVVqFJDxTXPj5CgvYqhySwfS0X279vlcA1bkDUP
	KCy0PZR5H16djfkiKlYwGXaep4qWyCoqYsAVLJmHJnodr9O6+99RVNWIz8PV9W2ygrCMRwv3gqK
	NVomKj2ViGzUVcNLC7VJ/0M/SjiKIBbTCa8z8KEMPZz+iTGPCLLmHPwg568Lij37hzHSPbSSGkV
	TeHtwb6qrWR7j2lQMA6wLBSmKFxkn3LBTdrjmpDp3zA9TZM1XWmZZ8wUCxs4zeiq7Ot5fhPhHOM
	KIXQ==
X-Google-Smtp-Source: AGHT+IGyXyEnXPt/zd9SI74zODDrmgjcXDOuyeeX4wNZw6PtAsT0SI11XMnWl3GBdKlBp+qsLE74cg==
X-Received: by 2002:a05:6512:3da2:b0:568:8ac2:f18f with SMTP id 2adb3069b0e04-5688ac2f457mr565954e87.30.1757409595617;
        Tue, 09 Sep 2025 02:19:55 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d633sm389344e87.68.2025.09.09.02.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:19:55 -0700 (PDT)
Message-ID: <382bb1dd-47ba-445c-a13d-0d96312a756b@blackwall.org>
Date: Tue, 9 Sep 2025 12:19:52 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, mlxsw@nvidia.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>
References: <cover.1757004393.git.petrm@nvidia.com>
 <20250908192753.7bdb8d21@kernel.org>
 <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Content-Language: en-US
In-Reply-To: <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 12:07, Nikolay Aleksandrov wrote:
> On 9/9/25 05:27, Jakub Kicinski wrote:
>> On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
>>> Yet another option might be to use in-kernel FDB filtering, and to filter
>>> the local entries when dumping. Unfortunately, this does not help all that
>>> much either, because the linked-list walk still needs to happen. Also, with
>>> the obvious filtering interface built around ndm_flags / ndm_state
>>> filtering, one can't just exclude pure local entries in one query. One
>>> needs to dump all non-local entries first, and then to get permanent
>>> entries in another run filter local & added_by_user. I.e. one needs to pay
>>> the iteration overhead twice, and then integrate the result in userspace.
>>> To get significant savings, one would need a very specific knob like "dump,
>>> but skip/only include local entries". But if we are adding a local-specific
>>> knobs, maybe let's have an option to just not duplicate them in the first
>>> place.
>>
>> Local-specific knob for dump seems like the most direct way to address
>> your concern, if I'm reading the cover letter right. Also, is it normal
>> to special case vlan 0 the way this series does? Wouldn't it be cleaner
>> to store local entries in a separate hash table? Perhaps if they lived
>> in a separate hash table it'd be odd to dump them for VLAN 0 (so the
>> series also conflates the kernel internals and control path/dump output)
>>
>> Given that Nik has authored the previous version a third opinion would> be great... adding a handful of people to CC.
> 
> My 2c, it is ok to special case vlan 0 as it is illegal to use, so it can be used
> to match on "special" entries like this. I'd like to avoid the complexity of maintaining
> multiple hash tables or lists just because of this issue, it is not a common problem
> and I think the optional vlan 0 trick is a nice minimal way to deal with it. We already
> have fdb filtering for dumps, but that requires us to go over all fdbs and with
> fdb duplication the local ones alone can be a pretty high number.
> 

And just to make sure it is clear - usually we are talking about a low number of fdb entries
(w/o duplicates), IIRC up to 100 in most cases.

> The pros are that we don't have fdb duplication (much smaller number of fdbs),
> we use standard bridge infra available to store and find them (the fdb rhashtable,
> with local entries tagged as vlan 0) and code-wise it is pretty simple to maintain.
> This solution has worked for over 10 years at Cumulus, it is well tested.
> 
> It needs to be optional though as it changes user-visible behaviour for local fdbs.
> Any other solution would probably have to be optional as well.
> 
> And obviously I am biased, so good alternatives are welcome too. :-)
> 
> Cheers,
>   Nik
> 
> 
> 
> 

