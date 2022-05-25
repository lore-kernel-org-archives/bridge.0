Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=KtU04oFIh5Z0YSsR5FQRVyG/XaU2MIHApujJFCWuZlw=;
 b=QqGYFn4Ab/DfOssUeWALroVEeCh9UhII4ToDkKRqMH2XJaQXYENX3C07V7wDmMpuPs
 JB3nZ4QAR/l9TljZY57Uuupxe1QmncQMTZ5I50aguJnVGNj9v5id7qb2+BG1fcInEp2L
 b9z2+5kDCMMMCrsXu7n7v40qvPya+hxNYfNUtz0O9ntgyGKdkE02ugcZO98fspQhi80T
 u/uE2lleR4T3dIgB7EKLlUELP3N/KLVAA7/6/EEP16i87GjgEC6aZW5yNb/sGrVc69iw
 gxuZU+B3cTUODouyMdi1eNJJ5xxLm0G9V7ka82qlV5C9zfWaWc31Q5mm4ez/nueuTqH5
 AQfg==
Message-ID: <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
Date: Wed, 25 May 2022 11:38:37 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
 <86zgj6oqa9.fsf@gmail.com>
 <b78fb006-04c4-5a25-7ba5-94428cc9591a@blackwall.org>
 <86fskyggdo.fsf@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <86fskyggdo.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On 25/05/2022 11:34, Hans Schultz wrote:
> On ons, maj 25, 2022 at 11:06, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> On 24/05/2022 19:21, Hans Schultz wrote:
>>>>
>>>> Hi Hans,
>>>> So this approach has a fundamental problem, f->dst is changed without any synchronization
>>>> you cannot rely on it and thus you cannot account for these entries properly. We must be very
>>>> careful if we try to add any new synchronization not to affect performance as well.
>>>> More below...
>>>>
>>>>> @@ -319,6 +326,9 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>>>>>  	if (test_bit(BR_FDB_STATIC, &f->flags))
>>>>>  		fdb_del_hw_addr(br, f->key.addr.addr);
>>>>>  
>>>>> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &f->flags) && !test_bit(BR_FDB_OFFLOADED, &f->flags))
>>>>> +		atomic_dec(&f->dst->locked_entry_cnt);
>>>>
>>>> Sorry but you cannot do this for multiple reasons:
>>>>  - f->dst can be NULL
>>>>  - f->dst changes without any synchronization
>>>>  - there is no synchronization between fdb's flags and its ->dst
>>>>
>>>> Cheers,
>>>>  Nik
>>>
>>> Hi Nik,
>>>
>>> if a port is decoupled from the bridge, the locked entries would of
>>> course be invalid, so maybe if adding and removing a port is accounted
>>> for wrt locked entries and the count of locked entries, would that not
>>> work?
>>>
>>> Best,
>>> Hans
>>
>> Hi Hans,
>> Unfortunately you need the correct amount of locked entries per-port if you want
>> to limit their number per-port, instead of globally. So you need a
>> consistent
> 
> Hi Nik,
> the used dst is a port structure, so it is per-port and not globally.
> 
> Best,
> Hans
> 

Yeah, I know. :) That's why I wrote it, if the limit is not a feature requirement I'd suggest
dropping it altogether, it can be enforced externally (e.g. from user-space) if needed.

By the way just fyi net-next is closed right now due to merge window. And one more
thing please include a short log of changes between versions when you send a new one.
I had to go look for v2 to find out what changed.

>> fdb view with all its attributes when changing its dst in this case, which would
>> require new locking because you have multiple dependent struct fields and it will
>> kill roaming/learning scalability. I don't think this use case is worth the complexity it
>> will bring, so I'd suggest an alternative - you can monitor the number of locked entries
>> per-port from a user-space agent and disable port learning or some similar solution that
>> doesn't require any complex kernel changes. Is the limit a requirement to add the feature?
>>
>> I have an idea how to do it and to minimize the performance hit if it really is needed
>> but it'll add a lot of complexity which I'd like to avoid if possible.
>>
>> Cheers,
>>  Nik

