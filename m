Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334F253F3B
	for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289613; cv=none; b=Wbs93C36fST6K+fRROj2FkSev8C5HmRS+xG5TgmhmGcuAJtKOV1mE2phLnZxg6klypy4RHmo0u7/zwXLBtSDQWjCDyi3wRuKaHRh2YM82alRw+SuoQ/eHbfqlwxIun5VmxBR3TievqNDr5KUh7gs/ODioEso4yyPGHz7sKJOhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289613; c=relaxed/simple;
	bh=367tBOVSTQNE68f9evXGvkRc2n1V8n4iAsIeEbOEs7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIgUTnxJiVfWy9YoIQqUVErJq6fxdOF8U8rRh/v6CnSs+PagBhl4CcYHqQHQ3qUBfBLNWbWoudKc49DJDmhDh9LPDsm07hJ5wTtILlJ7dTqxDZpFF1MC2poV4DN+MfTP3L0F7XbVKn/bpSqadKlxdlU/pjunKh4AtBcngiPv9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=V9SBrfe4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="V9SBrfe4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1098242266b.3
        for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739289608; x=1739894408; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hI/ECcJmQ5+lRsmCQ33ubWCT5i7ZlE5HoQwEXVHTSj0=;
        b=V9SBrfe4jLzvlvPLBKL0dPT5TYpW/v40q7O1P3TvMyx4cKWis1j+WLHgQdg/jGVePy
         0xzbNa0b/W6YoQp1TwCejH8TMWHFjCQ14WdGnAoy2kRUNnT79hd4yGmnUr3ilk7CucQO
         5XIeLFvRKykxx/MtW0BnThbndUwmHq7WArH1KNvkNfGiVv6WqSrWPxhIbhpe5B+v21Kg
         V36wE0ej82lkJzM8OsF7VBJzVybuZxgLfCBi7vaykSGu9FXFX97fJNymZ4BZ0RWh3NOS
         YtyswPrT8OzUlRPnqWkufzk+jliIQkENf3nQMPa9UzN+YSVp0ohn5S9zRJXGu9PNaj7p
         pgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289608; x=1739894408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hI/ECcJmQ5+lRsmCQ33ubWCT5i7ZlE5HoQwEXVHTSj0=;
        b=OwbSEnmA+JazJAhlZMAiNpbjMWi6XeKTmt9J+5uHymOyJ4Q7lYOJZ+OlaOstDqrYww
         oT6SMFcM7mRZIdnMDS5ulNBHCS2Zl+z46m+fY786+17ZpWc3cfBdMnUjPJPpBHwi1Ugl
         nvMl+RgTcT8P0zeEKDoBFaciAr/i1yBAPHTmJlL+jKTLUQxiKaFOYkP6x6dDqz9tVUtr
         DFZvSX4o0n6z64VcAyZQhv98MuA/Tc3edTeYpBECQEbuWpqaMGiOBoXlwbAyHVqCKRAn
         lITnUMuUZCG6jjwGNr6kybmcQM/WzilZpg3Un/PLMJq6ZTKlvKVhOTRErZSyByhYDiWy
         3Knw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ITEBeHIDNq64s+ccd4AT9JY646w+dQbx5PMY4KyMQ+nmVDGRMU8lM32RswthH0806umVFJk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPnEtrz/2yqMiKa/CEFRNM+NiC301p7fV1amKjUnLXNTTmkNVf
	kP91AbpUGeovU1YtlXgSMoiudD4f8NyEAwfslk2OlGT7/S2zNA3AMXrZAlM9GU8=
X-Gm-Gg: ASbGncuDxrDijC7dQcOdqAD/JPeWr2b/W1VGbu+jpMxR63OKE/ETyD8lJC8OTVZb3fn
	/jlEB63oInP3rDl6h2U21Npb7Ko0pMBuXxp+9t/ovuoSN6WAdPemXcaz4YiB0ZdQnIF8zhnyO/d
	NNXVqUSxkdV7dxptQyrA5thrWZW6pdhCnZEZKqz0qAdcZDuS+c+7rqBkqG8u38VmmajYakO4wQK
	ZbrZ9rpPL4FjLxer802kMEB90KSjZZKE7Ue9yCsWqlFPYFcTNpFmk2vsGbdWWFgu29q0QVidIjj
	sBXvByxTLVSa/z6PfttYziu+KO8VMLBVBvK3Amd5RTxs66Y=
X-Google-Smtp-Source: AGHT+IE7ksSku6fs3EFiOJ7qMjT+Xj86y9WzUfaIKnMbJB/roCniH1bXiqumQdCG0sjm3B/UGhh56Q==
X-Received: by 2002:a17:907:2d24:b0:ab2:ea29:b6 with SMTP id a640c23a62f3a-ab7f01cc9bemr17039766b.35.1739289608146;
        Tue, 11 Feb 2025 08:00:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ce2e91e9sm307325466b.117.2025.02.11.08.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 08:00:07 -0800 (PST)
Message-ID: <91d709aa-2414-4fb4-b3e1-94e0e330d33c@blackwall.org>
Date: Tue, 11 Feb 2025 18:00:05 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] bridge: Add filling forward path from
 port to port
To: Vladimir Oltean <olteanv@gmail.com>, Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250209111034.241571-1-ericwouds@gmail.com>
 <20250209111034.241571-6-ericwouds@gmail.com>
 <20250211132832.aiy6ocvqppoqkd65@skbuf>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250211132832.aiy6ocvqppoqkd65@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 15:28, Vladimir Oltean wrote:
> On Sun, Feb 09, 2025 at 12:10:25PM +0100, Eric Woudstra wrote:
>> @@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
>>  	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
>>  		return;
>>  
>> -	vg = br_vlan_group(br);
>> +	if (p)
>> +		vg = nbp_vlan_group(p);
>> +	else
>> +		vg = br_vlan_group(br);
>>  
>>  	if (idx >= 0 &&
>>  	    ctx->vlan[idx].proto == br->vlan_proto) {
> 
> I think the original usage of br_vlan_group() here was incorrect, and so
> is the new usage of nbp_vlan_group(). They should be br_vlan_group_rcu()
> and nbp_vlan_group_rcu().
> 

Oops, right. Nice catch!

