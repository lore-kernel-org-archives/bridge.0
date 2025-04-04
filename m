Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829720F081
	for <bridge@lists.linux.dev>; Fri,  4 Apr 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797050; cv=none; b=uFhU+S2M5AZbAZhrZbXwv/5cRKqqgWzLyilxkdhUKRiLe8xunjrwXx2wkxc1L/ucrRFky5DwDzmfI8LKeCbEUavCQLRCpd4kB1YAp88Y0kcLU0ExonBQSt8kMKP5v4wUHeskZUStPoGDfwAj/X2W/Hd8vpb59Ne8Ejk6mVn7WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797050; c=relaxed/simple;
	bh=ouROHuQWcAD3W9eytP+HmLUDp18dNL1U5cg3yioIUq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2/TLBtFhdzzDMzq84TYA+WfX9nADcGiV97Nz1mZ/0QztO61XPwnSxeC+heqtAzqMr0eQU1U9rVKJNB951HWYBbQzpgCC2vlS92lj/ZMD22Yn6rFexgLTmc2mOKoJFYiRV3BeTpqSQwSyjy+QRhRUuytlSk67mBITKb/u5J41jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=nIRqGWWE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nIRqGWWE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso16845595e9.2
        for <bridge@lists.linux.dev>; Fri, 04 Apr 2025 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743797046; x=1744401846; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zP03ijhZ2aqQsthTQz8RL6yLJtMw3d+tIA07mCuHO+w=;
        b=nIRqGWWEuJytL3cQr6+QDRASCMaybdTcBQ495ZdpUeMyK/ZtAgG/uMXXH3QQEDfUYS
         LmQ9Q2RaKRfBKqbtIcuQPFjADeTpqt+Z/WCSBbMe8YCvYqnCYutu6Yd0hIVC9n/LI4Rg
         jMpHQ/3IH8ey7A6/OhMj0LsUITi5sT3GY65X8EXEpMZhM8KQ/83buL1DPT1gTK+SzczA
         aH6O3Og32k8AxMuyCyUegbPKNcM3I55IFH1UE3E1WaU4iO8yGVKLA5/D5Y02klWRcBxk
         bdxpJFJi6iqt5aQ5hFuLX/iMesBTfaZHxhgNvQHfiFwFqsFrUsC/LXdHmtcCnZxjRap1
         rHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797046; x=1744401846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP03ijhZ2aqQsthTQz8RL6yLJtMw3d+tIA07mCuHO+w=;
        b=SakNBkyvEoPcnC/grRzcnRXh8lVU+XR/CPvpSvbxGI9qi5Jyc9JktAHAbFo6kt9jrG
         mtXJN9Rf591FKQeDjbZpQcU5CbhjUhbZemfoopXiTSNm/OKo78iajIOH8IysHf7UTdBS
         PUYfFn1CeKYtYgLpxfQmDe2CvOyvL8ZKCiHgTvrgg8EPF4/iGsVytFpwn1PFSBL40qJF
         w7G39lZ/ohwBgxINZU95HMslH4RK36m8/W9zwyPKNWCL6W0R6rITrRMrOxYEN2QnI7ey
         ZzfXZyklwRFcHtkoD75Vv9xlGi2Yg6i98U3yXyI2Bz1OVgijjrVC/XFpKmpg0UIqlhN7
         S8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVbPwX1fh6mcMeVEVIJYL2047RNgGlWvcOE71xJa/3xWaBsy4SMrh4zmG/Iz43xZBUU9sp7LSw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFPNc6wvUCffR5m6ie3drEsgOhaTX6l1rL5m5v6atuD+BmjY/K
	9F0JZVjiH8XFtVlXxm5391B6v2stS1zldukXr0CvSUPawa6aslfSUifHmwKshRU=
X-Gm-Gg: ASbGncveLVXVZo3vV5DfKtr+/NROqEs7Ps1jCpGC2aPJ/zH3Iro4tNL/8fA1OPYQ7Pi
	dV42RZM4BbPh95PK3Fd2697VumzJppn/5YkQLXtOg/L2QAnUEw6sm1pBQnfZaa4IdeeWWB8pUVx
	mRJG2KkZjEYGeYhzA1gMCvFSwqqNzlC/fvTQe4ZFflMhYlcC65pADk/5SmaTAR0jBA8pH6NP87X
	r61x6XZaXFiaDn5NgrDsvieyJrNEDulFONGe6NG3MeIIgRSGNRCZQxVmw4//wssgnd5ZMuYsgAC
	FrKHq4PZNx6ATK1fRAXg9DeUNd1QzPCSN0J2gervZ05PIVIYlwBuiTDSYk7s2Qh0zA0oz+oOSrQ
	v
X-Google-Smtp-Source: AGHT+IEjIxLY0tbFxlyNpcjKXrg78y2ZQb0LH2OPyUVnkkSD5YRsGWUpiwLCyDgfBVWGGqcG57xffQ==
X-Received: by 2002:a05:600c:4513:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-43ecf823163mr37804015e9.1.1743797046189;
        Fri, 04 Apr 2025 13:04:06 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34af0e6sm55209205e9.16.2025.04.04.13.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:04:05 -0700 (PDT)
Message-ID: <abb9e2c1-c4b5-4ffa-b2e3-8b204da5efca@blackwall.org>
Date: Fri, 4 Apr 2025 23:04:04 +0300
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
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <917d4124-c389-4623-836d-357150b45240@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/4/25 18:25, Joseph Huang wrote:
> On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
>> On 4/4/25 02:44, Joseph Huang wrote:
>>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>>> is set.
>>>
>>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>>> ---
>>>   net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>>   net/bridge/br_private.h   |  9 +++++++++
>>>   net/bridge/br_switchdev.c |  4 ++++
>>>   3 files changed, 34 insertions(+), 5 deletions(-)
>>>
>>
>> The patch looks good, but one question - it seems we'll mark mdb entries with
>> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
>>
>> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
>> to the non-switch ports as offload failed, but it is not due to a switch offload
>> error.
> 
> Good catch. No, that was not intended.
> 
> What if we short-circuit and just return like you'd suggested initially if err == -EOPNOTSUPP?
> 
>>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>>> index 40f0b16e4df8..9b5005d0742a 100644
>>> --- a/net/bridge/br_switchdev.c
>>> +++ b/net/bridge/br_switchdev.c
>>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>       struct net_bridge_mdb_entry *mp;
>>>       struct net_bridge_port *port = data->port;
>>>       struct net_bridge *br = port->br;
>>> +    u8 old_flags;
>>>   
> 
> +    if (err == -EOPNOTSUPP)
> +        goto notsupp;
> 
>>>       spin_lock_bh(&br->multicast_lock);
>>>       mp = br_mdb_ip_get(br, &data->ip);
>>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>           if (p->key.port != port)
>>>               continue;
>>>   +        old_flags = p->flags;
>>>           br_multicast_set_pg_offload_flags(p, !err);
>>> +        if (br_mdb_should_notify(br, old_flags ^ p->flags))
>>> +            br_mdb_flag_change_notify(br->dev, mp, p);
>>>       }
>>>   out:
>>>       spin_unlock_bh(&br->multicast_lock);
>>
> 
> + notsupp:
>     kfree(priv);

Looks good to me. Thanks!
