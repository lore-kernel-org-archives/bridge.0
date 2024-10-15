Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB51FC7C2
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999137; cv=none; b=LutP5oByjpM2e3QfCoOT+IMVgYAq5ei9MfPc8Yc4ErwBKjTJZpSGrEpRh6MU3q3M4loqb9tw+5gxEjkpE6s38JyHvAwlrcPMrBtD4aUDZeobC2pXlVRiFk4bk51OmEcgzVhH5um1yF6Qtv45sy9DmNieAH0+J7X4dgd603tOWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999137; c=relaxed/simple;
	bh=XGgtJDDDYxzb48QuctikU+Vt9hxTUybzOHi+IPF+7QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXfmZnQ/XUXSrra/7npDwA0XU1mNa6g2MOJ87KB84tToB4hXKu5DnmdAbBoa5yiUg8vnHTvLP1ZfavBsoVIeTDmxzuEwxEDwmIRcYqLIdHM80NfE7xY/rUE5Vt4QkalRsbqEB31hAoAPBAFB+p6IcZvvn/V6M79tWnGI4ucyPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjvjUGRU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjvjUGRU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so547787666b.1
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728999134; x=1729603934; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wgxlf8j6C6WxbcSqLlRz/GSOnVwKwwZyR7OiY8684pQ=;
        b=ZjvjUGRUie9BLuO1rma5MpPiKM/L6CM9miG5mWmTspeX8zXV2aeLzYyIxHzLGtvZ7S
         Tp7EmGodvHaw9/G+m7y+Z5fC3bsegugWHxQl2shir/e7F8LRs0AjjTaEq/RaS97w2zUJ
         crDZmBT/2nXAVHABQ4UQGAzOdf33F/SaJGwIcHbuT/n1/Oo64vAWrF8I2YoUmN5JbIJF
         jYo/znZK4gH09Tx196H85/HMpxl9UgSBZ0KGvK/32+YkifNDna0cOOKdCMcVLkL63W9W
         q2ePaIEXZWlJn9WnFQe2leP8kjxBo7fVxRfV8CsT4BBeiHee9dSUS9dQ+wlbLkw6Js5M
         My5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728999134; x=1729603934;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgxlf8j6C6WxbcSqLlRz/GSOnVwKwwZyR7OiY8684pQ=;
        b=tE6ru+Spnh/JW3GpjsUT1u5iZ9k3DZnmOU2cmgPA5ILVRvvHFWc3zcRRVmv+Ak4MDV
         584YQr4EDl/SVMrvzhLpabW85qhyMIlfyCPkAIfjH39Dl9chb7cZYJjQuLpupfuVqhF+
         jpbukQwqX7Wb6IYxrYL4WjdN1ZoNJspIBc4G99huALyWQVDezH4l1zq06HU/ezU3NB4V
         o6DfFBZqsgXYQCR8eoEufGsnE4SJRM60O+/xM93wpkU430L7nsWX9bCxQHqRVOQBoyy8
         N1dr9NL15RdyZXIz2ncFyhnke0yu5hSB2Zzujb2aQuRkITtQAz89/Eox+/7mgm0FC671
         iW5A==
X-Forwarded-Encrypted: i=1; AJvYcCVndNr1tdtHo49kK4IBF7wM1aYk902O5JNTa3IXkc7vaa25gWK+FCuKBhfRiYxwUvBy8422GtU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5NSMRkSGXn0iXl04xiGHJ9doPauf8taWGk0skbCTzVyDlAD2X
	CHfUxduFX0IqXPt54tcZSbIZOwWfwl9AC7lGSnYHqNhvUdBdURdL
X-Google-Smtp-Source: AGHT+IHead+svkj8BMnd2AtLtotz8v11llLgziR4JZ6WubowTfOWTXfJTTlJA3fxQTd68GmzjhaI0A==
X-Received: by 2002:a17:906:7955:b0:a9a:f19:8c2a with SMTP id a640c23a62f3a-a9a335726dfmr74735966b.6.1728999133316;
        Tue, 15 Oct 2024 06:32:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2974960esm72107366b.62.2024.10.15.06.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 06:32:12 -0700 (PDT)
Message-ID: <137aa23a-db21-43c2-8fb0-608cfe221356@gmail.com>
Date: Tue, 15 Oct 2024 15:32:11 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 00/12] bridge-fastpath and related
 improvements
To: Felix Fietkau <nbd@nbd.name>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <9f9f3cf0-7a78-40f1-b8d5-f06a2d428210@blackwall.org>
 <a07cadd3-a8ff-4d1c-9dca-27a5dba907c3@gmail.com>
 <0b0a92f2-2e80-429c-8fcd-d4dc162e6e1f@nbd.name>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <0b0a92f2-2e80-429c-8fcd-d4dc162e6e1f@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/15/24 2:16 PM, Felix Fietkau wrote:
> Hi Eric,
> 
> On 14.10.24 20:29, Eric Woudstra wrote:
>> It would be no problem for me to change the subject and body, if you
>> think that is better.
>>
>> The thing is, these patches actually make it possible to set up a fully
>> functional software fastpath between bridged interfaces. Only after the
>> software fastpath is set up and functional, it can be offloaded, which
>> happens to by my personal motivation to write this patch-set.
>>
>> If the offload flag is set in the flowtable, the software fastpath will
>> be offloaded. But in this patch-set, there is nothing that changes
>> anything there, the existing code is used unchanged.
> 
> FWIW, a while back, I also wanted to add a software fast path for the
> bridge layer to the kernel, also with the intention of using it for
> hardware offload. It wasn't accepted back then, because (if I remember
> correctly) people didn't want any extra complexity in the network stack
> to make the bridge layer faster.

Hello Felix,

I think this patch-set is a clear showcase it is not very complex at
all. The core of making it possible only consists a few patches. Half of
this patch-set involves improvements that also apply to the
forward-fastpath.

> Because of that, I created this piece of software:
> https://github.com/nbd168/bridger
> 
> It uses an eBPF TC classifier for discovering flows and handling the
> software fast path, and also creates hardware offload rules for flows.
> With that, hardware offloading for bridged LAN->WLAN flows is fully
> supported on MediaTek hardware with upstream kernels.
> 
> - Felix

Thanks, I've seen that already. Nice piece of software, but I'm not
running openwrt. I would like to see a solution implemented in the
kernel, so any operating system can use it.
