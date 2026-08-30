Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01B1A9F87
	for <bridge@lists.linux.dev>; Sun, 30 Aug 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078598; cv=none; b=qUtTXAzmISUJpPCT1aUF2iopoDauKWhhG7bzVtSQ19jg4QEjkpV9Q16SMfRjBGyTcC6aE+yykA1EIZmmtlOtzgaGSGuOyFdgpB0g76D3C41/sWWHyQ6i6RThFyOKNZQDMQIBMhlDRkQeXM+RCBDiIoYjCTpFbiuUDYBFI0SElWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078598; c=relaxed/simple;
	bh=K7G9RCI0/tBJ3Upvcml4SlVmXmX54r23emAr8xKlBgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2r99seYwiiU3ozJ2+nsHsnntGV+nk0vgTqU7JiIfXZCvmtHOl0V22lQjgHJzbBdOiiKfmtE21V9pqyib+iQR4dY7JempsRcBaFc8wXfr4VZZsPvA6hrAj0GD6QWWSVnEcBviaBYyqyrFAHtehMIUFPfIVMIMSCztUkY+YXSnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=j4Ms5ILc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="j4Ms5ILc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b965570d7so20865825e9.0
        for <bridge@lists.linux.dev>; Sun, 30 Aug 2026 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788078593; x=1788683393; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1bNOSJbklivuD8yC2PVBqkUNR9N+X/0O0I9jhmTrMxw=;
        b=j4Ms5ILczLxM1/fGVDWXWGRUwEL3L2DGjHHC4RfOVNCCdHks6Mw5rjQVGgu1J5Jiub
         GJNZBIXnk3C34LV2hilHpy6lJXwqw4mctTa1ejfV8xUephwJe0TcaMB7ezP0AC4VNSNP
         4A/qHamH1TYWafMVcYpw2NyD03ZyNHgO3cNid9IrPSgfwFvopJeNs12o2KKrX+QFwSa6
         nSMEK8Qi4BneB/U+mnSIrpcLAXkJoiCWuP8rayVklODiN0rLS2B/B7Fp7O+fDQGb3YMN
         ClXKmc8U0FkAKn2zTxelsRM2b9oTGnAxn3hs0ZVzmaIXSTmrV4R2+thRM7RVy6Jb1w4n
         K+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788078593; x=1788683393;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1bNOSJbklivuD8yC2PVBqkUNR9N+X/0O0I9jhmTrMxw=;
        b=OQgi0U3r19L8lScqoeeFXxhpziM9kFVHWlVnZt5G5Hbe4IZ8HAgoqbAREFwMGeky06
         2i5N77RC4gDrgK4qdWzVuCzJFJgRSGsMCrDJ2KEDWLgzQWauR1NLCo/wFmj3FSlZiRCV
         FrtA8TqZS6Mkd2sq9w8f7tLD7BjipHDSXaVAE6Fx8e5zRclb64Cwa4PnKtSk0Gkzb1HA
         UPhXsMu4uh4CFXGX0/qvfzOyYLathn5mEejmt/lJqdw5dCE4c5Xy/H09WG0YRW4xXPEL
         ZlbumVl+Gvic+K/7GuCQ0gFldpN7dbfcJHlamn0nFFKKUiNM1ywmZiPVqdzh7ortZ6KB
         jPPA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7tdBVOCM5OQyFuLTHXIf2Z+9my/uxVwnXDo+w9We9cOqtKxBfcl6zd79k5PAAkSod4JB8gYM=@lists.linux.dev
X-Gm-Message-State: AFuF++kMRNuEZXH9JpUrqGnX1wbNK/O54sX53ymzarhTGUPVvHb+rpvT
	j7UyFGORmT05B4n0yM61sQXC6wv43s5UQj8jfzRd4wEZctgdn5cQHXoXHrCB+FvTUpw=
X-Gm-Gg: AR+sD13rAfd9+81AeN5fkN7xXN183hG3YB+EkxBHVcr73wI3HqjAEwEzqs15rWRGx7w
	7gh+WOWmi8uXMNSSETiXCCOycyMhlz1/BS8hhmD8d/PAZw0SkF6EdZJPzlsi3egkqwrp1+WW3mj
	CFYiLTPW+gFOlrRdT79EBEx/5X4r8vDcn31zH0I+Dy7gxMupgbnA7tLTqbKTWvH48n3PwbKhA7U
	EHlOstjQaEfLxOJYJvi9YljkWNX4rwRpMZ8M9IXwc8YhE3e+Y8L1XQgJU7c0l4C920NZko1BONV
	xNcET794/Rc1wPZdwsPiJWVllkp7GBFWSJABATNWCJbWQG3XynLbEGUShehncyNSbpCrf58mF9x
	maYljTa7HenQBaaAUZXxDdSZ6WTL+AuOR1OqpEvmSEI1/DMFxR3NodTFUUqkojqm7uMo+Qsh1Ol
	YNFP5wGLkth63qnox3j8SuKDN/bop6dBZwM+g3mzSCgaIsWLqt1UZE7ezWUgb4Yor4DOgUOga4Q
	kJWDAdAUgJmXXyzkps=
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr294303225e9.0.1788078593038;
        Sun, 30 Aug 2026 01:29:53 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm313438015e9.10.2026.08.30.01.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 01:29:52 -0700 (PDT)
