Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A21DF246
	for <bridge@lists.linux.dev>; Thu, 27 Mar 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115986; cv=none; b=Bv2RZfezhAL2s9WUYm5wqZMEDzCKBFBTaaR1+Ak7D+aDmq5PkGskaeUwsxe0GplasoHhECFTGm9YV69MzLTjqzXjf3B7pnWBg+AqJl3RLrSv9mWmrPkyhoIL4CX07hWWq0rtk1UBP9go8Z0rmLeZMUNsI9YA1HarFWN0Yl3/6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115986; c=relaxed/simple;
	bh=pKpgtM4kB/4K64gSh6vdxNp84Cah8MzlKXkdIhPEZ84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7J3+FERCKz9Aw96fVX7OL036Nm7OgRo3C1jwIq7bfX7KPeOhVrwgogtHY1SGAbz1hCvBFhNmjkfZQJ34TsxCw/3PFJ9Yva5pUB3zhjx0DY8nnsx9Az9r5Titt4i6qXagP14s+BaARkJZnGLum/M5/jdYa5oKdMe734+EkmzS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=E3Cc97hd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="E3Cc97hd"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so1946238a12.1
        for <bridge@lists.linux.dev>; Thu, 27 Mar 2025 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743115982; x=1743720782; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k12Y8dWe84nCJDuQsvD5DEjenxTgzdu2WJ45ZyGKWY8=;
        b=E3Cc97hdnXOL0xUe/jDd2+1Y5WfIr4Ey7HSpT+MCGZWydeSMj5awbR8jIM+KNxkjoC
         mKdbOvOifdSLzVj7uWEm8gWrX8/w6nTO7ZLgg1q97j3Css6fbfDw2ovSjeFDTV6b7YO5
         elEIVWk7pgHOw00FPU76ukh487PnNItEtmKp1azfvVdzWZp32HflFyR2vIBX59p5AFWo
         ZrhIPz1F/tUMerH9xeRvtiKAYsu6mZtAjlX9Dbp2kELInoCOgCgtVS/3M9Px729bopIs
         AkoXVUwrhVjDrEYJ05Tal0RYWMPdoLC1E369o0EbgKQkyuHeV6uARmJ3Exkakh09PDus
         uIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115982; x=1743720782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k12Y8dWe84nCJDuQsvD5DEjenxTgzdu2WJ45ZyGKWY8=;
        b=kbsdHuKyEqEWTUAquyUIyygle/NwysWMyuuqZrbQc30q5gi7c9bNfP0cM5zptyCaPf
         FgNLxxb4jmt4o+ySoPGIePTPKBHZ4bEX9vd2qNAfZx2yfrxiGx4QYsapQrqDTU+P/CGL
         hSLayKArw621i6FrIv21kNOyuVyMkc+HyoB5l5CkDzCJLusGCtCrjo+5DhYmWGkwzyJc
         uEFJR+W75mLIEkc03w/5CF89xD9pwv31ui+Na/fiU1EPz3ldKufdEZ7igit1+b53sxnD
         2fgxUcmyGJHxl3dc3Irz8FAXLFwnWPMnxgZiqWcS5ZRCiN8x9TLNBep4CL7ynkI3y8xD
         xxBw==
X-Forwarded-Encrypted: i=1; AJvYcCUfjyxsfh4N7HmDb4S4g7/GuK7lOnQodXHhJ07iciIMTdMSfqz6u2MAxOT9Hd9OGXxJCIF7QDM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5SwY3gRsG7gykjrNQQf+Kv0iOxahiW1Wagdw7M5oZRHCJrO9A
	d6HWXUEAwAd7i0pAtstEr2R5JHN1pvrYn9781JRJXXtk7PYHGUjAwVD7LxXk4G0=
X-Gm-Gg: ASbGncvoCDIHUEmj8n7Dh7BiM32/xgucLRJnjuhWjkpqUc0omLlpQATnoYU2GGW/wny
	hEAFx+/B08t032zo+Ez3CKdthTxQ6tnDsFeQxoAcWLoSqDtQdjaXJJ9kJTQ32XqayXXmE0dhLJ7
	PjwEXvmuk0mFW9ntw/HSlkXcTpj8emNZU4zGHMnu9/myPQxFPMy66UjUd7LzMRQveffPKBUHZ1c
	lN8ItAmmNpUJjvPLLjXR/I5nT/WCuRzc5Gb4PA19zR0svacQ550PZCiNFp53sJJStfukXyyjqe6
	k9IoEdZAvNl2oj1QL13w/vnJYNkfR6/IsWjNuoVkzSmW4LFB0GY=
X-Google-Smtp-Source: AGHT+IEQKYdXU4YRdq7AjkHureyIrp+bm+P0LupbshznRTrIcsjVjBe9WN63ZaIpC1RkUq+pZC7I3g==
X-Received: by 2002:a17:906:c153:b0:ac3:bd68:24eb with SMTP id a640c23a62f3a-ac6fae46de8mr605017166b.1.1743115982075;
        Thu, 27 Mar 2025 15:53:02 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.74.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922b965sm63206566b.20.2025.03.27.15.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 15:53:01 -0700 (PDT)
Message-ID: <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
Date: Fri, 28 Mar 2025 00:52:57 +0200
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
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/25 00:38, Joseph Huang wrote:
> On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct 
>>> net_device *dev, int err, void *pri
>>>            pp = &p->next) {
>>>           if (p->key.port != port)
>>>               continue;
>>> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>> +
>>> +        if (err)
>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>>> +        else
>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>
>> These two should be mutually exclusive, either it's offloaded or it 
>> failed an offload,
>> shouldn't be possible to have both set. I'd recommend adding some 
>> helper that takes
>> care of that.
> 
> It is true that these two are mutually exclusive, but strictly speaking 
> there are four types of entries:
> 
> 1. Entries which are not offload-able (i.e., the ports are not backed by 
> switchdev)
> 2. Entries which are being offloaded, but results yet unknown
> 3. Entries which are successfully offloaded, and
> 4. Entries which failed to be offloaded
> 
> Even if we ignore the ones which are being offloaded (type 2 is 
> transient), we still need two flags, otherwise we won't be able to tell 
> type 1 from type 4 entries.
> 
> If we need two flags anyway, having separate flags for type 3 and type 4 
> simplifies the logic.
> 
> Or did I misunderstood your comments?
> 
> Thanks,
> Joseph

I think you misunderstood me, I don't mind having the two flags. :)
My point is that they must be managed correctly and shouldn't be allowed
to be set simultaneously.

Cheers,
  Nik

