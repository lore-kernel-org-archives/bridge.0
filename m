Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE715EFDA
	for <bridge@lists.linux.dev>; Fri,  5 Apr 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348568; cv=none; b=nWGJ6A6tpSymtsE7SyyHIn7Li0UNFjCheD30/DbsgeYvxaPKmsgPzaCBVK2KLoDXOM836/WDwoSadDZfYYaYFpJif7xrlb0huy9GGtSHxDx5O4MNiGT0ccRS+xQb1xfNDBCEYvOL+zPvB/uyxGOnYqaAZQqv7fj7T/MQiiyato0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348568; c=relaxed/simple;
	bh=/c7g36rtE40BDeZV1S/AlcHS7dY6Xj4ExtPGgjvBAJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQLLnS6PQY5nswlNehf4XDnrCWpo3/IjA3xFDKR4oSR7JIhN7t3GDhYOyijCBRU8nXuDJkb4LWeE4KpKkH9hw3K/69qU+W2Yx4F86RCB5qV5VTgNjs33MP4yblGucHQJRWSwDyEBNBmMK9AW2J7DPIh8xgbY1hIKcMZwbbeDLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TohefDLJ; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TohefDLJ"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6156483284fso28320827b3.0
        for <bridge@lists.linux.dev>; Fri, 05 Apr 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712348565; x=1712953365; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uO9sL7m4DMsIKcxtkPkEJUbu4NEoxIAppzIfnBTObw=;
        b=TohefDLJAJ8ln8IOV8zIT2ykF2wHbbUoiD5NDqCFBBo0FKVUpPjh/618yFCE2qQ7zE
         4fUDXycRu5LQg/NMHZfyi2zDq51MO+UQiSYTcpePF+tHhOogihKJw9C9GpxSUU2l2RU8
         2ujJniHw71yHywlHNnFr8rIRrQ+bwXyyvcemAfqTmLMUDYKuVuiqcIxmlCP5x/LwyJbI
         udveBHmKZCgSnLrMZdAtmjUnOqUiBvDkVMjhD4djwqRcjzO1yv2XAbBHR8P2fbiUsUDQ
         WEQPpS+/ahu6uiOndQXYePu7x7bi+0klq3lYJw41kcDsvyZCkGY6wShK0Q6nlp+YHbYM
         JQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712348565; x=1712953365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uO9sL7m4DMsIKcxtkPkEJUbu4NEoxIAppzIfnBTObw=;
        b=XyoK3H9JP8Mx+yje/X3aklYWQ+vEsg5Af1EVjPFkCZfpr0WsuLbsfoG1gj7OPSrU+I
         oHFczWZC46bXt8+KnSb0ZAloQAXBIeYJ77vgvmKcsp6u+Mnte6011p/nj648gSIR+EWn
         6MeT4fzdGqn5BjkxqIOnhjbfIc5yF0YcG+9sZBMg4m3j30Lnfjr3KN8EicT2jhGpE1a8
         4XaQWWYJ7jl2jWCQeYm5dHacIsRvB+R9JP5k0S1cSU/jfY3km98TvJPUB9c8Ri9UHRpv
         Ta8qbk1aTgTM/lYifxGsv3+slGOrAo5QyCmc8LUaPsskeLOXlrjKim83qZLxt/k5xYMG
         mVfg==
X-Forwarded-Encrypted: i=1; AJvYcCV1NKxvlYIiwQkADAbrH1742kEC2w5pH1Z6U88kfNOJ0G8wB8cU1l82FY71hJoMXEZfAIMvIo4B3g4DY13MjHLXpRRHKam0
X-Gm-Message-State: AOJu0YzTvaUlS59S1RAa6DPb7781IPxxku7/ygFfE6/+kKf34Gr/stl+
	HcCmPlJBnPKb2uAJn9z/EZUdzg8Mys4tzjuZgU7J3Cep4K1CUvlF
X-Google-Smtp-Source: AGHT+IH/fk1YAwa90MOBxgFnsa+3wbT2P6MSx+PBNEyLZqpyED42kh5pJENTlsy6ODPjOmgWmKoDIA==
X-Received: by 2002:a0d:d9d1:0:b0:615:1413:95c1 with SMTP id b200-20020a0dd9d1000000b00615141395c1mr2510706ywe.19.1712348564458;
        Fri, 05 Apr 2024 13:22:44 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id x11-20020a81b04b000000b006155d6134dasm501309ywk.141.2024.04.05.13.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 13:22:44 -0700 (PDT)
