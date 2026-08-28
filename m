Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B252181334
	for <bridge@lists.linux.dev>; Fri, 28 Aug 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912589; cv=none; b=kJDjH3KnS1TVCU7koWqdOpKUXsu0RA6qylmsmglHdgepMtGRfupDt0ZlCcZmDsG89QQOarcv4MhqN0+5EvuzMgaXG9dXrkkAViAZ9dpZBGoBBOmwU4mbAlpcBOKQOxziYe03E2ZjLmlJkenOF1SnhmbDzliL+RGaE34ZIM+wE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912589; c=relaxed/simple;
	bh=EfQtWsR8HhNL/FTZFFNCO2u47LKPG7z6X31K2hLCtXI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h9eaiwQCYjA+LRaWm+6SK1SQZr+XY/LgWxaue6A227pHDPnOvkVUw+9LBa2+BLzw0m0hvF0l7AJ1795hbDRzWJOQ66vUXOcOraYGGcRp8pPoXaxxmkyuvAoMUPcso5C8hkkn4O6dL29s+bnexe4E7YDpZdHMA7KU+dhNUU/1OVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=D+7njwc4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="D+7njwc4"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e4998d28so555570f8f.2
        for <bridge@lists.linux.dev>; Fri, 28 Aug 2026 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787912585; x=1788517385; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud1SVn2U/zjHi4VSWIq5F5o3aDeRY2u2GtAjGiMvvok=;
        b=D+7njwc40zUmIVFQKPtHfNNYmp6cDP7FCw6oNL9s41xF9KpMIC4OhF7gq0Xjicri8p
         FDx7EQ6SkeuUtYzKpo2I/z6syVjJB/2Zq0lPe7FDtRXgfQ/sCidCKIR9FtG3eih6fSob
         anzkqZdg891JG+k9zv3HX1Mp1QDeuTssb/hi1Apj2+AvZh26B4Mp+zu9fUzAyAbmctt3
         iZB295mJqMn2NtXlxqfwzr7t1xXaqLxxB3hFfZAiMnY8/wpz/KeYXlgHsBBxdx3zufNS
         EPjf6jbUU55mnNiDHN9sYJsVE/et6Fz4SOZwfTMOdMuySkAUbP/j/AQI1tJpu21U/2+Q
         Pttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912585; x=1788517385;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud1SVn2U/zjHi4VSWIq5F5o3aDeRY2u2GtAjGiMvvok=;
        b=ha6oytkBtfQz9Wgh+HoB04bmKP3sN6yIuCHQh6CssGgkv0/HwaSkS4JxoHWliHoxSU
         bslN/FSRwSzgDEBYQQLGmqEKYhWqlyZNr+GAbwvM87HdLdVfoFN9U1/J4U5UO6GmkSqk
         EZ9zDK8PPKKiAdhGM5KCsDkmdYbJXuKjlt3gZJLi3vfNiUiLC0LkW0m2Ct1Lt4bTu0pP
         NVuO6Zrfa8iN18jXw6JGhSDVR9NagclmxXbXBe+78f7JCt/+COP0h1DWO32sqVxZwa0M
         VZ5YYmQnVKv/RHR4pUyIcpsP1F3CxJt5pBWIXV23yG/Nzv9OUE5NEQHtx2aYc6vE5SQM
         vv7A==
X-Forwarded-Encrypted: i=1; AHgh+Rp3Djq8Q0s87njPQAgrS0g3VSrZHOW7q5/RbBj0xzrMX20O0agDZAVUWUhUvkB7nTgMHc+cAFc=@lists.linux.dev
X-Gm-Message-State: AFuF++mRi2ZdvjED1XK0YiVOY/bN4J1AxbtyKlwfJfov9dvGk8KrTkMJ
	OCLO4Si3uAGop2aSZzkrcMGq8G0U+m3DC6kqgoB8KOj+tFN1K5Oq+Dn/WgUJu0pKlBM=
