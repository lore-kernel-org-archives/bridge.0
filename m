Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C953398
	for <bridge@lists.linux.dev>; Fri,  5 Apr 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343495; cv=none; b=bbEKEXI+BNAYTGJ62NTJPE7ISXd63UEWbM8hrf104PSL3aezlyyCcnAo9lN99CLpYbcZodmHvigUgBbCsN5uRtRpVje50Ml0yAZ8xMSYyT+6iviSAdNykOIs2sr/ewOeH8PW1LfF1b2JmfGOD9rLIp5yiUbYF1TfCWrTKzVNg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343495; c=relaxed/simple;
	bh=TqNsEWEXLQNb5wTUaOuCY4vPYv0zMydgUQmOxvROaZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NowF5xAsZOotyJTlcwhNP5q9ht16nM9m3RkKxE0RoMRD6Hf5/JLXz6seb6saEcHpXZ/AgKv3niE25xj8yM67tyPiGSGzG1+d2rh1m5quJBuWCoO1a6NBML/ODPGWjILLFnWw6tK3kzbUK/zKR4zaXqX2yCxg7/+fThd+0yW9Odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBnWLVbS; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBnWLVbS"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-617ddc988f5so5405747b3.2
        for <bridge@lists.linux.dev>; Fri, 05 Apr 2024 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712343493; x=1712948293; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7kbTABmSB3WHGlFkXmQdklyP9Fynhg8P2k5hFgf9iM=;
        b=aBnWLVbSAtDb6Jms9LaCV5cqpv570R5P2mLSXdFG83zk862e9Vad9MCZIeZjon+uqi
         T8dMpApoRFXiHsWcNgNTnPPL05Mf++1Yie6CIfq3pWIrITE3GcMuCSo+HDHXe7DLUg+t
         t1FRCLweCwa/vU0QAmYWGDrgFV7hm4IpC2hXZ1L9HA2Ry76w5S6HxDWUtrOzVs2DW1Sc
         x/kIZodg96TY9rlv3vlFLmziKi65vlHlpWuc4LfU9iClacD4slBFkGEdvjtUvD/SUvYu
         PnJPfD645OOl0wc2+EnhdOmt4wg9+4NoMI5vK2NZZWqHE7U8CDErCb7Gbxu9yUYVJ2gk
         cRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343493; x=1712948293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7kbTABmSB3WHGlFkXmQdklyP9Fynhg8P2k5hFgf9iM=;
        b=ej1owX7x2pZoSwhSxakW7BFqm8QqA+RnCFDcjppoMGs/zZdqENi6CglPSbjIcrc2dy
         8AbkHb2UQWj9fJgUI3kof77fB+O28yKSjc+jQoYGxpqhjq7Rij4EA22cJrvyNQ+4Hhj6
         or25QVunIK/MCk/ncSu7I1L7D6FXg6YdBVruJOfyE/GxasJM/MZfvqe9TfqyCGGs4DGr
         +hUzRFQtUK9gpvzcyRfy+gz1QENSqG/MPYPl+UC1VyJCIFXSTsu71EZMIfYHPDroy910
         BQMD7QhY1V1d7BmVPsZXS3hVFZFXj6Vw2pryc+VIUGj4CbfWIgbw1wEFgEzxyAmSSs1f
         BPzg==
X-Forwarded-Encrypted: i=1; AJvYcCWlalSRbVpaasxWhruI6dpwZYB26+KArWIIy1CWhrFRgb/JryLKHC6MokfNqGQhJsksoFuSKVLXA3zPQxcSavN+259E17Iz
X-Gm-Message-State: AOJu0YyGLfnSvzsRJ3Yr+AlzIM5FAWtwWkQKI+xQ5Njc1iwASxVhNkEt
	9F/tDwHIbeMJoc5DP9Fpr0gYVnnM2TwwbX87DgkTKAmCqS+HQs1P
X-Google-Smtp-Source: AGHT+IGAUd3Bg+ii71QK/C2dpvD0uH7oCwfe2q/A6gBLAJWnZ32PJMDhQPIIPbh3ZkqKASOQNvR80A==
X-Received: by 2002:a25:a3c6:0:b0:dcc:aa1f:b418 with SMTP id e64-20020a25a3c6000000b00dccaa1fb418mr2088089ybi.1.1712343492813;
        Fri, 05 Apr 2024 11:58:12 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id i128-20020a256d86000000b00dcdbe11c243sm433140ybc.1.2024.04.05.11.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:58:12 -0700 (PDT)
