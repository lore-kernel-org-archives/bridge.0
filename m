Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A82208E
	for <bridge@lists.linux.dev>; Thu,  2 May 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714682240; cv=none; b=tGJ+cAzzQJCHEAXdGHf0nGhQlnCNa9eRsXpeqEqJvHJP2ddcSq329AYYiHiviwojJKa17rluvFDukuPEne4DTFDxVFFE3GR0UWwr63SpGmEhoHvmZddsTQ89H6OC2YeVKIlE/DSimsRNbLmOQQ8QhKi+AlLjYubJ77+ttlpfE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714682240; c=relaxed/simple;
	bh=2k7OPTWw2B8a6AN3gHmY8q9bPGj8mN1RIq+lrkfxLGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cuRStAcFSARo5PKyx97Xfb3jME7kiUvowIQ2Zm5YHIV+L4bmnn0NyDDzT1KrwcOBfw3KKNyDIgEYw5V2sNQX2FThRIFBwXPgWlrbpJLJ6Z0nPKd6EuvAfRmkngMzMr7XmJA0gBCx1wy6OFeMQjJWrC5vHSJqHpb1M1CUvHS+YuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW0npivz; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW0npivz"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-61b4cbb8834so83994687b3.0
        for <bridge@lists.linux.dev>; Thu, 02 May 2024 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714682238; x=1715287038; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NKIW82xynE28sXh1illyNkxP3ipnCGT4+/So5MYXvsk=;
        b=bW0npivzOLtHjrukPPOEgOniDbRAkheWFUmJfDfginzE/NUMFs9dQDcThRib0yzGFl
         MnEBWiXbpiROfbZ+RXTxj+I5/eLvaqjAtGdEQOLm1WWygtPGdLIdwmDwWJ+Fxm1y0jd8
         O+jyUExoYLPbnOQ/fILspeFAxKFhNdi/D5eVJI7GEOEEWx0ccWZyMN4oU3Hzn53OEhv9
         M7uKOyf05b3/uw53JhTKJ17y7xdgwkwKSvuArDR/Tg0XpLdWbD0l94tgayzLxA8/IRro
         l1ZdEg6wEy0r6N19wBOtZbUWOQEnpAAsewyWp6bhjZITTqdLaYdEt+7xyWzikaiJGyXv
         3d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714682238; x=1715287038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKIW82xynE28sXh1illyNkxP3ipnCGT4+/So5MYXvsk=;
        b=pcaFsiRKKd5uFhQbqlsSg3XzPFh5dGFCwbeO/oJvkq6RcYrScUrHygvKgmxEB280TI
         fYlaYJp8VYFd1uELB/wc5YM3S0LZui4udB4QaF6ZJS2rXGX9f4PswMJinNoMIVIzWFWy
         i/t1DZlgAvGnVBz1mTWBIS5yyHjzGJCgVGSsU7wcZE+B86AqNEryZHqibvt8A1b49D1W
         2ZfC0XMQXGAcyjlv8D72hDGM/7lHmYgFsclQ2bY1S9Er5ZXYE9qgQPLPYTZOT4SUL6+r
         FRkmoJL0O2Kwym0lxJ0UzNsddaprS03pWlT9Gle9CZO6VCNvgWYdnzMg8eFyEKNQx5kU
         3t9A==
X-Forwarded-Encrypted: i=1; AJvYcCXoks/PO/GheBOkV7iFy0kjI4/0w75Q1QXdShM0BwpwmGfNKmau91ShAg55c7lZGEh8g3frQxNlU9TIoJBurQfnrpaUl0qY
X-Gm-Message-State: AOJu0YxRy7kDEQAlgoQs6Kj1klPneVxJUBQOgh+nKmjSHgVO16jVGnZf
	PIILBDijeu3/2s02JahM8BQVRcaxcyQU4olz2i+VF5sAJnEbrPrW
