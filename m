Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A341624DD
	for <bridge@lists.linux.dev>; Fri,  4 Apr 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797513; cv=none; b=i9xsl82sSlUx96Bux9Qi/WWS7kxItNsqsNFkrhLGYYf+6Cx8jY9pcpfxOkGGGRAsrcRBXVW66kAuyRn+pZCQyuXLbTfDoXudU/DdwmvBkAK7D2MlTg5mNOgPL0Aup+vOwBeDYHk2kzXnjF+9sPCl6lnSTu57/R8Euwj3eo4qYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797513; c=relaxed/simple;
	bh=xo+k1XqCAFwqSiZtxzM/KgtkdyDu6qBF00YwywXhJwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0joO1Y2B1uNO8LH6Kn3OFTqmaDGRZNAXq6MabeZ6r/ntuKwjQQkL6Lq+AUGOiUVKD+6ggQXHWVjDpOnDGBtwgbTku/8gHpPu7N5sZWvzfnwVTA4QG10dYYRCRCzBX3heOpRzBfcTycoZZaqrP9fXs7BR5rpCUjdNTpD857Pd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLIpxiI1; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLIpxiI1"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6f666c94285so28317877b3.3
        for <bridge@lists.linux.dev>; Fri, 04 Apr 2025 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743797511; x=1744402311; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSA5uRsE0C5NOHjWvbYKWt80GNLBtJr0B40wF/Z6HSU=;
        b=mLIpxiI1PCLFQCOTUnau6oyTBbWHpnuSo0IDZKD+H5/wcF4Uzo/DHEDo3rreZQR3IU
         wBLGuRzFVtvp6QFwLjbB0Q5CwW59u3kBdgvt8PBje6dR49rCYkZwjzcfZGoFhP8ZFaHz
         m9QAzagSK5wNLZwx05GNS/MJNjGUVPjyfPM6Tcetd4b5a9EYxwnPhv/rp5SVAuec0pCe
         KurDxEuQZws/mIEwHCqZkYEldwoQtJgA/U1caqwZ2OUBddwlbUcmD9tjgvkCxe1O4mZU
         Gt7Ipz4MbNEbUGBgAN98LK1WMz2HAB8LKYshoDPqR0pqlhzG51kBGn/HhaZk7ht6SarP
         FI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797511; x=1744402311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSA5uRsE0C5NOHjWvbYKWt80GNLBtJr0B40wF/Z6HSU=;
        b=sSut4CREq1vH6MGpyAAaZuB+AVx50xTeWK749j9rxE0pMF7IcHSI+7lb3sCVc4Cmw1
         otnKJ6mDiQ40RY71y+8bvSX1XKuLwUS9LZzNm2hkAII6uFX2Viihn86jT4at4fEP++tb
         VwfUq+0UOFrc5OsOmuUSP7rtWLLEMPzs1SOTblWTVr5iPCuE8g0ShsvcWxHTS7Mmiz8m
         zPYeDkH+iTfo/n7Hv7Iqf2713HiVPuorGG7cNRqyin2KVun7UCZwT4jetTOYn4kterOr
         NLrwMMaSTGXf1ZKXZCozSo5XQLdvKDscjNrqQlN5tv7xzi2sigHGvHNc6LCgvkYigxQ9
         YsAg==
X-Forwarded-Encrypted: i=1; AJvYcCUqqV2CBg6hU+PFXpDzpxfI8/c35o57x6NWsLSoRhf7+IquBkYMPxdCTvMvp52gAqig7VhOq4g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2XXAMXIUZPTMRjEqEtB1ssQBBW35M06LaZRUK1Q5Q04K9/NXf
	AlcadI7OWWqIpoUmph0FUkziTqhqszQrHe56yIbOilYbVsyVwWZi
