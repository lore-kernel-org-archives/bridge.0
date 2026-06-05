Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA43CE0B4
	for <bridge@lists.linux.dev>; Fri,  5 Jun 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647672; cv=none; b=J0Z6lQnkHG6SBfawBmWdIBkDm390Sah0ylZ5ivYw9KaJFKqHpGYTsPIiWU5n9ATDFW3dSg+NOux2UWMKigZeEsE+ZYO/zStNCTgeEprTn4laH0pa/VoniLPoQJQk7I5+YDMO5ipr+DkJb3XGccG0SeK7g+opS+gbOL3N2PWh9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647672; c=relaxed/simple;
	bh=rgfSYOiXywKrwLfB/qrMOdVjNG8ygmP3bouuywyCiSo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+8Fp9mPg9tQ6SEOzNkMvrQdXdIzxbkGJGWitI0f7zSjJRArEbAvrqXPluFukc8PSzfFIbrWqop2WQfGjuBhsSu27vYaIjD/tAHhKxtgM6ssKZAIpJ/1FLameVqYxCqUnP4dM0Eq/8OerKBlBuMAFpfZ9X7spks60oLGXXgco/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PWHaxwIh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PWHaxwIh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso8459715e9.0
        for <bridge@lists.linux.dev>; Fri, 05 Jun 2026 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780647669; x=1781252469; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTR+ZXHU2zHqRTVuftEearzPbfFaRCiKJR11oO5z0GA=;
        b=PWHaxwIhwDExQMBReEzsrDNB4dFVmSZZQahg5BnTedWwvEZqT7ovM8aCxi1Nw8vHRj
         tbl053+R/jZ62Y0U9soXM2khLfQY9GWqjRUMfusIfRy8XuS4l37r5N0ZiLE/v1awdDd2
         +nJqVDNVwA17HBkadXUSG0J48+cHzHODp3BzcaKR969h6hts8Wr8qSumindnJA3IRpMc
         rzTQCGQiJSbiJ2K6w9FwzXiMzxlZniv542565PW3vljqHbrQU994Mo2XqWpWxdPRXnca
         AcMhYTOQeQbKqZXSaN9q8XwnAzvO50XdB9RKIFDO9b2/mKFLef/678VWrJwQ7j9DzXoM
         wizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647669; x=1781252469;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTR+ZXHU2zHqRTVuftEearzPbfFaRCiKJR11oO5z0GA=;
        b=iznylBo04rNPLRQghGfh0o3PHz1zPPpNMVjw+vBt03W8+jCHQ1mWNjq44aHNZtvTKH
         /6BrrxgVKyQKH0EaR6EaOCyJfk6iiU0GMRwod6De0FQcSO1HcYlhzvXM7Edy0LPoZEGP
         4J0QUoXAzcjHeypH9aZYWP94EIrz8hjDpVLNjToTqmeTpcmtrqBlqlyJezHpTJSuhBM9
         S2ee0MQ/rZGXAUplDp1uK2Zfk3Rq7RXZIy4KHBoWNCj+F63C/xvAgr3YX9AFFixkzLbl
         ftM8I/Z9wcyuGZd8KJjGqfMCQAIBQsCjtiZPGtTkoPpD5mqgve6FX8ykkJL/InLM/SS2
         k0DA==
X-Forwarded-Encrypted: i=1; AFNElJ917/jQKIchjyJWRT1QH55rJzEIzbJTlrdYnlaCMkpafNakj4/zv9TS0a622SBsie20rSuBeM4=@lists.linux.dev
X-Gm-Message-State: AOJu0YySDaufm3rS1l5su/wZE6Dd8FfZsD2/Kw5UQPC90hW5FQ90AoSC
	0cu0cztQnMuZ0rYcZ1ogBZWDvR5Y37CTWMi/VsxGzECMEf8040Bt9TlcP4j4bJJPWdo=
X-Gm-Gg: Acq92OEdo9aLlBl/zswaRJc8oAP5kLXxdQLTKMbBInkFXOuLlYzL9+or6Iw3wi/kcRp
	JzoBjiKQWLcRdOkTb1/oU/tVNWPQv8RZH8H70RbIjSHzZ2XXtqrzSdXCUGQ+UUB/Q0tMSBiUpfG
	qO1n+XJSh5PU7VAtaRZoFo+gagFg0hwIbEg4A+vykTtQJIkKMGsIFKtI/ETwfjY5fgPnW6jszBx
	5aopjMoxYJXOqf740vd4vgVgDvrwDHMMrpKe05As9I9DAli/c6xX4aeSRgXtqL4jV7pGdWi6zjc
	4pEKNldVR6KWwAsZB/SytXV+H7lwiuJp5US9O1+MNvlnEwlg2CO90Yg0J1Q4FAWVLYE+yIPUd4e
	/Cs0Y8QyEHgzZkAXio9Lbjs2F5LhQKd5XZafErSdiwxwZcqCCvtyQsxSW/PX00XCMNwPpcey7EG
	qHNVSnIrUcJH5LEs8FJV1vxWSnHaDFf2Pz1McqlfS5JvEC6KtM3aXZiK7PnMLobdtt
X-Received: by 2002:a05:600c:4ed1:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-490c2cf67f7mr22714655e9.10.1780647669382;
        Fri, 05 Jun 2026 01:21:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm141002065e9.14.2026.06.05.01.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:21:08 -0700 (PDT)
Message-ID: <8186bef1-aa58-47c5-9816-1b707ec949da@blackwall.org>
Date: Fri, 5 Jun 2026 11:21:07 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on
 system_dfl_long_wq
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
References: <20260507134815.295588-1-marco.crivellari@suse.com>
 <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
 <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org>
In-Reply-To: <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/06/2026 11:20, Nikolay Aleksandrov wrote:
> On 05/06/2026 11:16, Marco Crivellari wrote:
>> Hi,
>>
>> On Thu, May 7, 2026 at 3:48 PM Marco Crivellari
>> <marco.crivellari@suse.com> wrote:
>>> [...]
>>>   net/bridge/br_fdb.c    | 2 +-
>>>   net/bridge/br_stp.c    | 2 +-
>>>   net/bridge/br_stp_if.c | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> Gentle ping.
>>
>> Thanks!
>>
> 
> Ping about what? The patch is marked as RFC so it is not
> going to be considered. It already got a reviewed-by one

err, considered to be applied

> of the maintainers, I'm ok with it too, so when sending it please add:
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Cheers,
>   Nik

