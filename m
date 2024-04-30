Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9522180A78
	for <bridge@lists.linux.dev>; Tue, 30 Apr 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496472; cv=none; b=ATpfHNQ7M60OYkqCCXY4dWmRIbDNXaUQ6AEs/Vzw58MIYcZQAxPfhJ+uIMtsHeF4GCNPiep0RU3pzu4PiwO8L0CLZpSuqAO3S0A22dvMfsNwv5zrNnPAeu5ZNCb9g9APDppEamFDVDaSyJHTPvoumaFk1Wmr4TbDhwmUFxbiGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496472; c=relaxed/simple;
	bh=/hfseXbWrHSrt8y1mxI48f9ERs61F3BThMzjLWyNR6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juqJRVz2vNGAq+Ib7BRf2HYkc7NXIZ+kV1Vgi64J63PaxW9T6bfbIdxz6ugNIEzxiT1+8PdvC+aH9iOrzYBzc14bhetnx3zgeGqJss4YsIjmZeFPLbYSx77CnD42JYyFyiuBN+vMiq7tFjsVdgyyOhw4bSgT0GcROPqF0Hv4fZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNsin8In; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNsin8In"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-61ab31d63edso129167b3.1
        for <bridge@lists.linux.dev>; Tue, 30 Apr 2024 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714496470; x=1715101270; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsLnyG7voovmGuriZTP3Tq6cIlUoQEoRoHNx1oOzEiQ=;
        b=QNsin8InGPyuA7qW8L5ilJrnohOD+uh8xu/WRV98FWs3STqB3HTAE0ALJ953rI1pNt
         cwDZfBIK4lOt7pft1gwStl6j/U3x8hsACNKIdOKLsbZ4JL9D6c70n2wIoTJfQSDQ8x+/
         4hHsJ2aqvvxau5SvzfxLNkvrDt0zFH1jAKTvN9DMUJNGfBYu6UsaAvP8SGNqzo88+Io4
         2IK25md4hZx3WPI2uQXrl+orvWryJCBvwRYbsaIUx05XdjLcio4CbuVHX2raoDOYe9oc
         ITHJxcgDP8hiXXT4D8q9G2o88tL30rhQd5+1nhoz5X5XEMIbkK0KIhcSJ9+ZIE5HxABI
         QHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714496470; x=1715101270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsLnyG7voovmGuriZTP3Tq6cIlUoQEoRoHNx1oOzEiQ=;
        b=AqNpTNued8q61YUHSopPM471sf1G02cDhUUBN4ebZmac1XHG4tmxWy7hCwxVvlq2s2
         /3D6qnAEgki3BMSe8eRG4n45PeKH/XZnb7KRAZzDuIq8WPMajW/Fm6g2x5mYDgM564rQ
         CDU1Jl7Orm7GVjyAJ6V90e5R9el0YFygiPGdi2Dz8KwtHqtYqgCvlyb5ynyc2ulO3N10
         8SIf01Ar6b41QUi5hw1g/GKBiDBBmS1SU0gYkyjAZWW0RGOo8UqHGIiWSJdTgekNPL/8
         NxWz8XHxhLXIt/2YagEEmxjpOkh5k4ULOqZPa8Lpxm35AQQmiSlCaMspA9wfisVOCSmb
         SMBw==
X-Forwarded-Encrypted: i=1; AJvYcCUMkWJdyAvNSbzYaPDINg6an9AN7lNEUXQO2Barlabc6SJBuPcBwk3CIUmoMK5bz323689whKMPoi3uord0boiS/5zJ/cO8
X-Gm-Message-State: AOJu0Yw8UgoGJmFqggdRd8I6lbCD8iiAWtXcsu5/jcZbz5zRED8HryQF
	oV88jRrKxYMfi/WRPIQrU5jCMGWIeS/DMdqg4kptQQwGirHDkUNk
X-Google-Smtp-Source: AGHT+IE+kb9HMLrlKxh6WjSxd75XtYt2UlpyAMcfpWeLW+RsJ29tXl9e8/cEdCSurYSIDMPS1JdTwQ==
X-Received: by 2002:a81:83ce:0:b0:615:73f:d52d with SMTP id t197-20020a8183ce000000b00615073fd52dmr2467145ywf.17.1714496469850;
        Tue, 30 Apr 2024 10:01:09 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id o13-20020a0dcc0d000000b0061bec63c153sm293362ywd.138.2024.04.30.10.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 10:01:09 -0700 (PDT)
