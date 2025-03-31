Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94418BBBB
	for <bridge@lists.linux.dev>; Mon, 31 Mar 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451914; cv=none; b=Gj9N9gCzeOVddJPrA14+ai7vwLDgzeVDqeoi1/pp7sfJkf4n3VlP/PAVEQRZ4mmKk9XG7Y/sZz2No2Mo7+TpeAl6vt1aAa5zoqVphRUrXdX7F8SWtm4vcHoykuVSTihiZscAtxH2fbKN3Whvwr7gz8vGLkmHGHSXm1AX0PjvKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451914; c=relaxed/simple;
	bh=OBzbiRgekCpil9D7mX+5gJrMZSeLnL5vGhu0E44lgKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrSQCLpn8M4Cw9vp0D6iER7rKlWOT1437GEsR4rFNIo94KJfWAqe35/rk1y7ontIKqNknCSconc9Hd9Jff18yA0xVvRNnwhqN+se4xX9Ez0Gc5AyefmSOhS3PXAttqgYO2lk6Tz+EuB3wYEjEWYtbG8Ip/sTJWKyjnHuUf9ky6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR1lMjOZ; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR1lMjOZ"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6f666c94285so49179747b3.3
        for <bridge@lists.linux.dev>; Mon, 31 Mar 2025 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451911; x=1744056711; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LR1OgG1N7YtLAYw3VdmcuwXI0YdDXSMCdXCbozGI5l8=;
        b=AR1lMjOZ1KFPXk8hOdMn793Wb77Vo98mILyZktVX6M93Nz1PFjFGtbC64/t+V04Ihv
         cotQyyAuLnQm0pjn++jyhJ8jBRYSAU4QijEknSODVMPDaWz3hRSgrTwFqmn18D+hGild
         H8lmMJuECLASvo5lbzuRMZ6Hp4QqEyxhyIpPZtHloS72WZgejNGoA8tFwjDCWvnrHtZn
         NTu6AURLC9s7x++F16kJ1ciLgGfOEgbu9bQeksROasOieE6dIz9kPHlFHf6hvOcRZzOB
         lav18lSEnfQoEczJ54kOvsQa+fsQzTdGoeaBNU816hUIoYsTFPouB4vB+6MoLpNviKky
         WB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451911; x=1744056711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR1OgG1N7YtLAYw3VdmcuwXI0YdDXSMCdXCbozGI5l8=;
        b=wYU8BR2ZAkYvLmXLvVw09gNZbHlk+0ubYG6X9Zlyr5VosBs3uGmGhXPCNgyAxJii3l
         B7DO6pebHqJbDzdFEaZiC9BNBrNUmBef83earv7QYSuPvgvOAUSrJFJcYadzahHClBAZ
         fD7QLv9t+JWALf6EMIQ2HGsEqaqesD34uJYNKmmCj7b4MkTdkjx+/49uipgegyU+mQTX
         HUvYVCaq4QJpRnV/kTUuCIX7ayoGUyBiIzBc3Xw/FNLxvNdTIn3pmwTQ2WKdKmhQ1NdX
         kT4FVtYs1djifToZM4VVWKjyL6wiQ4dpHSLYpomigD+OtmbRgnSp1FrS4xJiar+Q7w94
         ANaA==
X-Forwarded-Encrypted: i=1; AJvYcCVgo6YjcWVl2+XeCsxGS0huRP2X3+oKi3s+d+rX/hppklks7wJ5m2x5GdhDYlmElz9xnS1jbtg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3BMgHW3weACq4tM5GnWkN9+moO+RABRu41Qf8KMVQBZd/0xGQ
	x+fHJQjBcwYUb7Qd2iMW5Ha1b8wjbVUUZbO52ICuOyTMreDtT838
X-Gm-Gg: ASbGncsxfO2YtIKMd0eQRZQiNr3VaXsJC95zZnZKdhY9Net4EeOr46aJZ7dx5KXkrc5
	fdXr/VUGhjMFD+wXyXKDjbj46TRVfQ/1gPn6Zv9/0t7xNeFcyGsKSRt6a4zCYdXebuck4hLYry2
	Zix6SWiCezmve2MPbMnvQmr4ZO+5pSjvcmxqAhyuO3kEX/sUP8NdM9uJj7Sm/tj6SMhZomdQXSn
	iSIWiTT5xO87b6OKmwtAOiA+IKfXn3+apiy1hzV/y5J8Ak6jqbyp0w1AyhtWZyacFD4gIas8kTV
	wEzw4Ue02hQ5Wf7gS5YMZ9ePkDGDdaxqfZaEqhU/PVyBQsSrF/7TK1Q6jfVx/sc0DFQ=
X-Google-Smtp-Source: AGHT+IH766RK/hwM7mkPwql2PqHI7sNoGHRERLD30OsqqydvJaXG//mcrrrJ8IvYqM/qPgbCxFEohQ==
X-Received: by 2002:a05:690c:6f90:b0:6ef:94db:b208 with SMTP id 00721157ae682-702572ffee4mr138081477b3.24.1743451911527;
        Mon, 31 Mar 2025 13:11:51 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a341a69sm23270557b3.25.2025.03.31.13.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 13:11:51 -0700 (PDT)
