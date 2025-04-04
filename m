Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA31F3D30
	for <bridge@lists.linux.dev>; Fri,  4 Apr 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780358; cv=none; b=MfCS+iTthYy8rS11KIENO7nOlkukpFmjQJ1KF8wobLn0ffeMJA0V879YgHZOCUASRyuVJK+8vbn1lxXzhwPhKNb8ePbQWg/gugdGlJPf3sWAXgRXEP/Fzm7XOI0PNpS6xwsn1mz2PprTmw3pWUODCui78zI2nCwASG3NJ9KSnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780358; c=relaxed/simple;
	bh=xJg7HCoe0mVfJeMYzbUm1cWmxH+o1mewNNRakDyEJ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+8ybFOuOBjDybvILMCVTcfdJ4/qse8kFbNvA9762b7yg1SOnXfgz4MwAuAJvJQB3iG/vxexljSUmMTqHUkL4m/v5Ww9znGDBzdPOf2i4HcHFYRDnWu59MSD/nlRfYyFM6Ulh8cd9573LNavVZzmfb3wL8GEFXAylJG1v6XrP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSkoUjG+; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSkoUjG+"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6ff07872097so20647287b3.3
        for <bridge@lists.linux.dev>; Fri, 04 Apr 2025 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743780355; x=1744385155; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vK21i6Cm/oBnMUPYizwWzpUy62AvakVph2bcyRattBA=;
        b=FSkoUjG+iDAJsqaO62+jILagQCA5HmrPGHP0nkmsoJs1O2S1bbXBAaOzG/f9pRqDpA
         wP3rCzqOx1rs91nQNi3+CXejdVHnYiUhcO+FWdkA07j9FchXGXEnlt7loD4K6YLTsPjF
         NQC2OCw8GnawzGrmBJvClru+dlw9mbOiXjG7UPjdVX64Z//d8HHqTtQv/vMX2spQs/19
         3iggtMSm8Qizmv4pA4PMUwWCy2BXGM9JTfQXC/R4tB1W+UkR7fikEo36aaR+BSZjatbO
         ArL3LgIwOTJX5024F8f5OTkVmiuko2krGKaUNNY/cNwCR7ZnYyBindhRPh27HYoXta7G
         HIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743780355; x=1744385155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK21i6Cm/oBnMUPYizwWzpUy62AvakVph2bcyRattBA=;
        b=K9t+AESrK2/FAHgc7qduIK83IknbhvmbwxRT31XL5B7cC3sIQwbYw+/If5ygxeU5Lx
         14fGAKno1IGfKoLifdkJVmiUa2qX9rXWfDP7ok0lU/sv2B1Ge8OhDKJnBnAsbGyS6f5N
         rHu2ADDYZutelM01acxArF0qHnBcX4bOJl6HA39DEn2IVA0MbEiGnSpadG8qX/8i1kuX
         9DdigzVigHGeO/1q568/odqmxec0yF3t6zz6fHBPTxbDy3t2K1Jvm1tXhaN/o1IgkAJn
         +vPn6w6aUARDMAh2K1+KXxm23DNNclyiczIZ1PxSmlRbZVlBA/to4mvGFXVcN9R/A9vd
         Z7jA==
X-Forwarded-Encrypted: i=1; AJvYcCXSbnNcrYmO9Ghvd9wDRLJaYhnJpT4aFeRaQhDamrKJkLClQNRt7CSgRgeaCtmHEgjrWUriOjw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfB/65hYYfC9nqPqi1GIg/mb2bbmhAANN7wS6ruFOs0zxmAhFW
	pZ9gXHMRF9glwJl0m1G978RNB8cehQ8+ppOSU/U43fcVBksfeHw6
X-Gm-Gg: ASbGnctEqo3zUda21/ygnsLQIslXWxTFwMIxTyhzTVah47YRw5MW5BTD3VRRB6VfGIm
	RDpzDnJA3PirLsGI8U8PugE5Iy++daNQyV7kQS495vMS05ezYdA97iVfIA4d6r+zOmxM6q84lVd
	jkKHaivjrvxFKYFhSGr1YgOgtEmE6X0DaGqvljkWOOtXJdM5RP0Tu8v4SiJex6NqSlNcjHTjQtB
	LHe/+LCPsjX4neyY0wX2H46VBSZ09cu5u6bL5sBmsBAgZ9Dy+eg+3MSdGaEMgDeiTVGTmzwovrz
	ioGHSTXUsPtLb8FYlEcxLHaoas1PwhAC1h3Hdv4dYtfYIsTMXHB4AFQXW62dASbYiIU=
X-Google-Smtp-Source: AGHT+IG/ho+VI52OyNB7S66WowmtRGN4XNsDzBAzrRZShq7geFV74ZMq2NsftP++30euSownAh+xnQ==
X-Received: by 2002:a05:690c:c8c:b0:6f9:97af:b594 with SMTP id 00721157ae682-703e151b83dmr63946907b3.10.1743780355016;
        Fri, 04 Apr 2025 08:25:55 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e8ac79sm9284137b3.60.2025.04.04.08.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 08:25:54 -0700 (PDT)
Message-ID: <917d4124-c389-4623-836d-357150b45240@gmail.com>
Date: Fri, 4 Apr 2025 11:25:54 -0400
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
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <36c7286d-b410-4695-b069-f79605feade4@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
> On 4/4/25 02:44, Joseph Huang wrote:
>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>> is set.
>>
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>> ---
>>   net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>   net/bridge/br_private.h   |  9 +++++++++
>>   net/bridge/br_switchdev.c |  4 ++++
>>   3 files changed, 34 insertions(+), 5 deletions(-)
>>
> 
> The patch looks good, but one question - it seems we'll mark mdb entries with
> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
> 
> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
> to the non-switch ports as offload failed, but it is not due to a switch offload
> error.

Good catch. No, that was not intended.

What if we short-circuit and just return like you'd suggested initially 
if err == -EOPNOTSUPP?

>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 40f0b16e4df8..9b5005d0742a 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   	struct net_bridge_mdb_entry *mp;
>>   	struct net_bridge_port *port = data->port;
>>   	struct net_bridge *br = port->br;
>> +	u8 old_flags;
>>   

+	if (err == -EOPNOTSUPP)
+		goto notsupp;

>>   	spin_lock_bh(&br->multicast_lock);
>>   	mp = br_mdb_ip_get(br, &data->ip);
>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   		if (p->key.port != port)
>>   			continue;
>>   
>> +		old_flags = p->flags;
>>   		br_multicast_set_pg_offload_flags(p, !err);
>> +		if (br_mdb_should_notify(br, old_flags ^ p->flags))
>> +			br_mdb_flag_change_notify(br->dev, mp, p);
>>   	}
>>   out:
>>   	spin_unlock_bh(&br->multicast_lock);
> 

+ notsupp:
	kfree(priv);
