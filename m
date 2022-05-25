Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=J5DCkWestgVKoHEZoLossBiU0LtcBuAy5pRj+r09hN4=;
 b=XP3vHIYmf/Ce3FGxCzpcX7HjyAZBtPpnAymzxt8qes+BDIeDOh6F7lvUPFfx9tnC2d
 +xpmCEvfyTHqVlt9SBLYRRGulX1GyGwjXVwLdpwO14peVNHNhC/MII2rabef1oU1ErBK
 uZNvN3T5485zyLUgwwpDngrc7ZKytkgjUuSjRsNTvH9Df89NPu+mu9qTsDxub0/hnh6C
 byCcXLsQtqiFctApMaQMfD87zErzxamzEsrJpPNHWIcIzFKIGY+PgHKumqiyb4GOareT
 KhMZwEFZbM0wSipJvO7WkM2n+0uetym0XUO7zrCJcc94gdFBZglaLeYg2gOGwAWC740i
 G1nQ==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
 <86zgj6oqa9.fsf@gmail.com>
 <b78fb006-04c4-5a25-7ba5-94428cc9591a@blackwall.org>
 <86fskyggdo.fsf@gmail.com>
 <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
Date: Wed, 25 May 2022 11:11:00 +0200
Message-ID: <86v8tu7za3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On ons, maj 25, 2022 at 11:38, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 25/05/2022 11:34, Hans Schultz wrote:
>> On ons, maj 25, 2022 at 11:06, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>> On 24/05/2022 19:21, Hans Schultz wrote:
>>>>>
>>>>> Hi Hans,
>>>>> So this approach has a fundamental problem, f->dst is changed without any synchronization
>>>>> you cannot rely on it and thus you cannot account for these entries properly. We must be very
>>>>> careful if we try to add any new synchronization not to affect performance as well.
>>>>> More below...
>>>>>
>>>>>> @@ -319,6 +326,9 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>>>>>>  	if (test_bit(BR_FDB_STATIC, &f->flags))
>>>>>>  		fdb_del_hw_addr(br, f->key.addr.addr);
>>>>>>  
>>>>>> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &f->flags) && !test_bit(BR_FDB_OFFLOADED, &f->flags))
>>>>>> +		atomic_dec(&f->dst->locked_entry_cnt);
>>>>>
>>>>> Sorry but you cannot do this for multiple reasons:
>>>>>  - f->dst can be NULL
>>>>>  - f->dst changes without any synchronization
>>>>>  - there is no synchronization between fdb's flags and its ->dst
>>>>>
>>>>> Cheers,
>>>>>  Nik
>>>>
>>>> Hi Nik,
>>>>
>>>> if a port is decoupled from the bridge, the locked entries would of
>>>> course be invalid, so maybe if adding and removing a port is accounted
>>>> for wrt locked entries and the count of locked entries, would that not
>>>> work?
>>>>
>>>> Best,
>>>> Hans
>>>
>>> Hi Hans,
>>> Unfortunately you need the correct amount of locked entries per-port if you want
>>> to limit their number per-port, instead of globally. So you need a
>>> consistent
>> 
>> Hi Nik,
>> the used dst is a port structure, so it is per-port and not globally.
>> 
>> Best,
>> Hans
>> 
>
> Yeah, I know. :) That's why I wrote it, if the limit is not a feature requirement I'd suggest
> dropping it altogether, it can be enforced externally (e.g. from user-space) if needed.
>
> By the way just fyi net-next is closed right now due to merge window. And one more
> thing please include a short log of changes between versions when you send a new one.
> I had to go look for v2 to find out what changed.
>

Okay, I will drop the limit in the bridge module, which is an easy thing
to do. :) (It is mostly there to ensure against DOS attacks if someone
bombards a locked port with random mac addresses.)
I have a similar limitation in the driver, which should then probably be
dropped too?

The mayor difference between v2 and v3 is in the mv88e6xxx driver, where
I now keep an inventory of locked ATU entries and remove them based on a
timer (mv88e6xxx_switchcore.c).

I guess the mentioned log should be in the cover letter part?


>>> fdb view with all its attributes when changing its dst in this case, which would
>>> require new locking because you have multiple dependent struct fields and it will
>>> kill roaming/learning scalability. I don't think this use case is worth the complexity it
>>> will bring, so I'd suggest an alternative - you can monitor the number of locked entries
>>> per-port from a user-space agent and disable port learning or some similar solution that
>>> doesn't require any complex kernel changes. Is the limit a requirement to add the feature?
>>>
>>> I have an idea how to do it and to minimize the performance hit if it really is needed
>>> but it'll add a lot of complexity which I'd like to avoid if possible.
>>>
>>> Cheers,
>>>  Nik
