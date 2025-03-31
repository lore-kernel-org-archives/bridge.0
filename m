Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1D2101B3
	for <bridge@lists.linux.dev>; Mon, 31 Mar 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425530; cv=none; b=WavcRuMFW7ll2RuJjIZftLu0hg9RdQEh+UDrinA6hTFLXX/Au5P8AlTbtLrwskO7/33ByGLOu9dbYmhTYF8Z0+g5lbGLNJQtgeI5y25PPKEh3Bw4K9ZHkQu+sAcg9Fax4l4oi3P7Q8O6aBe3IdMYZedNEuoU8EtVub4Z+6aKFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425530; c=relaxed/simple;
	bh=Zc0HI/HpPRp4LKMEY0BpJbXpuNHzAcrT5EXAtIL0Yfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj1UQWrLMrJTm/zfuENMfn3352mDwJVvdb/Bl9TRAqn4y3JWLRfnAH0B9u05QcfIELvOYJgCbtgNuVL36t/zkryDnEMh/P4XpBXvPTVUhg9o62CBmb84yxnGeJCcYuspLmAZ1k9S2DkSz8xv2tSliVhnMHT336+WBlUMkS+SklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0sHMZHCq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0sHMZHCq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so7080380a12.0
        for <bridge@lists.linux.dev>; Mon, 31 Mar 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743425527; x=1744030327; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6T65GxNTfj24quUriuBkHJ+dt0mRwDTK5ChQlYE9MI=;
        b=0sHMZHCqqYdEzJrBfGxGzwQlIvkDfpgpwZ9AceMJzEyWwiWG5LNokXkLG4abAKmF3b
         jCTuvEryKbLfpFqljTKDKkLgsu+fRo9TUonXbdAmhbPJrz+P2n2ZcNQVC9ihoQwES5qc
         H7f/OM1ZHzQEWdnlaORTWZf+bN8r7/U9ILKEWZTVNSaAA4/k4Qw+XsSLzksT1+BlnIPa
         hS44JOts/rH5371VhL4UvOOK6AQZEF4orV+o1VXLGy+EBKvWAVYPfHWF/lLn1eIxfqS4
         W+NPZgnM4hfETCcrN1S6UiRb03j+xmAtN/2n7sEkd36skWWVJaYxsMyrVI97hyXnaq+0
         6yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743425527; x=1744030327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6T65GxNTfj24quUriuBkHJ+dt0mRwDTK5ChQlYE9MI=;
        b=CRf+liLTjpjm9cNx5IuZKpT2zGzfuXrovV9OHIGgUK4b9r/cdTmc9mddC0/feaQrkk
         z/tKgMCxrG3YhQaSAue5ag/59/pzN0A+Bn02Qd2AzEp5NRGNPhIT/D9wPYbnPRz95+NH
         6cB+bLK8r0DICqh3mA7lnO2mxv4zzPZ0ZGGzPQiOMhSVzd0iC1xjy2j9oBTHAFytNNhW
         /L5NLHUpslzEErUcEc/L5Xb91OkvMDqDaEM4uJiF5HJVMjXjGIrPP0ATVmDlQOYAkDj+
         uYm0zOTwj/s4mUBn5ze05U5N38UdCrYGppeZvqgVLnf3eZsqffOGB09Gj4fWydGN9MqR
         +N8g==
X-Forwarded-Encrypted: i=1; AJvYcCUISiS97nWaoii4OUv45Adf9cMJoLTc/YPo21tb96xaN9Hb3m9f9fXiJqfv8C10zfumaQ8PQo8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwAxDdzJdvvoHgdbk5MsqjvudAARM3FzNjpmCRwjPC4ggnCq+Y
	Dm9GWZp2PnVqPnNW5rwmHJk/9EbqoBzWcR1O6tV1Jd2Mee41QGJNPr1a8OBS/p0=