Message-ID: <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
Date: Fri, 5 Apr 2024 14:58:11 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
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
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240405110745.si4gc567jt5gwpbr@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On 4/5/2024 7:07 AM, Vladimir Oltean wrote:
> On Thu, Apr 04, 2024 at 04:43:38PM -0400, Joseph Huang wrote:
>> Hi Vladimir,
>>
>> On 4/2/2024 8:23 AM, Vladimir Oltean wrote:
>>> Can you comment on the feasibility/infeasibility of Tobias' proposal of:
>>> "The bridge could just provide some MDB iterator to save us from having
>>> to cache all the configured groups."?
>>> https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/
>>>
>>> What is done here will have to be scaled to many drivers - potentially
>>> all existing DSA ones, as far as I'm aware.
>>>
>>
>> I thought about implementing an MDB iterator as suggested by Tobias, but I'm
>> a bit concerned about the coherence of these MDB objects. In theory, when
>> the device driver is trying to act on an event, the source of the trigger
>> may have changed its state in the bridge already.
> 
> Yes, this is the result of SWITCHDEV_F_DEFER, used by both
> SWITCHDEV_ATTR_ID_PORT_MROUTER and SWITCHDEV_OBJ_ID_PORT_MDB.
> 
>> If, upon receiving an event in the device driver, we iterate over what
>> the bridge has at that instant, the differences between the worlds as
>> seen by the bridge and the device driver might lead to some unexpected
>> results.
> 
> Translated: iterating over bridge MDB objects needs to be serialized
> with new switchdev events by acquiring rtnl_lock(). Then, once switchdev
> events are temporarily blocked, the pending ones need to be flushed
> using switchdev_deferred_process(), so resync the bridge state with the
> driver state. Once the resync is done, the iteration is safe until
> rtnl_unlock().
> 
> Applied to our case, the MDB iterator is needed in mv88e6xxx_port_mrouter().
> This is already called with rtnl_lock() acquired. The resync procedure
> will indirectly call mv88e6xxx_port_mdb_add()/mv88e6xxx_port_mdb_del()
> through switchdev_deferred_process(), and then the walk is consistent
> for the remainder of the mv88e6xxx_port_mrouter() function.
> 
> A helper which does this is what would be required - an iterator
> function which calls an int (*cb)(struct net_device *brport, const struct switchdev_obj_port_mdb *mdb)
> for each MDB entry. The DSA core could then offer some post-processing
> services over this API, to recover the struct dsa_port associated with
> the bridge port (in the LAG case they aren't the same) and the address
> database associated with the bridge.
> 
> Do you think there would be unexpected results even if we did this?
> br_switchdev_mdb_replay() needs to handle a similarly complicated
> situation of synchronizing with deferred MDB events.
>  >> However, if we cache the MDB objects in the device driver, at least
>> the order in which the events took place will be coherent and at any
>> give time the state of the MDB objects in the device driver can be
>> guaranteed to be sane. This is also the approach the prestera device
>> driver took.
> 
> Not contesting this, but I wouldn't like to see MDBs cached in each
> device driver just for this. Switchdev is not very high on the list of
> APIs which are easy to use, and making MDB caching a requirement
> (for the common case that MDB entry destinations need software fixups
> with the mrouter ports) isn't exactly going to make that any better.
> Others' opinion may differ, but mine is that core offload APIs need to
> consider what hardware is available in the real world, make the common
> case easy, and the advanced cases possible. Rather than make every case
> "advanced" :)

Just throwing some random ideas out there. Do you think it would make 
more sense if this whole solution (rtnl_lock, iterator cb,...etc.) is 
moved up to DSA so that other DSA drivers could benefit from it? I 
thought about implement it (not the iterator, the current form) in DSA 
at first, but I'm not sure how other drivers would behave, so I did it 
with mv instead.

I guess the question is, is the current limitation (mrouter not properly 
offloaded) an issue specific to mv or is it a limitation of hardware 
offloading in general? I tend to think it's the latter.

But then again, if we move it to DSA, we would lose the benefit of the 
optimization of consolidating multiple register writes into just one (as 
done in patch 10 currently), unless we add a new switch op which takes a 
portvec instead of a port when modifying mdb's.
