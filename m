Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993B1A2624
	for <bridge@lists.linux.dev>; Tue,  3 Sep 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348469; cv=none; b=q2wc7AO20yPKsS0pXhI0U+jUmS3a0vbfHd345+nLrnHArEdxbis1SPcxXb3vUmSmhwcp/NY84TWye79dGqMFRxounf1Hh0w6shKuw0vo3wqg/iSmfp1cmrlW2gN5X5f6y1kRmdvmxwGo9Q8rdYT4BB5C4He3M1L+Cs/CsJ6GGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348469; c=relaxed/simple;
	bh=gGj3VHMffsVKcM98i8N/sYkYflpxs9vba5Oq3+GYaXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt8XdSJlBCRMsEMyvX26xUlij2Yh5Cw/R0/xpbrrOfoNSA56pghZe/Ssb4lJskRPBocCoGQ6ykDvDtNzDvcnPIEc41es/v2OcEodWZv0Q2qabpC9l/tRebPXzoT2AtYcp59nDpXgvUlTSMhGgJTVhZ9S5aqtYfii46+WSLBGBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JKJiOHOb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JKJiOHOb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso41128005e9.0
        for <bridge@lists.linux.dev>; Tue, 03 Sep 2024 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725348464; x=1725953264; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFJvmh7VK9yCH4l+cHnWAKDWl8DYAR9JbYqeBtzjBhA=;
        b=JKJiOHObIZ15fIadXHf9iA5EAsLAcjKTdwqz5WE+VJMaP5Zb8tIZO4pcb9pHhv7172
         vATHExzdnjWUoECAA1liZayGZy/opvHVEHenULlL14C9tFiNLTKwxNyCwfktrC9YCV+f
         p+Bbx1ErYVS2/8aEcj1pVxH7ZY+dG1q2lh6DHt+b6EegdenqndkaGnpEuUs6rMN+2R1f
         /I2C6o/Wbl3IJjKmvpoS+4zPK7BfMlFsxtev+zqoZAJWcDFvQh6ctbbhGAgmtmVexSXh
         xGDBcflmosN0yRHuGvwAyoNyEZ6s0EU1yHgTJsjVhODRJY8AoRJOnVsiqUPsyQCfSjcR
         a5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348464; x=1725953264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFJvmh7VK9yCH4l+cHnWAKDWl8DYAR9JbYqeBtzjBhA=;
        b=ByjgYTsk1gBh6DQ04Ne1Cf6DP506pLkwgRcIxmXf/1OFLWxFxWDkwNQFrTo3fD0QxX
         US0PqhZBu8gqjinAmXrm0BLS8hf/mYN1mrnzmIi0FgbReY2lrUYcRzpYa+z+X7eNR0Cz
         uRLqg5ccaQiNGMcONEiryo0H2o5+DZTUKT+MfKpbob96whLBvmcuDY+5IiLG3FQCVoOy
         sh6LpmSzb9M2jFHYcQOQx22gpUhxJmMafpTBzz1+2aUZ++XXYNNzAwaM2caQ8AigI0Sf
         R+BX/HT6NB+z6B8iCLO3LSdX6zCk0Yx3A4I3D5MzvbVEs/5v31PXz+1XPHCULUYPZYYB
         UgBA==
X-Forwarded-Encrypted: i=1; AJvYcCXAV725hN9jPwmHoFMz76F0XN6Btq37/e+A0L6gPTopqD72MY9qdusCyXjklJ/LDkMpGy7HjzM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9hlmP23BAsZuQ7QbEKWo/AVOKOk/290mKb/4jgYACFKe/Cg/y
	dlJkYC5B369SgS7gQ39I1DCUJtz9EZCy4hHJJ15/U1W8IwFjMYSdorEdk5JBxTQ=
