Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D05548FE
	for <bridge@lists.linux.dev>; Thu,  4 Apr 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270423; cv=none; b=DuxKJTGIt3GtIcY8Wz8EBiUmmh8j+kTitctONv+HfSv/YnzWEaO07iBwN/CaMoc3rd/oRaCUbBk4Abz1SCQ85zVEUoi4sWmsFeq/+Eywz23iJec24KJgZjPZUhMBBYKHGlpRfcjdHdJsmjEF6Ftty01AXBe0VBUIV0Cb5KUrCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270423; c=relaxed/simple;
	bh=vLERf+QX8KSMy6XI9NM+WgxZKTUBvVsma1I4xDMcYG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHJv/BZqmKvnUX1UZhmXMbl5vgNmjlszGqUZzO+D+qwbSsXDc8IDgYvXG4Ua7grXDwBxF/ce/RgVYS1fdSZSML1QlvlD9W3Tw7vudG8S+P0BFkTUwQaRTWRe6MnWl6rT/3P2ugS49nAbQgYbOzOw6jCRxwIoPxjaPjfZxvisuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrGLfdqt; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrGLfdqt"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6151e2d037dso18071547b3.3
        for <bridge@lists.linux.dev>; Thu, 04 Apr 2024 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712270420; x=1712875220; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnTW/weWTTG76gH50ECa2RV3vqrObly16JkLYAmVgOQ=;
        b=TrGLfdqtRXgMwGSS3SEzJ3h9rcZXuqp9Yf8WwcrtgNYgEi2wz7xWA0WKGrkYfSNUi+
         VHWL0eXTBj/HjTHlIIARWW7+hqwXcnsyzJVqxOXAz6LyQMV6AKGpeXtunqnPO+4Hal0X
         W1gCNG4eT5JGq3cuXPCDbM1hPiAGwVl4auJhp7ui/YTPEmNXleGIoB10OIWLP9uDIdE9
         QiVj4ceOTE8otAKZjLsWQ/V0oaFUpKVuu3sgyC+AyNMfYarJ5bVFdHWRVMLdG71OTcI8
         R3n/GRhBeFXGF7M9lQPAd03hEc1BKHbstJB5ln+FRlvbR9BX5pQz6tqUxGYOqvYZW1EA
         Atog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712270420; x=1712875220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnTW/weWTTG76gH50ECa2RV3vqrObly16JkLYAmVgOQ=;
        b=xAvaRSwfK4vsX3a9yE7B+G3mWKvMRwVRPzTqv/NVY83aHtPeA6YBqVSBFbSUchb1WI
         kYGObfl3LJYTBC+C9rPj5hvjLoPXGaQoMzqNcSe4wIxd4hB7PXhoe+QQt9e2JC2nwcPR
         UBjCMwj5Efom9Sya8qyTypUxVlv8gkvzN7ZKOB80pULiCAVsIvlJxQYq+4ydfQxkTzGV
         dmmmGHtIH0sgBIgzGV2w5KBN4NiAknS8EvxNaV5BHhk/hKlMc8LzNIcqxX5zsyw0x9VY
         4Uk6mr7i0grEekXm0EbSP7xf4KbxfZRacE+KcSsGrh67bn3IDAxmZ5D022W7fMMfjuYM
         SWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwiizduvpVK8FpRzk++/m278+XQYOupTDfYdAUgQsVtxS7WeJuhdTVKw3VrqxZMWXBG0hIEHpeKeF3QiL0JQjwM+ZO63lu
X-Gm-Message-State: AOJu0YwXxOVEjMhauEXoVBsZm1ZCfGW89j5CFU8RGGOPze5uRpxNEiv/
	0Snls0SZ7787AE9Jrc6yzEU0CBbI0DFBv6jUWIHbGZyyrns3BrdO
X-Google-Smtp-Source: AGHT+IEjof9G6y/blJK7Ac3hvK4D8knpxecWVEsAJ9CXikvry9ZyxDVsK/tNVpl/erf/Jofapl2Kzw==
X-Received: by 2002:a81:6055:0:b0:615:d7e:eb2 with SMTP id u82-20020a816055000000b006150d7e0eb2mr3721838ywb.16.1712270420524;
        Thu, 04 Apr 2024 15:40:20 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id k34-20020a81ac22000000b006153f151dfdsm89704ywh.86.2024.04.04.15.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 15:40:19 -0700 (PDT)
Message-ID: <2c3cddda-7ac6-4fc2-b1fa-775c048259e1@gmail.com>
Date: Thu, 4 Apr 2024 18:40:19 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <f5512e7b-b572-4444-9d56-1eed9bbcda6b@lunn.ch>
 <4c28d59e-0c4f-462c-8a1c-d4bd72e25115@gmail.com>
 <630c37d6-b1c6-466b-8d00-fdc84585d5e7@lunn.ch>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <630c37d6-b1c6-466b-8d00-fdc84585d5e7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 4/4/2024 6:11 PM, Andrew Lunn wrote:
