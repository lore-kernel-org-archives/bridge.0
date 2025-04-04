Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDB20ADC9
	for <bridge@lists.linux.dev>; Fri,  4 Apr 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797724; cv=none; b=PY83mol96e+uxNaD8MKFFl9hLK+uxJ6VK7+kxKiChgkZcxq0jCo9TxlcoNYA86jzZJJFirYYxZsaIT76R8WxK/GHJeeSq4FSCrDQs0tBa0SRBRDyTiDC6Js92sxezETFozkkou6RetzQPPcrjNDHdZXyQAq9FL9T7Xy/xDffc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797724; c=relaxed/simple;
	bh=FNMLVPOYURQjDIbEqTZeHZjf8H6jXyblhUfeS+qvi4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsHKeFOOefYdTwehyLp7hBdASBQIZkrKLc94X8B5VIo+YY9oSMGvog5gO33b25N1whzUZQVILHA4PXJ02btsm7R0kvwm0+sbhzmTEt25tmwTa+okWpTitCA54rzUMfc5vQJP26AzL0n0snUjzDr7ScuiDfMzwSu24huwFqFbv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bfx2Kxiq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bfx2Kxiq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so25127295e9.3
        for <bridge@lists.linux.dev>; Fri, 04 Apr 2025 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743797721; x=1744402521; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDPtzrDQm7D2KJ6r1jIrDZFX1ist1md5kdhYkAXF22A=;
        b=bfx2Kxiq2lmCi/DN+Ukh79RHeRenCFTvkPYQCkvgssZeAzIvd8KSlGcDy4Uv4YRjz9
         gJqIj/XBmS4TQzWAmXoJQr9Cww5LG9KSzdrqw2O03lsbKcS4GkSh6nziH7FUykHPpSso
         KD4jQoQtO49NX2w18Vfxj+rG6flXK9XyWlIWgfdmAnETCfGC07SdTrhurdym5NfTS7ak
         gyrKtFK2/hG+glNemN/XY7AfBQv3vKba8nIZxpS400UuwhUReCYFx3YK5H6n9W4pX0MT
         O+bMJxsy3UsAAmvqgEc84YqpYXKBbg6VCIvxn8YxCi+oPZXX+j3W2LR9r0CMbnvhNBXH
         sZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797721; x=1744402521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDPtzrDQm7D2KJ6r1jIrDZFX1ist1md5kdhYkAXF22A=;
        b=FlPbsHUPEUBqoASkdOtjJoLLB/SVKN0b8WdKwZiAJuaEiTw1cm0sddls03Fs7TvoTf
         f/y0vcgYzUSrqEkKXNeypAFr5vaEmJ9AmcQZySxbUiEECrKlp/XSDga+6V+T9dBSkPv4
         XbIYHmy0SQCTlCHoVuvbxdybFnh67xjq+FBEi9JhcxqQ0ZkpS4KC/1mj5dJdVzfcMCRR
         LGcWoSP+uTo+2cMbgM4PvgSCLV3cfCV3/WPS/rQxrZOFDqdOqD/18ffEuZSQgRymqT/x
         nsku858tnbAPQlEDttXQjtrJ0CiF2loi3hznX3BHjFDg2PBpUW/oMhgwuDXAs1X3tfaT
         t2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUUDySkRD+xKshOOy9vboKCKQ2/2ecbA8SIEe4hdEr38hX75kqm070xI+qqj5bc7EW09oqDvlA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwYq1ZNDU61yXz9suMhQyaRBKhIVztdI6Z0UdQfzlOaE5mn0Zb
	tIxabFFRgSpJw9ytmZbHkOqO9/mEq95+WabALLqXMaP8M94xVAPwe+bfrguWs/M=