Message-ID: <5d93f576-1d27-4d3f-8b37-0b2127260cca@gmail.com>
Date: Mon, 31 Mar 2025 16:11:50 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 2/3] net: bridge: mcast: Notify on offload flag
 change
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-3-Joseph.Huang@garmin.com>
 <d9a8d030-7cac-4f5f-b422-1bae7f08c74f@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <d9a8d030-7cac-4f5f-b422-1bae7f08c74f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/2025 4:47 AM, Nikolay Aleksandrov wrote:
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 68dccc2ff7b1..5b09cfcdf3f3 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -504,20 +504,41 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   	struct net_bridge_mdb_entry *mp;
>>   	struct net_bridge_port *port = data->port;
>>   	struct net_bridge *br = port->br;
>> +	bool offload_changed = false;
>> +	bool failed_changed = false;
>> +	u8 notify;
>>   
>>   	spin_lock_bh(&br->multicast_lock);
>>   	mp = br_mdb_ip_get(br, &data->ip);
>>   	if (!mp)
>>   		goto out;
>> +
>> +	notify = br->multicast_ctx.multicast_mdb_notify_on_flag_change;
> 
> let's not waste cycles if there was an error and notify == 0, please keep the original
> code path and avoid walking over the group ports.

But we do want to keep the error flag so that the error shows up in 
'bridge mdb show', right? Notify should only affect the real-time 
notifications, and not the error status itself.

> 
>> +
>>   	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
>>   	     pp = &p->next) {
>>   		if (p->key.port != port)
>>   			continue;
>>   
>> -		if (err)
>> +		if (err) {
>> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD_FAILED))
>> +				failed_changed = true;
>>   			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>> -		else
>> +		} else {
>> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD))
>> +				offload_changed = true;
>>   			p->flags |= MDB_PG_FLAGS_OFFLOAD;
>> +		}
>> +
>> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE ||
>> +		    (!offload_changed && !failed_changed))
>> +			continue;
>> +
>> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY &&
>> +		    !failed_changed)
>> +			continue;
>> +
>> +		br_mdb_flag_change_notify(br->dev, mp, p);
> 
> This looks like a mess.. First you need to manage these flags properly as I wrote in my
> other reply, they must be mutually exclusive and you can do this in a helper. Also
> please read the old flags in the beginning, then check what flags changed, make a mask
> what flags are for notifications (again can come from a helper, it can be generated when
> the option changes so you don't compute it every time) and decide what to do if any of
> those flags changed.
> Note you have to keep proper flags state regardless of the notify option.
> 
>>   	}
>>   out:
>>   	spin_unlock_bh(&br->multicast_lock);
> 

How does this look:

--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -496,6 +496,21 @@ struct br_switchdev_mdb_complete_info {
         struct br_ip ip;
  };

+static void br_multicast_set_pg_offload_flags(int err,
+                                             struct 
net_bridge_port_group *p)
+{
+       p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+       p->flags |= (err ? MDB_PG_FLAGS_OFFLOAD_FAILED : 
MDB_PG_FLAGS_OFFLOAD);
+}
+
+static bool br_multicast_should_notify(struct net_bridge *br,
+                                      u8 old_flags, u8 new_flags)
+{
+       return (br_boolopt_get(br, 
BR_BOOLOPT_FAILED_OFFLOAD_NOTIFICATION) &&
+               ((old_flags & MDB_PG_FLAGS_OFFLOAD_FAILED) !=
+               (new_flags & MDB_PG_FLAGS_OFFLOAD_FAILED)));
+}
+
  static void br_switchdev_mdb_complete(struct net_device *dev, int err, 
void *priv)
  {
         struct br_switchdev_mdb_complete_info *data = priv;
@@ -504,23 +519,25 @@ static void br_switchdev_mdb_complete(struct 
net_device *dev, int err, void *pri
         struct net_bridge_mdb_entry *mp;
         struct net_bridge_port *port = data->port;
         struct net_bridge *br = port->br;
-
-       if (err)
-               goto err;
+       u8 old_flags;

         spin_lock_bh(&br->multicast_lock);
         mp = br_mdb_ip_get(br, &data->ip);
         if (!mp)
                 goto out;
         for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
              pp = &p->next) {
                 if (p->key.port != port)
                         continue;
-               p->flags |= MDB_PG_FLAGS_OFFLOAD;
+
+               old_flags = p->flags;
+               br_multicast_set_pg_offload_flags(err, p);
+               if (br_multicast_should_notify(br, old_flags, p->flags))
+                       br_mdb_flag_change_notify(br->dev, mp, p);
         }
  out:
         spin_unlock_bh(&br->multicast_lock);
-err:
         kfree(priv);
  }

Thanks,
Joseph