Message-ID: <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
Date: Tue, 30 Apr 2024 13:01:08 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
 <20240430012159.rmllu5s5gcdepjnc@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240430012159.rmllu5s5gcdepjnc@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/2024 9:21 PM, Vladimir Oltean wrote:
> On Mon, Apr 29, 2024 at 04:14:03PM -0400, Joseph Huang wrote:
>> How about the following syntax? I think it satisfies all the "not breaking
>> existing behavior" requirements (new option defaults to off, and missing
>> user space netlink attributes does not change the existing behavior):
>>
>> mcast_flood off
>>    all off
>> mcast_flood off mcast_flood_rfc4541 off
>>    all off
>> mcast_flood off mcast_flood_rfc4541 on
>>    224.0.0.X and ff02::1 on, the rest off
>> mcast_flood on
>>    all on
>> mcast_flood on mcast_flood_rfc4541 off
>>    all on (mcast_flood on overrides mcast_flood_rfc4541)
>> mcast_flood on mcast_flood_rfc4541 on
>>    all on
>> mcast_flood_rfc4541 off
>>    invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
>> specified first)
>> mcast_flood_rfc4541 on
>>    invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
>> specified first)
> 
> A bridge port defaults to having BR_MCAST_FLOOD set - see new_nbp().
> Netlink attributes are only there to _change_ the state of properties in
> the kernel. They don't need to be specified by user space if there's
> nothing to be changed. "Only valid if another netlink attribute comes
> first" makes no sense. You can alter 2 bridge port flags as part of the
> same netlink message, or as part of different netlink messages (sent
> over sockets of other processes).
> 
>>
>> Think of mcast_flood_rfc4541 like a pet door if you will.
> 
> Ultimately, as far as I see it, both the OR-based and the AND-based UAPI
> addition could be made to work in a way that's perhaps similarly backwards
> compatible. It needs to be worked out with the bridge maintainers. Given
> that I'm not doing great with my spare time, I will take a back seat on
> that.

Nik, do you have any objection to the following proposal?

mcast_flood ->          default/    off         on
(existing flag)         missing     (specified/ (specified/
                         (on)        nlmsg)      nlmsg)

mcast_flood_rfc4541
(proposed new flag)
      |
      v
default/                flood all   no flood    flood all
missing
(off)

off                     flood all   no flood    flood all
(specified/nlmsg)

on                      flood all   flood 4541  flood all
(specified/nlmsg)                   ^^^^^^^^^^
                                     only behavior change


Basically the attributes are OR'ed together to form the final flooding 
decision.


> 
> However, what I don't quite understand in your proposal is how many IPv4
> addresses lie beyond the "224.0.0.X" notation? 256? Explain why there is
> such a large discrepancy in the number of IPv4 addresses you are in
> control of (256), vs only 1 IPv6 address with the new rfc4541 flag?

That's straight out of RFC-4541 ("coincidentally", these are also the IP 
addresses for which the bridge will not create mdb's):

2.1.2.

    2) Packets with a destination IP (DIP) address in the 224.0.0.X range
       which are not IGMP must be forwarded on all ports.

       This recommendation is based on the fact that many host systems do
       not send Join IP multicast addresses in this range before sending
       or listening to IP multicast packets.  Furthermore, since the
       224.0.0.X address range is defined as link-local (not to be
       routed), it seems unnecessary to keep the state for each address
       in this range.  Additionally, some routers operate in the
       224.0.0.X address range without issuing IGMP Joins, and these
       applications would break if the switch were to prune them due to
       not having seen a Join Group message from the router.

and

3.

In IPv6, the data forwarding rules are more straight forward because
    MLD is mandated for addresses with scope 2 (link-scope) or greater.
    The only exception is the address FF02::1 which is the all hosts
    link-scope address for which MLD messages are never sent.  Packets
    with the all hosts link-scope address should be forwarded on all
    ports.
