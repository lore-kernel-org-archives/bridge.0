Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5F156C7B
	for <bridge@lists.linux.dev>; Sun, 24 Nov 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485442; cv=none; b=A93Km6qYg6NQ0dHEBhPT78YBGaK7tvIukGUaF8nbesVkSN3Wb4aoOuBF8ROln6OC8puzlMxUDiMCR1ANvfrnmsg1t+Pf2D7aMDU8mW46BXk/xz4NezNmFC/dc6lTpW5yoPbXV1+X71KhmB3e61eaEZRrW+8i4oQ1E5Sepft9mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485442; c=relaxed/simple;
	bh=NpHCbf62av9/PPK7BaTpxt0lk/75DwEWPCY/Tnu2xKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWMkyE4LGUmnNlbwx8G8cxniW1CoimWOecVt0F0LGh4Dl/A6R3Y+IOkggrv9eE5RSfim2KCmr1RR08JX2V2jiPUdoupo4JIEVtri+JP+MnEzPSUg5Dc4X2K/9UP9izdsD9O6c9KegVxo5tt6YBWZbVDl3pSNubnCj5CTpqDTcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NuKbW7oo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NuKbW7oo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-382411ea5eeso2090857f8f.0
        for <bridge@lists.linux.dev>; Sun, 24 Nov 2024 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732485439; x=1733090239; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5yrXMRtai5EAywu8wJpj+bkyRvZoed7ZFVKBNaw1x8=;
        b=NuKbW7ooQA+t5G3CEcniXrolyJ8lrL7r7ChxkhRHGFGbYnJf+SuuV6SKoPD7x554c1
         5y+iN2yAd7DeSVRwPgMEB+qeUtAeppJx5IIjvICnfnbx7GdpHMKjnHI7xlq0rP5bHIfM
         vVUK/zZBAJzAMmH+bofgvvkSejxfV3K75pUcwxSsqxuLxcLUgeX1DP6JXq+yekmUFEQw
         F8VjD2VDClEBjF9lj8Kko99J0HF31zg/lSva688rjWtRpTPmKsZhs/RNf9Kq8GCXH7Hj
         RLIvv9hS9kWZvYygLfQG2Duo7nYvN86QLQAqUNH9mFxom+tXTjx3LFWZkKjEi/ypzCgf
         Pn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732485439; x=1733090239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5yrXMRtai5EAywu8wJpj+bkyRvZoed7ZFVKBNaw1x8=;
        b=FfGFW1AKydtPcTLl65QefBV0PW9QF3inw8/XZAJInXcO8Z2gqiNro540LEEGiYySVd
         FhO5NarkpJasv1JTVGgBhKebwCiWeqVa1g4BJC/1R3+ZeIwqn5ZaTf8tyJLDa1PhKlbh
         +K4u1YP9TUwLOZJjjznwxl/yJ6heAR0i8cZaVrkvm42A0eOZTO9lIKC4Ybbp9C1Hxuld
         OJ7QWJPJK6f0K8V+4aBMinpgIyFYMiO6bNdxQTjlMRJlS+02BTEE9O24gGyAnGhrXs8O
         AslKH5Ryv9PTFvFOslGF04h9sUBeNw8/7Z+esErtONHHB5F4B321nI0OFaGZ5D37sJVk
         G5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa2XVfAzzQ/LLTO1+eGJ+/nq/KP5ISVlaxvnED3lmX2iTLzrrAXSOmgbJDyx2cWTpk0Fzgslw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzCec7SqG8PfTmGSC/JE+23gugS+4uakIRGU7OLV7oSn6fz+LP
	IkA276ym+ySD8M5yPuA07g+JjMBjHbzlZrkft5YFm/mlJhIx17LBt3/bnFDyii8=
X-Gm-Gg: ASbGncswy0D49awwCBNPklM552tUY6JreSjpBAPUeojA70Ti/boVOqWtRjJ1/SpHNuf
	zDzGl658T1tyWEofktBEOm89qsM0zsjXfpwbuiO0XR5SHRoGztyY05BiyIClDHnwnGhNIGEpaES
	UFjZSpGu8X/1jg3w8zISWC/AETODhjHRMSUhnyubkwgdfd3Nr4MptovcbAzVqjounwhg/KqDcJw
	jigIvs2D761T5XEByf10d71zVIxqQI+jYCbGsFkYP3ngW4nxUkA
X-Google-Smtp-Source: AGHT+IGMAOqJMIhmfSxPxSLsMr48gcoyUhLJuaGrSWiRPA3cEqIM0EpifqKQyZ89S0Tan5CyBkK6Tw==
X-Received: by 2002:a5d:6f1d:0:b0:382:49c0:131a with SMTP id ffacd0b85a97d-38259cb7f74mr12568969f8f.1.1732485439448;
        Sun, 24 Nov 2024 13:57:19 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm8876697f8f.1.2024.11.24.13.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 13:57:18 -0800 (PST)
Message-ID: <c09bb2f0-2aff-4dc4-bf9b-53f97fd2d878@blackwall.org>
Date: Sun, 24 Nov 2024 23:57:17 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
To: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "roopa@nvidia.com"
 <roopa@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
 <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 23:23, Elliot Ayrey wrote:
> On Sat, 2024-11-09 at 15:40 +0200, Nikolay Aleksandrov wrote:
>> No way, this is ridiculous. Changing the port like that for a notification is not
>> ok at all. It is also not the bridge's job to notify user-space for sticky fdbs
>> that are trying to roam, you already have some user-space app and you can catch
>> such fdbs by other means (sniffing, ebpf hooks, netfilter matching etc). Such
>> change can also lead to DDoS attacks with many notifications.
> 
> Unfortunately in this case the only indication we get from the hardware of this
> event happening is a switchdev notification to the bridge. All traffic is dropped
> in hardware when the port is in this mode so the methods you suggest will not work.
> 

I see

> I have changed my implementation to use Andrew's suggestion of using a new attribute
> rather than messing with the port. But would this also be more appropriate if the
> notification was only triggered when receiving the event from hardware? If not
> then do you have any suggestions for getting these kinds of events from hardware
> to userspace without going through the bridge?
> 
> 

We want to have the same behaviour (or as close as possible) between sw and hw.
Since this can cause many notifications to be sent up for current setups, maybe
make it optional so we'll get notifications for roam attempts only when we
explicitly enable them, with default off. You can look into bridge's bool options
for this (e.g. link-local fdb learning option).


Cheers,
 Nik