Message-ID: <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
Date: Fri, 5 Apr 2024 16:22:43 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/2024 7:00 AM, Nikolay Aleksandrov wrote:
> On 4/5/24 13:20, Vladimir Oltean wrote:
>> On Thu, Apr 04, 2024 at 06:16:12PM -0400, Joseph Huang wrote:
>>>>> mcast_flood == off:
>>>>> - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
>>>>> - mcast_ipv4_data_flood: don't care
>>>>> - mcast_ipv6_ctrl_flood: don't care
>>>>> - mcast_ipv6_data_flood: don't care
>>>>> - mcast_l2_flood: don't care
>>>>> mcast_flood == on:
>>>>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>>>>> - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
>>>>> - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
>>>>> - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
>>>>> - Flood L2 according to mcast_l2_flood
>>>
>>> Did you mean
>>>
>>> if mcast_flood == on (meaning mcast_flood is ENABLED)
>>> - mcast_ipv4_ctrl_flood: don't care (since 224.0.0.x will be flooded 
>>> anyway)
>>> ...
>>>
>>> if mcast_flood == off (meaning mcast_flood is DISABLED)
>>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>>> ...
>>>
>>> ? Otherwise the problem is still not solved when mcast_flood is 
>>> disabled.
>>
>> No, I mean exactly as I said. My goal was not to "solve the problem"
>> when mcast_flood is disabled, but to give you an option to configure the
>> bridge to achieve what you want, in a way which I think is more 
>> acceptable.
>>
>> AFAIU, there is not really any "problem" - the bridge behaves exactly as
>> instructed given the limited language available to instruct it 
>> ("mcast_flood"
>> covers all multicast). So the other knobs have the role of fine-tuning
>> what gets flooded when mcast_flood is on. Like "yes, but..."
>>
>> You can't "solve the problem" when it involves changing an established
>> behavior that somebody probably depended on to be just like that.
>>
>>>> Yep, sounds good to me. I was thinking about something in these lines
>>>> as well if doing a kernel solution in order to make it simpler and more
>>>> generic. The ctrl flood bits need to be handled more carefully to make
>>>> sure they match only control traffic and not link-local data.
>>>
>>> Do we consider 224.0.0.251 (mDNS) to be control or data? What 
>>> qualifies as
>>> control I guess that's my question.
>>
>> Well, as I said, I'm proposing that 224.0.0.x qualifies as control and
>> the rest of IPv4 multicast as data. Which means that, applied to your
>> case, "mcast_flood on mcast_ipv4_ctrl_flood on mcast_ipv4_data_flood off"
>> will "force flood" mDNS just like the IGMP traffic from your patches.
>> I'm not aware if this could be considered problematic (I don't think so).
>>
>> The reason behind this proposal is that, AFAIU, endpoints may choose to
>> join IGMP groups in the 224.0.0.x range or not, but RFC4541 says that
>> switches shouldn't prune the destinations towards endpoints that don't
>> join this range anyway: https://www.rfc-editor.org/rfc/rfc4541#page-6
>>
>> Whereas for IP multicast traffic towards an address outside 224.0.0.x,
>> pruning will happen as per the IGMP join tracking mechanism.
> 
> +1, non-IGMP traffic to 224.0.0.x must be flooded to all anyway
> so this should allow for a better control over it, but perhaps
> the naming should be link_local instead because control usually
> means IGMP, maybe something like mcast_ip_link_local_flood
> 

Like this?

bridge link set dev swp0 mcast_flood off
   - all flooding disabled

bridge link set dev swp0 mcast_flood on
   - all flooding enabled

bridge link set dev swp0 mcast_flood on mcast_ipv4_data_flood off 
mcast_ipv6_data_flood off
   - IPv4 data packets flooding disabled, IPv6 data packets flooding 
disabled, everything else floods (that is to say, only allow IPv4 local 
subnet and IPv6 link-local to flood)

?

The syntax seems to be counterintuitive.

Or like this?

bridge link set dev swp0 mcast_flood on mcast_ipv4_ctrl_flood on
   - only allow IPv4 local subnet to flood, everything else off

?

So basically the question is, what should the behavior be when something 
is omitted from the command line?