Message-ID: <15fce8a9-9657-4efb-8308-921f8d498640@blackwall.org>
Date: Sun, 30 Aug 2026 11:29:51 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
To: Yuan Tan <yuantan098@gmail.com>
Cc: Yilin Zhu <zylzyl2333@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, idosch@nvidia.com,
 horatiu.vultur@microchip.com, kuba@kernel.org,
 henrik.bjoernlund@microchip.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
 <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
 <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
 <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
 <CAPuPA7KykYqE71P+7-7=1A50S1H3Ksi7ONk+kb_xR0Ep8HKBaw@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAPuPA7KykYqE71P+7-7=1A50S1H3Ksi7ONk+kb_xR0Ep8HKBaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2026 22:44, Yuan Tan wrote:
> On Fri, Aug 28, 2026 at 3:23 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 12/05/2026 11:09, Nikolay Aleksandrov wrote:
>>> On 12/05/2026 08:21, Yilin Zhu wrote:
>>>> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>>>
>>>>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
>>>>>> On 10/05/2026 12:15, Ren Wei wrote:
>>>>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>>>>>>
>>>>>>> CFM registers a bridge frame handler when the first MEP is created and
>>>>>>> unregisters it when the last MEP is deleted. The registered object also
>>>>>>> contains the hlist_node used by the bridge-local frame_type_list.
>>>>>>>
>>>>>>> The CFM frame type is currently global, so enabling CFM on multiple
>>>>>>> bridges links the same hlist_node into multiple bridge-local lists. A
>>>>>>> later unregister on one bridge can then operate on list state belonging
>>>>>>> to another bridge.
>>>>>>>
>>>>>>> Move the CFM frame type into struct net_bridge and register/unregister
>>>>>>> the bridge-owned object. This keeps frame handler list membership local
>>>>>>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>>>>>>
>>>>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
>>>>>>> frame RX added.")
>>>>>>> Cc: stable@kernel.org
>>>>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>>>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>>>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>>>>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>>>>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>>>>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>>>>>> ---
>>>>>>>     net/bridge/br_cfm.c     | 14 ++++++--------
>>>>>>>     net/bridge/br_private.h | 18 +++++++++++-------
>>>>>>>     2 files changed, 17 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>
>>>>>> I think MRP suffers from the same bug, but I also think we can contain the
>>>>>> fix within the packet type structure instead of making the already huge
>>>>>> struct net_bridge even bigger. Also, linking a struct within net_bridge
>>>>>> to a list within the same net_bridge looks weird.
>>>>>>
>>>>>> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
>>>>>> dynamically and link it, then br_del_frame should take a type instead of a ptr
>>>>>> and remove that frame type and free it with kfree_rcu. That would require
>>>>>> br_add_frame return value to be checked in the respective cfm/mrp functions.
>>>>>> Warnings for already existing types on add or missing types on del should be
>>>>>> added.
>>>>>>
>>>>>
>>>>> Actually I have a better idea since these handlers can be added only once per
>>>>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
>>>>> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
>>>>> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
>>>>> not compiled in. Would you like me to prepare it or do you want to give it a go?
>>>>>
>>>>
>>>> Hi Nik,
>>>>
>>>> Thanks for the suggestion.
>>>>
>>>> I'll give it a go. IIUC, the idea is to remove the shared
>>>> br_frame_type list entries for CFM/MRP, track their per-bridge enable
>>>> state with bridge option bits, and dispatch the CFM/MRP handlers directly
>>>> from the receive path when the corresponding EtherType and option bit
>>>> match.
>>>>
>>>> I'll include MRP in v2.
>>>>
>>>> Thanks,
>>>> Yilin
>>>>
>>>
>>> Great, thank you. That should simplify the code and give us 8 bytes of Rx hot
>>> cache line back. The important point is that there haven't been any new
>>> handlers since these were added back in 2020, and also these are not
>>> common, so making their impact on the fast-path as small as possible
>>> while fixing the bug sounds good.
>>>
>>> A quick & dirty sketch of the fixes gives me:
>>> 5 files changed, 47 insertions(+), 66 deletions(-)
>>>
>>> That can probably be improved (i.e. more deletions).
>>>
>>> Just please make sure that if CFM/MRP are not enabled in .config, they
>>> would not affect the fast-path at all.
>>>
>>> Cheers,
>>>    Nik
>>>
>>
>> Hi Yilin,
>> Are you still considering fixing these problems? A few months passed since
>> we last spoke.
>>
>> Cheers,
>>    Nik
>>
>>
> 
> Hi Nik,
> 
> I’m very sorry for the long delay. Yilin has gone back to continue his
> studies and unfortunately no longer has the time to finish this patch.
> 
> There was also an issue on my side in keeping track of this work, and
> I failed to notice that the patch had been left without a follow-up
> for so long. I apologize for that.
> 
> I can take over the patch, address the remaining feedback, and send a
> new version. That said, I’m not sure whether it might actually be
> easier for you to make the changes directly, if you are willing to do
> so. I’ve heard from maintainers that reviewing and iterating on
> someone else’s patch can sometimes take more effort than simply making
> the fix themselves, so I wanted to ask which approach you would
> prefer.
> 
> If you would prefer to fix the issue directly, could you please
> include the following tags?
> Reported-by: zylzyl2333@gmail.com
> Reported-by: vega@nebusec.ai
> 
> Otherwise, I’m happy to take over and prepare the next revision.
> What would you prefer?
> 
> Best,
> Yuan

Please take over and do the next revision. Just make sure the new cfm/mrp
option bits are checked together first and as an unlikely case.

Thanks,
  Nik