X-Gm-Gg: ASbGncvxDKCrhHs2i4G4iKJOlpvaY7cA43VKqzYAxcGR5o/ITnWe4lbnSjnIktuy34X
	i0bIZPZ1e01LC+WHJWR9lMHgUUvLgtRwWTRppuNCp9kpPW0Cf2In+7pNq/FSGAItO9lw5Jtx7Vi
	rSeswfsDMU4drrrszNcxAlzBTHh1CISXBw+ZzkqAj0X4vuLCcvb8GZV8gCEfe5jUfdjSr3vxepA
	6lsNeIGbbNNxDWnx4xUF1V8IUGID+MUaHh1DjCLMzrd8sjCeC2Z/gVy9Nq7InL97cg7OXh2bgUL
	TAn7LSeHKYebDbzvPMXxFwJIkHv8HH4MjYEP9QIVvQ7JgDYX5mI=
X-Google-Smtp-Source: AGHT+IFxhdtbJTpnPbhUgLUozMESZ9/aqB70JTwf+Ggby43nXPU4gPgaePZldfj2ATJIUcnPh/2Ssw==
X-Received: by 2002:a17:907:8686:b0:ac3:ef11:8787 with SMTP id a640c23a62f3a-ac738b910e3mr905521466b.54.1743425526894;
        Mon, 31 Mar 2025 05:52:06 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.74.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b150sm623687666b.46.2025.03.31.05.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 05:52:06 -0700 (PDT)
Message-ID: <da181580-56bd-460c-b2bf-16ebb86bbff5@blackwall.org>
Date: Mon, 31 Mar 2025 15:51:54 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Joseph Huang <joseph.huang.2024@gmail.com>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
 <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
 <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
 <8f51bb33-c5a5-4046-93d6-f58e841256e5@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8f51bb33-c5a5-4046-93d6-f58e841256e5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/28/25 17:53, Joseph Huang wrote:
> On 3/27/2025 6:52 PM, Nikolay Aleksandrov wrote:
>> On 3/27/25 00:38, Joseph Huang wrote:
>>> On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>>>>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct 
>>>>> net_device *dev, int err, void *pri
>>>>>            pp = &p->next) {
>>>>>           if (p->key.port != port)
>>>>>               continue;
>>>>> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>>> +
>>>>> +        if (err)
>>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>>>>> +        else
>>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>>
>>>> These two should be mutually exclusive, either it's offloaded or it 
>>>> failed an offload,
>>>> shouldn't be possible to have both set. I'd recommend adding some 
>>>> helper that takes
>>>> care of that.
>>>
>>> It is true that these two are mutually exclusive, but strictly 
>>> speaking there are four types of entries:
>>>
>>> 1. Entries which are not offload-able (i.e., the ports are not backed 
>>> by switchdev)
>>> 2. Entries which are being offloaded, but results yet unknown
>>> 3. Entries which are successfully offloaded, and
>>> 4. Entries which failed to be offloaded
>>>
>>> Even if we ignore the ones which are being offloaded (type 2 is 
>>> transient), we still need two flags, otherwise we won't be able to 
>>> tell type 1 from type 4 entries.
>>>
>>> If we need two flags anyway, having separate flags for type 3 and 
>>> type 4 simplifies the logic.
>>>
>>> Or did I misunderstood your comments?
>>>
>>> Thanks,
>>> Joseph
>>
>> I think you misunderstood me, I don't mind having the two flags. :)
> 
> Got it. Thanks.
> 
>> My point is that they must be managed correctly and shouldn't be allowed
>> to be set simultaneously.
>>
>> Cheers,
>>   Nik
>>
> 
> Helper function like this?
> 
> +static void set_mdb_pg_offload_flags(bool err, u8 *flags)
> +{
> +    *flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
> +    *flags |= (err ? MDB_PG_FLAGS_OFFLOAD_FAILED : MDB_PG_FLAGS_OFFLOAD);
> +}

This could work, but I have to see how it aligns with the rest of the
code to be able to answer well. Also why not just pass the pg?
Please also choose another helper name, e.g.
br_multicast_set_pg_offload_flags() or something in these lines. You
can check br_private.h for other helpers to get an idea.

> 
> and then from the call site
> 
> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +        set_mdb_pg_offload_flags(err, &p->flags);
> 
> ?
> 
> Or simply clearing the flags in-line:
> 
> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +        p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
> +
> +        if (err)
> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
> +        else
> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
> 
> ?

I'd prefer using a  helper. Thanks.

> 
> Thanks,
> Joseph

Cheers,
  Nik