X-Gm-Gg: ASbGncuTOB81P2VIugQ6wyJjFs2+W49jpEMHs+WnZ9MuIo6jonY2Uh8AvK2Zro/9MEY
	DI+o3mL5mTmE6Sj3obHJGssHC5ntdYj/rcUPA4cPNf2Qm6E+mxExG6tILxFjL3nPfAFq8IRNVY7
	sg6t3fLFDYmimleRpFXX+d6MLsendhSAkXCwGhmhgZ/OWFapgZEBjU+87HBWKmji9dEKY2Q7C2p
	I2gyMQskpxYAMd0IKtehMfrILqlb/skulI7y79tiCFY2m3a4R1FPMJgnyFVP/3NYxOw3oxcnc1k
	3KDraFrgpqv0tdOh8QrP6GfK1y04s6YVDbvBluK9lV0FxWJQmk1oPxNFrbR50E0kZeM=
X-Google-Smtp-Source: AGHT+IFvu+fFNrQn76ol4gsVEODHZphUpWaMek5ObX18b+ke75B35G87/TomGwuHzuRE8BuuBtBPuA==
X-Received: by 2002:a05:690c:18:b0:703:afd6:42b0 with SMTP id 00721157ae682-703f3fa8362mr11933207b3.0.1743797511009;
        Fri, 04 Apr 2025 13:11:51 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e2ed05sm10597317b3.18.2025.04.04.13.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:11:50 -0700 (PDT)
Message-ID: <9e7f6c4c-cabe-46e9-b59f-6638b4ae25e3@gmail.com>
Date: Fri, 4 Apr 2025 16:11:50 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-4-Joseph.Huang@garmin.com>
 <36c7286d-b410-4695-b069-f79605feade4@blackwall.org>
 <917d4124-c389-4623-836d-357150b45240@gmail.com>
 <abb9e2c1-c4b5-4ffa-b2e3-8b204da5efca@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <abb9e2c1-c4b5-4ffa-b2e3-8b204da5efca@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/2025 4:04 PM, Nikolay Aleksandrov wrote:
> On 4/4/25 18:25, Joseph Huang wrote:
>> On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
>>> On 4/4/25 02:44, Joseph Huang wrote:
>>>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>>>> is set.
>>>>
>>>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>>>> ---
>>>>    net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>>>    net/bridge/br_private.h   |  9 +++++++++
>>>>    net/bridge/br_switchdev.c |  4 ++++
>>>>    3 files changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>
>>> The patch looks good, but one question - it seems we'll mark mdb entries with
>>> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
>>>
>>> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
>>> to the non-switch ports as offload failed, but it is not due to a switch offload
>>> error.
>>
>> Good catch. No, that was not intended.
>>
>> What if we short-circuit and just return like you'd suggested initially if err == -EOPNOTSUPP?
>>
>>>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>>>> index 40f0b16e4df8..9b5005d0742a 100644
>>>> --- a/net/bridge/br_switchdev.c
>>>> +++ b/net/bridge/br_switchdev.c
>>>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>        struct net_bridge_mdb_entry *mp;
>>>>        struct net_bridge_port *port = data->port;
>>>>        struct net_bridge *br = port->br;
>>>> +    u8 old_flags;
>>>>    
>>
>> +    if (err == -EOPNOTSUPP)
>> +        goto notsupp;
>>
>>>>        spin_lock_bh(&br->multicast_lock);
>>>>        mp = br_mdb_ip_get(br, &data->ip);
>>>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>            if (p->key.port != port)
>>>>                continue;
>>>>    +        old_flags = p->flags;
>>>>            br_multicast_set_pg_offload_flags(p, !err);
>>>> +        if (br_mdb_should_notify(br, old_flags ^ p->flags))
>>>> +            br_mdb_flag_change_notify(br->dev, mp, p);
>>>>        }
>>>>    out:
>>>>        spin_unlock_bh(&br->multicast_lock);
>>>
>>
>> + notsupp:
>>      kfree(priv);
> 
> Looks good to me. Thanks!

Thanks for the review!

And a logistic question. Now that part 1 and part 2 are ack'd (thanks 
again for the review), when I send out v3, should I resend those 
(unmodified part 1 and part 2) with my v3 patch series, or should I 
break this one off and only send part 3 v3 as a separate patch?

Thanks,
Joseph
