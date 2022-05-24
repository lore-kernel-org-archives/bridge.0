Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=2/bDGPYXufJFzkVnBY8mqDgAglNZetlk8WJ7Djt/e2E=;
 b=e6JB8CI6WFSU+Q/ABVHaxlfYhBRAsmmbmkIDuhn1m6DKPOXKF37gjB/m9GdsVi49dc
 JNf43jPT5zw03LMoVZ8t3fuV30/a2V5p20h02AkSpplyqHBCbbU0BEhybKuk9LvBIU0v
 yF5u5B3igHgLN7iRG8ZQrDAszFgPNI/I5CRCOoGPWgb0Tr5z/PCYQqsyZhaq45tfM2ue
 TR82sVYgQfPiZLzURg9Q0Ng/5eocdGR5EPE8FxukEwr6LoxzCf3TXITUf9yHbYMLAfmG
 vt/o3bafEdXjgzQsP4rsUwQGadPuBcmEHO5dtLS97SrWhTOdZeC4FS/jt5IR6+lcfUJ1
 OuKg==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
Date: Tue, 24 May 2022 18:21:02 +0200
Message-ID: <86zgj6oqa9.fsf@gmail.com>
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

>
> Hi Hans,
> So this approach has a fundamental problem, f->dst is changed without any synchronization
> you cannot rely on it and thus you cannot account for these entries properly. We must be very
> careful if we try to add any new synchronization not to affect performance as well.
> More below...
>
>> @@ -319,6 +326,9 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>>  	if (test_bit(BR_FDB_STATIC, &f->flags))
>>  		fdb_del_hw_addr(br, f->key.addr.addr);
>>  
>> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &f->flags) && !test_bit(BR_FDB_OFFLOADED, &f->flags))
>> +		atomic_dec(&f->dst->locked_entry_cnt);
>
> Sorry but you cannot do this for multiple reasons:
>  - f->dst can be NULL
>  - f->dst changes without any synchronization
>  - there is no synchronization between fdb's flags and its ->dst
>
> Cheers,
>  Nik

Hi Nik,

if a port is decoupled from the bridge, the locked entries would of
course be invalid, so maybe if adding and removing a port is accounted
for wrt locked entries and the count of locked entries, would that not
work?

Best,
Hans
