Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778441B36A
	for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798450; cv=none; b=pP+ld9j5zSoxDgYxG+Y3zLa01yqvvql7UJ0XbfSRyFmXkiWTfFSHkxR3lXnRAPC9Pr9K4aTEfURkJ6RloX1eUNOcOuWREtRVY7zjdQwqoHjo23N29cv4kAClN5L0F6sZ9+zB0bNf5eHAL93982Bdk7i9sI1VhCADPYvwQy8tf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798450; c=relaxed/simple;
	bh=LfJCPXrkCvU4eIADzu4kkxml+HubEsRZjw6OEOvo9zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK2G+XCZAdRfOa2s+iGqMOQ0505XtDHuiTL7yZH5KOAIFO4Gd3CE3EUORslbVhSslcsbChmppA8EC5DelaY/bQ5QZFmX2mCdK+1czBhS4tDrBm09kCjWD2b2oXSitMrinY8NMUV7t08A2Nl614mTxAPLK7UNB1kew9n4yVrh+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LYvgyI9H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LYvgyI9H"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso1912425e9.2
        for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784798444; x=1785403244; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1pcUHyEXTLP5ioaaGQiLm4UUcHFQIHxMWGMjnBYpmk=;
        b=LYvgyI9HDcBaiai8/3AnXYKdfDLlfT1QBBNW+2IYlr9MwR4rdGFDrZGLyj2gsmbnMG
         /jk/vXTTW/ccFUa61LENIo/LRPSnxc/nprKXUJIGs319iuG9fG1wbkyZ/XfIjN8ziIO3
         e6VL8KGsWQTQvyvpzXOTcDijUnSb8Ifn7iymJDeogT5KWTk4oWozyvUqWv7CL/gmtKml
         N17Vk0W5ilU7Fs4LkXvAPjx+vwSS6W7rdsANttxROKg1VYVQOGTb3ZjImSnjsubv0i4n
         rzCbjAtn8qDcL/7TLOu8foGnt3F1fhw5fYJQ4rQGOJqLP9c8aw8HiS9NQQqyp4m6w1vN
         nvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798444; x=1785403244;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1pcUHyEXTLP5ioaaGQiLm4UUcHFQIHxMWGMjnBYpmk=;
        b=pdYa4anP1dq+tbBtm+m94CfEmOWIT2IXjh+725P5VKUm4qtLV6GlyPUzmwGILpbEQI
         bwlIc84XPf7JQ2E4jyRJ7vlf6TCmUkKFOXpuX/o5YTzuATy8BawjZwO3+cezWqkdVRdr
         ajaQ+15BXof8T4MtE74N/J+iggOGeUlkxWTORTtV5l5O7DJ/zvlvS98DKclaybuXNzMB
         FAHw/78Ug9hawi2rkjw64aNDUApP5HCgS9eM0W4dH1vLrwwt6bNz+3DBUH3qn6efoQ81
         dxvxRfoFoOyVbvrfduAbGqqlgAFkgt1Z4H0fcD75RiWkvmJ8YJYehNY59Elc+zrBSooD
         vksQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8vxZ4TndxRdUEGvbLvwN/NJvlJaK8skyzT32dJc4AJrBzJ3+OGNrL0DoU5dkDsdB+p8QA9WU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxgF5ngefe6N090aBeabbkNlfvI17f45zVFljaG8Ok0TE+7O4J4
	KpzUN49CG/y6DqJdhan3zFQT0QsE4lYPUuMvW6uYyPNj/WdNTdLmAFIL/L7HoV+a03g=
X-Gm-Gg: AR+sD132oaYs3rZkTqCBOcXUt4ivl1qCZEbgfc0ig9RWAZB7WSxkTM+75IY3XIp2P0/
	mKU9vg2IFVMGxXEpJinZ6Y+E5XMUPc8KbX2x9JSQ1J3GvNB+HLZLKEuB9gHfPu8+s82eMMkYRt9
	wdEeXBvupHRmSFMdlf0zAq15uIGnyCAtZoFnIHaekg71X1nEkWIdON8ZPk695vGbBo9btShHMpy
	L/ocCadAPxrC0VDo5xOfpGIxBeHP+R8Vn4n0e0liBQPGbi6050zHTSMAW49sKol3aU43MEsMKoC
	RPn3QeZRpDbwjNj2hdLm7ZqRqWphu5ze02BABXar+LXVklG/n129MRwniMwsFJshOlpIWJQZnwh
	d3ag+taBlW3BQW97EyGeRhiIqTpLX4BtkDJW7ZKI1dNQuNf4M+pmDI2+6axrrt30qYhKwH3hEhc
	lS0DeIjPKX7bLyoM17VOSdCcQLkiBTDD/F
X-Received: by 2002:a05:600c:6b6a:b0:495:3f0f:d515 with SMTP id 5b1f17b1804b1-49573cf4d25mr17400085e9.36.1784798442830;
        Thu, 23 Jul 2026 02:20:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm14557268f8f.6.2026.07.23.02.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:20:42 -0700 (PDT)
