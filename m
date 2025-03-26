Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8A19C569
	for <bridge@lists.linux.dev>; Wed, 26 Mar 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028728; cv=none; b=c0s7xnb66XSDWfsSaibAO+A8AZaM0zdar1hMfshSgW8BtUEVQoNi0y6FjcHlOnfrVWkdUMNG/TDxuV6J/T6kh9fpdUUUCP0qa8XmXbIcT/bDX0zuz85+aW6/BTLpocVGByKsXgSbqHejQIgVJD/8rFmuQ20ZtY/IbBLvh9CIQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028728; c=relaxed/simple;
	bh=H2y9HtTQmvQBzJD1T7U+UffAZs7WKkknHLjpbbnkIc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bV3sbfufw4qAhfIjIzaeysBrn/khA4iNFjmSFcQ7N6wQogxx2TNcPn7cE/dYxJL38qvL0fy9Xzuh98Zlfb3WcRcQpBewuyXlUGM+AMV5In1oMC4D6JfHlabyMI7mkTRlPNSE90tUh8Con5oMFzLuL3kdYeh4m45ry7WS7qIwuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FENYYf50; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FENYYf50"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6febf391132so4009627b3.1
        for <bridge@lists.linux.dev>; Wed, 26 Mar 2025 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743028726; x=1743633526; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9D44QjpZljk+SGdrmPC7kTMGNHThYXdBfqrpwqLcab0=;
        b=FENYYf50n6e1RDuXSRL4uX2RO5q7u4fXlnDYpOnCSxZr1u54AZl8kIY35I4UZSp8pL
         m+o7H5XM1UuSShz9RtnzY8HGMY2na28XJ6Ju56hGn2BIlVcAWFV6X3yBKoUNJPu4sM+H
         aC9Djb6YZ2af60rSnS2jSLfvrc/RuS51CDwZQ1a8MOSXe+xkzK+vUKNyvbumyJduqLIB
         XSItUtSmzRbKk07fg0XwEUDseO/8HErn29ehiWR1X60FiIFcclC366l7z43IrYjkfQls
         8cNVOEh3gYLH1e73SbfY1siNZ9yplaVp6ZbJ1iNa0dpkt94Utnb1AXLzPpqNMbik+lOG
         B/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028726; x=1743633526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D44QjpZljk+SGdrmPC7kTMGNHThYXdBfqrpwqLcab0=;
        b=boh+QHcxHy+ui+0IQat1CLB2s/S04ETlxB5xvhTdFOx5cStaA8GmMAy4H2omutd7cI
         WECuw6Z421gpxHO9WR79wCY5Y+DW3wKVQdlvmarK63x9kEv4cc/TGiKdFAGFWOM1Dk0E
         hPn7OORr5y+SknH2oElebWcqWpXvwMQeQEFhg+FmLW/IHdv/Ws4ya8+XqmpL6/U3KR1s
         RrfqkkiYjeeDm8xmOXqtDiUXFpfNxWznx8o7/pxKxsns5iYlK88CzEGA9VpDPIHk5iyp
         XS1nL5Ud1XGA+tYCYS7mgc9bSG1Zwd3oEf74xuNYuC6iUA4zLvzeCHGEfqh5opeQ2pck
         lgtg==
X-Forwarded-Encrypted: i=1; AJvYcCWXu2wwW4BFYwgBuGrF9qetVKJkVwuu5mjgfpxPEiMtz2UUILnJzedurBpwMgRTqQDmRyWpLhk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5hFbXhTXaFvDWxHpvjwVdgq2p+slvnX6HK/jvDwVfrNw05bC/
	0wqMVsaxiM+yvpcHh0osuIOwYLTnNTie0U2xSwoOW8dJys3ed2Lc
X-Gm-Gg: ASbGncuSsXQB4ML4zQjVudQu8/dztAw/3iGiWfRRkYtRsc2dAovw+DnDMtNF8/AdEXx
	gpwBXgiPfrd1GfaDSfjO2ZhL0sUYzRiCe4ebUrXpTqC4O3LOctL63kWjwDreKslBmxZUPhSfTFO
	VsDbwOOep5HebEaqv+rdV/v/hZ/c3yeePg+fWUIcdvrQ8QYIjihfbJ3GK5Imon9F2ZdhkzOwo4d
	PdSFErBY9aG2AKcAXon5HtlVqyTs1VxwICUEKsNAeW6EboUwGC5xvULwKPTBxwuhP/oOR+lgEDw
	kZQZ+G1FcvBcyW2byJeJrzw0Rztpf5oITUXLLhGt5NaESNH5IxbbpzvTogK4O+giWek=
X-Google-Smtp-Source: AGHT+IFdgdXC0PO8hx8zYU5TTKZvweZhG74lAB4hPV2nUNafFDcA0T0mgJgKTjPM7YGUdKXT3THvYA==
X-Received: by 2002:a05:690c:4b09:b0:6f9:544f:67dc with SMTP id 00721157ae682-70224f87e53mr19561247b3.1.1743028725541;
        Wed, 26 Mar 2025 15:38:45 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-702283ec2e1sm517867b3.125.2025.03.26.15.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 15:38:45 -0700 (PDT)
Message-ID: <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
Date: Wed, 26 Mar 2025 18:38:44 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   	     pp = &p->next) {
>>   		if (p->key.port != port)
>>   			continue;
>> -		p->flags |= MDB_PG_FLAGS_OFFLOAD;
>> +
>> +		if (err)
>> +			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>> +		else
>> +			p->flags |= MDB_PG_FLAGS_OFFLOAD;
> 
> These two should be mutually exclusive, either it's offloaded or it failed an offload,
> shouldn't be possible to have both set. I'd recommend adding some helper that takes
> care of that.

It is true that these two are mutually exclusive, but strictly speaking 
there are four types of entries:

1. Entries which are not offload-able (i.e., the ports are not backed by 
switchdev)
2. Entries which are being offloaded, but results yet unknown
3. Entries which are successfully offloaded, and
4. Entries which failed to be offloaded

Even if we ignore the ones which are being offloaded (type 2 is 
transient), we still need two flags, otherwise we won't be able to tell 
type 1 from type 4 entries.

If we need two flags anyway, having separate flags for type 3 and type 4 
simplifies the logic.

Or did I misunderstood your comments?

Thanks,
Joseph