X-Google-Smtp-Source: AGHT+IEQHFClV0KFpBCHO6n1FHyIoyoPBdf2Q5fEq9bZfr1yqIWPXgtqiqNkPkZhleCQe85yTKw+CA==
X-Received: by 2002:a05:600c:3b1e:b0:426:62df:bdf0 with SMTP id 5b1f17b1804b1-42c82f5318fmr36445035e9.10.1725348463989;
        Tue, 03 Sep 2024 00:27:43 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-30-236.comnet.bg. [109.160.30.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm160150715e9.34.2024.09.03.00.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 00:27:43 -0700 (PDT)
Message-ID: <aee25423-c9e4-4c3a-8990-d019f085467c@blackwall.org>
Date: Tue, 3 Sep 2024 10:27:41 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
To: Ido Schimmel <idosch@nvidia.com>, Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Petr Machata <petrm@mellanox.com>,
 Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
 <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
 <ZtRWACsOAnha75Ef@shredder.mtl.com>
 <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
 <CAJpXRYReCbrh0z3fmgKqycJHZ+Z8=+KnK+YpOrhD1UsmgfiSxg@mail.gmail.com>
 <ZtXS0lxzOSSq8AMb@shredder.mtl.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZtXS0lxzOSSq8AMb@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 17:59, Ido Schimmel wrote:
> On Mon, Sep 02, 2024 at 09:34:48AM +0200, Jonas Gorski wrote:
>> Am So., 1. Sept. 2024 um 14:25 Uhr schrieb Nikolay Aleksandrov
>> <razor@blackwall.org>:
>>>
>>> On 01/09/2024 14:54, Ido Schimmel wrote:
>>>> On Sat, Aug 31, 2024 at 11:31:50AM +0300, Nikolay Aleksandrov wrote:
>>>>> On 30/08/2024 17:53, Jonas Gorski wrote:
>>>>>> When userspace wants to take over a fdb entry by setting it as
>>>>>> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
>>>>>> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
>>>>>>
>>>>>> If the bridge updates the entry later because its port changed, we clear
>>>>>> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
>>>>>> flag set.
>>>>>>
>>>>>> If userspace then wants to take over the entry again,
>>>>>> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
>>>>>> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
>>>>>> update:
>>>>>>
>>>>>>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>>>>>>            /* Refresh entry */
>>>>>>            fdb->used = jiffies;
>>>>>>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>>>>>            /* Take over SW learned entry */
>>>>>>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>>>>>>            modified = true;
>>>>>>    }
>>>>>>
>>>>>> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
>>>>>> by also allowing it if swdev_notify is true, which it will only be for
>>>>>> user initiated updates.
>>>>>>
>>>>>> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
>>>>>> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
>>>>>> ---
>>>>>>  net/bridge/br_fdb.c | 3 ++-
>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>>>>> index c77591e63841..c5d9ae13a6fb 100644
>>>>>> --- a/net/bridge/br_fdb.c
>>>>>> +++ b/net/bridge/br_fdb.c
>>>>>> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>>>>>>             if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>>>>>>                     /* Refresh entry */
>>>>>>                     fdb->used = jiffies;
>>>>>> -           } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>>>>> +           } else if (swdev_notify ||
>>>>>> +                      !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>>>>>                     /* Take over SW learned entry */
>>>>>>                     set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>>>>>>                     modified = true;
>>>>>
>>>>> This literally means if added_by_user || !added_by_user, so you can probably
>>>>> rewrite that whole block to be more straight-forward with test_and_set_bit -
>>>>> if it was already set then refresh, if it wasn't modified = true
>>>>
>>>> Hi Nik,
>>>>
>>>> You mean like this [1]?
>>>> I deleted the comment about "SW learned entry" since "extern_learn" flag
>>>> not being set does not necessarily mean the entry was learned by SW.
>>>>
>>>> [1]
>>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>>> index c77591e63841..ad7a42b505ef 100644
>>>> --- a/net/bridge/br_fdb.c
>>>> +++ b/net/bridge/br_fdb.c
>>>> @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>>>>                         modified = true;
>>>>                 }
>>>>
>>>> -               if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>>>> +               if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>>>>                         /* Refresh entry */
>>>>                         fdb->used = jiffies;
>>>> -               } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>>> -                       /* Take over SW learned entry */
>>>> -                       set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>>>> +               } else {
>>>>                         modified = true;
>>>>                 }
>>>
>>> Yeah, that's exactly what I meant. Since the added_by_user condition becomes
>>> redundant we can just drop it.
>>
>> br_fdb_external_learn_add() is called from two places; once when
>> userspace adds a EXT_LEARN flagged fdb entry (then swdev_nofity is
>> set), and once when a switchdev driver reports it has learned an entry
>> (then swdev_notify isn't).
>>
>> AFAIU the previous condition was to prevent user fdb entries from
>> being taken over by hardware / switchdev events, which this would now
>> allow to happen. OTOH, the switchdev notifications are a statement of
>> fact, and the kernel really has a say into whether the hardware should
>> keep the entry learned, so not allowing entries to be marked as
>> learned by hardware would also result in a disconnect between hardware
>> and kernel.
> 
> The entries were already learned by the hardware and the kernel even
> updated their destination in br_fdb_external_learn_add(), it is just
> that it didn't set the EXT_LEARN flag on them, which seems like a
> mistake.
> 
>>
>> My change was trying to accomodate for the former one, i.e. if the
>> user bit is set, only the user may mark it as EXT_LEARN, but not any
>> (switchdev) drivers.
>>
>> I have no strong feelings about what I think is right, so if this is
>> the wanted direction, I can send a V2 doing that.
> 
> I prefer v2 as it means that an entry that was learned by the hardware
> will now be marked as such regardless if it was previously added by user
> space or not

+1
We were already in a bad situation, if anything this would make it
better. We can take care of added_by_user behaviour later.

Thanks,
 Nik