X-Google-Smtp-Source: AGHT+IEk0Vq7nvkUegRQmJTtiriFRc550xlqBzFlsS1gfiw5ChBAOgoZ4cC+qmr28IgjTicQEreA/Q==
X-Received: by 2002:a81:7303:0:b0:61b:bd65:3025 with SMTP id o3-20020a817303000000b0061bbd653025mr778076ywc.40.1714682237736;
        Thu, 02 May 2024 13:37:17 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id k14-20020a81ac0e000000b0061be24994e6sm375355ywh.30.2024.05.02.13.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 13:37:17 -0700 (PDT)
Message-ID: <85cb2625-7bac-45cd-af31-0d114253e6e4@gmail.com>
Date: Thu, 2 May 2024 16:37:16 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
From: Joseph Huang <joseph.huang.2024@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
 <20240405110745.si4gc567jt5gwpbr@skbuf>
 <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
 <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>
 <20240430005949.44lcegwhmcetpddm@skbuf>
 <f5ca9b38-3729-49a1-b221-fcc3aecba5d6@gmail.com>
Content-Language: en-US
In-Reply-To: <f5ca9b38-3729-49a1-b221-fcc3aecba5d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/30/2024 12:27 PM, Joseph Huang wrote:
> On 4/29/2024 8:59 PM, Vladimir Oltean wrote:
>> On Mon, Apr 29, 2024 at 06:07:25PM -0400, Joseph Huang wrote:
>>> Something like this (some layers omitted for brevity)?
>>>
>>>                                        +br_iterator
>>>                                        |  for each mdb
>>>                                        |    _br_switchdev_mdb_notify
>>>  rtnl_lock                             |      without F_DEFER flag
>>>   |                                    |      |
>>>   +switchdev_port_attr_set_deferred    |      +switchdev_port_obj_notify
>>>     |                                  |        |
>>>     +dsa_port_mrouter                  |        +dsa_user_port_obj_a/d
>>>       |                                |          |
>>>       +mv88e6xxx_port_mrouter----------+          
>>> +mv88e6xxx_port_obj_a/d
>>>                                          |
>>>   +--------------------------------------+
>>>   |
>>> rtnl_unlock
>>
>> At a _very_ superficial glance, I don't think you are properly
>> accounting for the fact that even with rtnl_lock() held, there are still
>> SWITCHDEV_OBJ_ID_PORT_MDB events which may be pending on the switchdev
>> chain. Without a switchdev_deferred_process() flush call, you won't be
>> getting rid of them, so when you rtnl_unlock(), they will still run.
>>
>> Even worse, holding rtnl_lock() will not stop the bridge multicast layer
>> from modifying its br->mdb_list; only br->multicast_lock will.
>>
>> So you may be better off also acquiring br->multicast_lock, and
>> notifying the MDB entries to the switchdev chain _with_the F_DEFER flag.
> 
> Like this?
> 
>                                        +br_iterator(dsa_cb)
>                                        |  lock br->multicask_lock
>                                        |  for each mdb
>                                        |    br_switchdev_mdb_notify
>  rtnl_lock                             |      |
>   |                                    |      +switchdev_port_obj_._defer
>   +switchdev_port_attr_set_deferred    |  unlock br->multicast_lock
>     |                                  |
>     +dsa_port_mrouter                  |
>       |                                |
>       +mv88e6xxx_port_mrouter----------+
>                                          |
>   +--------------------------------------+
>   |
> rtnl_unlock
> 
> (potential task change)
> 
> rtnl_lock
>   |
>   +switchdev_deferred_process
>   | flush all queued dfitems in queuing order
>   |
> rtnl_unlock
> 
> I'm not that familiar with the bridge code, but is there any concern 
> with potential deadlock here (between rtnl_lock and br->multicast_lock)?

Hi Nik,

Do you know if it's safe to acquire rtnl_lock and br->multicast_lock in 
the following sequence? Is there any potential possibility for a deadlock?

rtnl_lock
spin_lock(br->multicast_lock)
spin_unlock(br->multicast_lock)
rtnl_unlock

If the operation is safe, the next question is should it be spin_lock or 
spin_lock_bh?

Thanks,
Joseph