X-Gm-Gg: ASbGnctuyCfYtlgxfuAml4epjBfDuVbnonzJNRqX/uKkTrKoxqmPfuSVIIi2f1TKjtv
	JqDuYc3cIP/1pbqqY5BOWBbHJm3nlMlqVkZP26mne04/v6VCJnPSt84nhhfvAQYw9xbqxQVblX9
	EitbKn1IboZUycexV9ixv/D4I6p3ELD1BfCvc//ht54CFUFHhC1CBJZGEsTLkj/O4LE7+227iZq
	TNXMMA8/Bzp0cX+pDTlupIlk6rrOPaLyjzKUCpWDcuTWIjvZ4EYGS8Mf8bRyv7G02N9XWjtlfl+
	vzaH9lHX9gkQDiHBNBlQQiPQKqb/Zpoo1ad5kSACevY9+vpl0nQm0yRLN3KkSVUssNoj4o15yJm
	J
X-Google-Smtp-Source: AGHT+IGVOzLfgvsBZseM5TV3JdkQLxAe0MfgoooeouE9pQaId+9aWIcjjMv6iTb0EZIAoYH8aCKyuQ==
X-Received: by 2002:a05:6000:4305:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-39d0de27eeamr3277151f8f.29.1743797720808;
        Fri, 04 Apr 2025 13:15:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7064sm5279408f8f.34.2025.04.04.13.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:15:20 -0700 (PDT)
Message-ID: <96bda215-bee1-4ff7-9d88-b97922ca7b1a@blackwall.org>
Date: Fri, 4 Apr 2025 23:15:19 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Joseph Huang <joseph.huang.2024@gmail.com>,
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
 <9e7f6c4c-cabe-46e9-b59f-6638b4ae25e3@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9e7f6c4c-cabe-46e9-b59f-6638b4ae25e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/4/25 23:11, Joseph Huang wrote:
> On 4/4/2025 4:04 PM, Nikolay Aleksandrov wrote:
>> On 4/4/25 18:25, Joseph Huang wrote:
>>> On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
>>>> On 4/4/25 02:44, Joseph Huang wrote:
>>>>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>>>>> is set.
>>>>>
>>>>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>>>>> ---
>>>>>    net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>>>>    net/bridge/br_private.h   |  9 +++++++++
>>>>>    net/bridge/br_switchdev.c |  4 ++++
>>>>>    3 files changed, 34 insertions(+), 5 deletions(-)
>>>>>
>>>>
>>>> The patch looks good, but one question - it seems we'll mark mdb entries with
>>>> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
>>>>
>>>> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
>>>> to the non-switch ports as offload failed, but it is not due to a switch offload
>>>> error.
>>>
>>> Good catch. No, that was not intended.
>>>
>>> What if we short-circuit and just return like you'd suggested initially if err == -EOPNOTSUPP?
>>>
>>>>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>>>>> index 40f0b16e4df8..9b5005d0742a 100644
>>>>> --- a/net/bridge/br_switchdev.c
>>>>> +++ b/net/bridge/br_switchdev.c
>>>>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>>        struct net_bridge_mdb_entry *mp;
>>>>>        struct net_bridge_port *port = data->port;
>>>>>        struct net_bridge *br = port->br;
>>>>> +    u8 old_flags;
>>>>>    
>>>
>>> +    if (err == -EOPNOTSUPP)
>>> +        goto notsupp;
>>>
>>>>>        spin_lock_bh(&br->multicast_lock);
>>>>>        mp = br_mdb_ip_get(br, &data->ip);
>>>>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>>            if (p->key.port != port)
>>>>>                continue;
>>>>>    +        old_flags = p->flags;
>>>>>            br_multicast_set_pg_offload_flags(p, !err);
>>>>> +        if (br_mdb_should_notify(br, old_flags ^ p->flags))
>>>>> +            br_mdb_flag_change_notify(br->dev, mp, p);
>>>>>        }
>>>>>    out:
>>>>>        spin_unlock_bh(&br->multicast_lock);
>>>>
>>>
>>> + notsupp:
>>>      kfree(priv);
>>
>> Looks good to me. Thanks!
> 
> Thanks for the review!
> 
> And a logistic question. Now that part 1 and part 2 are ack'd (thanks again for the review), when I send out v3, should I resend those (unmodified part 1 and part 2) with my v3 patch series, or should I break this one off and only send part 3 v3 as a separate patch?
> 
> Thanks,
> Joseph

You should send the whole set again as v3, but you should keep the acked-by tags in those patches.

Cheers,
 Nik