Message-ID: <d27e9e6d-351f-45e6-914b-3189fb6d3fd7@blackwall.org>
Date: Thu, 23 Jul 2026 12:20:40 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6 neighbour
 suppression
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "dsahern@kernel.org" <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "ja@ssi.bg" <ja@ssi.bg>, Petr Machata <petrm@nvidia.com>,
 "fw@strlen.de" <fw@strlen.de>, "kuniyu@google.com" <kuniyu@google.com>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1784463131.git.danieller@nvidia.com>
 <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
 <SJ2PR12MB9008CFB1549DE9F3B7AC23F0D8C02@SJ2PR12MB9008.namprd12.prod.outlook.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <SJ2PR12MB9008CFB1549DE9F3B7AC23F0D8C02@SJ2PR12MB9008.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2026 09:40, Danielle Ratson wrote:
>> -----Original Message-----
>> From: Nikolay Aleksandrov <razor@blackwall.org>
>> Sent: Monday, 20 July 2026 12:31
>> To: Danielle Ratson <danieller@nvidia.com>; netdev@vger.kernel.org
>> Cc: dsahern@kernel.org; Ido Schimmel <idosch@nvidia.com>;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; horms@kernel.org; ja@ssi.bg; Petr Machata
>> <petrm@nvidia.com>; fw@strlen.de; kuniyu@google.com;
>> bridge@lists.linux.dev; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6
>> neighbour suppression
>>
>> On 19/07/2026 16:34, Danielle Ratson wrote:
>>> The bridge implements IPv6 neighbour suppression by snooping Neighbour
>>> Solicitation and Neighbour Advertisement messages, but it previously
>>> only checked the ICMPv6 type and code before acting on them. This
>>> leaves it open to acting on malformed or spoofed packets that any RFC
>>> 4861 compliant node should reject, and the option parsing in
>>> br_nd_send() open-codes a loop that has historically been a source of bugs.
>>>
>>> This series hardens and cleans up that path:
>>>
>>> Add ndisc_check_ns_na(), a standalone NS/NA validator modeled after
>>> ipv6_mc_check_mld(), implementing the RFC 4861 section 7.1.1 / 7.1.2
>>> mandatory receive checks (hop limit, checksum, code, length, target
>>> and option validation). Wire the bridge into it so NS/NA messages are
>>> validated to the same standard MLD already enjoys.
>>>
>>> Replace the manual ND option parsing loop in br_nd_send() with
>>> ndisc_parse_options() and ndisc_opt_addr_data(), and linearize the skb
>>> once it has been validated as an NS/NA message so that this and any
>>> future ND message handling operate on a linear buffer. The first patch
>>> is a small preparatory cleanup that drops the now-unnecessary
>>> skb_header_pointer() fallback from br_is_nd_neigh_msg().
>>>
>>> No functional change is intended for well-formed packets.
>>>
>>> Patchset overview:
>>> Patch #1: drop the skb_header_pointer() fallback.
>>> Patches #2-#3: add ndisc_check_ns_na() and validate NS/NA with it.
>>> Patch #4: linearize once the ND message type is validated.
>>> Patch #5: parse options via ndisc_parse_options().
>>>
>>> Danielle Ratson (5):
>>>     bridge: Use direct pointer in br_is_nd_neigh_msg()
>>>     ipv6: ndisc: Add ndisc_check_ns_na() validation helper
>>>     bridge: Validate NS/NA messages using ndisc_check_ns_na()
>>>     bridge: Linearize skb once the ND message type is validated
>>>     bridge: Use ndisc_parse_options() to parse ND options in
>>> br_nd_send()
>>>
>>>    include/net/ndisc.h          |   2 +
>>>    net/bridge/br_arp_nd_proxy.c |  54 +++++-----
>>>    net/bridge/br_device.c       |   4 +-
>>>    net/bridge/br_input.c        |   4 +-
>>>    net/bridge/br_private.h      |   2 +-
>>>    net/ipv6/Makefile            |   2 +-
>>>    net/ipv6/ndisc.c             |   1 +
>>>    net/ipv6/ndisc_snoop.c       | 190
>> +++++++++++++++++++++++++++++++++++
>>>    8 files changed, 224 insertions(+), 35 deletions(-)
>>>    create mode 100644 net/ipv6/ndisc_snoop.c
>>>
>>
>> Nice set, but I'm curious - any reason not to use EXPORT_SYMBOL_GPL()
>> instead?
>>
> 
> I guess you are referring to ndisc_parse_options and ndisc_check_ns_na?
> The reason is basically that other sibling functions used EXPORT_SYMBOL() rather than EXPORT_SYMBOL_GPL() (ndisc_send_skb, ndisc_ns_create, and the ndisc_check_ns_na() equivalent in mld, ipv6_mc_check_mld()).
> However, ndisc_send_na() for example is newer and uses EXPORT_SYMBOL_GPL(). So it might make sense to use that in ndisc_parse_options(), if you prefer.
> 

Yep, I was referring to those newly exported symbols.
Personally I'd always go for the _GPL variant when possible, but it's not a
strong preference, more a personal one. I was just curious if there was some
particular reason not to be. :)

Thanks,
  Nik

>> Cheers,
>>    Nik

