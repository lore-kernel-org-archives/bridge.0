Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC620F5C6
	for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094396; cv=none; b=oWWFDR8WJ1b4uhNU+q5Wkwb5qSuw68vNpLl0j745lmhxs0St7GJ2+zJ2QIx0XJkInlzo4Xurd/VfjeQHA9BjbRZWWl3bAE1R4j4T4saVXkp2V+oYnS2JWIetox/I5ydkrwRJQDJcLwHGm4UUtWyWw5fH9EKkvtbQB856WFIR9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094396; c=relaxed/simple;
	bh=t9Pj6Lytp3o2TRKmx2LFg2KV8jy16bK0bFqodVcoKE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTVbJ4+zwGG/8lijbgp0pAqy4KVWIbm9NTno3xNlLAZhKgCq9+PBVuWi9pTkSy1IOZoVBzH6K28HRRORYwIQsVdKPSdK5sGAthl5CHt13FU8dqZ5GDNSuJcsXm7Xzh+VYyyQdyPQfiFBba3ok47fECJomJPKQSdQN6Vbfhdfty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQzoxOHF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQzoxOHF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99eb8b607aso563473166b.2
        for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729094393; x=1729699193; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmj3m26uAVevKrLVIw7nRomm2+bj6OhZczGFx03aqgs=;
        b=PQzoxOHFvfjoWmSHwXR8cnpOcNlnbgHQmFwKA70aO0yDWL+ECh/vm3bqhypL8cQLu3
         OMQcXr98dynuYYvTNzZWOyUDvpgm2SqPAftNwuuApVrLVSCxDHYrcwirbRC3a0uGYZ1y
         sMpO+uuOXIaU+D9GtWW/mAQHmlW16kwhEJS4Nf/G79NUEzSB5mWSCOuaoBK5Q7VEDpZ+
         +ErgN9mkv+IrCq/JEVuEN7q35ZnzttyaRRYU6YIhF90h5F09KKzBdKOvuVIROw2Wt3EN
         XeH/UkejpmoHHGyUJAJP1p45m/YhYHBAOlCBvyPZASV70azQleGliXwts1BedjEKiRtW
         szeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094393; x=1729699193;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmj3m26uAVevKrLVIw7nRomm2+bj6OhZczGFx03aqgs=;
        b=d/qVhIBVT170pTxYtp3bwK6ngRbeTk0c4jypWKkl/4X5WnAgufE8kJ0Xq2rJfC4THH
         1t97Z16cIskt4atvxmC2tv7YNA0ifhfOCDDD4H8wYAWe3FHYzbvqR+Zi78K+b5pJ9xLz
         ahMKo/E1hrMGIYEQtzVaVuQTS8PsbjTOOGgTkbfyCwgbVknNHqOAYDDEqKe2pc2pKxEu
         GmRtw558wuYNAyJi0552k8plZrTam6G969TnH82AP31bFd/sWL3M1qUeFVmEMIEXYb1L
         uWmMvdTTZvidkHUEAsuGUHTWb+BgToAjb6UQj4WHBTbpZq5VfRpXl2JwMPwqst9OaDlb
         peaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNRaFZViA/b38VsKw8qgdDkDDWrkdzNo3Tt9stioBtCmo9VKW4fsIThOmhvvPrK03BDJ8oxU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxKfFSm7exsZ+QZ2I2vA6rdBmYnd5wkPtQ953uqDpCxaAJnnf/w
	pv+T7wh6apUE6Z809j+khOmXxYTV90uwqjzLZuJ9IsKYNaK36j2V
X-Google-Smtp-Source: AGHT+IEXjAEvk5CdHrK8htzjtcfYfdp/XWOG5TaTbOL8TmX4lMucUTmZkpPTZn1+9nd/fPfsH42SKg==
X-Received: by 2002:a17:907:868d:b0:a99:4aa7:4d77 with SMTP id a640c23a62f3a-a9a34c83718mr303503266b.3.1729094392957;
        Wed, 16 Oct 2024 08:59:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2989797fsm196863666b.196.2024.10.16.08.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:59:52 -0700 (PDT)
Message-ID: <d7d48102-4c52-4161-a21c-4d5b42539fbb@gmail.com>
Date: Wed, 16 Oct 2024 17:59:50 +0200
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
 <137aa23a-db21-43c2-8fb0-608cfe221356@gmail.com>
 <a7ab80d5-ff49-4277-ba73-db46547a8a8e@nbd.name>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <a7ab80d5-ff49-4277-ba73-db46547a8a8e@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/15/24 9:44 PM, Felix Fietkau wrote:
> On 15.10.24 15:32, Eric Woudstra wrote:
>>
>>
>> On 10/15/24 2:16 PM, Felix Fietkau wrote:
>>> Hi Eric,
>>>
>>> On 14.10.24 20:29, Eric Woudstra wrote:
>>>> It would be no problem for me to change the subject and body, if you
>>>> think that is better.
>>>>
>>>> The thing is, these patches actually make it possible to set up a fully
>>>> functional software fastpath between bridged interfaces. Only after the
>>>> software fastpath is set up and functional, it can be offloaded, which
>>>> happens to by my personal motivation to write this patch-set.
>>>>
>>>> If the offload flag is set in the flowtable, the software fastpath will
>>>> be offloaded. But in this patch-set, there is nothing that changes
>>>> anything there, the existing code is used unchanged.
>>>
>>> FWIW, a while back, I also wanted to add a software fast path for the
>>> bridge layer to the kernel, also with the intention of using it for
>>> hardware offload. It wasn't accepted back then, because (if I remember
>>> correctly) people didn't want any extra complexity in the network stack
>>> to make the bridge layer faster.
>>
>> Hello Felix,
>>
>> I think this patch-set is a clear showcase it is not very complex at
>> all. The core of making it possible only consists a few patches. Half of
>> this patch-set involves improvements that also apply to the
>> forward-fastpath.
> 
> It's definitely an interesting approach. How does it deal with devices
> roaming from one bridge port to another? I couldn't find that in the code.

It is handled in the same manner when dealing with the forward-fastpath,
with the aid of conntrack. If roaming is problematic, then it would be
for both the forward-fastpath and the bridge-fastpath. I have a topic on
the banana-pi forum about this patch-set, so I think long discussions
about additional details we could have there, keeping the mailing list
more clean.

>>> Because of that, I created this piece of software:
>>> https://github.com/nbd168/bridger
>>>
>>> It uses an eBPF TC classifier for discovering flows and handling the
>>> software fast path, and also creates hardware offload rules for flows.
>>> With that, hardware offloading for bridged LAN->WLAN flows is fully
>>> supported on MediaTek hardware with upstream kernels.
>>>
>>> - Felix
>>
>> Thanks, I've seen that already. Nice piece of software, but I'm not
>> running openwrt. I would like to see a solution implemented in the
>> kernel, so any operating system can use it.
> 
> Makes sense. By the way, bridger can easily be built for non-OpenWrt
> systems too. The only library that's actually needed is libubox - that
> one is small and can be linked in statically. ubus support is fully
> optional and not necessary for standard cases.
> 
> - Felix
