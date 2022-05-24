Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=FYyqUIqX7o7uukxhOxpvy5c6jwFhAW9JG5e+iqj0ZAA=;
 b=c40RMye4tt3qCM6W7eagyel05d9f+ezi9QjwhaQUCVPrgeXySiIl9CgyIOCULFxZRD
 R6hBjevW71JnRlce8PS7Z25IqHWEruI0bmo1pEwvrEZrFMyulwV9euVsIFwx1faYR3pt
 IZOpC8zioCI8T2SnZoD3ZoSTFvlbhGEjtZ8ulllzeUUNb91lhIKU8erEgOQ+3jnIWFjx
 fiv+sihOx6bLRkA5OmLH/IMQpg6fnANudZqfBYeJtNmLbZiq+VIKRXePkKm+JBYSWSOK
 2et3ghTg4DPaTlWwem54LXEFrT27VZvUKSFjYc7yQesvH60Ljkbai0rT9V3qfElTv5FM
 XxeQ==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
Date: Tue, 24 May 2022 18:08:08 +0200
Message-ID: <8635gyvrpz.fsf@gmail.com>
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

I could check if f->dst is NULL, but in general this should be able to
work on a per port basis, so do you have an idea of how to keep a per
port counter of added locked fdb entries?

Best,
Hans