X-Gm-Gg: AR+sD13NFrG3/tMXn9RhBgRJgE7oRWBrAMVaF9gLkYY/kNbNRBEC4kjlEZSzOiVMSk5
	eHid7cF31ZA+sEwVV4E3POWxUou9xqitWpbuf4exbRBLFBWFvpw0Z3b9ZPIzV+eF/tx/gXIC910
	0haW/oZFnEUpPapFqyGY0OOFi8LDpnwCti1yTS4hhEHqqQuSUxdevuptl+sEVSOD3OiTFAW1dCG
	SnExxngY8mkqmLkGVKlpcLrtK9d6XLUB96VIWME63mqxPAF+n1lCxSCQ+tkTLwe7XGZzvEotMkn
	y3/WY6ci+dRNaroJS9DX/3fHX8Gg9AjryaWm1rje8y8maOZPkjhqzHP5UL48wbsWU28rPgOiucG
	lyOvG30ZsQd7IGDmD1awjVauU5827eB3tlzNIkn67T670Lg46BUqxWj8B0gSoJ6Vv+TGCjShR4B
	H0f9uqKRObw4bdstuhhpkZeWaLwZFrOvss8gE7gg6iPwnT2lSj0mf24ukt62YgHgb9yEpyyxHKe
	qucJNxFUnyF8R/ec54=
X-Received: by 2002:a05:6000:2401:b0:482:dd67:3a57 with SMTP id ffacd0b85a97d-482f7989684mr7352129f8f.4.1787912584753;
        Fri, 28 Aug 2026 03:23:04 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab5a2csm2775134f8f.4.2026.08.28.03.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 03:23:04 -0700 (PDT)
Message-ID: <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
Date: Fri, 28 Aug 2026 13:23:03 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Yilin Zhu <zylzyl2333@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, horatiu.vultur@microchip.com,
 kuba@kernel.org, henrik.bjoernlund@microchip.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 ronbogo@outlook.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
 <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
 <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
In-Reply-To: <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/05/2026 11:09, Nikolay Aleksandrov wrote:
> On 12/05/2026 08:21, Yilin Zhu wrote:
>> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>
>>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
>>>> On 10/05/2026 12:15, Ren Wei wrote:
>>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>>>>
>>>>> CFM registers a bridge frame handler when the first MEP is created and
>>>>> unregisters it when the last MEP is deleted. The registered object also
>>>>> contains the hlist_node used by the bridge-local frame_type_list.
>>>>>
>>>>> The CFM frame type is currently global, so enabling CFM on multiple
>>>>> bridges links the same hlist_node into multiple bridge-local lists. A
>>>>> later unregister on one bridge can then operate on list state belonging
>>>>> to another bridge.
>>>>>
>>>>> Move the CFM frame type into struct net_bridge and register/unregister
>>>>> the bridge-owned object. This keeps frame handler list membership local
>>>>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>>>>
>>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
>>>>> frame RX added.")
>>>>> Cc: stable@kernel.org
>>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>>>> ---
>>>>>    net/bridge/br_cfm.c     | 14 ++++++--------
>>>>>    net/bridge/br_private.h | 18 +++++++++++-------
>>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
>>>>>
>>>>
>>>> I think MRP suffers from the same bug, but I also think we can contain the
>>>> fix within the packet type structure instead of making the already huge
>>>> struct net_bridge even bigger. Also, linking a struct within net_bridge
>>>> to a list within the same net_bridge looks weird.
>>>>
>>>> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
>>>> dynamically and link it, then br_del_frame should take a type instead of a ptr
>>>> and remove that frame type and free it with kfree_rcu. That would require
>>>> br_add_frame return value to be checked in the respective cfm/mrp functions.
>>>> Warnings for already existing types on add or missing types on del should be
>>>> added.
>>>>
>>>
>>> Actually I have a better idea since these handlers can be added only once per
>>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
>>> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
>>> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
>>> not compiled in. Would you like me to prepare it or do you want to give it a go?
>>>
>>
>> Hi Nik,
>>
>> Thanks for the suggestion.
>>
>> I'll give it a go. IIUC, the idea is to remove the shared
>> br_frame_type list entries for CFM/MRP, track their per-bridge enable
>> state with bridge option bits, and dispatch the CFM/MRP handlers directly
>> from the receive path when the corresponding EtherType and option bit
>> match.
>>
>> I'll include MRP in v2.
>>
>> Thanks,
>> Yilin
>>
> 
> Great, thank you. That should simplify the code and give us 8 bytes of Rx hot
> cache line back. The important point is that there haven't been any new
> handlers since these were added back in 2020, and also these are not
> common, so making their impact on the fast-path as small as possible
> while fixing the bug sounds good.
> 
> A quick & dirty sketch of the fixes gives me:
> 5 files changed, 47 insertions(+), 66 deletions(-)
> 
> That can probably be improved (i.e. more deletions).
> 
> Just please make sure that if CFM/MRP are not enabled in .config, they
> would not affect the fast-path at all.
> 
> Cheers,
>   Nik
> 

Hi Yilin,
Are you still considering fixing these problems? A few months passed since
we last spoke.

Cheers,
  Nik