> On Thu, Apr 04, 2024 at 05:35:41PM -0400, Joseph Huang wrote:
>> Hi Andrew,
>>
>> On 4/2/2024 8:43 AM, Andrew Lunn wrote:
>>> On Mon, Apr 01, 2024 at 08:10:59PM -0400, Joseph Huang wrote:
>>>> There is a use case where one would like to enable multicast snooping
>>>> on a bridge but disable multicast flooding on all bridge ports so that
>>>> registered multicast traffic will only reach the intended recipients and
>>>> unregistered multicast traffic will be dropped. However, with existing
>>>> bridge ports' mcast_flood flag implementation, it doesn't work as desired.
>>>>
>>>> This patchset aims to make multicast snooping work even when multicast
>>>> flooding is disabled on the bridge ports, without changing the semantic of
>>>> the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.
>>>>
>>>> Also, in a network where more than one multicast snooping capable bridges
>>>> are interconnected without multicast routers being present, multicast
>>>> snooping fails if:
>>>>
>>>>    1. The source is not directly attached to the Querier
>>>>    2. The listener is beyond the mrouter port of the bridge where the
>>>>       source is directly attached
>>>>    3. A hardware offloading switch is involved
>>>
>>> I've not studied the details here, but that last point makes me think
>>> the offload driver is broken. There should not be any difference
>>> between software bridging and hardware bridging. The whole idea is
>>> that you take what Linux can do in software and accelerate it by
>>> offloading to hardware. Doing acceleration should not change the
>>> behaviour.
>>>
>>
>> In patch 10 I gave a little more detail about the fix, but basically this is
>> what happened.
>>
>> Assuming we have a soft bridge like the following:
>>
>>              bp1 +------------+
>>    Querier <---- |   bridge   |
>>                  +------------+
>>                 bp2 |      | bp3
>>                     |      |
>>                     v      v
>>              MC Source    MC Listener
>>
>> Here bp1 is the mrouter port, bp2 is connected to the multicast source, and
>> bp3 is connected to the multicast listener who wishes to receive multicast
>> traffic for that group.
>>
>> After some Query/Report exchange, the snooping code in the bridge is going
>> to learn about the Listener from bp3, and is going to create an MDB group
>> which includes bp3 as the sole member. When the bridge receives a multicast
>> packet for that group from bp2, the bridge will do a look up to find the
>> members of that group (in this case, bp3) and forward the packet to every
>> single member in that group. At the same time, the bridge will also forward
>> the packet to every mrouter port so that listeners beyond mrouter ports can
>> receive that multicast packet as well.
>>
>> Now consider the same scenario, but with a hardware-offloaded switch:
>>
>>                  +------------+
>>                  |   bridge   |
>>                  +------------+
>>                        ^
>>                        |
>>                        | p6 (Host CPU port)
>>           p1/bp1 +------------+
>>    Querier <---- |     sw     |
>>                  +------------+
>>              p2/bp2 |      | p3/bp3
>>                     |      |
>>                     v      v
>>              MC Source    MC Listener
>>
>> Same Query/Report exchange, same MDB group, except that this time around the
>> MDB group will be offloaded to the switch as well. So in the switch's ATU we
>> will now have an entry for the multicast group and with p3 being the only
>> member of that ATU. When the multicast packet arrives at the switch from p2,
>> the switch will do an ATU lookup, and forward the packet to p3 only. This
>> means that the Host CPU (p6) will not get a copy of the packet, and so the
>> soft bridge will not have the opportunity to forward that packet to the
>> mrouter port. This is what patch 10 attempts to address.
>>
>> One possible solution of course is to add p6 to every MDB group, however
>> that's probably not very desirable. Besides, it will be more efficient if
>> the packet is forwarded to the mrouter port by the switch in hardware (i.e.,
>> offload mrouter forwarding), vs. being forwarded in the bridge by software.
> 
> Thanks for the explanation. So i think the key part which you said
> above is:
> 
>    At the same time, the bridge will also forward the packet to every
>    mrouter port so that listeners beyond mrouter ports can receive that
>    multicast packet as well.
> 
> How does the bridge know about the mrouter port? It seems like the

The bridge learns about the existence of the Querier by the reception of 
Queries. The bridge will mark the port which it received Queries from as 
the mrouter port.

> bridge needs to pass that information down to the switch. Is the

The bridge does pass that information down to switchdev. Patch 5 adds 
DSA handling of that event as well. Patches 9 and 10 adds the support in 
the mv88e6xxx driver.

> mrouter itself performing a join on the group when it has members of
> the group on the other side of it?

You hit a key point here. The Querier does not send Report (not with 
IGMPv2 anyway), so the bridge will never add the mrouter port to any MDB 
group. That's why patch 10 is needed. Prestera driver does something 
similar (which is what patches 6,7, and 10 are modeled after).

> 
> 	Andrew


